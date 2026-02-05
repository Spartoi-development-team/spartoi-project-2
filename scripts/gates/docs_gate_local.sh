#!/usr/bin/env bash
set -euo pipefail

echo "[docs_gate_local] starting"
set -x
echo "[docs_gate_local] PATH=$PATH"
echo "[docs_gate_local] which python:"; which python || true
echo "[docs_gate_local] which python3:"; which python3 || true
echo "[docs_gate_local] mkdocs CLI available:"; command -v mkdocs || true
if command -v mkdocs >/dev/null 2>&1; then
  echo "[docs_gate_local] mkdocs --version:"; mkdocs --version || true
  mkdocs build --strict || { echo "docs_gate_local: mkdocs build failed"; exit 1; }
elif python -m mkdocs >/dev/null 2>&1; then
  echo "[docs_gate_local] python -m mkdocs --version:"; python -m mkdocs --version || true
  # Fallback: run mkdocs via python -m to avoid relying on PATH
  python -m mkdocs build --strict || { echo "docs_gate_local: python -m mkdocs build failed"; exit 1; }
else
  # If mkdocs is not available via CLI or python -m, this is a real failure.
  echo "docs_gate_local: mkdocs not installed; failing with clear message" >&2
  echo "Ensure mkdocs is installed via pip (python -m pip install mkdocs) or provide a runner with mkdocs available" >&2
  exit 1
fi

echo "docs_gate_local: OK"
