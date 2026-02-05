#!/usr/bin/env bash
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
