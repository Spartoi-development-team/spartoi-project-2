#!/usr/bin/env bash
set -euo pipefail

bash scripts/docs_gate_local.sh
[ -x scripts/links_gate_local.sh ] && bash scripts/links_gate_local.sh
[ -x scripts/vale_gate_local.sh ] && bash scripts/vale_gate_local.sh

echo "=== ALL LOCAL GATES PASSED ==="
