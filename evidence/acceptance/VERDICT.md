REPRODUCTION
------------
To reproduce the run exactly (from repo root):

env -u GITHUB_TOKEN GH_TOKEN="$GH_ADMIN_TOKEN" bash scripts/acceptance/aggregator.sh

EVIDENCE
--------
- evidence/acceptance/gh_auth_status.txt         -> gh auth status output
- evidence/acceptance/gh_api_user.http           -> gh api -i /user (headers + JSON)
- evidence/acceptance/rulesets/*                 -> rulesets list and raw HTTPs
- evidence/acceptance/pr_1.json                  -> PR #1 JSON body
- evidence/acceptance/pr_1.http                  -> PR #1 raw HTTP (headers + body)
- evidence/acceptance/pr_1_merge.http            -> PR #1 merge endpoint raw HTTP
- evidence/acceptance/pr_1_checks.http           -> PR #1 checks endpoint raw HTTP
- evidence/acceptance/branch_protection_main.http-> Branch protection raw HTTP
- evidence/acceptance/branch_protection_summary.json -> Interpreted status

SUMMARY
-------
Gate: Token provenance
- Verdict: PASS
  Evidence: gh auth status shows a token with scopes: gist, read:org, repo. See gh_api_user.http X-Oauth-Scopes header.

Gate: Ruleset presence
- Verdict: PASS
  Evidence: rulesets list returned HTTP 200 with entries. See evidence/acceptance/rulesets/_repos_shw097_spartoi-project-2_rulesets_raw.http

Detailed per-ruleset files saved under evidence/acceptance/rulesets/per_ruleset/*.json and *.http

Gate: PR probe (PR #1 existence and mergeability)
- Verdict: PASS (PR exists)
  Evidence: pr_1.json shows PR #1 state "open" and "mergeable_state":"blocked". Merge/check endpoints captured.

Gate: Branch protection
- Verdict: FAIL (Branch not protected)
  Evidence: branch_protection_main.http returned HTTP/2.0 404 Not Found with body {"message":"Branch not protected"}

NOTES & NEXT STEPS
------------------
- Multiple rulesets found. Do NOT delete automatically. Minimal cleanup plan:
  1) Inspect each ruleset detail: cat evidence/acceptance/rulesets/*_repos_*_rulesets_raw.http | jq .[].id,.[]
  2) Decide which ruleset(s) are redundant. To remove a repository ruleset: gh api -X DELETE /repos/:owner/:repo/rulesets/:ruleset_id -i --input -  # supply minimal JSON if required
  3) Prefer disabling enforcement before deletion: gh api -X PATCH /repos/:owner/:repo/rulesets/:ruleset_id -f enforcement=disabled -i

Exact commands used (examples):
gh auth status
gh api -i /user
gh api -i /repos/$GITHUB_REPOSITORY/pulls/1
gh api -i /repos/$GITHUB_REPOSITORY/branches/main/protection
