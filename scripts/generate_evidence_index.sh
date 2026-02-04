#!/usr/bin/env bash
set -euo pipefail

out="evidence/evidence_index.json"
mkdir -p evidence
jq -n '{generated_at:(now|todate), files: []}' > "$out" 2>/dev/null || echo '{"generated_at":"'"$(date -u --iso-8601=seconds)"'","files":[]}' > "$out"
echo "OK: evidence index at $out"
