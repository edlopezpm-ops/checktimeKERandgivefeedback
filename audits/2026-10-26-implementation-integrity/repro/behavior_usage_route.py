import os,sys,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
url='postgresql+psycopg://audit_admin@127.0.0.1:55526/behavior_mcp_test'
os.environ['TIMEKER_DATABASE_URL']=url
os.environ['TIMEKER_DATABASE_ROLE']='audit_admin'
os.environ['TIMEKER_TEST_DATABASE_URL']=url
os.environ['TIMEKER_ENVIRONMENT']='test'
from fastapi.testclient import TestClient
from cryptography.fernet import Fernet
from app.config import Settings
from app.main import create_app
from app.privacy import POLICY_VERSION
from tests.conftest import csrf
settings=Settings(environment='test',database_url=url,database_role='audit_admin',base_url='http://testserver',session_secret='synthetic-audit-privacy-secret-5233'*2,encryption_key=Fernet.generate_key().decode(),dev_login=True,allowlist=('audit-owner@example.invalid',),optional_usage_enabled=True)
body={'policy':POLICY_VERSION,'event':'page_view','page':'home','action':None}
headers={'origin':'http://testserver','sec-fetch-site':'same-origin'}
with TestClient(create_app(settings)) as web:
    page=web.get('/')
    consent=web.post('/privacy/preferences',data={'csrf':csrf(page),'policy_version':POLICY_VERSION,'choice':'accept_usage'},headers={'Accept':'application/json'})
    anonymous=web.post('/privacy/usage',json=body,headers=headers,follow_redirects=False)
    login=web.post('/auth/local',data={'csrf':csrf(web.get('/'))})
    if login.status_code!=200:raise RuntimeError('Synthetic owner login failed')
    signed=web.post('/privacy/usage',json=body,headers=headers,follow_redirects=False)
result={'oracle':'Enabled optional home category measurement with valid same-origin headers and current signed explicit consent must reach real collector both before and after optional owner login. No runner/router patch.','consent_status':consent.status_code,'consent_usage_enabled':consent.json().get('usage_enabled'),'anonymous_usage_status':anonymous.status_code,'anonymous_usage_redirect':anonymous.headers.get('location'),'owner_usage_status':signed.status_code,'route_expected_status':204,'default_off_qualification':'Baseline environments keep optional measurement off; defect concerns source readiness of explicitly enabled mode, no activation performed.'}
(ROOT/'evidence'/'behavior-usage-route.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result))
