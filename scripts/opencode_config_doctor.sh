#!/usr/bin/env bash
set -euo pipefail:contentReference[oaicite:4]{index=4}] $*" >&2; exit 1; }
pass() { echo "[PASS] $*"; }

FILES=()
[ -f .opencode/opencode.json ] && FILES+=(".opencode/opencode.json")
[ -f .opencode/opencode.jsonc ] && FILES+=(".opencode/opencode.jsonc")
[ -f "$HOME/.config/opencode/opencode.json" ] && FILES+=("$HOME/.config/opencode/opencode.json")
[ -f "$HOME/.config/opencode/opencode.jsonc" ] && FILES+=("$HOME/.config/opencode/opencode.jsonc")

[ ${#FILES[@]} -eq 0 ] && pass "No opencode config files found." && exit 0

for f in "${FILES[@]}"; do
  # jsonc 先粗檢（避免 jq 直接炸）；只要抓到 mcp.enabled 就 Fail
  if grep -qE '"mcp"[[:space:]]*:[[:space:]]*\{[^}]*"enabled"[[:space:]]*:' "$f"; then
    fail "$f contains illegal key: mcp.enabled (OpenCode expects mcp.<server>.enabled)"
  fi
done

pass "No illegal mcp.enabled key found in configs."
