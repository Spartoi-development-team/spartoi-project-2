#!/usr/bin/env bash
set -euo pipefail
CFG=".opencode/opencode.json"

python - <<'PY'
import json, pathlib, sys

p = pathlib.Path(".opencode/opencode.json")
d = json.loads(p.read_text(encoding="utf-8"))
perm = d.get("permission", {})

def die(msg, code=2):
    print(f"[guard] {msg}")
    sys.exit(code)

def check_leaf(v, path):
    if isinstance(v, str):
        if v not in ("allow","ask","deny"):
            die(f"Invalid permission value at {path}: {v!r} (expected allow/ask/deny)")
    elif isinstance(v, dict):
        for k2,v2 in v.items():
            check_leaf(v2, f"{path}.{k2}")
    else:
        die(f"Invalid permission type at {path}: {type(v).__name__} (expected string or object map)")

if not isinstance(perm, dict):
    die(f"permission must be an object, got {type(perm).__name__}")

for k,v in perm.items():
    check_leaf(v, f"permission.{k}")

print("[guard] OK")
PY
