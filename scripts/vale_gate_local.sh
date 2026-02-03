#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

echo "=== Vale Gate Check (Local) ==="
command -v vale >/dev/null 2>&1 || { echo "vale missing. Install it first."; exit 1; }
[ -f .vale.ini ] || { echo ".vale.ini missing"; exit 1; }

# Lint markdown under docs/ + repo root docs
vale docs/**/*.md docs/*.md README.md AGENTS.md CLAUDE.md || {
  echo "❌ Vale FAILED"
  exit 1
}
echo "✅ Vale PASSED"
