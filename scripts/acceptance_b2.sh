#!/usr/bin/env bash
set -u
set -o pipefail

mkdir -p evidence/b2
# 1) 先取證：預設 gpt-5-mini，除非 OPENCODE_ESCALATE_MODEL 有指定
bash scripts/probe_model.sh || { echo "[ACCEPTANCE] FAIL: model probe"; exit 10; }

# 2) 跑原本 acceptance
bash scripts/acceptance_b2.inner.sh > evidence/b2/acceptance_console.txt 2>&1
ec=$?
echo "$ec" > evidence/b2/exit_code.txt
tail -n 80 evidence/b2/acceptance_console.txt || true

exit "$ec"
