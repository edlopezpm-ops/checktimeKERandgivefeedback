import os,sys,json
from pathlib import Path
from decimal import Decimal
from datetime import date
ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
import psycopg
DB='behavior_mcp_test'
with psycopg.connect(host='127.0.0.1',port=55526,dbname='postgres',user='audit_admin',autocommit=True) as c:
    if not c.execute('SELECT 1 FROM pg_database WHERE datname=%s',(DB,)).fetchone():c.execute('CREATE DATABASE behavior_mcp_test OWNER audit_admin')
url='postgresql+psycopg://audit_admin@127.0.0.1:55526/'+DB
os.environ['TIMEKER_DATABASE_URL']=url
os.environ['TIMEKER_DATABASE_ROLE']='audit_admin'
os.environ['TIMEKER_TEST_DATABASE_URL']=url
os.environ['TIMEKER_TEST_ADMIN_ROLE']='audit_admin'
os.environ['TIMEKER_ENVIRONMENT']='test'
from alembic import command
from alembic.config import Config
from sqlalchemy import select,func,text
from fastapi.testclient import TestClient
from cryptography.fernet import Fernet
from app.config import Settings
from app.main import create_app
from app.db import session_factory
from app.seed import seed
from app.models import Base,Project,Client,Timecard
from app.subscription_models import WorkspaceSubscription
from app.subscriptions import CATALOG_VERSION
from tests.conftest import csrf
from tests.integration.test_delegated_integration import connect,mcp,CLIENT,CALLBACK
from datetime import UTC,datetime,timedelta
command.upgrade(Config(str(PRODUCT/'alembic.ini')),'head')
settings=Settings(environment='test',database_url=url,database_role='audit_admin',base_url='http://testserver',session_secret='synthetic-audit-mcp-secret-5931'*2,encryption_key=Fernet.generate_key().decode(),dev_login=True,allowlist=('audit-owner@example.invalid',),integration_enabled=True,integration_clients_json=json.dumps([{'client_id':CLIENT,'name':'Synthetic audit assistant','redirect_uris':[CALLBACK]}]))
factory=session_factory(url)
with factory.begin() as db:
    db.execute(text('TRUNCATE '+','.join(t.name for t in reversed(Base.metadata.sorted_tables))+' CASCADE'))
    owner,client=seed(db,settings,'fixture')
    db.add(WorkspaceSubscription(id=1,owner_id=owner.id,plan_code='pro',catalog_revision=CATALOG_VERSION,access_expires_at=datetime.now(UTC)+timedelta(days=2)))
    client_id=str(client.id)
    project_id=str(db.scalar(select(Project.id).where(Project.client_id==client.id)))
def tool(web,tokens,name,args):
    response=mcp(web,tokens,'tools/call',{'name':name,'arguments':args})
    if response.status_code!=200 or response.json()['result'].get('isError'):raise RuntimeError('MCP call failed '+str(response.status_code))
    return response.json()['result']['structuredContent']
with TestClient(create_app(settings)) as web:
    login=web.post('/auth/local',data={'csrf':csrf(web.get('/'))})
    if login.status_code!=200:raise RuntimeError('Local synthetic owner login failed')
    tokens,_=connect(web,scopes='time:read time:write')
    created=tool(web,tokens,'create_time_entry',{'client_id':client_id,'project_id':project_id,'case_id':None,'work_date':'2026-10-26','timezone':'America/Santiago','minutes':37,'description':'New independent metamorphic audit work','expected_card_version':0,'confirmed':True,'idempotency_key':'audit-new-mcp-37minutes'})
    args={'client_id':client_id,'week_start':'2026-10-26','timecard_id':created['timecard_id']}
    before=tool(web,tokens,'list_time_entries',args)
    with factory.begin() as db:
        db.add(Client(code='AUDIT-UNRELATED-2',legal_name='Unrelated synthetic second client',display_name='Unrelated synthetic second client',country_code='US',status='draft',timezone='UTC',currency='USD',rate=Decimal('17.00')))
    after=tool(web,tokens,'list_time_entries',args)
    with factory() as db:
        persisted_cards=db.scalar(select(func.count()).select_from(Timecard))
        clients=db.scalar(select(func.count()).select_from(Client))
result={'oracle':'Metamorphic property: adding an unrelated client must not change a client+exact-timecard read; independent SQL count proves exactly one stored timecard. Public MCP OAuth/PKCE/token/tool path used, only synthetic local owner login.','stored_timecards':persisted_cards,'stored_clients_after':clients,'before_timecard_ids':[c['id'] for c in before['timecards']],'after_timecard_ids':[c['id'] for c in after['timecards']],'before_singular_timecard_present':before['timecard'] is not None,'after_singular_timecard_present':after['timecard'] is not None,'entry_minutes_after':[e['minutes'] for e in after['entries']],'unexpected_duplicate_count':len(after['timecards'])-persisted_cards}
(ROOT/'evidence'/'behavior-mcp-cartesian.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result))
