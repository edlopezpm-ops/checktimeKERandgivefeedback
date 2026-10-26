import os,sys,subprocess
from pathlib import Path
from xml.etree import ElementTree as ET
root=Path(__file__).resolve().parents[1]
name,label=sys.argv[1:]
nodes=[]
for case in ET.parse(root/'evidence'/name).iter('testcase'):
    if case.find('error') is not None:
        nodes.append(case.get('classname').replace('.','/')+'.py::'+case.get('name'))
assert nodes
print('Replaying setup errors only:',len(nodes),flush=True)
subprocess.run([sys.executable,str(root/'repro'/'run_check.py'),label,'-m','pytest',*nodes,'-q','--tb=short','--junitxml='+str(root/'evidence'/(label+'.xml'))],check=True)
