#!/usr/bin/env bash
set -euo pipefail
preflight_dir="$1"
out="$preflight_dir/metadata.json"
utc_ts=$(date -u +%Y%m%dT%H%M%SZ)
git_head=$(git rev-parse HEAD 2>/dev/null || echo "")
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
opencode_ok_file="$preflight_dir/smoke_rerun_exitcode.txt"
opencode_ok=false
if [ -f "$opencode_ok_file" ]; then
  rc=$(cat "$opencode_ok_file" 2>/dev/null || echo "1")
  if [ "$rc" -eq 0 ]; then
    opencode_ok=true
  fi
fi
# permissions check
permissions_ok=true
if rg -n "Permission required" "$preflight_dir"/*.txt >/dev/null 2>&1; then
  permissions_ok=false
fi
# merge_group presence
merge_group_present=false
if rg -n "merge_group" .github/workflows >/dev/null 2>&1; then
  merge_group_present=true
fi
# pr13 state file
pr13_raw="$preflight_dir/gh_pr13_checks_raw.txt"
pr13_state="UNAVAILABLE"
if [ -f "$pr13_raw" ]; then
  # try parse JSON or fallback to text
  if jq -e . >/dev/null 2>&1 <"$pr13_raw"; then
    # if array, check all states
    st=$(jq -r '.[].state' "$pr13_raw" 2>/dev/null | paste -s -d, -)
    pr13_state="$st"
  else
    pr13_state=$(head -n200 "$pr13_raw" | tr '\n' ' ')
  fi
fi
# Build evidence pointers
evidence_ptrs=$(jq -n --arg p1 "$preflight_dir/smoke_rerun_stdout.txt" --arg p2 "$preflight_dir/smoke_rerun_stderr.txt" --arg p3 "$preflight_dir/smoke_rerun_exitcode.txt" '{smoke_stdout: $p1, smoke_stderr: $p2, smoke_exitcode: $p3}')
jq -n --arg utc_ts "$utc_ts" --arg git_head_sha "$git_head" --arg branch "$branch" --argjson opencode_ok "$opencode_ok" --argjson permissions_ok "$permissions_ok" --argjson merge_group_present "$merge_group_present" --arg pr13_state "$pr13_state" --argjson evidence_ptrs "$evidence_ptrs" \
  '{utc_ts: $utc_ts, git_head_sha: $git_head_sha, branch: $branch, opencode_ok: $opencode_ok, permissions_ok: $permissions_ok, merge_group_present: $merge_group_present, pr13_gates_state: $pr13_state, evidence_ptrs: $evidence_ptrs}' > "$out"
# validation: ensure fields present
for f in utc_ts git_head_sha branch opencode_ok permissions_ok merge_group_present pr13_gates_state evidence_ptrs; do
  if ! jq -e "has(\"$f\")" "$out" >/dev/null; then
    echo "missing field $f in $out" >&2
    exit 1
  fi
done
