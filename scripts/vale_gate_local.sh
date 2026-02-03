#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

echo "=== Vale Gate Check (Local) ==="
command -v vale >/dev/null 2>&1 || { echo "vale missing. Install it first."; exit 1; }
[ -f .vale.ini ] || { echo ".vale.ini missing"; exit 1; }

# Enable ** recursive globbing + avoid literal patterns when empty
shopt -s globstar nullglob

files=(
  docs/**/*.md
  docs/*.md
  README.md
  AGENTS.md
  CLAUDE.md
)

# Fail-closed: if nothing matched, do not pass silently.
if [ "${#files[@]}" -eq 0 ]; then
  echo "❌ Vale FAILED: no markdown files matched (check docs/ exists and globstar is working)"
  exit 1
fi

vale "${files[@]}" || {
  echo "❌ Vale FAILED"
  exit 1
}

echo "✅ Vale PASSED"
