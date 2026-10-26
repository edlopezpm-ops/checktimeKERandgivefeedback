import asyncio,hashlib,json,os,sys
from pathlib import Path
from datetime import datetime,timedelta,timezone
from types import SimpleNamespace
from urllib.parse import urlencode
from uuid import uuid4
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
import psycopg,httpx
DB='behavior_grace_test'
BASE='postgresql+psycopg://audit_admin@127.0.0.1:55526/'+DB
with psycopg.connect(host='127.0.0.1',port=55526,dbname='postgres',user='audit_admin',autocommit=True) as conn:
    if not conn.execute('SELECT 1 FROM pg_database WHERE datname=%s',(DB,)).fetchone():conn.execute('CREATE DATABASE behavior_grace_test OWNER audit_admin')
os.environ['TIMEKER_DATABASE_URL']=BASE
os.environ['TIMEKER_DATABASE_ROLE']='audit_admin'
os.environ['TIMEKER_ENVIRONMENT']='test'
from alembic import command
from alembic.config import Config
from sqlalchemy import text
from app import subscription_billing as service
from app.db import session_factory
from app.models import Base,User
from app.paddle import PaddleSandbox
from app.subscription_billing_models import BillingAccount,BillingOperation
from app.subscription_models import WorkspaceSubscription
from app.subscriptions import CATALOG_VERSION
command.upgrade(Config(str(PRODUCT/'alembic.ini')),'head')
PRICES={offer:'pri_'+str(index).zfill(26) for index,offer in enumerate(service.OFFERS,1)}
config=SimpleNamespace(subscription_provider='paddle_sandbox',environment='test',base_url='https://audit.example.invalid',paddle_api_key='pdl_sdbx_apikey_'+'a'*26+'_'+'b'*22+'_ccc',paddle_client_token='test_'+'d'*27,paddle_webhook_secret='synthetic-audit-only-not-provider-credential',paddle_price_ids_json=json.dumps(PRICES))
results=[]
def run_case(zone,failure,label):
    url=BASE+'?'+urlencode({'options':'-c timezone='+zone})
    factory=session_factory(url)
    tenant_id,owner_id,checkout_id=uuid4(),uuid4(),uuid4()
    subscription_id='sub_'+'q'*26
    customer_id='ctm_'+'j'*26
    transaction_id='txn_'+'v'*26
    paid_end=failure-timedelta(days=1)
    previous_start=paid_end-timedelta(days=30)
    period_end=paid_end+timedelta(days=30)
    binding={'checkout_id':str(checkout_id),'tenant_id':str(tenant_id)}
    price={'id':PRICES['solo_monthly'],'type':'standard','status':'active','trial_period':None,'unit_price':{'amount':'700','currency_code':'USD'},'unit_price_overrides':[],'billing_cycle':{'interval':'month','frequency':1}}
    shared={'customer_id':customer_id,'status':'past_due','currency_code':'USD','collection_mode':'automatic','items':[{'price':price,'quantity':1}],'custom_data':binding,'updated_at':failure.isoformat()}
    transaction={**shared,'id':transaction_id,'subscription_id':subscription_id,'billing_period':{'starts_at':paid_end.isoformat(),'ends_at':period_end.isoformat()}}
    subscription={**shared,'id':subscription_id,'current_billing_period':transaction['billing_period'],'created_at':previous_start.isoformat(),'scheduled_change':None}
    with factory.begin() as db:
        db.execute(text('TRUNCATE '+','.join(table.name for table in reversed(Base.metadata.sorted_tables))+' CASCADE'))
        db.add(User(id=owner_id,email='independent-grace@example.invalid',display_name='Synthetic audit owner',role='owner',active=True,session_revision=0))
        db.flush()
        db.add(BillingOperation(id=checkout_id,owner_id=owner_id,key_digest='a'*64,payload_digest='b'*64,action='billing.checkout',state='confirmed',intent={'offer':'solo_monthly','renewal_authorized':True,'tenant_id':str(tenant_id)},transaction_id=transaction_id,result={'outcome':'PENDING'}))
        db.flush()
        db.add(BillingAccount(id=1,owner_id=owner_id,customer_id=customer_id,subscription_id=subscription_id,checkout_id=checkout_id,provider_status='active',provider_offer='solo_monthly',entitlement_offer='solo_monthly',paid_through=paid_end,proven_period_start=previous_start,provider_updated_at=paid_end,requires_selection=False))
        db.add(WorkspaceSubscription(id=1,owner_id=owner_id,plan_code='solo',catalog_revision=CATALOG_VERSION,access_expires_at=paid_end))
    calls=[]
    def provider(request):
        calls.append(request.method+' '+request.url.path)
        if request.method!='GET':raise RuntimeError('Unexpected provider write')
        if request.url.path=='/transactions/'+transaction_id:return httpx.Response(200,json={'data':transaction})
        if request.url.path=='/subscriptions/'+subscription_id:return httpx.Response(200,json={'data':subscription})
        raise RuntimeError('Unexpected provider path')
    adapter=PaddleSandbox(config,transport=httpx.MockTransport(provider))
    tenant=SimpleNamespace(id=tenant_id,factory=factory)
    observations=[]
    with patch.object(service,'_provider',lambda settings:adapter):
        for number,occurred in enumerate([failure,failure+timedelta(hours=6),failure+timedelta(hours=12)],1):
            event={'event_id':'evt_'+uuid4().hex[:26],'event_type':'transaction.payment_failed','data':transaction,'occurred_at':occurred.isoformat()}
            digest=hashlib.sha256(json.dumps(event,sort_keys=True).encode()).hexdigest()
            receipt=asyncio.run(service.handle_verified_event(tenant,config,event,digest))
            # Fresh independent connection/session after every committed handler.
            with factory() as db:
                row=db.get(WorkspaceSubscription,1)
                account=db.get(BillingAccount,1)
                expiry=row.access_expires_at
                observations.append({'event_number':number,'outcome':receipt['outcome'],'database_timezone':db.scalar(text('SHOW timezone')),'earliest_failure_utc':account.past_due_since.astimezone(timezone.utc).isoformat(),'expiry_as_loaded':expiry.isoformat(),'expiry_utc':expiry.astimezone(timezone.utc).isoformat(),'elapsed_seconds_from_earliest_failure':int(expiry.timestamp()-failure.timestamp()),'expected_utc_elapsed_seconds':7*24*3600})
    factory.kw['bind'].dispose()
    results.append({'case':label,'failure_utc':failure.isoformat(),'session_timezone':zone,'observations':observations,'provider_get_calls':len(calls),'provider_writes':0,'stable_after_retries':len({o['expiry_utc'] for o in observations})==1})
