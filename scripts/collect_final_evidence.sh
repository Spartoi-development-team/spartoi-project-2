#!/usr/bin/env bash
set -euo pipefail

OUTDIR=$(ls -1 evidence/_acceptance 2>/dev/null || true)
if [ -z "${OUTDIR}" ]; then
  echo "No acceptance evidence found under evidence/_acceptance" >&2
  exit 2
fi

LATEST_DIR=$(ls -1 evidence/_acceptance | sort | tail -n 1)
BASE="evidence/_acceptance/${LATEST_DIR}"
FINAL="${BASE}/final/verdict.json"
SUMMARY_DIR="evidence/_omoc_verify/${LATEST_DIR}"
mkdir -p "${SUMMARY_DIR}"

SUMMARY_FILE="${SUMMARY_DIR}/final_evidence_summary.txt"
echo "Acceptance evidence summary for ${LATEST_DIR}" >"${SUMMARY_FILE}"

if [ -f "${FINAL}" ]; then
  echo "verdict_json: ${FINAL}" >>"${SUMMARY_FILE}"
  jq '.' "${FINAL}" >>"${SUMMARY_FILE}" || true
else
  echo "verdict_json: MISSING" >>"${SUMMARY_FILE}"
fi

# Try to collect GH run URLs from verdict.json if present
if command -v jq >/dev/null 2>&1 && [ -f "${FINAL}" ]; then
  echo "Extracting run urls..." >>"${SUMMARY_FILE}"
  jq -r '..|.url? // empty' "${FINAL}" >>"${SUMMARY_FILE}"
fi

# Add control_plane/CR_OPEN.md excerpt
if [ -f control_plane/CR_OPEN.md ]; then
  echo "\nCR_OPEN excerpt:" >>"${SUMMARY_FILE}"
  sed -n '1,200p' control_plane/CR_OPEN.md >>"${SUMMARY_FILE}"
else
  echo "CR_OPEN: MISSING" >>"${SUMMARY_FILE}"
fi

echo "Summary written to ${SUMMARY_FILE}"
exit 0
