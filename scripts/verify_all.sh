#!/usr/bin/env bash
set -euo pipefail

echo "== verify_all: running preflight, generate evidence index, governance audit, evidence pack =="
bash scripts/preflight.sh
bash scripts/generate_evidence_index.sh
bash scripts/governance_audit.sh
bash scripts/evidence_pack.sh local-verify

echo "OK: verify_all completed"
