#!/usr/bin/env bash

# Force a deterministic latest acceptance dir per Task A requirement
LATEST_ACCEPTANCE_DIR="evidence/_acceptance/20260205T041819Z"
export LATEST_ACCEPTANCE_DIR

# --- canonical latest acceptance dir (directory only) ---
# existing selection fallback (kept for compatibility)
SELECTION_FALLBACK="$(scripts/select_latest_acceptance_dir.sh || true)"
if [ -z "${LATEST_ACCEPTANCE_DIR:-}" ] || [ ! -d "${LATEST_ACCEPTANCE_DIR}" ]; then
  LATEST_ACCEPTANCE_DIR="$SELECTION_FALLBACK"
fi
# ---------------------------------------------------------
# Orchestrator: acceptance.sh

set -e
TS=$(date -u +%Y%m%dT%H%M%SZ)
BASE_DIR="evidence/_acceptance/${TS}"
CONTROL_DIR="${BASE_DIR}/control_plane"
FINAL_DIR="${BASE_DIR}/final"
mkdir -p "${CONTROL_DIR}" "${FINAL_DIR}"

attempt=0
max_attempts=3
while [ $attempt -lt $max_attempts ]; do
  attempt=$((attempt+1))
  echo "Attempt $attempt"
  # 1) snapshot
  bash scripts/control_plane_snapshot.sh > /dev/null 2>&1 || true
  # copy snapshot outputs if any
  LATEST_SNAPSHOT=$(ls -d evidence/_acceptance/*/control_plane 2>/dev/null | tail -n1 || true)
  if [ -n "$LATEST_SNAPSHOT" ]; then
    cp -r "$LATEST_SNAPSHOT"/* "${CONTROL_DIR}/" 2>/dev/null || true
  fi

  # 2) build doc_index (use existing script if present)
  if [ -f scripts/ssot/scan_and_build_doc_index.sh ]; then
    bash scripts/ssot/scan_and_build_doc_index.sh || true
    if [ -f control_plane/doc_index.json ]; then
      cp control_plane/doc_index.json "${CONTROL_DIR}/doc_index.json" || true
    fi
  fi

  # 3) build trace_map (use new conservative SRS parser)
  python3 scripts/build_trace_map_from_srs.py || true

# --- deterministic verdict JSON output (minimal schema) ---
FINAL_DIR="$BASE_DIR/final"
mkdir -p "$FINAL_DIR"
VERDICT_TEXT_FILE="$FINAL_DIR/verdict.txt"
VERDICT_JSON_FILE="$FINAL_DIR/verdict.json"
# If a plaintext verdict exists, prefer it; fall back to exit codes or default to FAIL
VERDICT_VAL="FAIL"
if [ -f "$VERDICT_TEXT_FILE" ]; then
  # Accept simple PASS/FAIL in the first line
  VLINE=$(sed -n '1p' "$VERDICT_TEXT_FILE" | tr -d '\r\n' || true)
  case "$VLINE" in
    PASS|pass|Pass) VERDICT_VAL="PASS" ;;
    *) VERDICT_VAL="FAIL" ;;
  esac
fi

# Collect required checks list
REQUIRED_CHECKS_FILE="$BASE_DIR/pr10_checks_latest.json"
REQUIRED_CHECKS_LIST=()
if [ -f "$REQUIRED_CHECKS_FILE" ]; then
  if command -v jq >/dev/null 2>&1; then
    REQUIRED_CHECKS_LIST=$(jq -r '.[].name' "$REQUIRED_CHECKS_FILE" 2>/dev/null | jq -R -s -c 'split("\n")[:-1]' || echo "[]")
  fi
fi

# Collect run ids if available
MAIN_RUN_ID=""
MG_RUN_ID=""
if [ -f "$BASE_DIR/control_plane/latest_main_runs.json" ]; then
  MAIN_RUN_ID=$(jq -r '.[0].id // empty' "$BASE_DIR/control_plane/latest_main_runs.json" 2>/dev/null || true)
fi
if [ -f "$BASE_DIR/control_plane/latest_merge_group_run.json" ]; then
  MG_RUN_ID=$(jq -r '.id // empty' "$BASE_DIR/control_plane/latest_merge_group_run.json" 2>/dev/null || true)
fi

# HITL guard evidence
HITL_PRESENT=false
HITL_FILES=( )
# Look for explicit SSOT files in control_plane or base_dir
if [ -f control_plane/EXECUTE_DISABLED ] || [ -f "$BASE_DIR/control_plane/EXECUTE_DISABLED" ]; then
  HITL_PRESENT=true
  if [ -f control_plane/EXECUTE_DISABLED ]; then HITL_FILES+=("control_plane/EXECUTE_DISABLED"); fi
  if [ -f "$BASE_DIR/control_plane/EXECUTE_DISABLED" ]; then HITL_FILES+=("$BASE_DIR/control_plane/EXECUTE_DISABLED"); fi
fi
# Also search for kill/kill_switch tokens within acceptance evidence
if find "$BASE_DIR" -type f -iname '*kill*' -o -iname '*kill_switch*' | grep -q . 2>/dev/null; then
  HITL_PRESENT=true
  while IFS= read -r f; do HITL_FILES+=("$f"); done < <(find "$BASE_DIR" -type f -iname '*kill*' -o -iname '*kill_switch*' 2>/dev/null)
fi

# Produce verdict JSON safely via dedicated emitter script
python3 scripts/emit_verdict_json.py --base-dir "$BASE_DIR" --ts "$TS" || true

# Ensure verdict exit code is logically consistent for downstream verification
if [ "${VERDICT_VAL}" = "PASS" ]; then
  echo "0" > "$FINAL_DIR/verdict.exit_code" || true
else
  echo "2" > "$FINAL_DIR/verdict.exit_code" || true
fi
  if [ -f control_plane/trace_map.json ]; then
    cp control_plane/trace_map.json "${CONTROL_DIR}/trace_map.json" || true
  fi

  # 4) JSON schema validation (basic)
  python3 - <<'PY'
import json,sys
ok=True
try:
  j=json.load(open('control_plane/trace_map.json'))
  assert isinstance(j,list)
except Exception as e:
  ok=False
print('TRACE_MAP_OK' if ok else 'TRACE_MAP_FAIL')
PY

  # 5) required checks alignment: ensure check_run_names.txt exists
  if [ -f "${CONTROL_DIR}/check_run_names.txt" ]; then
    echo "Checks present" > "${FINAL_DIR}/checks_present.txt"
  else
    echo "Missing check_run_names" > "${FINAL_DIR}/checks_present.txt"
  fi

  # 6) Decide PASS/FAIL based on parsed MAI entries and missing_fields
  # If trace_map.json absent or empty -> fail
  if [ ! -f control_plane/trace_map.json ]; then
    echo "FAIL" > "${FINAL_DIR}/verdict.txt"
    echo "No trace_map.json generated" > "${FINAL_DIR}/repair_plan.md"
    touch control_plane/mai_missing.flag || true
    continue
  fi

  # Count MAI entries and entries with missing_fields
  if command -v jq >/dev/null 2>&1; then
    TOTAL_MAI=$(jq 'length' control_plane/trace_map.json 2>/dev/null || echo 0)
    MISSING_FIELDS_COUNT=$(jq '[.[] | select(.missing_fields != null)] | length' control_plane/trace_map.json 2>/dev/null || echo 0)
  else
    TOTAL_MAI=$(python3 - <<'PY'
import json
try:
 j=json.load(open('control_plane/trace_map.json',encoding='utf-8'))
 print(len(j) if isinstance(j,list) else 0)
except Exception:
 print(0)
PY
)
    MISSING_FIELDS_COUNT=$(python3 - <<'PY'
import json
try:
  j=json.load(open('control_plane/trace_map.json',encoding='utf-8'))
  print(len([1 for x in j if x.get('missing_fields')]))
except Exception:
  print(0)
PY
)
  fi

  if [ "${TOTAL_MAI}" -eq 0 ]; then
    echo "FAIL" > "${FINAL_DIR}/verdict.txt"
    echo "No MAI entries parsed from SRS" > "${FINAL_DIR}/repair_plan.md"
    touch control_plane/mai_missing.flag || true
    # ensure an empty trace_map is present
    python3 - <<'PY'
import json,os
f='control_plane/trace_map.json'
os.makedirs(os.path.dirname(f), exist_ok=True)
open(f,'w',encoding='utf-8').write(json.dumps([],indent=2,ensure_ascii=False))
PY
    continue
  fi

  if [ "${MISSING_FIELDS_COUNT}" -gt 0 ]; then
    echo "FAIL" > "${FINAL_DIR}/verdict.txt"
    echo "Attempt ${attempt} repair plan: missing fields in MAI entries" > "${FINAL_DIR}/repair_plan.md"
    # copy CR_OPEN to final control dir for visibility
    if [ -f control_plane/CR_OPEN.md ]; then
      cp control_plane/CR_OPEN.md "${CONTROL_DIR}/CR_OPEN.md" || true
    fi
    # mark mai missing flag for operator attention
    touch control_plane/mai_missing.flag || true
    continue
  fi

  # If we reach here, it looks like MAI coverage parsed and no missing fields
  echo "PASS" > "${FINAL_DIR}/verdict.txt"
  # Emit deterministic verdict JSON after PASS/FAIL decision so payload reflects final state
  python3 scripts/emit_verdict_json.py --base-dir "$BASE_DIR" --ts "$TS" || true
  exit 0
done

echo "Max attempts reached" > "${FINAL_DIR}/final_status.txt"
exit 1

# Ensure deterministic final verdict json (Fail-Closed) - use emitter
if [ -n "${LATEST_ACCEPTANCE_DIR:-}" ] && [ -d "$LATEST_ACCEPTANCE_DIR" ]; then
  mkdir -p "$LATEST_ACCEPTANCE_DIR/final"
  python3 scripts/emit_verdict_json.py --latest-dir "$LATEST_ACCEPTANCE_DIR" || true
fi
# ------------------------------------------------------------
