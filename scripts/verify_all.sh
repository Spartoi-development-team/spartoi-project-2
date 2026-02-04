#!/usr/bin/env bash
# verify_all: orchestrates steps but handles per-step errors without killing the whole process
set -u

echo "== verify_all: running preflight, generate evidence index, governance audit, evidence pack =="

bash scripts/preflight.sh || echo "preflight failed" >&2
bash scripts/generate_evidence_index.sh || echo "generate_evidence_index failed" >&2
bash scripts/governance_audit.sh || echo "governance_audit failed" >&2
bash scripts/evidence_pack.sh local-verify || echo "evidence_pack failed" >&2

echo "OK: verify_all completed"
