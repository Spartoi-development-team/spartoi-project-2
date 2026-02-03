#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="evidence/acceptance"
mkdir -p "$OUT_DIR"

TS=$(date --iso-8601=seconds)

echo "=== AUTH CHECK ($TS) ===" | tee "$OUT_DIR/auth_check.txt"

echo "-- Environment (GH/GITHUB variables masked) --" | tee -a "$OUT_DIR/auth_check.txt"
for v in GH_TOKEN GITHUB_TOKEN GH_ADMIN_TOKEN; do
  if [ -n "${!v-}" ]; then
    val="${!v}"
    masked="${val:0:4}...${val: -4}"
    echo "$v=SET (masked=$masked)" | tee -a "$OUT_DIR/auth_check.txt"
  else
    echo "$v=UNSET" | tee -a "$OUT_DIR/auth_check.txt"
  fi
done

echo "-- gh auth status (CLI) --" | tee -a "$OUT_DIR/auth_check.txt"
gh auth status 2>&1 | tee "$OUT_DIR/gh_auth_status.txt" | tee -a "$OUT_DIR/auth_check.txt"

echo "-- gh api /user (HTTP with headers) --" | tee -a "$OUT_DIR/auth_check.txt"
# This will show response headers (including X-OAuth-Scopes) proving which token/scopes were used
gh api -i /user 2>&1 | tee "$OUT_DIR/gh_api_user.http" | tee -a "$OUT_DIR/auth_check.txt"

echo
echo "Auth check complete. Files written: $OUT_DIR/gh_auth_status.txt, $OUT_DIR/gh_api_user.http" | tee -a "$OUT_DIR/auth_check.txt"

exit 0
