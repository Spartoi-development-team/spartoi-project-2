#!/usr/bin/env bash
set -euo pipefail

# Minimal repair loop: read artifacts/gate_report.json and attempt small fixes
REPORT=artifacts/gate_report.json
if [ ! -f "$REPORT" ]; then
  echo "repair_loop: gate_report.json missing" >&2
  exit 2
fi

status=$(jq -r .status "$REPORT" 2>/dev/null || echo "UNKNOWN")
echo "repair_loop: gate status=$status"

if [ "$status" = "PASS" ]; then
  echo "repair_loop: nothing to do"
  exit 0
fi

echo "repair_loop: attempting minimal remediation"

# Example remediation: ensure scripts are executable
chmod +x scripts/gate_all_local.sh || true
for f in scripts/*.sh scripts/gates/*.sh; do
  [ -f "$f" ] || continue
  chmod +x "$f" || true
done

# re-run gates
bash scripts/gates/run_gates.sh || true

new_status=$(jq -r .verdict artifacts/verdict.json 2>/dev/null || echo "UNKNOWN")
if [ "$new_status" = "PASS" ]; then
  echo "repair_loop: remediation succeeded"
  exit 0
else
  echo "repair_loop: remediation failed; leave gate_report.json as-is and create control_plane/CR_OPEN.md"
  mkdir -p control_plane
  cat > control_plane/CR_OPEN.md <<'EOF'
# CR_OPEN - Repair loop could not auto-fix gates

The automatic repair loop attempted minimal fixes but gates remain failing.
Please inspect artifacts/gate_report.json and artifacts/logs for details.

EOF
  exit 1
fi
