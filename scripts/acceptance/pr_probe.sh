#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="evidence/acceptance"
mkdir -p "$OUT_DIR"

REPO=${GITHUB_REPOSITORY:-}
if [ -z "$REPO" ]; then
  REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)
fi
if [ -z "$REPO" ]; then
  echo "ERROR: GITHUB_REPOSITORY not set and gh repo view failed" >&2
  exit 2
fi

PR_NUM=1
PR_JSON="$OUT_DIR/pr_${PR_NUM}.json"
PR_HTTP="$OUT_DIR/pr_${PR_NUM}.http"

echo "Fetching PR #$PR_NUM for $REPO"

# Use gh api to fetch PR details with headers
gh api -i "/repos/$REPO/pulls/$PR_NUM" > "$PR_HTTP" 2>&1 || true

# Extract body JSON safely: find first line that begins with '{' or '[' and write from there
awk 'BEGIN{found=0} { if(found||/^[[:space:]]*[{[]/){ found=1; print } }' "$PR_HTTP" > "$PR_JSON" || true

echo "Saved PR JSON to $PR_JSON and raw HTTP to $PR_HTTP"

# If PR exists, get merge status and checks
if jq -e .id "$PR_JSON" >/dev/null 2>&1; then
  echo "PR exists; fetching merge status and checks"
  gh api -i "/repos/$REPO/pulls/$PR_NUM/merge" > "$OUT_DIR/pr_${PR_NUM}_merge.http" 2>&1 || true
  gh api -i "/repos/$REPO/pulls/$PR_NUM/checks" > "$OUT_DIR/pr_${PR_NUM}_checks.http" 2>&1 || true
fi

exit 0
