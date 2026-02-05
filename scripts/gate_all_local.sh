#!/usr/bin/env bash
set -euo pipefail

# Minimal gate_all_local implementation used by CI when missing.
# This script runs the individual gate checks under scripts/gates/*.sh

OUT_DIR="artifacts"
mkdir -p "$OUT_DIR"
mkdir -p "$OUT_DIR/logs"

echo "[gate_all_local] START" | tee "$OUT_DIR/logs/gate_all_local.stdout"

RC=0

for g in scripts/gates/docs_gate_local.sh scripts/gates/links_gate.sh scripts/gates/vale_gate.sh; do
  if [ -f "$g" ]; then
    echo "[gate_all_local] running $g" | tee -a "$OUT_DIR/logs/gate_all_local.stdout"
    # Use explicit bash to execute the script regardless of executable bit
    if bash "$g" >>"$OUT_DIR/logs/gate_all_local.stdout" 2>&1; then
      echo "[gate_all_local] $g: OK" | tee -a "$OUT_DIR/logs/gate_all_local.stdout"
    else
      echo "[gate_all_local] $g: FAIL" | tee -a "$OUT_DIR/logs/gate_all_local.stdout"
      RC=1
    fi
  else
    echo "[gate_all_local] $g not found; marking fail" | tee -a "$OUT_DIR/logs/gate_all_local.stdout"
    RC=1
  fi
done

if [ $RC -eq 0 ]; then
  echo "[gate_all_local] ALL LOCAL GATES PASSED" | tee -a "$OUT_DIR/logs/gate_all_local.stdout"
else
  echo "[gate_all_local] SOME GATES FAILED rc=$RC" | tee -a "$OUT_DIR/logs/gate_all_local.stdout"
fi

exit $RC
