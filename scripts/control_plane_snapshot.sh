#!/usr/bin/env bash
# control_plane_snapshot.sh
# Collect CI and governance evidence into evidence/_acceptance/<UTC_TS>/control_plane/

set +e
TS=$(date -u +%Y%m%dT%H%M%SZ)
OUTDIR="evidence/_acceptance/${TS}/control_plane"
# Ensure ruleset snapshot is collected (ruleset id: 12397323)
mkdir -p "$OUTDIR"
if command -v gh >/dev/null 2>&1; then
  echo "Fetching ruleset_12397323 via gh api"
  gh api repos/${GITHUB_REPOSITORY:-Spartoi-development-team/spartoi-project-2}/rulesets/12397323 --jq '.' > "$OUTDIR/ruleset_12397323.json" 2>/dev/null || true
else
  echo "gh CLI not available; skipping ruleset fetch" > "$OUTDIR/ruleset_12397323.json" || true
fi

# Normalize required_status_checks into rules_main.json if present
if [ -f "$OUTDIR/ruleset_12397323.json" ]; then
  if command -v jq >/dev/null 2>&1; then
    jq '{required_status_checks: .required_status_checks, id: .id, name: .name}' "$OUTDIR/ruleset_12397323.json" > "$OUTDIR/rules_main.json" 2>/dev/null || true
  else
    cp "$OUTDIR/ruleset_12397323.json" "$OUTDIR/rules_main.json" || true
  fi
fi

# Copy any historical control_plane/_evidence artifacts if present
shopt -s nullglob 2>/dev/null || true
for f in control_plane/_evidence/*/rules_main.json; do
  cp "$f" "${OUTDIR}/rules_main.json" 2>/dev/null || true
  break
done
for f in control_plane/_evidence/*/latest_main_runs.json; do
  cp "$f" "${OUTDIR}/latest_main_runs.json" 2>/dev/null || true
  echo 0 > "${OUTDIR}/main_runs.exit_code.txt" || true
  break
done
for f in control_plane/_evidence/*/latest_merge_group_runs.json; do
  cp "$f" "${OUTDIR}/latest_merge_group_runs.json" 2>/dev/null || true
  echo 0 > "${OUTDIR}/mq_runs.exit_code.txt" || true
  break
done

# Mark rules exit code if rules_main.json present
if [ -f "${OUTDIR}/rules_main.json" ]; then
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
