#!/usr/bin/env bash
set -euo pipefail

echo "[links_gate] running lychee if available"
if command -v lychee >/dev/null 2>&1; then
  lychee . || { echo "links_gate: lychee reported failures"; exit 1; }
else
  echo "links_gate: lychee not installed; skipping";
fi

echo "links_gate: OK"
