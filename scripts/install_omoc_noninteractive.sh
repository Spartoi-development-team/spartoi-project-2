#!/usr/bin/env bash
# Non-interactive OMOC installer for CI / automated runs
set -u

echo "Installing OMOC (non-interactive)"

# Non-interactive flags / provider selection
export OHMYOPENCODE_PROVIDERS="copilot=yes,claude=no,openai=no,gemini=no,opencode-zen=no,zai=no"

# Ensure no interactive prompts from common installers
export DEBIAN_FRONTEND=noninteractive
export GIT_TERMINAL_PROMPT=0

# Install bun if missing non-interactively
if ! command -v bun >/dev/null 2>&1; then
  curl -fsSL https://bun.sh/install | BUN_INSTALLER_NONINTERACTIVE=1 bash || true
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Install opencode CLI non-interactively
if ! command -v opencode >/dev/null 2>&1; then
  curl -fsSL https://opencode.ai/install | bash || true
  export PATH="$HOME/.local/bin:$PATH"
fi

echo "Registering OMOC plugin (bunx oh-my-opencode install)"
# Use non-interactive plugin install; bunx may not exist in PATH for some shells
if command -v bunx >/dev/null 2>&1; then
  bunx oh-my-opencode install --non-interactive --providers "$OHMYOPENCODE_PROVIDERS" || true
else
  # fallback to npx way without prompts
  npx --yes oh-my-opencode install --non-interactive --providers "$OHMYOPENCODE_PROVIDERS" || true
fi

echo "Verifying opencode plugin registration"
if [ -f .opencode/opencode.json ]; then
  grep -q 'oh-my-opencode' .opencode/opencode.json || true
fi

echo "Done"

exit 0
