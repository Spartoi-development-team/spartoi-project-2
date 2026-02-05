#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
EVIDENCE_DIR="$ROOT_DIR/evidence/_preflight/${TS}"
mkdir -p "$EVIDENCE_DIR"

CHECK_ONLY=false
if [[ "${1-}" == "--check" ]]; then
  CHECK_ONLY=true
fi

# capture opencode and node versions (if available)
if command -v opencode >/dev/null 2>&1; then
  opencode --version > "$EVIDENCE_DIR/opencode_version.txt" 2>&1 || true
else
  echo "opencode: not found" > "$EVIDENCE_DIR/opencode_version.txt"
fi

if command -v node >/dev/null 2>&1; then
  node --version > "$EVIDENCE_DIR/node_version.txt" 2>&1 || true
else
  echo "node: not found" > "$EVIDENCE_DIR/node_version.txt"
fi

# run python doctor in check mode first to produce report
python3 "$SCRIPT_DIR/opencode_doctor.py" --ts "$TS" --check

# read report and see if unknown keys were detected
DETECTED_COUNT=$(python3 - <<PY
import json,sys
p='"$EVIDENCE_DIR/opencode_doctor_report.json"'
try:
    rep=json.load(open($p))
    keys=rep.get('detected_unknown_keys') or []
    print(len(keys))
except Exception as e:
    print(0)
PY
)

if [[ "$DETECTED_COUNT" -gt 0 && "$CHECK_ONLY" = false ]]; then
  # backup original config if exists
  if [[ -f "$ROOT_DIR/opencode.json" ]]; then
    cp "$ROOT_DIR/opencode.json" "$EVIDENCE_DIR/opencode.json.bak"
  elif [[ -f "$ROOT_DIR/opencode.jsonc" ]]; then
    cp "$ROOT_DIR/opencode.jsonc" "$EVIDENCE_DIR/opencode.json.bak"
  fi

  # run python doctor to perform fix
  python3 "$SCRIPT_DIR/opencode_doctor.py" --ts "$TS"
  FIXED=true
else
  FIXED=false
fi

# attempt to run 'opencode agent list' and capture output
if command -v opencode >/dev/null 2>&1; then
  opencode agent list > "$EVIDENCE_DIR/opencode_agent_list.txt" 2>&1 || true
else
  echo "opencode: not found, could not run 'opencode agent list'" > "$EVIDENCE_DIR/opencode_agent_list.txt"
fi

# final evidence summary printed to stdout
cat <<EOF
Preflight evidence written to:
  $EVIDENCE_DIR/opencode_version.txt
  $EVIDENCE_DIR/opencode_config_path.txt
  $EVIDENCE_DIR/opencode_doctor_report.json
  $EVIDENCE_DIR/opencode_agent_list.txt

EOF

if [[ "$FIXED" = true ]]; then
  echo "Repository changes were made by the doctor. Run 'git status' to review." >&2
  git status --porcelain || true
  echo "Suggested commit message: chore(opencode): add config doctor fail-closed preflight" >&2
fi

if [[ "$CHECK_ONLY" = true && "$DETECTED_COUNT" -gt 0 ]]; then
  echo "Preflight detected unknown opencode top-level keys. Failing in --check mode." >&2
  exit 2
fi

exit 0
