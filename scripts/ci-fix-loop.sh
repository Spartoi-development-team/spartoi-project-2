#!/usr/bin/env bash
set -euo pipefail

# Simple CI loop: check required checks via gh, download failed run logs to evidence/_ci_logs/<run_id>/
# and apply minimal fix strategy: if missing gate_all_local.sh or mkdocs, create minimal files and commit.

EVIDENCE_DIR="evidence/_ci_logs"
mkdir -p "$EVIDENCE_DIR"

# State file to track consecutive failures by signature
STATE_FILE="$EVIDENCE_DIR/failure_state.json"
if [ ! -f "$STATE_FILE" ]; then
  echo '{}' > "$STATE_FILE"
fi

get_latest_failed_run_number() {
  gh run list --workflow=quality-gates.yml --limit 30 --json number,conclusion,headSha,url --jq '.[] | select(.conclusion=="failure") | .number' | head -n1 || true
}

download_run() {
  local run_number="$1"
  local dest="$EVIDENCE_DIR/run_${run_number}"
  mkdir -p "$dest"
  # save run meta
  gh run view "$run_number" --json url,conclusion,headSha,headBranch,number,jobs --jq '.' > "$dest/run_meta.json" || true
  # download artifacts if any
  gh run download "$run_number" --dir "$dest" || true
  echo "$dest"
}

first_error_signature() {
  local run_dir="$1"
  local log="$run_dir/artifacts/logs/gate_all_local.stdout"
  if [ -f "$log" ]; then
    # prefer explicit known messages
    sig=$(grep -i -m1 -E "mkdocs not installed|mkdocs build failed|FAIL|failed|ERROR" "$log" || true)
    if [ -z "$sig" ]; then
      sig=$(sed -n '1,200p' "$log" | tr '\n' ' ' | cut -c1-200)
    fi
    # compact signature: collapse whitespace and truncate
    echo "$sig" | tr '\n' ' ' | tr -s ' ' | cut -c1-180
  else
    echo "no_gate_log_found"
  fi
}

increment_failure() {
  local sig="$1"
  # read current state
  if [ ! -f "$STATE_FILE" ]; then echo '{}' > "$STATE_FILE"; fi
  python - <<PY
import json,sys
f='''$STATE_FILE'''
sig='''$sig'''
with open(f,'r') as fh:
    s=json.load(fh)
s[sig]=s.get(sig,0)+1
with open(f,'w') as fh:
    json.dump(s,fh)
print(s[sig])
PY
}

reset_failure() {
  local sig="$1"
  python - <<PY
import json
f='''$STATE_FILE'''
sig='''$sig'''
with open(f,'r') as fh:
    s=json.load(fh)
if sig in s:
    s[sig]=0
with open(f,'w') as fh:
    json.dump(s,fh)
PY
}

apply_minimal_fix() {
  local sig="$1"
  # Minimal heuristics: if mkdocs mentioned or missing index, add docs/index.md file
  if echo "$sig" | grep -qi "mkdocs" || echo "$sig" | grep -qi "index.md"; then
    if [ ! -f docs/index.md ]; then
      mkdir -p docs
      cat > docs/index.md <<'MD'
---
title: Home
---

# OMOC Acceptance

Minimal placeholder created by CI fixer to satisfy MkDocs build.

MD
      git add docs/index.md
      git commit -m "ci-loop: add minimal docs/index.md to satisfy mkdocs (auto-fix)" || true
      git push || true
      return 0
    fi
  fi
  # Add other heuristics here as needed
  return 1
}

run_diagnostics() {
  local run_number="$1"
  local dest="$EVIDENCE_DIR/run_${run_number}/diagnostics"
  mkdir -p "$dest"
  gh run view "$run_number" --log > "$dest/run_full_log.txt" || true
  gh run view "$run_number" --json jobs --jq '.jobs' > "$dest/jobs.json" || true
  echo "diagnostics: saved run logs and jobs to $dest"
}

main() {
  # find latest failed run
  run_number=$(get_latest_failed_run_number)
  if [ -z "$run_number" ]; then
    echo "No failed runs found"
    exit 0
  fi
  echo "Found failed run: $run_number"
  run_dir=$(download_run "$run_number")
  sig=$(first_error_signature "$run_dir")
  echo "First error signature: $sig"
  # record evidence
  echo "signature: $sig" > "$run_dir/first_error.txt"
  # increment counter
  count=$(increment_failure "$sig")
  echo "Failure count for this signature: $count"
  if [ "$count" -ge 2 ]; then
    echo "Signature failed >=2 times: switching to diagnostics"
    run_diagnostics "$run_number"
  else
    if apply_minimal_fix "$sig"; then
      echo "Applied minimal fix for signature: $sig"
      reset_failure "$sig"
    else
      echo "No automatic fix available for signature: $sig"
    fi
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  main
fi
