"""Independent native GET trace from actual rendered forms on disposable PostgreSQL."""
from datetime import UTC,datetime,timedelta
from html.parser import HTMLParser
import json
from pathlib import Path
from urllib.parse import urlencode
from cryptography.fernet import Fernet
from fastapi.testclient import TestClient
from sqlalchemy import text

from app.config import Settings
from app.db import session_factory
from app.main import create_app
from app.models import Base,Client
from app.seed import FIXTURE_OWNER,seed
from app.settings import save_lookup_limits
from app.subscription_models import WorkspaceSubscription
from app.subscriptions import CATALOG_VERSION

AUDIT=Path(__file__).resolve().parents[1]
URL='postgresql+psycopg://timeker_app@127.0.0.1:55526/timeker_diagnostic_test'
cfg=Settings(environment='test',database_url=URL,base_url='http://testserver',
             session_secret='independent-native-billing-session-'*3,encryption_key=Fernet.generate_key().decode(),
             dev_login=True,allowlist=(FIXTURE_OWNER,))

class Forms(HTMLParser):
    def __init__(self,html):
        super().__init__();self.forms=[];self.current=None;self.select=None;self.feed(html)
    def handle_starttag(self,tag,attrs):
        attrs=dict(attrs)
        if tag=='form':
            self.current={'action':attrs.get('action',''),'method':attrs.get('method','get'),'fields':{},'buttons':[]};self.forms.append(self.current)
        elif self.current is not None:
            if tag=='input' and attrs.get('name'):self.current['fields'][attrs['name']]=attrs.get('value','')
            elif tag=='select' and attrs.get('name'):self.select=attrs['name'];self.current['fields'][self.select]=''
            elif tag=='option' and self.select and 'selected' in attrs:self.current['fields'][self.select]=attrs.get('value','')
            elif tag=='button':self.current['buttons'].append(attrs)
    def handle_endtag(self,tag):
        if tag=='form':self.current=None
        if tag=='select':self.select=None

factory=session_factory(URL)
with factory.begin() as db:
    assert db.scalar(text('SELECT current_database()'))=='timeker_diagnostic_test'
    assert str(db.scalar(text('SELECT inet_server_addr()'))) in {'127.0.0.1','::1'}
    names=','.join(table.name for table in reversed(Base.metadata.sorted_tables))
    db.execute(text('TRUNCATE '+names+' CASCADE'))
    actor,client=seed(db,cfg,'fixture');actor_id,client_id=actor.id,client.id
    db.add(WorkspaceSubscription(id=1,owner_id=actor_id,plan_code='pro',catalog_revision=CATALOG_VERSION,access_expires_at=datetime.now(UTC)+timedelta(days=30)))
    for number in range(3):
        db.add(Client(code=f'AUD{number}',legal_name='Independent synthetic lookup',display_name=f'Independent lookup{number}',status='active',country_code='US',timezone='UTC',currency='USD',rate=0))
    save_lookup_limits(db,actor_id,{'selector_page_size':'1','selector_search_limit':'4'})

app=create_app(cfg)
with TestClient(app) as web:
    landing=web.get('/')
    form=next(form for form in Forms(landing.text).forms if form['action']=='/auth/local')
    assert web.post('/auth/local',data=form['fields']).status_code==200
    baseline=web.get('/billing');assert baseline.status_code==200
    form=next(form for form in Forms(baseline.text).forms if 'period_start' in form['fields'])
    button=next(item for item in form['buttons'] if item.get('aria-label')=='Search client records')
    submission={**form['fields'],'client_id':'','period_start':'2026-10-01','period_end':'2026-10-31',button['name']:button['value']}
    target=form['action']+'?'+urlencode(submission)
    missing=web.get(target,follow_redirects=False)
    chosen=web.get(form['action']+'?'+urlencode({**submission,'client_id':str(client_id)}),follow_redirects=False)
    control=web.get(form['action']+'?'+urlencode({key:value for key,value in {**submission,'client_id':str(client_id)}.items() if key!=button['name']}),follow_redirects=False)
    result={'snapshot_config':'test/full create_app, own loopback timeker_diagnostic_test, no test imports/no route patches',
            'requirement':'Native lookup search/paging preserves chosen dates and selector controls, including clearing selected client when page size1',
            'initial_billing_status':baseline.status_code,'actual_form_method':form['method'],'actual_form_action':form['action'],
            'actual_lookup_button':{key:button[key] for key in ['name','value','aria-label']},
            'period_start_submitted':submission['period_start'],'period_end_submitted':submission['period_end'],
            'cleared_client_lookup_status':missing.status_code,'cleared_client_error_page':'Invalid request' in missing.text,
            'cleared_client_period_controls_preserved':any('period_start' in form['fields'] for form in Forms(missing.text).forms),
            'selected_client_lookup_status':chosen.status_code,'selected_client_wrong_work_page':'Choose billable work' in chosen.text,
            'selected_client_lookup_controls_preserved':'Search client records' in chosen.text,
            'normal_business_action_status':control.status_code,'normal_business_action_work_page':'Choose billable work' in control.text,
            'source_locations':['app/web/templates/billing.html:4','app/web/templates/lookup.html:17-19','app/main.py:1539'],
            'source_modules':{'create_app':__import__('app.main',fromlist=['x']).__file__}}
    (AUDIT/'evidence/billing-native-lookup.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))
    assert result['cleared_client_lookup_status']==400
    assert result['cleared_client_period_controls_preserved'] is False
    assert result['selected_client_wrong_work_page'] is True
    assert result['selected_client_lookup_controls_preserved'] is False
    assert result['normal_business_action_status']==200
factory.kw['bind'].dispose()
