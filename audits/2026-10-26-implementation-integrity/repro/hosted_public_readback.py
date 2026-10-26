import hashlib,json,sys,time
from pathlib import Path
from datetime import datetime,timezone
from urllib.parse import urlsplit
import httpx
ROOT=Path(__file__).resolve().parents[1]
SOURCE=Path(r'<SOURCE_ROOT>')
ORIGIN='https://stage-timeker.aekr.io'
checks=[]
assets={'/static/app.js':'app/web/static/app.js','/static/app.css':'app/web/static/app.css','/static/timecards.js':'app/web/static/timecards.js','/static/wordmark.svg':'app/web/static/wordmark.svg'}
start=datetime.now(timezone.utc).isoformat()
for path in ['/health/live','/health/ready','/sign-in',*assets]:
    instant=datetime.now(timezone.utc).isoformat()
    clock=time.perf_counter()
    item={'path':path,'observed_utc':instant,'method':'GET'}
    if path in assets:
        item['source_path']=assets[path]
        item['source_sha256']=hashlib.sha256((SOURCE/assets[path]).read_bytes()).hexdigest()
    try:
        # No cookies retained across public observations; no credentials or environment proxy.
        with httpx.Client(timeout=httpx.Timeout(20,connect=8),follow_redirects=False,trust_env=False) as client:
            with client.stream('GET',ORIGIN+path,headers={'User-Agent':'timeKER-functional-audit-public-readback/1.0','Accept-Encoding':'identity'}) as response:
                item.update(status_code=response.status_code,content_type=response.headers.get('content-type',''),cache_control=response.headers.get('cache-control',''),set_cookie_present='set-cookie' in response.headers)
                location=response.headers.get('location')
                if location:
                    target=urlsplit(location)
                    item['redirect_target_without_query']=target.scheme+'://'+target.netloc+target.path if target.netloc else target.path
                payload=bytearray()
                for chunk in response.iter_bytes():
                    if len(payload)+len(chunk)>4*1024*1024:raise ValueError('Public response exceeds4MiB audit bound')
                    payload.extend(chunk)
        item['bytes']=len(payload)
        if path in assets:
            item['served_sha256']=hashlib.sha256(payload).hexdigest()
            item['matches_current_source']=item['served_sha256']==item['source_sha256']
        elif path.startswith('/health/'):
            try:
                health=json.loads(payload)
                item['public_health_status']=health.get('status') if isinstance(health,dict) and health.get('status') in {'live','ready','ok','unavailable'} else 'unrecognized'
            except (ValueError,UnicodeError):item['public_health_status']='not_json'
        else:
            text=payload.decode('utf-8',errors='replace')
            item['sign_in_copy_present']='Sign in' in text
            item['google_label_present']='Google' in text
        item['observation']='AVAILABLE' if item['status_code']==200 else 'UNCONFIRMED'
    except Exception as error:
        item['observation']='UNKNOWN'
        item['error_type']=type(error).__name__
        # Error messages may include request details; preserve only a fixed classification.
    item['duration_seconds']=round(time.perf_counter()-clock,6)
    checks.append(item)
result={'origin':ORIGIN,'started_utc':start,'finished_utc':datetime.now(timezone.utc).isoformat(),'source_snapshot':'1036d705f7f3721e2fa83df67cf913a40dad65b8','checks':checks,'scope':'Public Stage GET only. No login, cookies/credentials reused, provider action, write, deployment or PROD request.','limitations':['Public source-byte matches attest only these four public asset bodies at these observation times.','No runtime image/source/configuration attestation, privileged health, authenticated business flow, capacity, provider delivery or owner acceptance is established.','HTTP200 alone does not demonstrate persistence or financial effects.','Preceding web viewer calls could not access the two health endpoints; direct HTTP observations recorded separately.']}
(ROOT/'evidence'/'hosted-public-readback.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result))
