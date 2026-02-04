#!/usr/bin/env bash
set -u
set -o pipefail

mkdir -p evidence/b1

target="github-copilot/gpt-5-mini"
if [ -n "${OPENCODE_ESCALATE_MODEL:-}" ]; then
  target="${OPENCODE_ESCALATE_MODEL}"
fi

stderr_file="evidence/b1/model_probe.stderr.txt"
stdout_file="evidence/b1/model_probe.stdout.txt"

# run probe (capture stdout/stderr separately)
stdout="$(opencode run -m "$target" "Reply ONLY: OK $target" 2> "$stderr_file")"
ec=$?
printf "%s" "$stdout" > "$stdout_file"

# write machine-verifiable JSON evidence (IMPORTANT: quoted heredoc to prevent bash expansion)
python - <<'PY'
import json, time, os
target = os.environ.get("TARGET_MODEL","")
ec = int(os.environ.get("PROBE_EXIT","1"))
stdout = open("evidence/b1/model_probe.stdout.txt","r",encoding="utf-8").read()
stderr = open("evidence/b1/model_probe.stderr.txt","r",encoding="utf-8").read()

out = {
  "utc_ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
  "requested_model": target,
  "exit_code": ec,
  "stdout": stdout,
  "stderr": stderr
}
open("evidence/b1/model_probe.json","w",encoding="utf-8").write(json.dumps(out,ensure_ascii=False,indent=2)+"\n")
print("WROTE evidence/b1/model_probe.json")
PY

# export values for python block
# (do it after python write? no—python reads env; so we rerun python with env)
TARGET_MODEL="$target" PROBE_EXIT="$ec" python - <<'PY'
import json, time, os
target = os.environ.get("TARGET_MODEL","")
ec = int(os.environ.get("PROBE_EXIT","1"))
stdout = open("evidence/b1/model_probe.stdout.txt","r",encoding="utf-8").read()
stderr = open("evidence/b1/model_probe.stderr.txt","r",encoding="utf-8").read()

out = {
  "utc_ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
  "requested_model": target,
  "exit_code": ec,
  "stdout": stdout,
  "stderr": stderr
}
open("evidence/b1/model_probe.json","w",encoding="utf-8").write(json.dumps(out,ensure_ascii=False,indent=2)+"\n")
print("WROTE evidence/b1/model_probe.json (env-bound)")
PY

if [ "$ec" -ne 0 ]; then
  echo "[FAIL] model probe exit_code=$ec"
  exit 2
fi
if [ "$stdout" != "OK $target" ]; then
  echo "[FAIL] stdout mismatch; expected 'OK $target' got '$stdout'"
  exit 3
fi

echo "[PASS] model probe: $target"
