"""Exact rational oracle and real HTTP counterexample, no pytest/fixture hooks."""
import json
import os
import random
import re
import sys
from datetime import UTC, datetime, timedelta
from decimal import Decimal
from fractions import Fraction
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(Path.cwd()))
from alembic import command
from alembic.config import Config
from cryptography.fernet import Fernet
from fastapi.testclient import TestClient
from sqlalchemy import select, text
from app.config import Settings
from app.db import session_factory
from app.domain import line_amount
from app.main import create_app
from app.models import Base, Invoice, Project
from app.seed import FIXTURE_OWNER, seed
from app.subscription_models import WorkspaceSubscription
from app.subscriptions import CATALOG_VERSION

def csrf(page):
    return re.search(r'name="csrf" value="([^"]+)"',page.text).group(1)

rng = random.Random(20261026)
rows = []
for index in range(400):
    minutes, cents = rng.randrange(1441), rng.randrange(1,100000)
    correct = Decimal((minutes*cents+30)//60)/100
    actual = line_amount(minutes,Decimal(cents)/100)
    rows.append({'index':index,'minutes':minutes,'rate':str(Decimal(cents)/100), 'exact_amount_rational':str(Fraction(minutes*cents,6000)), 'expected':str(correct),'observed':str(actual),'match':actual==correct})

url=os.environ['TIMEKER_DATABASE_URL']
assert any('127.0.0.1:55526/'+name in url for name in ('timeker_independent_test','timeker_rounding_test'))
command.upgrade(Config('alembic.ini'),'head')
factory=session_factory(url)
settings=Settings(environment='test',database_url=url,base_url='http://testserver',
    session_secret='independent-rounding-session-'*3,encryption_key=Fernet.generate_key().decode(),
    dev_login=True,allowlist=(FIXTURE_OWNER,))
with factory.begin() as db:
    db.execute(text('TRUNCATE '+','.join(t.name for t in reversed(Base.metadata.sorted_tables))+' CASCADE'))
    owner,client=seed(db,settings,'fixture')
    client.rate=Decimal('15.15')
    db.add(WorkspaceSubscription(id=1,owner_id=owner.id,plan_code='pro',catalog_revision=CATALOG_VERSION,
        access_expires_at=datetime.now(UTC)+timedelta(days=31)))
    project=db.scalar(select(Project))
    client_id,project_id=client.id,project.id
with TestClient(create_app(settings)) as web:
    page=web.post('/auth/local',data={'csrf':csrf(web.get('/'))})
    page=web.post('/timecards/save',data={'csrf':csrf(page),'client_id':str(client_id),
        'week':'2026-10-19','version':'0','projects':str(project_id),f'duration_{project_id}_0':'0:02'})
    with factory() as db:
        card=db.execute(text('SELECT id,version FROM timecards')).one()
    page=web.post(f'/timecards/{card.id}/finalize',data={'csrf':csrf(page),'version':str(card.version)})
    page=web.post('/billing/create',data={'csrf':csrf(page),'client_id':str(client_id),
        'period_start':'2026-10-19','period_end':'2026-10-25'})
    with factory() as db:
        invoice=db.scalar(select(Invoice))
        saved={'number':invoice.number,'total':str(invoice.total),'line_minutes':invoice.lines[0].quantity_minutes,
            'line_rate':str(invoice.lines[0].unit_rate),'line_amount':str(invoice.lines[0].amount)}
    assert page.status_code==200 and saved['line_minutes']==2 and saved['line_rate']=='15.15'
    exported=web.get('/reports/export.csv')
    assert exported.status_code==200
    import csv
    from io import StringIO,BytesIO
    from pypdf import PdfReader
    csv_rows=list(csv.DictReader(StringIO(exported.text)))
    assert len(csv_rows)==1 and csv_rows[0]['Minutes']=='2' and csv_rows[0]['Hourly estimate']=='0.50'
    pdf=web.get(f'/billing/{invoice.id}/pdf')
    assert pdf.status_code==200
    pdf_text='\n'.join(p.extract_text() for p in PdfReader(BytesIO(pdf.content)).pages)
    assert '0.50' in pdf_text and '0.51' not in pdf_text
    result={'seed':20261026,'case_count':400,'matching':sum(r['match'] for r in rows),
        'mismatches':[r for r in rows if not r['match']], 'cases':rows,
        'oracle':'positive exact integer cents: floor((minutes * rate_cents + 30) / 60); half-up tie established by exact Fraction, stdlib Decimal at precision80 as second check',
        'native_HTTP':{'observed':saved,'expected_total':'0.51','exact':'0.505','status':page.status_code,'fresh_SQL':True},
        'exported_PDF':{'status':pdf.status_code,'sha256':__import__('hashlib').sha256(pdf.content).hexdigest(),'text':pdf_text,'observed_total':'0.50','expected_total':'0.51'},
        'report_CSV':{'status':exported.status_code,'rows':csv_rows,'observed_hourly_estimate':'0.50','expected_hourly_estimate':'0.51'}}
    from decimal import localcontext
    with localcontext() as ctx:
        ctx.prec=80
        assert Decimal(2)*Decimal('15.15')/Decimal(60)==Decimal('0.505')
    assert saved['total']=='0.50', 'Counterexample no longer present; re-evaluate baseline'
    (ROOT/'evidence'/'rounding-counterexample.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k!='cases'}))
factory.kw['bind'].dispose()
