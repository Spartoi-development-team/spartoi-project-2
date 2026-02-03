#!/usr/bin/env bash
set -Eeuo pipefail
trap 'echo "❌ FAIL @ line $LINENO: $BASH_COMMAND" >&2' ERR

mkdir -p evidence
LOG="evidence/verify_ruleset_and_pr.log"
exec > >(tee -a "$LOG") 2>&1

API_VER="2022-11-28"
OWNER="$(gh repo view --json owner -q .owner.login)"
REPO="$(gh repo view --json name  -q .name)"

echo "==[0] auth status =="
gh auth status -h github.com || true
echo

echo "==[1] list rulesets =="
gh api -i -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: $API_VER" \
  "/repos/$OWNER/$REPO/rulesets" | tee evidence/rulesets_list.http

# 取出 body：遇到 CRLF/LF 都能過
BODY="$(awk 'BEGIN{h=1} { if(h && ($0=="\r" || $0=="")) {h=0; next} if(!h) print }' evidence/rulesets_list.http)"
echo "$BODY" | jq -e . >/dev/null
echo "$BODY" | jq -r '.[] | "\(.id)\t\(.name)\t\(.enforcement)\t\(.conditions.ref_name.include|join(","))"'

RID="$(echo "$BODY" | jq -r '.[] | select(.name=="fail-closed-gates") | .id' | head -n1)"
test -n "$RID"
echo "ruleset_id=$RID"
echo

echo "==[2] ruleset detail must include required check gates =="
gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: $API_VER" \
  "/repos/$OWNER/$REPO/rulesets/$RID" | tee "evidence/ruleset_${RID}.json" >/dev/null

jq -e '.rules[] | select(.type=="required_status_checks") | .parameters.required_status_checks[] | select(.context=="gates")' \
  "evidence/ruleset_${RID}.json" >/dev/null
echo "✅ ruleset requires check context: gates"
echo

echo "==[3] PR #1 merge/check state (authoritative) =="
gh pr view 1 --json url,title,mergeStateStatus,statusCheckRollup \
  | tee evidence/pr1_state.json

jq -r '"url=\(.url)\nmergeStateStatus=\(.mergeStateStatus)\nchecks=" + ((.statusCheckRollup//[])|map(.name + ":" + (.conclusion//"pending"))|join(", "))' \
  evidence/pr1_state.json
echo

echo "==[4] classic branch protection status (200 exists / 404 none / 403 auth issue) =="
gh api -i -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: $API_VER" \
  "/repos/$OWNER/$REPO/branches/main/protection" | tee evidence/branch_protection_main.http || true

STATUS="$(head -n1 evidence/branch_protection_main.http | awk "{print \$2}")"
echo "http_status=$STATUS"
case "$STATUS" in
  200) echo "classic branch protection: EXISTS" ;;
  404) echo "classic branch protection: NONE (or auth issue if token is wrong)" ;;
  403) echo "classic branch protection: AUTH ISSUE" ;;
  *)   echo "classic branch protection: UNKNOWN" ;;
esac

echo
echo "✅ DONE. Evidence saved under evidence/"
