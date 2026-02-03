#!/usr/bin/env bash
# This script verifies documentation and markdown linting standards for the project.
set -euo pipefail

# Step 1: Validate mkdocs build process.
echo "=== Docs Gate Check (Local) ==="
echo ""

echo "[1/2] Running mkdocs build --strict..."
if mkdocs build --strict; then
  echo "✅ MkDocs build PASSED"
else
  echo "❌ MkDocs build FAILED"
  echo "Ensure mkdocs.yml is valid and all documentation files are complete."
  exit 1
fi
echo ""

# Step 2: Verify Markdown files comply with project conventions.
echo "[2/2] Running markdownlint-cli2 on project files..."
if markdownlint-cli2 AGENTS.md README.md docs/index.md .opencode/command/ping.md .opencode/commands/ping.md; then
  echo "✅ Markdownlint PASSED"
else
  echo "❌ Markdownlint FAILED"
  echo "Fix markdown formatting issues listed by markdownlint and retry."
  exit 1
fi
echo ""

echo "=== All Docs Gate Checks PASSED ==="

