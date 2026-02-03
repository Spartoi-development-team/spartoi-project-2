#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="evidence/acceptance"
mkdir -p "$OUT_DIR"

echo "Listing repository rulesets and saving details"

LIST_JSON="$OUT_DIR/rulesets_list.json"
DETAILS_DIR="$OUT_DIR/rulesets"
mkdir -p "$DETAILS_DIR"

# List rulesets (returns array) - capture headers too
echo "-- gh api -i /repos/:owner/:repo/code-scanning/sarif" >/dev/stderr

# Use the repo inferred by gh; allow user to set GITHUB_REPOSITORY
REPO=${GITHUB_REPOSITORY:-}
if [ -z "$REPO" ]; then
  # try gh repo view to get repo
  REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)
fi
if [ -z "$REPO" ]; then
  echo "ERROR: GITHUB_REPOSITORY not set and gh repo view failed" >&2
  exit 2
fi

echo "Repository: $REPO" > "$OUT_DIR/ruleset_audit.txt"

# The API for rulesets may be under repos/:owner/:repo/branch_protection/rulesets or org-level; we'll attempt candidate endpoints
ENDPOINTS=(
  "/repos/$REPO/rulesets"
  "/orgs/$(echo $REPO | cut -d'/' -f1)/rulesets"
)

for ep in "${ENDPOINTS[@]}"; do
  safe_name=$(echo "$ep" | tr '/:' '_' | tr -s '_')
  echo "Trying endpoint: $ep" | tee -a "$OUT_DIR/ruleset_audit.txt"
  if gh api -i "$ep" > "$DETAILS_DIR/${safe_name}.http" 2>&1; then
    # extract body JSON (naively: find first blank line then body). Save raw
    cp "$DETAILS_DIR/${safe_name}.http" "$DETAILS_DIR/${safe_name}_raw.http"
    echo "Saved $DETAILS_DIR/${safe_name}.http" | tee -a "$OUT_DIR/ruleset_audit.txt"
  else
    echo "Endpoint $ep returned non-200 (see ${DETAILS_DIR}/${safe_name}.http)" | tee -a "$OUT_DIR/ruleset_audit.txt"
  fi
done

echo "ruleset audit complete. See $DETAILS_DIR" | tee -a "$OUT_DIR/ruleset_audit.txt"

exit 0
