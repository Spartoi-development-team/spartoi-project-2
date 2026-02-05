#!/usr/bin/env bash
set -u
TS="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="evidence/_opencode_safe/$TS"
mkdir -p "$OUT"

echo "[SAFE] running: opencode $*" | tee "$OUT/cmd.txt"
(opencode --log-level DEBUG --print-logs "$@") \
  > >(tee "$OUT/stdout.log") \
  2> >(tee "$OUT/stderr.log" >&2)
EC=$?
echo "$EC" > "$OUT/exit_code.txt"
echo "[SAFE] exit_code=$EC"

# collect last logs if exist
mkdir -p "$OUT/opencode_logs"
ls -1t ~/.local/share/opencode/log/* 2>/dev/null | head -n 5 | while read -r f; do
  cp -f "$f" "$OUT/opencode_logs/" 2>/dev/null || true
done

exit 0
