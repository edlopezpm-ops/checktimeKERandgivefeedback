"""Challenge installed PostgreSQL guards without repository pytest hooks or helpers."""
from datetime import UTC, date, datetime
from decimal import Decimal
import hashlib
import importlib
import json
import os
from pathlib import Path
import sys
import time
from uuid import uuid4

AUDIT = Path(__file__).resolve().parents[1]
PRODUCT = AUDIT/'sandbox/product'
sys.path.insert(0,str(PRODUCT))
from sqlalchemy import create_engine, text
from sqlalchemy.exc import DBAPIError
from sqlalchemy.orm import Session
for p in (PRODUCT/'app').glob('*models.py'):
    importlib.import_module('app.'+p.stem)
from app.models import User, Client, Project, Timecard, TimeEntry, Invoice, InvoiceLine, Reservation, Artifact
from app.credit_memo_models import CreditMemo

import psycopg
from alembic import command
from alembic.config import Config
DATABASE='timeker_guard_contract_audit_r2_test'
assert DATABASE.endswith('_test')
with psycopg.connect(host='127.0.0.1',port=55526,dbname='postgres',user='audit_admin',autocommit=True) as admin:
    if admin.execute('SELECT EXISTS(SELECT 1 FROM pg_database WHERE datname=%s)',(DATABASE,)).fetchone()[0]:
        raise RuntimeError('Refusing to reuse guard target')
    admin.execute('CREATE DATABASE '+DATABASE+' OWNER audit_admin')
engine=create_engine('postgresql+psycopg://audit_admin@127.0.0.1:55526/'+DATABASE,hide_parameters=True)
cfg=Config(str(PRODUCT/'alembic.ini'));cfg.set_main_option('script_location',str(PRODUCT/'alembic'))
os.environ['TIMEKER_ENVIRONMENT']='test'
with engine.connect() as connection:
    cfg.attributes['connection']=connection
    command.upgrade(cfg,'head')
start=time.perf_counter()
with Session(engine) as db:
    if db.scalar(text('SELECT count(*) FROM users')):
        raise RuntimeError('Refusing to reuse populated guard-probe target')
    user=User(email='guard-audit@example.invalid',display_name='Synthetic audit',role='owner',active=True)
    client=Client(code='GUARD-AUDIT',legal_name='Synthetic audit',display_name='Synthetic audit',country_code='US',
                  status='active',timezone='UTC',language='en',currency='USD',rate=Decimal('1.00'),weekly_limit_minutes=1200)
    db.add_all([user,client]);db.flush()
    project=Project(client_id=client.id,code='A',name='Synthetic audit',status='active',billable=True,project_type='time_and_materials')
    db.add(project);db.flush()
    card=Timecard(owner_id=user.id,client_id=client.id,week_start=date(2026,10,19),total_minutes=3,status='Draft')
    db.add(card);db.flush()
    entry=TimeEntry(timecard_id=card.id,project_id=project.id,work_date=date(2026,10,20),minutes=3,billable=True,
                    ready_rate=Decimal('1.00'),ready_rate_source={'kind':'explicit_owner','revision':1})
    db.add(entry);db.flush()
    card.status='Finalized';card.finalized_at=datetime.now(UTC);db.flush()
    invoice=Invoice(client_id=client.id,number='AUDIT-ROUNDING-0001',period_start=date(2026,10,19),period_end=date(2026,10,25),
                    currency='USD',subtotal=Decimal('.05'),total=Decimal('.05'),status='Draft')
    db.add(invoice);db.flush()
    line=InvoiceLine(invoice_id=invoice.id,project_id=project.id,description='Synthetic three minutes',service_period='2026-10-20',
                     quantity_minutes=3,unit_rate=Decimal('1.00'),amount=Decimal('.05'),basis='time',sort_order=0)
    db.add(line);db.add(Reservation(entry_id=entry.id,invoice_id=invoice.id));db.flush()
    payload=b'%PDF-1.7\nSYNTHETIC GUARD INPUT; NOT A RENDERED DOCUMENT\n'
    digest=hashlib.sha256(payload).hexdigest()
    artifact=Artifact(invoice_id=invoice.id,filename='synthetic-guard.pdf',pdf_bytes=payload,sha256=digest,renderer_version='audit-synthetic')
    db.add(artifact);db.flush()
    original={'publication_contract':'ph3.v1','source_ids':[str(entry.id)],'number':invoice.number,'currency':'USD','total':'0.05',
              'lines':[{'line_id':str(line.id),'amount':'0.05','minutes':3,'basis':'time','unit_rate':'1.00'}]}
    invoice.snapshot=original;invoice.issued_at=datetime.now(UTC);invoice.issue_date=date(2026,10,26);invoice.status='Issued'
    db.commit()
    identity={'invoice_id':invoice.id,'entry_id':entry.id,'artifact_id':artifact.id,'line_id':line.id,'user_id':user.id}

