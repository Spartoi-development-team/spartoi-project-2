#!/usr/bin/env bash
set -euo pipefail

echo "==[1/7] System sanity =="
uname -a
whoami
echo "node: $(node --version)"
echo "python: $(python3 --version)"

echo "==[2/7] Install Bun (if missing) =="
if ! command -v bun >/dev/null 2>&1; then
  curl -fsSL https://bun.sh/install | bash
  # bun installer adds to ~/.bashrc; ensure current shell sees it
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi
echo "bun: $(bun --version)"

echo "==[3/7] Install OpenCode (if missing) =="
if ! command -v opencode >/dev/null 2>&1; then
  curl -fsSL https://opencode.ai/install | bash
  export PATH="$HOME/.local/bin:$PATH"
fi
echo "opencode: $(opencode --version)"

echo "==[4/7] Install Oh My OpenCode (OMOC) plugin =="
# Prefer bunx per guide (npx is known to be flaky for this stack)
bunx oh-my-opencode install || true

echo "==[5/7] Python deps for MkDocs Material =="
python3 -m pip install --upgrade pip
python3 -m pip install mkdocs-material

echo "==[6/7] Node deps for markdownlint + lychee =="
# markdownlint-cli2 (node) + lychee (we'll use action in CI; local optional)
npm -g i markdownlint-cli2 || true

echo "==[7/7] Done. Next: run 'opencode' inside repo =="
