#!/usr/bin/env bash
set -euo pipefail
echo "Starting minimal sanity run"
if [ -f .opencode/sanity.json ]; then
  # run the configured command if present
  cmd=$(jq -r '.sanity // empty' .opencode/sanity.json)
  if [ -n "$cmd" ]; then
    echo "Running: $cmd"
    eval "$cmd"
    exit 0
  fi
fi
echo "No sanity command found"
exit 2
