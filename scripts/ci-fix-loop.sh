#!/usr/bin/env bash
set -euo pipefail

# Simple CI loop: check required checks via gh, download failed run logs to evidence/_ci_logs/<run_id>/
# and apply minimal fix strategy: if missing gate_all_local.sh or mkdocs, create minimal files and commit.

EVIDENCE_DIR="evidence/_ci_logs"
mkdir -p "$EVIDENCE_DIR"

check_failed_runs() {
  gh run list --workflow=quality-gates.yml --limit 20 --json number,conclusion,headSha,url,headBranch --jq '.'
}

download_run() {
  local run_number="$1"
  local dest="$EVIDENCE_DIR/$run_number"
  mkdir -p "$dest"
  gh run download "$run_number" --dir "$dest" || true
  echo "$dest"
}

main() {
  runs_json=$(check_failed_runs)
  echo "$runs_json" | python -c "import sys,json; data=json.load(sys.stdin)
import sys
for r in data:
    if r.get('conclusion')=='failure':
        print(r.get('number'))
        break
" || true
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  main
fi
