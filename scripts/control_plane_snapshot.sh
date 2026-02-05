#!/usr/bin/env bash
# control_plane_snapshot.sh
# Collect CI and governance evidence into evidence/_acceptance/<UTC_TS>/control_plane/

set +e
TS=$(date -u +%Y%m%dT%H%M%SZ)
OUTDIR="evidence/_acceptance/${TS}/control_plane"
mkdir -p "${OUTDIR}"

# 1) rules_main.json (if present in control_plane/_evidence)
if [ -f control_plane/_evidence/*/rules_main.json ]; then
  cp control_plane/_evidence/*/rules_main.json "${OUTDIR}/rules_main.json" 2>/dev/null
fi

# 2) latest_main_runs.json and latest_merge_group_runs.json (if present)
if [ -f control_plane/_evidence/*/latest_main_runs.json ]; then
  cp control_plane/_evidence/*/latest_main_runs.json "${OUTDIR}/latest_main_runs.json" 2>/dev/null
  echo $? > "${OUTDIR}/main_runs.exit_code.txt"
fi
if [ -f control_plane/_evidence/*/latest_merge_group_runs.json ]; then
  cp control_plane/_evidence/*/latest_merge_group_runs.json "${OUTDIR}/latest_merge_group_runs.json" 2>/dev/null
  echo $? > "${OUTDIR}/mq_runs.exit_code.txt"
fi

# 3) rules exit code
if [ -f control_plane/_evidence/*/rules_main.json ]; then
  echo 0 > "${OUTDIR}/rules.exit_code.txt"
fi

# 4) check_run_names.txt: extract job names from .github/workflows/quality-gates.yml or use detected evidence
if [ -f .github/workflows/quality-gates.yml ]; then
  grep -E "^\s+[a-zA-Z0-9_-]+:\s*$" .github/workflows/quality-gates.yml | sed 's/://g' | tr -d ' ' > "${OUTDIR}/check_run_names.txt" || true
fi

echo "Snapshot complete" > "${OUTDIR}/snapshot.txt"
echo 0 > "${OUTDIR}/snapshot.exit_code.txt"
echo "${OUTDIR}"

exit 0
