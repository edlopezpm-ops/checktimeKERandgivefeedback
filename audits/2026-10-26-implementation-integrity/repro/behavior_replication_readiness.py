import os,sys,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
os.environ['TIMEKER_TEST_DATABASE_URL']='postgresql+psycopg://timeker_app@127.0.0.1:55526/behavior_audit_test'
os.environ['TIMEKER_DATABASE_URL']=os.environ['TIMEKER_TEST_DATABASE_URL']
os.environ['TIMEKER_TEST_ADMIN_ROLE']='audit_admin'
os.environ['TIMEKER_ENVIRONMENT']='test'
from sqlalchemy import text
from tests.integration.test_tenancy import tenant_pair
fixture=tenant_pair.__wrapped__()
pair=next(fixture)
try:
    own=pair.registry.default
    with pair.admin.connect() as db:db.execute(text('ALTER ROLE '+own.role+' REPLICATION'))
    with own.factory() as db:
        role=db.execute(text('SELECT rolreplication,rolsuper,rolcreatedb,rolcreaterole,rolbypassrls FROM pg_roles WHERE rolname=current_user')).one()
    pair.registry.ready()
    result={'configuration':'two isolated nonowner schema roles from existing fixture; only role attributes instrumented; baseline ready first','replication':role[0],'other_elevated_flags':list(role[1:]),'readiness':'ACCEPTED','expected':'Reject runtime replication privilege under deploy/postgres/README.md:59-61','scope':'local isolated schemas only, not actual Stage or PROD'}
    (ROOT/'evidence'/'behavior-replication-readiness.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps(result))
finally:
    with pair.admin.connect() as db:db.execute(text('ALTER ROLE '+own.role+' NOREPLICATION'))
    try:next(fixture)
    except StopIteration:pass
