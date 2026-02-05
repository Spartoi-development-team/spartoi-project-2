# Plan: Build trace_map from SRS and run acceptance loop

Files to review:
- scripts/build_trace_map_from_srs.py (new)
- scripts/acceptance.sh (modified to call new parser)

Goal:
- Safely parse ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md §10 (MAI) into control_plane/trace_map.json.
- Fail-closed behavior: do not synthesize MAI entries; record missing fields in control_plane/CR_OPEN.md and create control_plane/mai_missing.flag when MAI missing.
- Run the auto acceptance loop (scripts/auto_acceptance_loop.sh) up to 5 rounds; collect evidence and produce final verdict report.

Checks for reviewer (Momus):
1. Atomic writes: trace_map.json must be written atomically (use tempfile + replace). (build_trace_map_from_srs.py)
2. Conservative behavior: No generation of MAI entries that are not present in SRS; missing fields must be marked via 'missing_fields' and logged to CR_OPEN.md.
3. acceptance.sh uses new parser and decides PASS only when TOTAL_MAI>0 and MISSING_FIELDS_COUNT==0; otherwise writes repair_plan and sets mai_missing.flag.
4. Scripts handle missing jq gracefully (fallback via Python) and don't crash when external tools are absent.
5. No use of unsafe constructs: no shell eval of untrusted data, no writing outside repo, no network calls by default.

Commands to run for verification (what the auto-run will execute):
- python3 scripts/build_trace_map_from_srs.py
- bash scripts/auto_acceptance_loop.sh

Evidence to collect after run:
- FINAL_ACCEPTANCE_DIR (path)
- content of FINAL_ACCEPTANCE_DIR/final/verdict.json
- content of FINAL_ACCEPTANCE_DIR/control_plane/CR_OPEN.md (if present)
- content of FINAL_ACCEPTANCE_DIR/control_plane/check_run_names.txt (if present)

If approved, Momus should respond with APPROVE and confirm the checklist items.
