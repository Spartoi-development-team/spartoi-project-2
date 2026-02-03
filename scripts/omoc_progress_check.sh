#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

echo "== [A] Runtime =="
date -Is
uname -a || true
echo "CODESPACES=${CODESPACES:-false}"
echo

echo "== [B] Must-have tools =="
need(){ command -v "$1" >/dev/null 2>&1 && echo "✓ $1 ($(command -v "$1"))" || echo "✗ $1 MISSING"; }
need git
need jq
need node
need npm
need bun
need python
need pip
need opencode
need gh
echo

echo "== [C] Versions =="
opencode --version || true
lychee --version 2>/dev/null || echo "(lychee not installed)"
vale --version 2>/dev/null || echo "(vale not installed)"
echo

echo "== [D] Repo contracts & configs =="
for f in AGENTS.md CLAUDE.md opencode.json .opencode/oh-my-opencode.json; do
  [ -f "$f" ] && echo "✓ $f" || echo "✗ missing $f"
done
jq -e . opencode.json >/dev/null && echo "✓ opencode.json parse OK" || echo "✗ opencode.json parse FAIL"
jq -e . .opencode/oh-my-opencode.json >/dev/null && echo "✓ .opencode/oh-my-opencode.json parse OK" || echo "✗ .opencode/oh-my-opencode.json parse FAIL"
echo

echo "== [E] Gates (local) =="
bash scripts/gate_all_local.sh
echo

echo "== [F] Git status =="
git status --porcelain
echo

echo "== [G] Suggest next actions =="
echo "- ACTION: OpenCode TUI: /connect -> GitHub Copilot -> device login; then /models."
echo "- ACTION: Verify merge queue checks run on merge_group (CI already prepared)."
