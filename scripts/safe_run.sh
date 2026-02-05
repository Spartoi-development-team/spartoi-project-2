#!/usr/bin/env bash
set +e
TS="$(date -u +%Y%m%dT%H%M%SZ)"
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OUT="$ROOT/evidence/_opencode_safe/$TS"
mkdir -p "$OUT"

run() {
  local name="$1"; shift
  echo "===== $name =====" | tee -a "$OUT/_timeline.log"
  ( "$@" ) > >(tee "$OUT/$name.stdout.log") 2> >(tee "$OUT/$name.stderr.log" >&2)
  local ec=$?
  echo "$ec" | tee "$OUT/$name.exit_code.txt"
  echo "" | tee -a "$OUT/_timeline.log"
  return 0
}

run 01_opencode_version bash -lc "command -v opencode && opencode --version"
run 02_models           bash -lc "opencode models | tee \"$OUT/models.txt\""
run 03_config           bash -lc "ls -la opencode.json; cat opencode.json"

# 如果 acceptance.sh 尚未存在，先 FAIL-Closed 並把缺口落盤
if [ -x scripts/acceptance.sh ]; then
  run 04_acceptance     bash -lc "scripts/acceptance.sh"
else
  echo "MISSING scripts/acceptance.sh" | tee -a "$OUT/_timeline.log"
  echo 2 > "$OUT/04_acceptance.exit_code.txt"
fi

echo "DONE: $OUT"
