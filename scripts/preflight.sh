#!/usr/bin/env bash
set -u

TS="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="evidence/_preflight/$TS"
mkdir -p "$OUT"

run() {
  local name="$1"; shift
  local cmd="$*"
  echo "===== [$name] cmd: $cmd" | tee -a "$OUT/_meta.log"
  bash -lc "$cmd" \
    > >(tee "$OUT/${name}.stdout.log") \
    2> >(tee "$OUT/${name}.stderr.log" >&2)
  local ec=$?
  echo "===== [$name] exit_code=$ec" | tee -a "$OUT/_meta.log"
  echo "$ec" > "$OUT/${name}.exit_code.txt"
  return 0
}

run "01_git_remote" 'git remote -v'
run "02_git_status" 'git status -sb || true; git log -1 --oneline || true'
run "03_repo_identity" 'echo "PWD=$PWD"; git rev-parse --show-toplevel || true; git rev-parse --abbrev-ref HEAD || true; git rev-parse HEAD || true'

# OpenCode basics (logs path per official troubleshooting)
run "10_opencode_version" 'opencode --version || true'
run "11_opencode_help" 'opencode --help | sed -n "1,200p" || true'
run "12_opencode_models" 'opencode models 2>&1 | sed -n "1,240p" || true'
run "13_opencode_sanity" 'opencode --log-level DEBUG --print-logs run "Reply ONLY: OK." || true'

# Collect last logs (OpenCode writes logs under ~/.local/share/opencode/log/ on macOS/Linux)
run "14_opencode_logs_ls" 'ls -la ~/.local/share/opencode/log/ 2>/dev/null || true'
run "15_opencode_logs_tail" 'for f in $(ls -1t ~/.local/share/opencode/log/* 2>/dev/null | head -n 3); do echo "--- $f"; tail -n 200 "$f"; done || true'

# GitHub CLI / Auth / Repo metadata
run "20_gh_version" 'gh --version || true'
run "21_gh_auth_status" 'gh auth status || true'
run "22_gh_repo_view" 'gh repo view --json nameWithOwner,visibility,defaultBranchRef,url 2>/dev/null || true'

# Workflows / Runs
run "30_workflows_ls" 'ls -la .github/workflows 2>/dev/null || true'
run "31_gh_workflow_list" 'gh workflow list 2>/dev/null || true'
run "32_gh_run_list" 'gh run list --limit 20 2>/dev/null || true'

# Rulesets / Branch protection (may fail if token lacks perms; still record)
OWNER_REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)"
echo "$OWNER_REPO" > "$OUT/_owner_repo.txt"
run "40_rulesets_list" 'test -n "'"$OWNER_REPO"'" && gh api "repos/'"$OWNER_REPO"'/rulesets" 2>/dev/null | tee "'"$OUT"'/rulesets.json" >/dev/null || true'
run "41_branch_protection_main" 'test -n "'"$OWNER_REPO"'" && gh api "repos/'"$OWNER_REPO"'/branches/main/protection" 2>/dev/null | tee "'"$OUT"'/branch_protection_main.json" >/dev/null || true'

# Evidence directories snapshot
run "50_evidence_tree" 'ls -la evidence 2>/dev/null || true; find evidence -maxdepth 4 -type f 2>/dev/null | sed -n "1,200p" || true'
echo "DONE. Evidence at: $OUT"
