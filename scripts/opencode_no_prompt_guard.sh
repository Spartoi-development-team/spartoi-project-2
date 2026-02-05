#!/usr/bin/env bash
set -euo pipefail
CFG=".opencode/opencode.json"
python - <<'PY'
import json, pathlib, sys
p = pathlib.Path(".opencode/opencode.json")
d = json.loads(p.read_text(encoding="utf-8"))
perm = d.get("permission", {})
need = {"edit":"allow","bash":"allow","webfetch":"allow","external_directory":"allow"}
if not isinstance(perm, dict):
    print("[guard] permission must be object")
    sys.exit(2)
bad=[]
for k,v in need.items():
    if perm.get(k)!=v:
        bad.append((k,perm.get(k),v))
if bad:
    for k,got,exp in bad:
        print(f"[guard] permission.{k}={got!r} expected {exp!r}")
    sys.exit(3)
print("[guard] OK (no-prompt posture locked)")
PY
