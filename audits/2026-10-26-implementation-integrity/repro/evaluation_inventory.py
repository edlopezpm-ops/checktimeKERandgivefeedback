"""Static test/lockfile inventory; discovery is not semantic completeness."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import tomllib

ROOT=Path(r'<SOURCE_ROOT>')
AUDIT=Path(__file__).resolve().parents[1]
files=[]
tautologies=[]
for path in sorted((ROOT/'tests').rglob('*.py')):
    source=path.read_text(encoding='utf-8-sig')
    tree=ast.parse(source)
    functions=[n for n in ast.walk(tree) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)) and n.name.startswith('test_')]
    assertions=[n for n in ast.walk(tree) if isinstance(n,ast.Assert)]
    for node in assertions:
        if isinstance(node.test,ast.Constant) and bool(node.test.value):
            tautologies.append({'path':path.relative_to(ROOT).as_posix(),'line':node.lineno,'kind':'constant_truthy_assert'})
        if isinstance(node.test,ast.Compare) and len(node.test.comparators)==1 and ast.dump(node.test.left)==ast.dump(node.test.comparators[0]):
            tautologies.append({'path':path.relative_to(ROOT).as_posix(),'line':node.lineno,'kind':'self_comparison'})
    files.append({'path':path.relative_to(ROOT).as_posix(),'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
                  'test_function_definitions':len(functions),'python_assert_nodes':len(assertions),
                  'classification':'inventoried/static_AST_screen; not full semantic review'})
package=json.loads((ROOT/'deploy/cloudflare/package.json').read_text())
lock=json.loads((ROOT/'deploy/cloudflare/package-lock.json').read_text())
node_check=[]
for group in ['dependencies','devDependencies']:
    for name,requested in package.get(group,{}).items():
        actual=lock['packages']['node_modules/'+name]['version']
        node_check.append({'name':name,'package_spec':requested,'locked_version':actual,'matches_exact':requested==actual})
uv=tomllib.loads((ROOT/'uv.lock').read_text())
project=tomllib.loads((ROOT/'pyproject.toml').read_text())
tracked=subprocess.check_output(['git','ls-tree','-r','--name-only','HEAD'],cwd=ROOT,text=True).splitlines()
result={'python_test_files':files,'test_function_definitions':sum(x['test_function_definitions'] for x in files),
        'python_assert_nodes':sum(x['python_assert_nodes'] for x in files),'literal_tautology_candidates':tautologies,
        'node_root_lock_alignment':node_check,'uv_lock_version':uv['version'],'uv_lock_revision':uv.get('revision'),
        'uv_locked_packages':len(uv['package']),'requires_python_matches':uv['requires-python']==project['project']['requires-python'],
        'tracked_ci_paths':[x for x in tracked if x.startswith(('.github/','.gitlab-ci','.circleci/','Jenkinsfile','azure-pipelines'))],
        'limitations':['AST tests are function definitions, not parametrized discovered counts.',
                       'Dependency source/binary implementations are inventoried/locked, not exhaustively reviewed.',
                       'No CI configuration in this snapshot does not disprove external repository branch checks.']}
(AUDIT/'evidence/evaluation-inventory.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k!='python_test_files'},indent=2))
