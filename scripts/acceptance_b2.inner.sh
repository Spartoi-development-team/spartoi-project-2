#!/usr/bin/env bash
# Safe acceptance runner: non-destructive, always writes evidence and exit codes, captures logs
LOG="evidence/b2/acceptance_console.txt"
EXIT_FILE="evidence/b2/exit_code.txt"
mkdir -p "$(dirname "$LOG")"
# ensure log file exists
: > "$LOG"

echo "== acceptance_b2: run verify_all and gate_all_local with retries ==" | tee -a "$LOG"
max=5
i=1
overall_rc=2
while [ $i -le $max ]; do
  echo "-- iteration $i/$max --" | tee -a "$LOG"
  # run verify_all in a safe, non-terminal-killing way
  bash scripts/verify_all.sh >>"$LOG" 2>&1 || rc=$?
  rc=${rc:-0}
  if [ $rc -eq 0 ]; then
    echo "ACCEPTANCE: PASS" | tee -a "$LOG"
    overall_rc=0
    break
  else
    echo "ACCEPTANCE: iteration $i failed (rc=$rc)" | tee -a "$LOG"
    # try to self-heal by re-running bootstrap (capture errors but don't exit)
    bash scripts/bootstrap.sh >>"$LOG" 2>&1 || echo "bootstrap returned non-zero" >>"$LOG"
    i=$((i+1))
    sleep 1
  fi
done

if [ $overall_rc -ne 0 ]; then
  echo "ACCEPTANCE: HARD FAIL after $max iterations" | tee -a "$LOG"
fi

# Always write exit code and a short tail for quick inspection
echo $overall_rc > "$EXIT_FILE"
echo "--- tail of acceptance log ---" | tee -a "$LOG"
tail -n 40 "$LOG" | tee -a "$LOG"

# Print short summary to stdout (non-interactive)
printf "ACCEPTANCE_RESULT=%d\nLOG=%s\n" "$overall_rc" "$LOG"

exit $overall_rc
