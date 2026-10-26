"""Contract oracles outside pytest hooks; all records are disposable and synthetic."""
import hashlib
import json
import os
import random
import re
import sys
from datetime import UTC, date, datetime, timedelta
from decimal import Decimal
from io import BytesIO
from pathlib import Path

product = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else Path.cwd()
os.chdir(product)
sys.path.insert(0, str(product))
from alembic import command
from alembic.config import Config
from cryptography.fernet import Fernet
from fastapi.testclient import TestClient
from pypdf import PdfReader
from sqlalchemy import select, text
from sqlalchemy.exc import DBAPIError
from app import billing, credits, timecards
from app.config import Settings
from app.db import session_factory
from app.domain import DomainError, line_amount, money, parse_duration, week_start
from app.main import create_app
from app.models import Artifact, Base, Client, Invoice, Project, Timecard, TimeEntry
from app.seed import FIXTURE_OWNER, seed
from app.subscription_models import WorkspaceSubscription
from app.subscriptions import CATALOG_VERSION

checks = []
def check(condition, label):
    assert condition, label
    checks.append(label)

def reject(call, label):
    try:
        call()
    except DomainError:
        checks.append(label)
        return
    raise AssertionError(label)

def csrf(response):
    found = re.search(r'name="csrf" value="([^"]+)"', response.text)
    assert found, 'CSRF form missing'
    return found.group(1)

def forms(response, action):
    for route, body in re.findall(r'<form[^>]*action="([^"]+)"[^>]*>(.*?)</form>', response.text, re.S):
        if route == action:
            return dict(re.findall(r'<input[^>]*name="([^"]+)"[^>]*value="([^"]*)"', body))
    raise AssertionError('Required native form missing: ' + action)

def domain_oracles():
    # Independent integer arithmetic: cents * minutes / 60 rounded half up.
    rng = random.Random(20261026)
    for i in range(400):
        minutes, cents = rng.randrange(1441), rng.randrange(1, 100000)
        check(parse_duration(f'{minutes//60}:{minutes%60:02}') == minutes, f'duration-{i}')
        expected_cents = (minutes*cents + 30)//60
        check(line_amount(minutes, Decimal(cents)/100) == Decimal(expected_cents)/100, f'amount-{i}')
    for raw in ['24:01', '1:99', '-0:01', '0.0001', '1e0', 'NaN', 'Infinity', '12:3']:
        reject(lambda: parse_duration(raw), 'invalid-duration-'+raw)
    for raw in ['NaN', 'Infinity', '3.001', '-0.01']:
        reject(lambda: money(raw), 'invalid-money-'+raw)
    reject(lambda: money(1.25), 'float-money')
    check(week_start(datetime(2026, 10, 26, 1, tzinfo=UTC), 'America/Santiago') == date(2026, 10, 19), 'Santiago-Sunday-vs-UTC-Monday')

