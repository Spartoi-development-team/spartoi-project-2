#!/usr/bin/env bash
set -euo pipefail

bash scripts/docs_gate_local.sh

# Fail-closed: these gates must exist and must run.
[ -x scripts/links_gate_local.sh ] || { echo "❌ missing or not executable: scripts/links_gate_local.sh"; exit 1; }
[ -x scripts/vale_gate_local.sh ]  || { echo "❌ missing or not executable: scripts/vale_gate_local.sh"; exit 1; }

bash scripts/links_gate_local.sh
bash scripts/vale_gate_local.sh

echo "=== ALL LOCAL GATES PASSED ==="
