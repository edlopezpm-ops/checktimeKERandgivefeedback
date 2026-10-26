from pathlib import Path
import shutil

AUDIT=Path(__file__).resolve().parents[1]
PRODUCT=AUDIT/'sandbox/product'
TARGET=AUDIT/'repro/navigation_tests'
TARGET.mkdir(exist_ok=True)
for name in ['test_stage_refinements.py','test_work_management.py']:
    source=(PRODUCT/'tests/e2e'/name).read_text(encoding='utf-8')
    source='from conftest import audit_wait_saved\n'+source
    replacements={
      'page.get_by_role("button", name="Save project", exact=True).click()':'/projects',
      'page.get_by_role("button", name="Save case", exact=True).click()':'/cases',
      'page.get_by_role("button", name="Finalize week", exact=True).click()':'FINALIZED',
    }
    for anchor,target in replacements.items():
        lines=source.splitlines();updated=[]
        for line in lines:
            updated.append(line)
            if line.strip()==anchor:
                indent=line[:len(line)-len(line.lstrip())]
                updated.append(indent+f'audit_wait_saved(page, server, "{target}")')
        source='\n'.join(updated)+'\n'
    (TARGET/name).write_text(source,encoding='utf-8')
shutil.copy2(PRODUCT/'tests/e2e/axe.min.js',TARGET/'axe.min.js')
print('Copied two test modules; inserted optional waits only, product baseline unchanged')
