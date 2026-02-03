#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

echo "=== Links Gate Check (Local) ==="
command -v lychee >/dev/null 2>&1 || { echo "lychee missing. Install it first."; exit 1; }

# Enable ** recursive globbing; nullglob prevents literal patterns from leaking through.
shopt -s globstar nullglob

inputs=(
  docs/**/*.md
  docs/*.md
  README.md
  AGENTS.md
  CLAUDE.md
  .opencode/commands/**/*.md
  .opencode/command/*.md
)

# Fail-closed: "0 files" must be a failure, not a pass.
if [ "${#inputs[@]}" -eq 0 ]; then
  echo "❌ Lychee FAILED: no inputs matched (check paths/globs)"
  exit 1
fi

lychee \
  --no-progress \
  --max-concurrency 8 \
  --timeout 20 \
  --retry-wait-time 2 \
  --exclude-path '(?:^|/)site/' \
  --exclude-path '(?:^|/)node_modules/' \
  --exclude-path '(?:^|/)\.opencode/node_modules/' \
  "${inputs[@]}" || {
    echo "❌ Lychee FAILED"
    exit 1
  }

echo "✅ Lychee PASSED"
