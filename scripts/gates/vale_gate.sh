#!/usr/bin/env bash
set -euo pipefail

echo "[vale_gate] running vale if available"
if command -v vale >/dev/null 2>&1; then
  vale || { echo "vale_gate: vale reported failures"; exit 1; }
else
  echo "vale_gate: vale not installed; skipping";
fi

echo "vale_gate: OK"
