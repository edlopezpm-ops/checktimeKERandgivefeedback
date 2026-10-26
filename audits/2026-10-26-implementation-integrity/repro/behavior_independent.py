import asyncio
import hashlib
import json
import sys
from pathlib import Path
from uuid import uuid4

ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
from app.config import Settings
from app.domain import DomainError
from app.integration_auth import IntegrationError, new_credential, parse_credential
from app.proposal_sending import ProposalResult, normalize_result
from app.proposal_sending_transport import classify_response
from app.subscription_billing import _direction

checks=[]
def check(name, predicate):
    assert predicate, name
    checks.append(name)

def rejects(fn):
    try: fn()
    except (ValueError,DomainError,IntegrationError): return True
    return False

tenant,identifier=uuid4(),uuid4()
for i in range(100):
    raw=new_credential('tka',tenant,identifier)
    check(f'credential_roundtrip_{i}',parse_credential(raw,'tka')==(tenant,identifier))
    check(f'credential_wrong_kind_{i}',rejects(lambda:parse_credential(raw,'tkr')))
    check(f'credential_truncated_{i}',rejects(lambda:parse_credential(raw[:-1],'tka')))
check('production_local_login_fail_closed',rejects(lambda:Settings(environment='production',dev_login=True)))
check('disabled_outbound_with_credentials_fail_closed',rejects(lambda:Settings(sending_provider='disabled',sending_api_token='synthetic-not-a-real-token')))
for source,target in [('solo_monthly','solo_annual'),('solo_annual','pro_monthly'),('pro_monthly','solo_annual'),('pro_annual','pro_monthly')]:
    check('cross_cycle_fail_closed_'+source+'_'+target,rejects(lambda:_direction(source,target)))
recipient='audit-new-731@example.invalid'
for label,status,body,expected in [
 ('malformed',200,b'{','uncertain'),
 ('unproved_200',200,b'{}','uncertain'),
 ('accepted_queued',200,json.dumps({'success':True,'result':{'delivered':[],'queued':[recipient],'permanent_bounces':[]}}).encode(),'sent'),
 ('mismatched_address',200,json.dumps({'success':True,'result':{'delivered':[],'queued':['other@example.invalid'],'permanent_bounces':[]}}).encode(),'uncertain'),
 ('duplicate_status',200,json.dumps({'success':True,'result':{'delivered':[recipient],'queued':[recipient],'permanent_bounces':[]}}).encode(),'uncertain'),
 ('suppressed',200,json.dumps({'success':True,'result':{'delivered':[],'queued':[],'permanent_bounces':[],'suppressed_recipients':[recipient]}}).encode(),'failed'),
 ('ambiguous_server_error',500,json.dumps({'success':False,'errors':[{'code':1}]}).encode(),'uncertain'),
 ('definitive_rejection',403,json.dumps({'success':False,'errors':[{'code':1}],'result':None}).encode(),'failed'),
]: check('proposal_provider_'+label,classify_response(status,body,recipient).state==expected)
for state,code in [('sent','provider_rejected'),('failed','provider_queued'),('uncertain','recipient_bounced')]:
    check('inconsistent_outcome_'+state,normalize_result(ProposalResult(state,code)).state=='uncertain')
result={'oracle':'Contract-derived protocol/disabled-provider/cycle constraints; explicit expected states independent of product calculation. No network/DB/provider effects.','passed':len(checks),'checks':checks}
(ROOT/'evidence'/'behavior-independent.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps({'passed':len(checks),'failed':0}))
