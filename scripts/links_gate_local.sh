#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

echo "=== Links Gate Check (Local) ==="
command -v lychee >/dev/null 2>&1 || { echo "lychee missing. Install it first."; exit 1; }

# Scope: only check *your* docs + repo contracts, not vendored deps.
# Exclude paths are regex (not URLs). See lychee docs.
lychee \
  --no-progress \
  --max-concurrency 8 \
  --timeout 20 \
  --retry-wait-time 2 \
  --exclude-path '(?:^|/)site/' \
  --exclude-path '(?:^|/)node_modules/' \
  --exclude-path '(?:^|/)\.opencode/node_modules/' \
  docs/**/*.md docs/*.md README.md AGENTS.md CLAUDE.md .opencode/commands/**/*.md .opencode/command/*.md || {
    echo "❌ Lychee FAILED"
    exit 1
  }

echo "✅ Lychee PASSED"
