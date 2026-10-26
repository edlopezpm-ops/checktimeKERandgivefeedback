import hashlib
import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'repro'))
from run_check import ENV, PYTHON, PRODUCT
ENV['TIMEKER_DATABASE_URL']=ENV['TIMEKER_TEST_DATABASE_URL']='postgresql+psycopg://timeker_app@127.0.0.1:55526/timeker_independent_test'
manifest=json.loads((ROOT/'evidence'/'snapshot-before.json').read_text(encoding='utf-8'))
controls=[
    ('constant_calculation','app/domain.py','return (Decimal(minutes) / Decimal(60) * rate).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)','return Decimal("0.00")',False,'amount-0'),
    ('omit_persistence','app/timecards.py','card.entries = saved_entries','pass  # independent negative control: omit persistence',True,'fresh-SQL-saved-minutes'),
    ('fake_publish_success','app/billing.py','    from app.subscriptions import finish_operation, replay_operation\n\n    _billing_owner(db, actor)\n    payload = {"invoice_id": invoice_id, "preview_digest": expected_digest}', '    return require(db, Invoice, invoice_id)\n    from app.subscriptions import finish_operation, replay_operation\n\n    _billing_owner(db, actor)\n    payload = {"invoice_id": invoice_id, "preview_digest": expected_digest}',True,'render-failure-not-success'),
]
result_path=ROOT/'evidence'/'finance-negative-controls.json'
results=json.loads(result_path.read_text(encoding='utf-8'))['results'] if result_path.exists() else []
for name,path,before,after,flow,label in controls:
    if any(x['operator']==name and x['detected'] for x in results):
        continue
    dest=ROOT/'sandbox'/'mutations'/name
    for row in manifest['files']:
        target=dest/row['path']
        target.parent.mkdir(parents=True,exist_ok=True)
        shutil.copyfile(PRODUCT/row['path'],target)
    source=dest/path
    baseline=source.read_bytes()
    value=baseline.decode('utf-8').replace('\r\n','\n')
    assert value.count(before)==1,(name,value.count(before))
    source.write_text(value.replace(before,after),encoding='utf-8')
    started=time.perf_counter()
    cmd=[str(PYTHON),str(ROOT/'repro'/'independent_finance.py'),str(dest)]
    if flow: cmd.append('--flow-only')
    log=ROOT/'evidence'/('negative-'+name+'.log')
    with log.open('w',encoding='utf-8') as output:
        p=subprocess.run(cmd,cwd=dest,env=ENV,stdout=output,stderr=subprocess.STDOUT,timeout=90)
    content=log.read_text(encoding='utf-8')
    result={'operator':name,'path':path,'exit_code':p.returncode,'detected':p.returncode!=0 and label in content,
        'expected_assertion':label,'duration_seconds':time.perf_counter()-started,'argv':cmd,'log':log.name}
    source.write_bytes(baseline)
    result['restored_sha256']=hashlib.sha256(source.read_bytes()).hexdigest()
    assert result['restored_sha256']==hashlib.sha256(baseline).hexdigest()
    results.append(result)
    result_path.write_text(json.dumps({'results':results},indent=2),encoding='utf-8')
    print(json.dumps(result))
(ROOT/'evidence'/'finance-negative-controls.json').write_text(json.dumps({'tool':'selective source mutation; standalone contract verifier','version':'1','results':results,'detected':sum(x['detected'] for x in results),'surviving':sum(not x['detected'] for x in results),'timeouts':0,'equivalent':0,'invalid':0},indent=2),encoding='utf-8')
assert all(x['detected'] for x in results)
