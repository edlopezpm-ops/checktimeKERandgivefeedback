import json
import os
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
import psycopg
from alembic.config import Config
from alembic import command
from sqlalchemy import text
from app.config import Settings
from app.tenancy import TenantRegistry

DATABASE='behavior_audit_test'
ADMIN='audit_admin'
assert DATABASE.endswith('_test')
with psycopg.connect(host='127.0.0.1',port=55526,dbname='postgres',user=ADMIN,autocommit=True) as c:
    if not c.execute('SELECT 1 FROM pg_database WHERE datname=%s',(DATABASE,)).fetchone():
        c.execute('CREATE DATABASE behavior_audit_test OWNER audit_admin')
os.environ['TIMEKER_DATABASE_URL']='postgresql+psycopg://audit_admin@127.0.0.1:55526/behavior_audit_test'
os.environ['TIMEKER_ENVIRONMENT']='test'
command.upgrade(Config(str(PRODUCT/'alembic.ini')),'head')
settings=Settings(environment='test',database_url=os.environ['TIMEKER_DATABASE_URL'],database_role=ADMIN,base_url='http://testserver',allowlist=('new-audit@example.invalid',))
registry=TenantRegistry(settings)
try:
    with registry.default.factory() as db:
        elevated=db.execute(text("SELECT rolsuper,rolcreatedb,rolcreaterole,rolbypassrls FROM pg_roles WHERE rolname=current_user")).one()
        table_owner=db.scalar(text("SELECT current_user::regrole::oid = relowner FROM pg_class WHERE oid='clients'::regclass"))
    registry.ready()
    result={'test':'singleton_role_readiness','configuration':'test environment with one registered workspace and onboarding disabled; same _check_databases branch as single hosted workspace','actual_privileges':{'superuser':elevated[0],'createdb':elevated[1],'createrole':elevated[2],'bypassrls':elevated[3],'clients_table_owner':table_owner},'readiness':'ACCEPTED','scope_limit':'No hosted TLS connection or live role tested. Demonstrates missing guard for one-workspace configuration; not proof actual Stage runtime is elevated.'}
finally:registry.dispose()
(ROOT/'evidence'/'behavior-singleton-readiness.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result))
