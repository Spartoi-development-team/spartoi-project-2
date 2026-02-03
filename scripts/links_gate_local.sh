#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

echo "=== Links Gate Check (Local) ==="
command -v lychee >/dev/null 2>&1 || { echo "lychee missing. Install it first."; exit 1; }

# Tweak these defaults if needed:
# - Exclude common noisy paths (site build output)
# - Fail on broken links
# - Use a cache to reduce flakiness
lychee \
  --no-progress \
  --max-concurrency 8 \
  --timeout 20 \
  --retry-wait-time 2 \
  --exclude-path site \
  "**/*.md" "**/*.html" || {
    echo "❌ Lychee FAILED"
    exit 1
  }

echo "✅ Lychee PASSED"
