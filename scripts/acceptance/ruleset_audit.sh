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
    # Keep a raw copy
    cp "$DETAILS_DIR/${safe_name}.http" "$DETAILS_DIR/${safe_name}_raw.http"
    echo "Saved $DETAILS_DIR/${safe_name}.http" | tee -a "$OUT_DIR/ruleset_audit.txt"

    # Extract JSON body (first line starting with [ or {) into a .json file if possible
    BODY_JSON="$DETAILS_DIR/${safe_name}.json"
    awk 'BEGIN{found=0} { if(found||/^[[:space:]]*[{[]/){ found=1; print } }' "$DETAILS_DIR/${safe_name}.http" > "$BODY_JSON" || true

    # If body contains an array of rulesets, fetch each ruleset detail via its _links.self.href
    if command -v jq >/dev/null 2>&1 && jq -e 'type=="array"' "$BODY_JSON" >/dev/null 2>&1; then
      echo "Found ruleset list; enumerating individual rulesets" | tee -a "$OUT_DIR/ruleset_audit.txt"
      mkdir -p "$DETAILS_DIR/per_ruleset"
      # For each ruleset, get its id and self href
      jq -c '.[]' "$BODY_JSON" | while read -r item; do
        id=$(echo "$item" | jq -r '.id // empty')
        href=$(echo "$item" | jq -r '._links.self.href // empty')
        if [ -n "$id" ] && [ -n "$href" ]; then
          safefile="$DETAILS_DIR/per_ruleset/ruleset_${id}.http"
          echo "Fetching ruleset $id -> $href" | tee -a "$OUT_DIR/ruleset_audit.txt"
          gh api -i "$href" > "$safefile" 2>&1 || true
          # extract body json
          awk 'BEGIN{found=0} { if(found||/^[[:space:]]*[{[]/){ found=1; print } }' "$safefile" > "$DETAILS_DIR/per_ruleset/ruleset_${id}.json" || true
        else
          echo "Skipping item without id/href" | tee -a "$OUT_DIR/ruleset_audit.txt"
        fi
      done
    fi

  else
    echo "Endpoint $ep returned non-200 (see ${DETAILS_DIR}/${safe_name}.http)" | tee -a "$OUT_DIR/ruleset_audit.txt"
  fi
done

echo "ruleset audit complete. See $DETAILS_DIR" | tee -a "$OUT_DIR/ruleset_audit.txt"

exit 0
