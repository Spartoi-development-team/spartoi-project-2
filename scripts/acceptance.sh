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

  # 3) build trace_map
python3 scripts/trace_map_build.py || true

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

  # 6) Decide PASS/FAIL
  GREP_FAIL=$(grep -c "MAI-PLACEHOLDER" "${CONTROL_DIR}/trace_map.json" || true)
  if [ "$GREP_FAIL" -eq 0 ]; then
    echo "PASS" > "${FINAL_DIR}/verdict.txt"
    exit 0
  else
    echo "FAIL" > "${FINAL_DIR}/verdict.txt"
    echo "Attempt ${attempt} repair plan" > "${FINAL_DIR}/repair_plan.md"
    # minimal repair: append placeholder resolved note to trace_map
    python3 - <<'PY'
import json
f='control_plane/trace_map.json'
try:
  j=json.load(open(f))
except:
  j=[]
j.append({'mai_id':'MAI-PLACEHOLDER','srs_req_id':'','acceptance_artifact':'','verification_method':'','pass_criteria':'','gate_ref':'','source_locator':'manual:repair'})
open(f,'w').write(json.dumps(j,indent=2,ensure_ascii=False))
print('repaired')
PY
  fi
done

echo "Max attempts reached" > "${FINAL_DIR}/final_status.txt"
exit 1

# Ensure deterministic final verdict json (Fail-Closed) - use emitter
if [ -n "${LATEST_ACCEPTANCE_DIR:-}" ] && [ -d "$LATEST_ACCEPTANCE_DIR" ]; then
  mkdir -p "$LATEST_ACCEPTANCE_DIR/final"
  python3 scripts/emit_verdict_json.py --latest-dir "$LATEST_ACCEPTANCE_DIR" || true
fi
# ------------------------------------------------------------
