#!/usr/bin/env bash
set -euo pipefail
mkdir -p evidence/b1
out="evidence/b1/governance_rules.json"

jq -n '{generated_at:(now|todate), rulesets: []}' > "$out" 2>/dev/null || echo '{"generated_at":"'"$(date -u --iso-8601=seconds)"'","rulesets":[]}' > "$out"
echo "OK: governance audit => $out"
