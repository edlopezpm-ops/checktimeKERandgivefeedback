import hashlib,json,subprocess,time
from pathlib import Path
from datetime import datetime,timezone
import httpx
ROOT=Path(__file__).resolve().parents[1]
SOURCE=Path(r'<SOURCE_ROOT>')
prior=json.loads((ROOT/'evidence'/'hosted-public-readback.json').read_text(encoding='utf-8'))
results=[]
for item in prior['checks']:
    if item.get('matches_current_source') is not False:continue
    path=item['path'];source=SOURCE/item['source_path']
    local=source.read_bytes()
    blob=subprocess.run(['git','show','HEAD:'+item['source_path']],cwd=SOURCE,capture_output=True,check=True).stdout
    with httpx.Client(timeout=httpx.Timeout(20,connect=8),follow_redirects=False,trust_env=False) as client:
        reply=client.get(prior['origin']+path,headers={'User-Agent':'timeKER-functional-audit-public-readback/1.0','Accept-Encoding':'identity'})
    payload=reply.content
    sha=lambda b:hashlib.sha256(b).hexdigest()
    results.append({'path':path,'observed_utc':datetime.now(timezone.utc).isoformat(),'status_code':reply.status_code,'source_working_bytes':len(local),'source_working_sha256':sha(local),'source_git_head_blob_bytes':len(blob),'source_git_head_blob_sha256':sha(blob),'served_bytes':len(payload),'served_sha256':sha(payload),'served_unchanged_since_initial':sha(payload)==item['served_sha256'],'served_matches_git_head_blob':payload==blob,'matches_after_crlf_to_lf':payload.replace(b'\r\n',b'\n')==local.replace(b'\r\n',b'\n'),'working_crlf_count':local.count(b'\r\n'),'served_crlf_count':payload.count(b'\r\n')})
result={'origin':prior['origin'],'purpose':'Resolve raw public asset mismatch against Windows checkout and exact Git HEAD blob, without deployment/runtime attestation.','checks':results,'result':'EOL_ONLY' if all(r['served_matches_git_head_blob'] and r['matches_after_crlf_to_lf'] for r in results) else 'CONTENT_DIFFERENCE_OR_UNCONFIRMED','scope':'Three public GETs only; no credential/session reuse, login, remote writes or PROD.'}
(ROOT/'evidence'/'hosted-asset-canonicalization.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result))
