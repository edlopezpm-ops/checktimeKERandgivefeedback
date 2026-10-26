import hashlib
import json
import shutil
import subprocess
from datetime import datetime, timezone
from pathlib import Path

SOURCE = Path(r'<SOURCE_ROOT>')
ROOT = Path(__file__).resolve().parents[1]
COPY = ROOT / 'sandbox' / 'product'

def git(*args):
    return subprocess.check_output(['git', '-C', str(SOURCE), *args]).decode('utf-8').strip()

def collect():
    paths = git('ls-files', '-c', '-o', '--exclude-standard', '-z').split('\0')
    rows = []
    for name in sorted(set(paths)):
        p = SOURCE / name
        if not p.is_file():
            continue
        data = p.read_bytes()
        rows.append({'path': name.replace('\\', '/'), 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    return rows

if __name__ == '__main__':
    rows = collect()
    manifest = {'source': str(SOURCE), 'branch': git('branch', '--show-current'), 'head': git('rev-parse', 'HEAD'), 'time_utc': datetime.now(timezone.utc).isoformat(), 'status': git('status', '--porcelain=v1'), 'files': rows}
    target = ROOT / 'evidence' / 'snapshot-before.json'
    if target.exists():
        original = json.loads(target.read_text(encoding='utf-8'))
        assert rows == original['files'], 'Evaluated source changed'
        (ROOT / 'evidence' / 'snapshot-after.json').write_text(json.dumps(manifest, indent=2), encoding='utf-8')
        print(json.dumps({'identity_preserved': True, 'files': len(rows)}))
    else:
        target.write_text(json.dumps(manifest, indent=2), encoding='utf-8')
        for row in rows:
            dest = COPY / row['path']
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(SOURCE / row['path'], dest)
        ignored = git('ls-files', '--others', '--ignored', '--exclude-standard', '-z').split('\0')
        groups = {}
        for name in ignored:
            if name:
                top = name.replace('\\', '/').split('/')[0]
                groups[top] = groups.get(top, 0) + 1
        (ROOT / 'evidence' / 'ignored-inventory.json').write_text(json.dumps({'method': 'git ignored metadata only; no ignored credential, archive or private record payload read', 'groups': groups, 'inspection': {'dependencies': 'not vendored in source; locked installs in sandbox', 'private_governance': 'operating instructions read, not evaluated', 'local_logs_and_outputs': 'historical evidence excluded from current verification', 'credential_files': 'not copied or opened', 'submodules': git('submodule', 'status')}}, indent=2), encoding='utf-8')
        print(json.dumps({'files': len(rows), 'bytes': sum(r['bytes'] for r in rows), 'copy': str(COPY), 'ignored_groups': groups}))
