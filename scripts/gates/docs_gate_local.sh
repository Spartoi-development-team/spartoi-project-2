#!/usr/bin/env bash
set -euo pipefail

echo "[docs_gate_local] starting"
if command -v mkdocs >/dev/null 2>&1; then
  mkdocs build --strict >/dev/null 2>&1 || { echo "docs_gate_local: mkdocs build failed"; exit 1; }
elif python -m mkdocs >/dev/null 2>&1; then
  # Fallback: run mkdocs via python -m to avoid relying on PATH
  python -m mkdocs build --strict >/dev/null 2>&1 || { echo "docs_gate_local: python -m mkdocs build failed"; exit 1; }
else
  # If mkdocs is not available via CLI or python -m, this is a real failure.
  echo "docs_gate_local: mkdocs not installed; failing with clear message" >&2
  echo "Ensure mkdocs is installed via pip (python -m pip install mkdocs) or provide a runner with mkdocs available" >&2
  exit 1
fi

echo "docs_gate_local: OK"
