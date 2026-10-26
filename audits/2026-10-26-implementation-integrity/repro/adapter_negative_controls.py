"""Targeted negative controls in disposable copies; never edits the product."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import time

ROOT = Path(r"<SOURCE_ROOT>")
AUDIT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "deploy/cloudflare"
COPY = AUDIT / "repro/adapter-mutation-copy"
COPY.mkdir(exist_ok=True)
for folder in ("src", "test"):
    shutil.copytree(SOURCE / folder, COPY / folder, dirs_exist_ok=True)
for name in ("package.json", "wrangler.jsonc", "wrangler.production.jsonc"):
    shutil.copy2(SOURCE / name, COPY / name)

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

baseline = {p.relative_to(SOURCE).as_posix(): digest(p) for p in SOURCE.glob("src/*.ts")}
results = []

def execute(name, test):
    start = time.perf_counter()
    tests = [str(p.relative_to(COPY)) for p in (COPY / "test").glob("*.test.mjs")] if test == "ALL" else [test]
    command = ["node", "--test", "--test-reporter=tap", *tests]
    result = subprocess.run(command, cwd=COPY,
                            capture_output=True, text=True, timeout=30)
    (AUDIT / "evidence" / (name + ".log")).write_text(result.stdout + result.stderr, encoding="utf-8")
    return {"name": name, "command": command,
            "exit_code": result.returncode, "elapsed_seconds": time.perf_counter()-start}

for name, source, before, after, test in [
    ("adapter-control-mail-false-ack", "src/internal.ts", "if (result.status === 204) return;",
     "if (result.status === 200 || result.status === 204) return;", "test/internal.test.mjs"),
    ("adapter-control-contact-no-send", "src/contact.ts", "if (!env.EMAIL) return result(502);",
     "if (!env.EMAIL) return result(502); return result(200);", "test/contact.test.mjs"),
    ("adapter-control-forwarding-spoof", "src/proxy.ts", "headers.set(\"x-forwarded-host\", origin.host);",
     "headers.set(\"x-forwarded-host\", \"attacker.invalid\");", "test/proxy.test.mjs"),
    ("adapter-control-entrypoint-false-success", "src/index.ts",
     'return proxyRequest(request, env, forwarded =>\n      getContainer(env.TIMEKER_PH2_STAGE_CONTAINER, "timeker-ph2-stage-v1").fetch(forwarded));',
     'return new Response("Simulated success without product execution", {status: 200});', "ALL"),
]:
    path = COPY / source
    raw = path.read_bytes()
    text = raw.decode("utf-8").replace("\r\n", "\n")
    if text.count(before) != 1:
        raise RuntimeError("Mutation anchor must be unique")
    base = execute(name + "-baseline", test)
    if base["exit_code"]:
        raise RuntimeError("Baseline failed")
    path.write_text(text.replace(before, after), encoding="utf-8")
    try:
        mutated = execute(name, test)
        mutated.update(baseline_exit_code=base["exit_code"], mutation_detected=mutated["exit_code"] == 1,
                       operator="targeted source substitution", source=source)
        results.append(mutated)
    finally:
        path.write_bytes(raw)
    if digest(path) != baseline[source]:
        raise RuntimeError("Baseline bytes not restored")

report = {"tool": "custom Python orchestrator + Node native test runner", "node_version": subprocess.check_output(["node", "--version"], text=True).strip(),
          "operators": len(results), "detected": sum(x["mutation_detected"] for x in results),
          "survived": sum(not x["mutation_detected"] for x in results), "timeouts": 0,
          "not_covered": 0, "equivalent": 0, "invalid": 0, "results": results,
          "source_unchanged": all(digest(SOURCE / p) == h for p,h in baseline.items()),
          "copy_restored": all(digest(COPY / p) == h for p,h in baseline.items())}
(AUDIT / "evidence/adapter-negative-controls.json").write_text(json.dumps(report, indent=2)+"\n", encoding="utf-8")
print(json.dumps(report, indent=2))
