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

BRANCH=${BRANCH:-main}
OUT_HTTP="$OUT_DIR/branch_protection_${BRANCH}.http"

echo "Checking branch protection for $REPO#$BRANCH"
gh api -i "/repos/$REPO/branches/$BRANCH/protection" > "$OUT_HTTP" 2>&1 || true

# Interpret common HTTP statuses by inspecting the raw response headers
echo "Interpreting branch protection HTTP response (see $OUT_HTTP)"
if grep -q "404 Not Found" "$OUT_HTTP"; then
  STATUS="404"
  NOTE="Branch protection endpoint returned 404: resource not found or branch has no protection configured"
elif grep -q "200 OK" "$OUT_HTTP"; then
  STATUS="200"
  NOTE="200 OK: Branch protection present; details in body"
elif grep -q "403 Forbidden" "$OUT_HTTP"; then
  STATUS="403"
  NOTE="403 Forbidden: token lacks permission to view branch protection (requires admin:org or repo:admin)"
else
  STATUS="unknown"
  NOTE="Could not determine HTTP status from response; inspect $OUT_HTTP"
fi

printf '{"repo":"%s","branch":"%s","status":"%s","note":"%s"}\n' "$REPO" "$BRANCH" "$STATUS" "$NOTE" > "$OUT_DIR/branch_protection_summary.json"

echo "Saved summary to $OUT_DIR/branch_protection_summary.json"

exit 0
