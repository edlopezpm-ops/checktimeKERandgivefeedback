"""Recompute the audit policy score from the frozen-weight capability matrix."""
import hashlib,json,sys
from fractions import Fraction
from pathlib import Path

root=Path(__file__).resolve().parents[1]
matrix=json.loads((root/'MATRIX.json').read_text(encoding='utf-8'))
contract=json.loads((root/'reviews'/'contract.json').read_text(encoding='utf-8'))
frozen={x['id']:x['weight'] for x in contract['capabilities']}
rows=matrix['capabilities']
assert {x['id']:x['weight'] for x in rows}==frozen
assert len({x['id'] for x in rows})==len(rows)
assert all(x['status'] in ('PASS','FAIL','UNKNOWN') for x in rows)
W=sum(x['weight'] for x in rows)
P=sum(x['weight'] for x in rows if x['status']=='PASS')
F=sum(x['weight'] for x in rows if x['status']=='FAIL')
U=sum(x['weight'] for x in rows if x['status']=='UNKNOWN')
assert W==P+F+U
def metric(n):
    return {'numerator':n,'denominator':W,'exact_percent':str(Fraction(100*n,W)) if W else 'N/A','display_percent':round(100*n/W,2) if W else None}
out={'schema':'functional-integrity.scorecard.v1','snapshot':matrix['snapshot_head'],
    'contract_sha256':hashlib.sha256((root/'reviews'/'contract.json').read_bytes()).hexdigest(),
    'matrix_sha256':hashlib.sha256((root/'MATRIX.json').read_bytes()).hexdigest(),
    'W':W,'P':P,'F':F,'U':U,'identity_W_equals_P_F_U':W==P+F+U,
    'D_demonstrated':metric(P),'C_decision':metric(P+F),'confirmed_failure':metric(F),'pending':metric(U),
    'capability_counts':{s:sum(x['status']==s for x in rows) for s in ('PASS','FAIL','UNKNOWN')},
    'inventory_closed':matrix['inventory_closed'],'provisional':not matrix['inventory_closed'],
    'verdict':'FAIL' if F else 'INCONCLUSIVE' if U or not matrix['inventory_closed'] else 'VERIFIED_WITHIN_SCOPE',
    'interpretation':'Audit policy of capability evidence; not probability of cheating, author attribution, branch coverage or estimate of every possible defect.'}
file=root/'SCORECARD.json'
if '--check' in sys.argv:
    assert json.loads(file.read_text(encoding='utf-8'))==out
else:
    file.write_text(json.dumps(out,indent=2),encoding='utf-8')
print(json.dumps(out,indent=2))
