import collections,json,sys
from pathlib import Path
from xml.etree import ElementTree as ET
root=Path(__file__).resolve().parents[1]
for name in sys.argv[1:]:
    file=root/'evidence'/name
    tree=ET.parse(file)
    rows=[]
    for case in tree.iter('testcase'):
        for kind in ('failure','error','skipped'):
            value=case.find(kind)
            if value is not None:
                rows.append({'node':case.get('classname').replace('.','/')+'.py::'+case.get('name'),'kind':kind,'message':value.get('message','')[:900],'text':(value.text or '')[-2200:]})
    counts={'total':sum(1 for x in tree.iter('testcase')),'failure':sum(x['kind']=='failure' for x in rows),'error':sum(x['kind']=='error' for x in rows),'skipped':sum(x['kind']=='skipped' for x in rows)}
    result={'file':name,'counts':counts,'nonpassing':rows}
    out=file.with_suffix('.summary.json')
    out.write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps({'file':name,'counts':counts,'groups':dict(collections.Counter((x['kind']+':'+x['message'].splitlines()[0][:180]) for x in rows))},indent=2))
