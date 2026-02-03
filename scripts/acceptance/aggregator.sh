#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="evidence/acceptance"
mkdir -p "$OUT_DIR"

SCRIPTS_DIR="scripts/acceptance"

echo "Starting acceptance aggregator - timestamp: $(date --iso-8601=seconds)" | tee "$OUT_DIR/aggregator_log.txt"

echo "Running auth_check.sh" | tee -a "$OUT_DIR/aggregator_log.txt"
bash "$SCRIPTS_DIR/auth_check.sh" 2>&1 | tee -a "$OUT_DIR/aggregator_log.txt"

echo "Running ruleset_audit.sh" | tee -a "$OUT_DIR/aggregator_log.txt"
bash "$SCRIPTS_DIR/ruleset_audit.sh" 2>&1 | tee -a "$OUT_DIR/aggregator_log.txt"

echo "Running pr_probe.sh" | tee -a "$OUT_DIR/aggregator_log.txt"
bash "$SCRIPTS_DIR/pr_probe.sh" 2>&1 | tee -a "$OUT_DIR/aggregator_log.txt"

echo "Running branch_protection_check.sh" | tee -a "$OUT_DIR/aggregator_log.txt"
bash "$SCRIPTS_DIR/branch_protection_check.sh" 2>&1 | tee -a "$OUT_DIR/aggregator_log.txt"

echo "Aggregator run complete" | tee -a "$OUT_DIR/aggregator_log.txt"

exit 0
