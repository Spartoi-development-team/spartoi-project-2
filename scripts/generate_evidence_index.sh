#!/usr/bin/env bash
# generate evidence index (non-failing)
set -u

out="evidence/evidence_index.json"
mkdir -p evidence
files=(
  "evidence/b2/exit_code.txt"
  "evidence/b2/acceptance_console.txt"
  "evidence/b1/model_probe.json"
  "evidence/b1/governance_rules.json"
  "evidence/b0_ledger.md"
  "evidence/b0_ledger.json"
  "evidence/install_vale.log"
  "evidence/vale_version.txt"
  "evidence/path.txt"
)

echo "{" > "$out"
echo "  \"generated_at\": \"$(date -u --iso-8601=seconds)\"," >> "$out"
echo "  \"files\": [" >> "$out"
first=true
for f in "${files[@]}"; do
  if [ "$first" = true ]; then first=false; else echo "," >> "$out"; fi
  echo "    \"$f\"" >> "$out"
done
echo "  ]" >> "$out"
echo "}" >> "$out"

echo "OK: evidence index at $out"
