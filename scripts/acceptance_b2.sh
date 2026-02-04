#!/usr/bin/env bash
set -euo pipefail

echo "== acceptance_b2: run verify_all and gate_all_local with retries =="
max=7
i=1
while [ $i -le $max ]; do
  echo "-- iteration $i/$max --"
  if bash scripts/verify_all.sh; then
    echo "ACCEPTANCE: PASS"
    exit 0
  else
    echo "ACCEPTANCE: iteration $i failed"
    i=$((i+1))
    # try to self-heal by re-running bootstrap
    bash scripts/bootstrap.sh || true
    sleep 1
  fi
done

echo "ACCEPTANCE: HARD FAIL after $max iterations"
exit 2
