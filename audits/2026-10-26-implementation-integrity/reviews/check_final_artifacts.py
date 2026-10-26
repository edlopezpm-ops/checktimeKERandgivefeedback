"""Read-only root artifact consistency check. Writes reviewer-owned output only."""
from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
from urllib.parse import unquote

ROOT=Path(__file__).resolve().parents[1]
contract=json.loads((ROOT/'reviews/contract.json').read_text(encoding='utf-8'))
matrix=json.loads((ROOT/'MATRIX.json').read_text(encoding='utf-8'))
score=json.loads((ROOT/'SCORECARD.json').read_text(encoding='utf-8'))
findings=json.loads((ROOT/'FINDINGS.json').read_text(encoding='utf-8'))
coverage=json.loads((ROOT/'COVERAGE.json').read_text(encoding='utf-8'))
frozen={c['id']:c for c in contract['capabilities']}
final={c['id']:c for c in matrix['capabilities']}
weight_match={k:v['weight'] for k,v in frozen.items()}=={k:v['weight'] for k,v in final.items()}
contract_field_changes=[]
for identifier,original in frozen.items():
    for field,value in original.items():
        if field not in {'status','unknown_reason','evidence'} and final.get(identifier,{}).get(field)!=value:
            contract_field_changes.append({'id':identifier,'field':field})
W=sum(c['weight'] for c in final.values())
weights={state:sum(c['weight'] for c in final.values() if c['status']==state) for state in ('PASS','FAIL','UNKNOWN')}
counts=Counter(c['status'] for c in final.values())
missing_evidence=[]
def walk(value,path=''):
    if isinstance(value,dict):
        for key,item in value.items():
            if key in {'evidence','recovered_evidence'} and isinstance(item,list):
                for ref in item:
                    if isinstance(ref,str) and ref.startswith(('evidence/','repro/','reviews/')) and not (ROOT/ref).exists():
                        missing_evidence.append({'at':path+'.'+key,'reference':ref})
            walk(item,path+'.'+key)
    elif isinstance(value,list):
        for index,item in enumerate(value):walk(item,path+f'[{index}]')
walk(matrix,'MATRIX');walk(findings,'FINDINGS')
broken_links=[]
for name in ('REPORT.md','REPRODUCE.md'):
    for match in re.finditer(r'\[[^\]]+\]\(([^)]+)\)',(ROOT/name).read_text(encoding='utf-8')):
        target=match.group(1).strip('<>')
        if '://' in target or target.startswith('#'):continue
        local=unquote(target.split('#',1)[0])
        if not (ROOT/local).exists():broken_links.append({'file':name,'target':target})
catalog=coverage['files']
unique_paths=len({f['path'] for f in catalog})
full=sum('static_semantic_full' in f['modes'] for f in catalog)
sampled=sum('static_sampled' in f['modes'] for f in catalog)
finding_ids={f['id'] for f in findings['findings']}
unlinked_findings=sorted({f for c in final.values() for f in c.get('finding_ids',[])}-finding_ids)
roots=['REPORT.md','MATRIX.json','SCORECARD.json','FINDINGS.json','COVERAGE.json','REPRODUCE.md']
hashes={name:hashlib.sha256((ROOT/name).read_bytes()).hexdigest() for name in roots}
result={'reviewed_at_utc':datetime.now(timezone.utc).isoformat(),'root_artifact_hashes':hashes,
        'weight_match':weight_match,'frozen_contract_field_changes':contract_field_changes,
        'computed_W':W,'computed_weights':weights,'computed_counts':dict(counts),
        'score_numerators_match':(score['W'],score['P'],score['F'],score['U'])==(W,weights['PASS'],weights['FAIL'],weights['UNKNOWN']),
        'matrix_hash_matches_score':hashes['MATRIX.json']==score['matrix_sha256'],
        'contract_hash_matches_score':hashlib.sha256((ROOT/'reviews/contract.json').read_bytes()).hexdigest()==score['contract_sha256'],
        'missing_evidence':missing_evidence,'broken_markdown_links':broken_links,'unlinked_finding_ids':unlinked_findings,
        'coverage_recorded_files':len(catalog),'coverage_unique_paths':unique_paths,'coverage_full':full,'coverage_sampled':sampled,
        'coverage_summary_matches':(len(catalog),unique_paths,full,sampled)==(coverage['inventory_files'],coverage['inventory_files'],coverage['semantic_full_files'],coverage['sampled_files']),
        'scope_review':'Report distinguishes 100% inventory from212 full semantic files/27 sampled; no line/branch coverage claim; no real provider/authentication/payment/email/capacity/recovery proof inferred.',
        'publication_review':'Parent confirms dossier README excludes PDF/PNG invoice artifacts and normalizes local paths. This subreview does not certify a public package that has not yet been assembled.',
        'corrections_requested':[
            {'id':'R-FINAL01','topic':'FIN-01 source line_amount is app/domain.py48-49, not52-53.'},
            {'id':'R-FINAL02','topic':'B02 predicate is app/archiving.py38-42; declared read tool93-101; wrangler cron11.'},
            {'id':'R-FINAL03','topic':'B01 add startup129-134/deep741-747; cheap health724-730 intentionally bounded.'},
            {'id':'R-FINAL04','topic':'C12/C15 must incorporate confirmed rounding propagation; parent accepted surface repro and original-weight FAIL adjudication.'},
            {'id':'R-FINAL05','topic':'REPRODUCE migration_review_probe.py should name actual migration_model_compare.py; parent correcting.'}],
        'source_changes_made':False}
result['mechanical_checks_pass']=all([weight_match,not contract_field_changes,result['score_numerators_match'],result['matrix_hash_matches_score'],result['contract_hash_matches_score'],not missing_evidence,not broken_links,not unlinked_findings,result['coverage_summary_matches']])
(ROOT/'reviews/final-artifact-review.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,ensure_ascii=False,indent=2))
