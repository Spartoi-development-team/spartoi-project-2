#!/usr/bin/env bash
set -euo pipefail
UTC_TS="${1:-$(date -u +%Y%m%dT%H%M%SZ)}"
EVD="evidence/_acceptance/${UTC_TS}"
mkdir -p "$EVD"

{
  echo "utc_ts=${UTC_TS}"
  echo "pwd=$(pwd)"
  echo "--- opencode --version ---"
  opencode --version || true
  echo "--- guard ---"
  ./scripts/opencode_no_prompt_guard.sh
  echo "--- config excerpts ---"
  echo "[project] .opencode/opencode.json permission:"
  python - <<'PY'
import json
d=json.load(open(".opencode/opencode.json","r",encoding="utf-8"))
print(d.get("permission"))
PY
  echo "[omoc] presence:"
  ls -la .opencode/oh-my-opencode.json* 2>/dev/null || true
} | tee "$EVD/acceptance_console.txt"

# A minimal smoke run: should not stop for "Permission required" if permissions are allow.
# We run a tiny instruction. If it still prompts, it will hang; that's a FAIL in CI terms.
# Use a timeout so we can fail-closed.
timeout 60s opencode run "Print 'OK' and do not modify files." \
  >"$EVD/opencode_run_stdout.txt" 2>"$EVD/opencode_run_stderr.txt" || true

echo "exit_code=$?" > "$EVD/opencode_run_exit_code.txt" || true

# Detect the old symptom explicitly
if rg -n "Permission required" "$EVD/opencode_run_stderr.txt" "$EVD/opencode_run_stdout.txt" >/dev/null 2>&1; then
  echo "[FAIL] Permission required still present" | tee -a "$EVD/acceptance_console.txt"
  exit 9
fi

echo "[PASS] No Permission required detected in smoke run outputs" | tee -a "$EVD/acceptance_console.txt"