UTC=timezone.utc
run_case('America/New_York',datetime(2026,10,25,9,17,23,tzinfo=UTC),'fall_dst_transition')
run_case('UTC',datetime(2026,10,25,9,17,23,tzinfo=UTC),'fall_utc_control')
run_case('America/New_York',datetime(2026,11,15,9,17,23,tzinfo=UTC),'no_transition_control')
run_case('America/New_York',datetime(2026,3,1,9,17,23,tzinfo=UTC),'spring_dst_transition')
report={'snapshot':'1036d705f7f3721e2fa83df67cf913a40dad65b8','oracle':'Mandatory retry invariance of expiry for the same earliest verified failure. Exact UTC elapsed seven days=604800seconds is an independent arithmetic check; even a calendar-day interpretation cannot justify changing expiry on repeated observation of the identical retained failure.','cases':results,'classification':'CONFIRMED_CONTRACT_FAILURE' if any(not r['stable_after_retries'] for r in results) else 'NOT_REPRODUCED','scope':'Real local PostgreSQL/service/independent new sessions; only external GET provider transport mocked. No remote webhook/signature/provider action or actual Stage timezone observed. Session timezone chosen per own connection, cluster settings unchanged.','source':'app/subscription_billing.py:1164-1175; GRACE timedelta applied to loaded ZoneInfo after min retains existing equal first argument; UTC normalization missing.','contract_sources':['AGENTS.md UTC technical timestamps','docs/DECISIONS.md:649-650','docs/PH3.md:402-405']}
(ROOT/'evidence'/'behavior-grace-dst.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print(json.dumps(report))
