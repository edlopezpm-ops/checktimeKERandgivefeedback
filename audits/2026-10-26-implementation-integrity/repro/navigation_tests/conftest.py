"""External observation and opt-in completion waits, ordinary fixtures imported unchanged."""
from collections import Counter
import json
import os
from pathlib import Path
from time import perf_counter
from urllib.parse import urlsplit
import pytest
from playwright.sync_api import expect
from sqlalchemy import select
from app.models import Client,Project,Case
from tests.conftest import factory,config,seeded,db,web,token  # noqa:F401
from tests.e2e.conftest import browser,server,page,login  # noqa:F401

AUDIT=Path(__file__).resolve().parents[2]
def audit_wait_saved(page,server,target):
    if os.getenv('AUDIT_WAIT_FOR_SAVED')!='true':return
    if target=='FINALIZED':expect(page.get_by_role('button',name='Reopen week',exact=True)).to_be_visible()
    else:expect(page).to_have_url(server+target)

@pytest.fixture(autouse=True)
def observe(request,browser,monkeypatch,factory):
    events=[];clock=perf_counter();original=browser.new_context
    def emit(kind,**values):events.append({'elapsed':perf_counter()-clock,'kind':kind,**values})
    def page_observer(page):
        def dialog(item):
            emit('dialog',type=item.type)
            item.dismiss()
        page.on('dialog',dialog)
        page.on('request',lambda req:emit('request',method=req.method,path=urlsplit(req.url).path)
            if req.is_navigation_request() or urlsplit(req.url).path=='/auth/session' else None)
        page.on('response',lambda res:emit('response',status=res.status,path=urlsplit(res.url).path)
            if res.request.is_navigation_request() or urlsplit(res.url).path=='/auth/session' else None)
        page.on('requestfailed',lambda req:emit('requestfailed',path=urlsplit(req.url).path,error=req.failure))
        page.on('framenavigated',lambda frame:emit('navigated',path=urlsplit(frame.url).path) if frame==page.main_frame else None)
    def context(*args,**kwargs):
        result=original(*args,**kwargs);result.on('page',page_observer);return result
    monkeypatch.setattr(browser,'new_context',context)
    yield
    with factory() as connection:
        projects=list(connection.scalars(select(Project)))
        cases=list(connection.scalars(select(Case)))
        readback={'projects_with_expected_flexfield2':sum((p.flexfields or {}).get('flexfield2')=='Diseño técnico · Panamá' for p in projects),
                  'cases_by_status':dict(Counter(c.status for c in cases)),
                  'archived_cases':sum(c.archived_at is not None for c in cases)}
    mode='waited' if os.getenv('AUDIT_WAIT_FOR_SAVED')=='true' else 'immediate'
    filename=request.node.name.replace('/','_')+'.json'
    target=AUDIT/'evidence'/('navigation-'+mode)
    target.mkdir(exist_ok=True)
    (target/filename).write_text(json.dumps({'node':request.node.nodeid,'mode':mode,'events':events,'independent_new_session_SQL_readback':readback},indent=2)+'\n',encoding='utf-8')
