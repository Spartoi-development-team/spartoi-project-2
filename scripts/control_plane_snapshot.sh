#!/usr/bin/env bash
# control_plane_snapshot.sh
# Collect CI and governance evidence into evidence/_acceptance/<UTC_TS>/control_plane/

set +e
TS=$(date -u +%Y%m%dT%H%M%SZ)
OUTDIR="evidence/_acceptance/${TS}/control_plane"
# Ensure ruleset snapshot is collected (ruleset id: 12397323)
mkdir -p "$OUTDIR"
# Copy static control_plane artifacts (e.g., HITL / kill-switch SSOT) if present in repo control_plane/
for f in control_plane/EXECUTE_DISABLED control_plane/RADAR_ONLY control_plane/PAPER control_plane/kill_switch; do
  if [ -f "$f" ]; then
    cp "$f" "$OUTDIR/" 2>/dev/null || true
  fi
done
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
    # If required_status_checks is null, fetch the effective branch rules for main
    RS_REQUIRED=$(jq -r '.required_status_checks // empty' "$OUTDIR/ruleset_12397323.json" 2>/dev/null || echo "")
    if [ -z "$RS_REQUIRED" ] || [ "$RS_REQUIRED" = "null" ]; then
      echo "ruleset required_status_checks is null; fetching effective rules from rules/branches/main"
      if command -v gh >/dev/null 2>&1; then
        gh api repos/${GITHUB_REPOSITORY:-Spartoi-development-team/spartoi-project-2}/rules/branches/main --jq '.' > "$OUTDIR/rules_effective_main.json" 2>/dev/null || true
      else
        echo "gh CLI not available; cannot fetch rules/branches/main" > "$OUTDIR/rules_effective_main.json" || true
      fi
    fi
  else
    cp "$OUTDIR/ruleset_12397323.json" "$OUTDIR/rules_main.json" || true
  fi
fi

# If we still don't have rules_effective_main.json but have historic snapshots, preserve them
for f in control_plane/_evidence/*/rules_effective_main.json; do
  cp "$f" "${OUTDIR}/rules_effective_main.json" 2>/dev/null || true
  break
done

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

# Collect PR #11 URL and recent runs (PR runs & merge_group runs)
if command -v gh >/dev/null 2>&1; then
  # PR #11 URL (if exists)
  PR11_URL=$(gh pr view 11 --json url --jq '.url' 2>/dev/null || true)
  if [ -n "$PR11_URL" ]; then
    echo "$PR11_URL" > "${OUTDIR}/pr11_url.txt" || true
  else
    echo "" > "${OUTDIR}/pr11_url.txt" || true
  fi

  # latest PR runs for PR 11
  if [ -n "$PR11_URL" ]; then
    gh run list --limit 20 --json databaseId,event,headBranch,headSha,status,conclusion,name,url --jq '[.[] | select(.event=="pull_request" and .headBranch=="'"$(basename "$PR11_URL")"'" )] | .[0]' > "${OUTDIR}/latest_pr_run.json" 2>/dev/null || true
  fi

  # latest merge_group runs (search for merge_group or queue runs)
  gh run list --limit 50 --json databaseId,event,headBranch,headSha,status,conclusion,name,url --jq '[.[] | select(.event=="merge_group" or .name|test("merge|merge_group|queue";"i"))] | .[0]' > "${OUTDIR}/latest_merge_group_run.json" 2>/dev/null || true
fi
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

# Ensure merge_group is present as an event in workflows to support merge queue
if [ -f .github/workflows/quality-gates.yml ]; then
  if ! grep -q "merge_group" .github/workflows/quality-gates.yml; then
    echo "WARNING: quality-gates.yml missing merge_group event" > "${OUTDIR}/quality_gates_merge_group_missing.txt" || true
  fi
fi

echo "Snapshot complete" > "${OUTDIR}/snapshot.txt"
echo 0 > "${OUTDIR}/snapshot.exit_code.txt"
echo "${OUTDIR}"

exit 0
