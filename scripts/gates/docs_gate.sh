#!/usr/bin/env bash
set -euo pipefail

echo "[docs_gate] checking mkdocs build (non-fatal if missing)"
if command -v mkdocs >/dev/null 2>&1; then
  mkdocs build --strict >/dev/null 2>&1 || { echo "docs_gate: mkdocs build failed"; exit 1; }
else
  echo "docs_gate: mkdocs not installed; skipping";
fi

echo "docs_gate: OK"
