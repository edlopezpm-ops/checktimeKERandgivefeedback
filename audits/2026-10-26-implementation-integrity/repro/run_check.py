import json
import os
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PRODUCT = ROOT / 'sandbox' / 'product'
PYTHON = PRODUCT / '.venv' / 'Scripts' / 'python.exe'
ENV = {k: v for k, v in os.environ.items() if not k.startswith('TIMEKER_')}
ENV.update(TIMEKER_TEST_DATABASE_URL='postgresql+psycopg://timeker_app@127.0.0.1:55526/timeker_audit_test', TIMEKER_DATABASE_URL='postgresql+psycopg://timeker_app@127.0.0.1:55526/timeker_audit_test', TIMEKER_ENVIRONMENT='test', WEASYPRINT_DLL_DIRECTORIES=r'<WORKSPACE_ROOT>\timeKER\.local\weasyprint\onedir\weasyprint\_internal', PYTHONUTF8='1', PYTHONDONTWRITEBYTECODE='1')
ENV.update(TIMEKER_TEST_ADMIN_ROLE='timeker_test', TIMEKER_TEST_MIGRATIONS_DATABASE='timeker_migrations_test')
if os.environ.get('AUDIT_DATABASE_NAME'):
    name = os.environ['AUDIT_DATABASE_NAME']
    assert name.startswith('timeker_') and name.endswith('_test') and name.replace('_', '').isalnum()
    ENV['TIMEKER_TEST_DATABASE_URL'] = ENV['TIMEKER_DATABASE_URL'] = 'postgresql+psycopg://timeker_app@127.0.0.1:55526/' + name

if __name__ == '__main__':
    label, *args = sys.argv[1:]
    if args and args[0] == '--raw':
        cmd = args[1:]
    else:
        cmd = [str(PYTHON), *args]
    started = datetime.now(timezone.utc).isoformat()
    clock = time.perf_counter()
    with (ROOT / 'evidence' / (label + '.log')).open('w', encoding='utf-8') as log:
        result = subprocess.run(cmd, cwd=PRODUCT, env=ENV, stdout=log, stderr=subprocess.STDOUT)
    receipt = {'label': label, 'argv': cmd, 'cwd': str(PRODUCT), 'started_utc': started, 'duration_seconds': time.perf_counter()-clock, 'exit_code': result.returncode, 'environment': {k:v for k,v in ENV.items() if k.startswith('TIMEKER_') or k == 'WEASYPRINT_DLL_DIRECTORIES'}}
    (ROOT / 'evidence' / (label + '.receipt.json')).write_text(json.dumps(receipt, indent=2), encoding='utf-8')
    print(json.dumps(receipt))
    print((ROOT / 'evidence' / (label + '.log')).read_text(encoding='utf-8')[-3500:])
    sys.exit(result.returncode)
