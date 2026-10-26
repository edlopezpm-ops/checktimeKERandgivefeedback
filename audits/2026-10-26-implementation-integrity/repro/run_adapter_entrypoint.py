"""Instrument only the container SDK import in disposable copies; check live export dispatch."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import time

ROOT = Path(r"<SOURCE_ROOT>/deploy/cloudflare")
AUDIT = Path(__file__).resolve().parents[1]
COPY = AUDIT / 'repro/adapter-entrypoint-copy'
COPY.mkdir(exist_ok=True)
shutil.copytree(ROOT/'src',COPY/'src',dirs_exist_ok=True)
path = COPY/'src/index.ts'
baseline_hash = hashlib.sha256((ROOT/'src/index.ts').read_bytes()).hexdigest()
source = path.read_text(encoding='utf-8').replace('"@cloudflare/containers"','"./audit-container-stub.mjs"')
path.write_text(source,encoding='utf-8')
(COPY/'src/audit-container-stub.mjs').write_text('export class Container {}\nexport class ContainerProxy {}\nexport const getContainer=(namespace,id)=>({fetch:request=>globalThis.__auditUpstream(namespace,id,request)});\n',encoding='utf-8')
results=[]
for kind in ['baseline','mutated']:
    if kind == 'mutated':
        before='return proxyRequest(request, env, forwarded =>\n      getContainer(env.TIMEKER_PH2_STAGE_CONTAINER, "timeker-ph2-stage-v1").fetch(forwarded));'
        assert source.count(before)==1
        path.write_text(source.replace(before,'return new Response("Simulated success without product execution", {status:200});'),encoding='utf-8')
    command=['node',str(AUDIT/'repro/adapter_entrypoint_independent.mjs'),str(path)]
    started=time.perf_counter()
    result=subprocess.run(command,capture_output=True,text=True,timeout=30)
    (AUDIT/f'evidence/adapter-independent-{kind}.log').write_text(result.stdout+result.stderr,encoding='utf-8')
    results.append({'kind':kind,'command':command,'exit_code':result.returncode,'elapsed_seconds':time.perf_counter()-started})
path.write_text(source,encoding='utf-8')
report={'results':results,'baseline_passed':results[0]['exit_code']==0,'previously_surviving_mutation_detected':results[1]['exit_code']==1,
        'product_source_unchanged':baseline_hash==hashlib.sha256((ROOT/'src/index.ts').read_bytes()).hexdigest(),
        'limitation':'SDK/container provider implementation is stubbed; actual exported application binding and proxy execute.'}
(AUDIT/'evidence/adapter-independent-entrypoint.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(report,indent=2))
