#!/usr/bin/env bash
set -euo pipefail

echo "=== Docs Gate Check (Local) ==="
echo ""

echo "[1/2] Running mkdocs build --strict..."
if mkdocs build --strict; then
  echo "✅ MkDocs build PASSED"
else
  echo "❌ MkDocs build FAILED"
  exit 1
fi
echo ""

echo "[2/2] Running markdownlint-cli2 on project files..."
if markdownlint-cli2 AGENTS.md README.md docs/index.md .opencode/command/ping.md .opencode/commands/ping.md; then
  echo "✅ Markdownlint PASSED"
else
  echo "❌ Markdownlint FAILED"
  exit 1
fi
echo ""

echo "=== All Docs Gate Checks PASSED ==="
