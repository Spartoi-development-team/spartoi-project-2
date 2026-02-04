#!/usr/bin/env bash
set -euo pipefail

# Single entry acceptance script for B1 minimal slice
OUT_DIR="evidence/_b1"
mkdir -p "$OUT_DIR"

echo "[ACCEPTANCE] START" | tee "$OUT_DIR/acceptance_console.txt"

# 1) probe model
echo "[STEP] probe_model" | tee -a "$OUT_DIR/acceptance_console.txt"
if bash scripts/probe_model.sh > "$OUT_DIR/model_probe.json" 2>&1; then
  echo "OK: model probe" | tee -a "$OUT_DIR/acceptance_console.txt"
else
  echo "FAIL: model probe" | tee -a "$OUT_DIR/acceptance_console.txt"
  echo 10 > "$OUT_DIR/exit_code.txt"
  echo "ACCEPTANCE: FAIL" | tee -a "$OUT_DIR/acceptance_console.txt"
  exit 10
fi

# 2) docs lint (mkdocs build + markdownlint)
echo "[STEP] docs lint" | tee -a "$OUT_DIR/acceptance_console.txt"
{
  echo "[2/1] mkdocs build --strict";
  if mkdocs build --strict >> "$OUT_DIR/acceptance_console.txt" 2>&1; then
    echo "✅ MkDocs build PASSED" | tee -a "$OUT_DIR/acceptance_console.txt"
  else
    echo "❌ MkDocs build FAILED" | tee -a "$OUT_DIR/acceptance_console.txt"
    echo 20 > "$OUT_DIR/exit_code.txt"
    echo "ACCEPTANCE: FAIL" | tee -a "$OUT_DIR/acceptance_console.txt"
    exit 20
  fi

  echo "[2/2] markdownlint-cli2";
  if markdownlint-cli2 AGENTS.md README.md .opencode/command/ping.md .opencode/commands/ping.md >> "$OUT_DIR/acceptance_console.txt" 2>&1; then
    echo "✅ Markdownlint PASSED" | tee -a "$OUT_DIR/acceptance_console.txt"
  else
    echo "❌ Markdownlint FAILED" | tee -a "$OUT_DIR/acceptance_console.txt"
    echo 21 > "$OUT_DIR/exit_code.txt"
    echo "ACCEPTANCE: FAIL" | tee -a "$OUT_DIR/acceptance_console.txt"
    exit 21
  fi
} || true

# 3) gate_runner self-test
echo "[STEP] gate_runner self-test" | tee -a "$OUT_DIR/acceptance_console.txt"
if python3 scripts/gate_runner.py --selftest > "$OUT_DIR/gate_selftest.txt" 2>&1; then
  echo "✅ gate_runner self-test PASSED" | tee -a "$OUT_DIR/acceptance_console.txt"
else
  echo "❌ gate_runner self-test FAILED" | tee -a "$OUT_DIR/acceptance_console.txt"
  echo 30 > "$OUT_DIR/exit_code.txt"
  echo "ACCEPTANCE: FAIL" | tee -a "$OUT_DIR/acceptance_console.txt"
  exit 30
fi

# 4) minimal Pipeline A run (produce triad.json)
echo "[STEP] minimal Pipeline A (produce triad)" | tee -a "$OUT_DIR/acceptance_console.txt"
python3 - <<'PY' > "$OUT_DIR/triad.json" 2>>"$OUT_DIR/acceptance_console.txt"
import json,hashlib,glob,sys,os
out = os.environ.get('OUT_DIR', None)
files = sorted(glob.glob('gates/templates/*'))
triad = []
for p in files:
    try:
        with open(p,'rb') as f:
            data = f.read()
        h = hashlib.sha256(data).hexdigest()
        triad.append({'gate_file': p, 'sha256': h})
    except Exception as e:
        triad.append({'gate_file': p, 'error': str(e)})
json.dump({'triad': triad}, sys.stdout, indent=2)
PY

if [ -s "$OUT_DIR/triad.json" ]; then
  echo "✅ triad generated" | tee -a "$OUT_DIR/acceptance_console.txt"
else
  echo "❌ triad generation failed" | tee -a "$OUT_DIR/acceptance_console.txt"
  echo 40 > "$OUT_DIR/exit_code.txt"
  echo "ACCEPTANCE: FAIL" | tee -a "$OUT_DIR/acceptance_console.txt"
  exit 40
fi

# 5) evidence index
echo "[STEP] generate evidence index" | tee -a "$OUT_DIR/acceptance_console.txt"
if bash scripts/generate_evidence_index.sh > "$OUT_DIR/generate_evidence_index.log" 2>&1; then
  cp evidence/evidence_index.json "$OUT_DIR/evidence_index.json" || true
  echo "✅ evidence index generated" | tee -a "$OUT_DIR/acceptance_console.txt"
else
  echo "❌ evidence index generation failed" | tee -a "$OUT_DIR/acceptance_console.txt"
  echo 50 > "$OUT_DIR/exit_code.txt"
  echo "ACCEPTANCE: FAIL" | tee -a "$OUT_DIR/acceptance_console.txt"
  exit 50
fi

echo 0 > "$OUT_DIR/exit_code.txt"
echo "ACCEPTANCE: PASS" | tee -a "$OUT_DIR/acceptance_console.txt"
exit 0
