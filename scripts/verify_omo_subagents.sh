#!/usr/bin/env bash
set -euo pipefail
TS=$(date -u +%Y%m%dT%H%M%SZ)
OUT_DIR="evidence/_omoc_verify/${TS}"
mkdir -p "$OUT_DIR"

# Run a short opencode task (radar-only, non-execute): ask opencode to list available agents
opencode run "List active agents and providers" > "$OUT_DIR/opencode_run.stdout" 2> "$OUT_DIR/opencode_run.stderr" || true

# Grep validations
grep -E "call_omo_agent|delegate_task|explore|librarian|oracle" "$OUT_DIR/opencode_run.stdout" > "$OUT_DIR/grep_subagents.txt" || true
grep -E "providerID=github-copilot|providerID=opencode|modelID=gpt-5-nano" "$OUT_DIR/opencode_run.stdout" > "$OUT_DIR/grep_providers.txt" || true

echo "Verification output saved to $OUT_DIR"
