"""Independent clean migration/catalog comparison on a new loopback test database."""
import importlib
import json
import os
from pathlib import Path
import sys
import time

AUDIT = Path(__file__).resolve().parents[1]
PRODUCT = AUDIT / 'sandbox/product'
sys.path.insert(0, str(PRODUCT))
os.chdir(PRODUCT)
for key in list(os.environ):
    if key.startswith('TIMEKER_'):
        del os.environ[key]
DATABASE = 'timeker_schema_contract_audit_test'
assert DATABASE.startswith('timeker_') and DATABASE.endswith('_test')
os.environ.update(TIMEKER_ENVIRONMENT='test',
    TIMEKER_DATABASE_URL=f'postgresql+psycopg://audit_admin@127.0.0.1:55526/{DATABASE}')
import psycopg
from sqlalchemy import create_engine, inspect, text
from alembic import command
from alembic.config import Config
from alembic.autogenerate import compare_metadata
from alembic.migration import MigrationContext

start = time.perf_counter()
with psycopg.connect(host='127.0.0.1',port=55526,dbname='postgres',user='audit_admin',autocommit=True) as admin:
    exists = admin.execute('SELECT EXISTS(SELECT 1 FROM pg_database WHERE datname=%s)',(DATABASE,)).fetchone()[0]
    if exists and '--inspect-existing' not in sys.argv:
        raise RuntimeError('Refusing to reuse existing target; create a newly named disposable target')
    if not exists:
        admin.execute('CREATE DATABASE ' + DATABASE + ' OWNER audit_admin')
engine = create_engine(os.environ['TIMEKER_DATABASE_URL'], hide_parameters=True)
cfg = Config(str(PRODUCT/'alembic.ini'))
cfg.set_main_option('script_location', str(PRODUCT/'alembic'))
with engine.connect() as connection:
    cfg.attributes['connection'] = connection
    if not exists:
        command.upgrade(cfg, 'head')
    for p in (PRODUCT/'app').glob('*models.py'):
        importlib.import_module('app.'+p.stem)
    from app.models import Base
    context = MigrationContext.configure(connection, opts={'compare_type':True, 'compare_server_default':True})
    differences = compare_metadata(context, Base.metadata)
    inspector = inspect(connection)
    tables = sorted(set(inspector.get_table_names())-{'alembic_version'})
    model_tables = sorted(Base.metadata.tables)
    missing_columns = []
    extra_columns = []
    column_types = []
    for table in tables:
        actual = {c['name']:c for c in inspector.get_columns(table)}
        expected = Base.metadata.tables.get(table)
        if expected is None:
            continue
        expected_names = set(expected.columns.keys())
        missing_columns.extend([table+'.'+c for c in expected_names-set(actual)])
        extra_columns.extend([table+'.'+c for c in set(actual)-expected_names])
        for column in expected.columns:
            if column.name in actual:
                observed = actual[column.name]
                actual_type = str(observed['type'].compile(dialect=engine.dialect))
                model_type = str(column.type.compile(dialect=engine.dialect))
                if actual_type != model_type:
                    column_types.append({'column':table+'.'+column.name,'actual':actual_type,'model':model_type})
    functions = connection.execute(text("""SELECT p.proname,p.proconfig FROM pg_proc p
      JOIN pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname=current_schema()
      ORDER BY p.proname""")).mappings().all()
    triggers = connection.execute(text("""SELECT c.relname,t.tgname,p.proname,t.tgdeferrable,t.tginitdeferred
      FROM pg_trigger t JOIN pg_class c ON c.oid=t.tgrelid JOIN pg_proc p ON p.oid=t.tgfoid
      JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=current_schema() AND NOT t.tgisinternal
      ORDER BY c.relname,t.tgname""")).mappings().all()
    constraints = sum(len(inspector.get_check_constraints(table)) for table in tables)
    head = connection.scalar(text('SELECT version_num FROM alembic_version'))
result = {'target':'new disposable loopback database '+DATABASE,'head':head,
    'elapsed_seconds':time.perf_counter()-start,'actual_tables':tables,'model_tables':model_tables,
    'actual_table_count':len(tables),'model_table_count':len(model_tables),
    'missing_model_tables':sorted(set(tables)-set(model_tables)),
    'missing_actual_tables':sorted(set(model_tables)-set(tables)),
    'missing_columns':missing_columns,'extra_columns':extra_columns,'type_string_differences':column_types,
    'autogenerate_differences':[{'kind':change[0],'table':change[2],'column':change[3],
                               'actual_server_default':str(change[-2].arg) if getattr(change[-2],'arg',None) is not None else None,
                               'model_server_default':str(change[-1].arg) if getattr(change[-1],'arg',None) is not None else None}
                              for group in differences for change in (group if isinstance(group,list) else [group])],
    'check_constraint_count':constraints,'functions':[dict(f) for f in functions],
    'triggers':[dict(t) for t in triggers],
    'limits':'No external provider. Autogenerate does not compare all CHECK expressions or trigger semantics. Static review covers these separately. Target retained for audit, no data from Stage/PROD.'}
result['instrumentation_note'] = 'Initial generic type __str__ comparison emitted dialect aliases as differences; corrected to compile both types against the same PostgreSQL dialect. Initial output retained separately; those aliases are not defects.'
evidence_path = AUDIT/'evidence/migration-model-compare.json'
if evidence_path.exists() and not (AUDIT/'evidence/migration-model-compare-initial.json').exists():
    evidence_path.rename(AUDIT/'evidence/migration-model-compare-initial.json')
evidence_path.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
engine.dispose()
print(json.dumps({k:v for k,v in result.items() if k not in {'functions','triggers','actual_tables','model_tables'}}))
