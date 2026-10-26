"""Raw invalid CSRF must be rejected by full app; no browser-refresh code in this request."""
from dataclasses import replace
from html.parser import HTMLParser
import json
from pathlib import Path
from urllib.parse import urlencode
from cryptography.fernet import Fernet
from fastapi.testclient import TestClient
from sqlalchemy import func,select,text
from authlib.oauth2.rfc7636 import create_s256_code_challenge
from app.config import Settings
from app.db import session_factory
from app.main import create_app
from app.models import User
from app.integration_models import IntegrationGrant,IntegrationCode
from app.seed import FIXTURE_OWNER

AUDIT=Path(__file__).resolve().parents[1]
URL='postgresql+psycopg://timeker_app@127.0.0.1:55526/timeker_diagnostic_test'
CLIENT='audit-independent-csrf';CALLBACK='https://assistant.example.invalid/audit-callback'
cfg=Settings(environment='test',database_url=URL,base_url='http://testserver',dev_login=True,
             allowlist=(FIXTURE_OWNER,),session_secret='independent-oauth-csrf-key-'*3,encryption_key=Fernet.generate_key().decode(),
             integration_enabled=True,integration_clients_json=json.dumps([{'client_id':CLIENT,'name':'Independent synthetic client','redirect_uris':[CALLBACK]}]))
class Forms(HTMLParser):
    def __init__(self,html):super().__init__();self.forms=[];self.current=None;self.feed(html)
    def handle_starttag(self,tag,attrs):
        attrs=dict(attrs)
        if tag=='form':self.current={'action':attrs.get('action',''),'fields':{}};self.forms.append(self.current)
        elif tag=='input' and self.current is not None and attrs.get('name'):self.current['fields'][attrs['name']]=attrs.get('value','')
    def handle_endtag(self,tag):
        if tag=='form':self.current=None
factory=session_factory(URL)
with factory() as db:
    assert db.scalar(text('SELECT current_database()'))=='timeker_diagnostic_test'
    assert db.scalar(select(User.id).where(User.email==FIXTURE_OWNER)) is not None
app=create_app(cfg)
with TestClient(app) as web:
    form=next(form for form in Forms(web.get('/').text).forms if form['action']=='/auth/local')
    assert web.post('/auth/local',data=form['fields']).status_code==200
    query={'response_type':'code','client_id':CLIENT,'redirect_uri':CALLBACK,'scope':'clients:read','state':'independent-synthetic-state',
           'code_challenge':create_s256_code_challenge('audit-independent-verifier-'*3),'code_challenge_method':'S256','resource':'http://testserver/mcp'}
    consent=web.get('/oauth/authorize?'+urlencode(query));assert consent.status_code==200
    form=next(form for form in Forms(consent.text).forms if form['action']=='/oauth/authorize')
    assert 'csrf' in form['fields']
    def counts():
        with factory() as db:return {'grants':db.scalar(select(func.count()).select_from(IntegrationGrant).where(IntegrationGrant.client_id==CLIENT)),
                                    'codes':db.scalar(select(func.count()).select_from(IntegrationCode).join(IntegrationGrant,IntegrationGrant.id==IntegrationCode.grant_id).where(IntegrationGrant.client_id==CLIENT))}
    before=counts()
    invalid=web.post('/oauth/authorize',data={**form['fields'],'csrf':'explicitly-invalid-csrf','decision':'allow'},follow_redirects=False)
    after_invalid=counts()
    valid=web.post('/oauth/authorize',data={**form['fields'],'decision':'allow'},follow_redirects=False)
    after_valid=counts()
    result={'scope':'full create_app; own loopback diagnostic_test; no test imports/route patches; synthetic consent only',
            'consent_get_status':consent.status_code,'invalid_raw_csrf_status':invalid.status_code,
            'invalid_raw_csrf_has_redirect':'location' in invalid.headers,'before':before,'after_invalid':after_invalid,
            'valid_csrf_control_status':valid.status_code,'after_valid':after_valid,
            'verdict':'Raw invalid CSRF rejected without grants/codes; valid token accepted. Browser DOM-tamper test must account for explicit session preflight refresh.'}
    assert invalid.status_code==403 and after_invalid==before
    assert valid.status_code==302 and after_valid['grants']==before['grants']+1
    (AUDIT/'evidence/oauth-csrf-refutation.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))
factory.kw['bind'].dispose()