checks=[]
def must_reject(name,sql,parameters):
    with engine.connect() as connection:
        tx=connection.begin()
        try:
            connection.execute(text(sql),parameters)
            tx.commit()
        except DBAPIError as error:
            tx.rollback()
            checks.append({'name':name,'result':'REJECTED','sqlstate':getattr(error.orig,'sqlstate',None)})
        else:
            checks.append({'name':name,'result':'UNEXPECTED_ACCEPTANCE'})
            raise AssertionError(name+' was not rejected')

must_reject('issued_total','UPDATE invoices SET total=0.06 WHERE id=:invoice_id',identity)
must_reject('issued_snapshot',"UPDATE invoices SET snapshot=snapshot||jsonb_build_object('audit_changed',true) WHERE id=:invoice_id",identity)
must_reject('issued_line','UPDATE invoice_lines SET amount=0.06 WHERE id=:line_id',identity)
must_reject('artifact_update',"UPDATE invoice_artifacts SET pdf_bytes=decode('00','hex') WHERE id=:artifact_id",identity)
must_reject('artifact_delete','DELETE FROM invoice_artifacts WHERE id=:artifact_id',identity)
must_reject('published_claim_delete','DELETE FROM invoice_time_entries WHERE entry_id=:entry_id',identity)
must_reject('published_void',"UPDATE invoices SET status='Void' WHERE id=:invoice_id",identity)
must_reject('published_entry_edit','UPDATE time_entries SET minutes=4 WHERE id=:entry_id',identity)

credit_ids=[]
for index, amount in enumerate((Decimal('.02'),Decimal('.01'),Decimal('.02')),1):
    with Session(engine) as db:
        credit_id=uuid4();credit_ids.append(credit_id)
        number=f'AUDIT-CREDIT-{index}'
        snapshot={'kind':'credit_memo','contract':'ph3.partial.v1','number':number,'reason':'Synthetic rounding audit',
                  'issue_date':'2026-10-26','original':original,'original_invoice_id':str(identity['invoice_id']),
                  'original_number':'AUDIT-ROUNDING-0001','original_sha256':digest,'credit_total':str(amount),
                  'credit_lines':[{'line_id':str(identity['line_id']),'mode':'minutes','minutes':1,'amount':str(amount)}]}
        credit=CreditMemo(id=credit_id,invoice_id=identity['invoice_id'],actor_id=identity['user_id'],number=number,
                          issue_date=date(2026,10,26),currency='USD',total=amount,reason='Synthetic rounding audit',snapshot=snapshot,
                          filename=f'synthetic-credit-{index}.pdf',pdf_bytes=payload,sha256=digest,renderer_version='audit-synthetic')
        db.add(credit);db.commit()
    checks.append({'name':f'cumulative_rounding_credit_{index}','result':'ACCEPTED','amount':str(amount),'minutes':1})
must_reject('published_claim_after_full_credit','DELETE FROM invoice_time_entries WHERE entry_id=:entry_id',identity)
must_reject('credit_update','UPDATE credit_memos SET total=0.00 WHERE id=:credit_id',{'credit_id':credit_ids[0]})
with engine.connect() as connection:
    after=connection.execute(text('''SELECT i.status,i.total,i.snapshot,a.pdf_bytes,a.sha256,
      (SELECT sum(total) FROM credit_memos WHERE invoice_id=i.id) AS credits,
      (SELECT count(*) FROM invoice_time_entries WHERE invoice_id=i.id) AS claims,
      (SELECT minutes FROM time_entries WHERE id=:entry_id) AS worked
      FROM invoices i JOIN invoice_artifacts a ON a.invoice_id=i.id WHERE i.id=:invoice_id'''),identity).mappings().one()
    assert after['status']=='Issued' and after['total']==Decimal('.05') and after['snapshot']==original
    assert after['pdf_bytes']==payload and after['sha256']==digest
    assert after['credits']==Decimal('.05') and after['claims']==1 and after['worked']==3
checks.append({'name':'fresh_connection_retains_original_and_full_credit','result':'PASS',
               'original_total':'0.05','credited_total':'0.05','claims':1,'worked_minutes':3,'artifact_sha256':digest})
engine.dispose()
result={'target':DATABASE+' on loopback55526 only','elapsed_seconds':time.perf_counter()-start,
        'checks':checks,'checks_count':len(checks),'expected_rejections':sum(x['result']=='REJECTED' for x in checks),
        'limits':'Direct SQL/ORM trigger checks on synthetic data, outside pytest hooks. Placeholder PDF bytes test custody guards only; no PDF renderer or public HTTP flow is credited.'}
(AUDIT/'evidence/migration-guard-probe.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result))
