#!/usr/bin/env bash
set -u
set -o pipefail

mkdir -p evidence/b1
target="${1:-github-copilot/gpt-5-mini}"
out="evidence/b1/model_probe.json"

# 若 operator 指定升級，才用升級模型（可稽核）
if [ -n "${OPENCODE_ESCALATE_MODEL:-}" ]; then
  target="${OPENCODE_ESCALATE_MODEL}"
fi

# 以最小 prompt 取證：stdout 必須精確回 OK + model_id
cmd=(opencode run -m "$target" "Reply ONLY: OK $target")
stdout=""
stderr=""
ec=0

# 不要讓整段炸掉
stdout="$("${cmd[@]}" 2> >(cat > evidence/b1/model_probe.stderr.txt) )" || ec=$?
stderr="$(cat evidence/b1/model_probe.stderr.txt 2>/dev/null || true)"

python - <<PY
import json, time
data={
  "utc_ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
  "requested_model": "$target",
  "exit_code": $ec,
  "stdout": ${json.dumps(stdout)},
  "stderr": ${json.dumps(stderr)}
}
open("$out","w",encoding="utf-8").write(json.dumps(data,ensure_ascii=False,indent=2)+"\n")
print("WROTE", "$out")
PY

# Fail-Closed 判準
if [ "$ec" -ne 0 ]; then
  echo "[FAIL] probe exit_code=$ec"
  exit 2
fi
if [ "$stdout" != "OK $target" ]; then
  echo "[FAIL] probe stdout mismatch"
  echo "  expected: OK $target"
  echo "  got:      $stdout"
  exit 3
fi

echo "[PASS] model probe OK: $target"
