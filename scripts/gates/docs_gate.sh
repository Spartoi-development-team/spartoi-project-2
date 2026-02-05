#!/usr/bin/env bash
set -euo pipefail

# Backwards-compatible docs gate wrapper. Ensures mkdocs is present and fails with clear message if not.
echo "[docs_gate] checking mkdocs build (fail if missing)"
if command -v mkdocs >/dev/null 2>&1; then
  mkdocs build --strict >/dev/null 2>&1 || { echo "docs_gate: mkdocs build failed"; exit 1; }
else
  echo "docs_gate: mkdocs not installed; failing" >&2
  exit 1
fi

echo "docs_gate: OK"