def financial_route_oracle():
    url = os.environ['TIMEKER_DATABASE_URL']
    assert '127.0.0.1:55526/timeker_independent_test' in url
    command.upgrade(Config('alembic.ini'), 'head')
    factory = session_factory(url)
    config = Settings(environment='test', database_url=url, base_url='http://testserver',
        session_secret='independent-synthetic-session-'*3, encryption_key=Fernet.generate_key().decode(),
        dev_login=True, allowlist=(FIXTURE_OWNER,))
    with factory.begin() as db:
        names = ','.join(t.name for t in reversed(Base.metadata.sorted_tables))
        db.execute(text('TRUNCATE ' + names + ' CASCADE'))
        owner, client = seed(db, config, 'fixture')
        client.rate = Decimal('47.13')
        client.legal_name = 'Independent synthetic audit client'
        db.add(WorkspaceSubscription(id=1, owner_id=owner.id, plan_code='pro',
            catalog_revision=CATALOG_VERSION, access_expires_at=datetime.now(UTC)+timedelta(days=31)))
        project = db.scalar(select(Project).where(Project.client_id == client.id))
        owner_id, client_id, project_id = owner.id, client.id, project.id
    with TestClient(create_app(config)) as web:
        check(web.post('/timecards/save', data={}, follow_redirects=False).status_code in (303, 403), 'guest-cannot-save')
        check(web.post('/auth/local', data={'csrf': csrf(web.get('/'))}).status_code == 200, 'local-explicit-auth')
        check(web.post('/timecards/save', data={}).status_code == 403, 'CSRF-required')
        entry_page = web.get(f'/timecards?client_id={client_id}&week=2026-10-19')
        values = dict(csrf=csrf(entry_page), client_id=str(client_id), week='2026-10-19',
            version='0', projects=str(project_id), internal='0')
        for day, value in enumerate(['0:07', '0:19', '0:43', '', '', '', '']):
            values[f'duration_{project_id}_{day}'] = value
        response = web.post('/timecards/save', data=values)
        check(response.status_code == 200, 'native-save-response')
        # New database connection, raw SQL, not the app's success notice or totals.
        with factory() as db:
            stored = db.execute(text('SELECT work_date,minutes FROM time_entries ORDER BY work_date')).all()
            check(stored == [(date(2026,10,19),7),(date(2026,10,20),19),(date(2026,10,21),43)], 'fresh-SQL-saved-minutes')
            card = db.scalar(select(Timecard))
            card_id, version = card.id, card.version
        response = web.post(f'/timecards/{card_id}/finalize', data={'csrf': csrf(response), 'version': str(version)})
        check(response.status_code == 200, 'native-finalize')
        response = web.post('/billing/create', data={'csrf': csrf(response), 'client_id': str(client_id),
            'period_start':'2026-10-19','period_end':'2026-10-25'})
        check(response.status_code == 200, 'native-billing-create')
        with factory() as db:
            invoice = db.scalar(select(Invoice))
            invoice_id = invoice.id
            check(invoice.total == Decimal('54.20'), 'independent-69min-47.13-total-54.20')
        response = web.get(f'/billing/{invoice_id}')
        draft = web.get(f'/billing/{invoice_id}/pdf')
        draft_text = '\n'.join(p.extract_text() for p in PdfReader(BytesIO(draft.content)).pages)
        check('BORRADOR' in draft_text and '54.20' in draft_text, 'draft-PDF-open-text-total-watermark')
        route = f'/billing/{invoice_id}/issue'
        import app.pdf
        original_render = app.pdf.render
        def broken_render(*args, **kwargs):
            raise RuntimeError('Independent synthetic PDF dependency failure')
        app.pdf.render = broken_render
        try:
            rejected = web.post(route, data=forms(response, route))
            check(rejected.status_code == 503, 'render-failure-not-success')
            with factory() as db:
                check(db.get(Invoice, invoice_id).status == 'Draft' and db.scalar(select(Artifact)) is None, 'fresh-SQL-render-failure-rollback')
        finally:
            app.pdf.render = original_render
        response = web.post(route, data=forms(response, route))
        check(response.status_code == 200, 'native-publish')
        with factory() as db:
            invoice = db.get(Invoice, invoice_id)
            artifact = db.scalar(select(Artifact).where(Artifact.invoice_id == invoice_id))
            check(invoice.status == 'Issued' and artifact is not None, 'fresh-SQL-publish-effect')
            frozen = artifact.pdf_bytes
            checksum = artifact.sha256
            check(hashlib.sha256(frozen).hexdigest() == checksum, 'independent-issued-checksum')
            check(invoice.snapshot['total_minutes'] == 69 and invoice.snapshot['total'] == '54.20', 'frozen-snapshot-independent-values')
            issue_date = invoice.issue_date
        text_pdf = '\n'.join(p.extract_text() for p in PdfReader(BytesIO(frozen)).pages)
        check('BORRADOR' not in text_pdf and '54.20' in text_pdf, 'issued-PDF-text-total-no-watermark')
        root = Path(__file__).resolve().parents[1]
        (root/'evidence'/'independent-synthetic-statement.pdf').write_bytes(frozen)
        (root/'evidence'/'independent-synthetic-statement.txt').write_text(text_pdf, encoding='utf-8')
        response = web.post(f'/billing/{invoice_id}/payment', data={'csrf': csrf(response),
            'amount':'13.07','currency':'USD','paid_at':str(issue_date),'method':'Synthetic audit transfer'})
        check(response.status_code == 200, 'native-manual-payment')
    factory.kw['bind'].dispose()
    factory = session_factory(url)
    with factory() as db:
        check(db.scalar(text('SELECT SUM(amount) FROM payments')) == Decimal('13.07'), 'fresh-engine-payment-persistence')
        invoice = db.get(Invoice, invoice_id)
        check(billing.balance(db, invoice) == Decimal('41.13'), 'independent-unpaid-balance')
        check(billing.artifact_bytes(db, invoice_id)[0] == frozen, 'fresh-engine-issued-bytes-stable')
    with factory.begin() as db:
        invoice = db.get(Invoice, invoice_id)
        draft = credits.create_draft(db, owner_id, invoice_id, 'Independent amount correction',
            [{'line_id':str(invoice.lines[0].id), 'amount':'11.19'}], expected_invoice_version=invoice.version,
            idempotency_key='independent-credit-draft')
        review = credits.preview(db, owner_id, draft.id)
        credits.issue(db, owner_id, draft.id, expected_version=draft.version, preview_digest=review['digest'], idempotency_key='independent-credit-publish')
    with factory() as db:
        invoice = db.get(Invoice, invoice_id)
        check(billing.balance(db, invoice) == Decimal('29.94'), 'independent-credit-payment-net-balance')
        check(billing.artifact_bytes(db, invoice_id)[0] == frozen, 'credit-preserves-issued-PDF')
        check(db.scalar(text('SELECT COUNT(*) FROM invoice_time_entries')) == 3, 'credit-preserves-permanent-source-claims')
    # Direct SQL guard independent of service/UI immutability checks.
    try:
        with factory.begin() as db:
            db.execute(text("UPDATE invoices SET total=0 WHERE id=:id"), {'id':invoice_id})
    except DBAPIError:
        checks.append('SQL-issued-total-immutable')
    else:
        raise AssertionError('SQL-issued-total-immutable')
    factory.kw['bind'].dispose()

if __name__ == '__main__':
    try:
        if '--flow-only' not in sys.argv:
            domain_oracles()
        financial_route_oracle()
    except Exception as error:
        print(json.dumps({'status':'FAIL','checks_completed':len(checks),'last_checks':checks[-5:], 'error_type':type(error).__name__, 'error':str(error)[:500]}))
        raise
    print(json.dumps({'status':'PASS','checks':len(checks),'seed':20261026, 'domain':'native financial lifecycle' if '--flow-only' in sys.argv else '400 duration/400 integer-cent arithmetic pairs plus invalids and native financial lifecycle', 'last_checks':checks[-26:]}))
