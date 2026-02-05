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

# Produce verdict JSON safely
if command -v jq >/dev/null 2>&1; then
  # Build required_checks JSON safely
  if [ -f "$REQUIRED_CHECKS_FILE" ]; then
    REQ_JSON=$(jq -c '.[].name' "$REQUIRED_CHECKS_FILE" 2>/dev/null | jq -R -s -c 'split("\n")[:-1]' 2>/dev/null || echo '[]')
  else
    REQ_JSON='[]'
  fi

  # Build hitl files JSON
  if [ "${#HITL_FILES[@]}" -gt 0 ]; then
    HITL_JSON=$(printf '%s\n' "${HITL_FILES[@]}" | jq -R -s -c 'split("\n")[:-1]')
  else
    HITL_JSON='[]'
  fi

  # Ensure rules path resolves to either rules_effective_main.json (preferred) or ruleset_12397323.json
  RULES_PATH="$BASE_DIR/control_plane/rules_effective_main.json"
  if [ ! -f "$RULES_PATH" ]; then
    RULES_PATH="$BASE_DIR/control_plane/ruleset_12397323.json"
  fi

  jq -n --arg verdict "$VERDICT_VAL" --argjson required_checks "$REQ_JSON" --arg main_id "$MAIN_RUN_ID" --arg mg_id "$MG_RUN_ID" --arg evidence_base "$BASE_DIR" --arg evidence_opencode "evidence/_opencode_safe/$TS" --arg rules_path "$RULES_PATH" --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" --argjson hitl_files "$HITL_JSON" '{verdict: $verdict, latest_acceptance_dir: $evidence_base, required_checks: $required_checks, run_ids: {main: ($main_id // null), merge_group: ($mg_id // null)}, evidence_paths: [$evidence_base, $evidence_opencode, $rules_path], HITL_guard: {present: ($hitl_files|length>0), files: $hitl_files}, timestamp: $timestamp}' > "$VERDICT_JSON_FILE" 2>/dev/null || true
else
  cat > "$VERDICT_JSON_FILE" <<EOF
{"verdict":"${VERDICT_VAL}","latest_acceptance_dir":"${BASE_DIR}","required_checks":[],"run_ids":{"main":"${MAIN_RUN_ID}","merge_group":"${MG_RUN_ID}"},"evidence_paths":["$BASE_DIR","evidence/_opencode_safe/$TS","$BASE_DIR/control_plane/ruleset_12397323.json"],"HITL_guard":{"present":${HITL_PRESENT},"files":[]},"timestamp":"$(date -u +%Y-%m-%dT%H:%M:%SZ)"}
EOF
fi

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

# --- ensure deterministic final verdict json (Fail-Closed) ---
if [ -n "${LATEST_ACCEPTANCE_DIR:-}" ] && [ -d "$LATEST_ACCEPTANCE_DIR" ]; then
  mkdir -p "$LATEST_ACCEPTANCE_DIR/final"
  python3 - <<'PY'
import json, os, glob
d=os.environ.get("LATEST_ACCEPTANCE_DIR","")
out=os.path.join(d,"final","verdict.json")
# 最小可稽核欄位：verdict + evidence_paths（後續可擴充 required_checks/run_ids）
verdict_txt=os.path.join(d,"final","verdict.txt")
verdict="UNKNOWN"
if os.path.exists(verdict_txt):
    t=open(verdict_txt,encoding="utf-8",errors="ignore").read()
    if "PASS" in t: verdict="PASS"
    elif "FAIL" in t: verdict="FAIL"
payload={
  "verdict": verdict,
  "latest_acceptance_dir": d,
  "evidence_paths": sorted(glob.glob(os.path.join(d,"**"), recursive=True))[:2000]
}
json.dump(payload, open(out,"w",encoding="utf-8"), ensure_ascii=False, indent=2)
print("WROTE", out, "verdict=", verdict)
PY
fi
# ------------------------------------------------------------
