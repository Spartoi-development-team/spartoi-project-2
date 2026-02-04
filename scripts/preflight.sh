#!/usr/bin/env bash
# preflight: conservative, avoids set -euo to prevent unexpected process exit in wrappers

set -u

# Create evidence preflight files if missing
mkdir -p evidence/preflight
preflight_file="evidence/preflight/preflight.txt"
repo_meta="evidence/repo_meta.json"

if [ ! -f "$preflight_file" ]; then
  echo "Preflight run at: $(date -u --iso-8601=seconds)" > "$preflight_file"
  echo "branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)" >> "$preflight_file"
  echo "commit=$(git rev-parse HEAD 2>/dev/null || echo unknown)" >> "$preflight_file"
fi

if [ ! -f "$repo_meta" ]; then
  mkdir -p evidence
  cat > "$repo_meta" <<EOF
{
  "repo": "$(git rev-parse --show-toplevel 2>/dev/null || pwd)",
  "commit": "$(git rev-parse HEAD 2>/dev/null || echo unknown)",
  "branch": "$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)",
  "generated_at": "$(date -u --iso-8601=seconds)"
}
EOF
fi

echo "OK: preflight done"
