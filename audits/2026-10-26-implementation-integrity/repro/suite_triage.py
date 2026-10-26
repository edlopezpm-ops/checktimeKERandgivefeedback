"""Read-only map of compact pytest progress to collected IDs; raw errors remain evidence."""
from collections import Counter
import json
from pathlib import Path
import re

AUDIT=Path(__file__).resolve().parents[1]
collection=(AUDIT/'evidence/evaluator-backend-collect.log').read_text(encoding='utf-8')
nodes=[line.strip() for line in collection.splitlines() if line.startswith('tests/') and '::' in line]
raw=(AUDIT/'evidence/backend-complete.log').read_text(encoding='utf-8')
progress=''.join(re.match(r'^([.EFsxX]+)(?:\s+\[[ 0-9%]+\])?$',line).group(1)
                 for line in raw.splitlines() if re.match(r'^([.EFsxX]+)(?:\s+\[[ 0-9%]+\])?$',line))
events=[{'position':i+1,'result':state,'node':nodes[i] if i<len(nodes) else 'UNMAPPED'}
        for i,state in enumerate(progress) if state!='.']
result={'collected':len(nodes),'progress_characters_observed':len(progress),
        'progress_counts':dict(Counter(progress)),
        'events':events,'errors_by_file':dict(Counter(x['node'].split('::')[0] for x in events if x['result']=='E')),
        'failures':[x for x in events if x['result']=='F'],
        'qualification':'Intermediate progress mapping only; source-node order is collect-only under same args. No root-cause assertion without final traceback.'}
(AUDIT/'evidence/suite-progress-map.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k!='events'},indent=2))
