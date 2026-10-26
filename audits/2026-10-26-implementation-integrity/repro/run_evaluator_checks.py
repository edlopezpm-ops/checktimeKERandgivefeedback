import json
from pathlib import Path
import re
import subprocess
import time

ROOT=Path(r'<SOURCE_ROOT>/deploy/cloudflare')
AUDIT=Path(__file__).resolve().parents[1]
results=[]
for name, command in [('adapter-node-tests',['node','--test','--test-reporter=tap',*[str(p.relative_to(ROOT)) for p in (ROOT/'test').glob('*.test.mjs')]]),
                      ('adapter-typescript',['node','node_modules/typescript/bin/tsc','--noEmit'])]:
    start=time.perf_counter()
    result=subprocess.run(command,cwd=ROOT,capture_output=True,text=True,timeout=60)
    output=result.stdout+result.stderr
    (AUDIT/f'evidence/{name}.log').write_text(output,encoding='utf-8')
    item={'name':name,'command':command,'cwd':str(ROOT),'exit_code':result.returncode,'elapsed_seconds':time.perf_counter()-start}
    for key in ['tests','pass','fail','cancelled','skipped','todo']:
        match=re.search(r'^# '+key+r' (\d+)$',output,re.M)
        if match:item[key]=int(match[1])
    results.append(item)
(AUDIT/'evidence/evaluator-runs.json').write_text(json.dumps(results,indent=2)+'\n',encoding='utf-8')
print(json.dumps(results,indent=2))
