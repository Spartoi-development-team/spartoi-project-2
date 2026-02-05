# SSOT Acceptance Automation Plan

This plan describes steps to implement SSOT acceptance automation (control-plane evidence collection, trace map building, and acceptance gating).

Scope:

- Pin opencode model in opencode.json (repo root). Schema: {"model": "string", "small_model": "string"}

- Build/validate control_plane/doc_index.json (path: control_plane/doc_index.json). Expected fields per entry: {"basename": "string", "path": "string", "sha256": "hex", "locators": ["heading:line", ...]}

- Build control_plane/trace_map.json (path: control_plane/trace_map.json) by parsing MAI tables from ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md. Required schema per MAI row:
  {"mai_id": "string","srs_req_id": "string","acceptance_artifact": "string","verification_method": "string","pass_criteria": "string","gate_ref": "string","source_locator": "string"}

- Add scripts (paths and responsibilities):
  - scripts/control_plane_snapshot.sh: collect and write under evidence/_acceptance/<UTC_TS>/control_plane/: rules_main.json, check_run_names.txt, latest_merge_group_runs.json, latest_main_runs.json, plus exit code files (e.g., main_runs.exit_code.txt). Use gh CLI (read-only) to fetch runs. Non-failing: record exit codes and continue.
  - scripts/trace_map_build.py: minimal parser to extract MAI id lines and map columns into trace_map.json. If parsing fails for any MAI, append an entry to control_plane/CR_OPEN.md and return non-zero but do not abort the whole snapshot.
  - scripts/acceptance.sh: orchestrator. Steps: snapshot -> build doc_index (use scripts/ssot/scan_and_build_doc_index.sh as baseline) -> run trace_map_build.py -> validate JSON schemas -> compare required check names (from check_run_names.txt) against repo's actual checks (gh api) -> produce final verdict file evidence/_acceptance/<UTC_TS>/final/verdict.txt (PASS/FAIL) and repair_plan.md when FAIL. Attempt up to 3 repair rounds by applying minimal patches (only to generated artifacts or doc_index/trace_map placeholders), log each attempt.

- Ensure CI workflows include merge_queue support. Verify .github/workflows/quality-gates.yml contains `on: merge_group` and a job named `gates` (used by snapshot scripts). If absent, plan a minimal patch: add 'on: merge_group' with safe noop job linking to existing gates job.

Evidence layout (minimal, machine-validated):

evidence/_acceptance/<UTC_TS>/control_plane/
- rules_main.json (JSON)
- check_run_names.txt (newline-separated job names)
- latest_merge_group_runs.json (JSON array)
- latest_main_runs.json (JSON array)
- *.exit_code.txt (plain text exit codes)
- doc_index.json (copied/validated)
- trace_map.json (generated)

evidence/_acceptance/<UTC_TS>/final/
- verdict.txt (PASS or FAIL)
- repair_plan.md (if FAIL) with a minimal patch plan

Repair strategy (minimal):
- For missing MAI extractions: append placeholder entries in control_plane/trace_map.json with source_locator pointing to CR_OPEN.md and mark in repair_plan.md.
- For missing required checks: add an entry to check_run_names.txt recommending the exact workflow job name to be added; do not modify workflows automatically.

Verification commands (examples):
- Validate opencode.json exists and fields: jq -e '.model and .small_model' opencode.json
- Validate doc_index entries have sha256: python -c "import json,sys,hashlib; j=json.load(open('control_plane/doc_index.json')); assert all(len(e['sha256'])==64 for e in j)"
- Validate trace_map schema: jq -e '.[] | .mai_id and .srs_req_id and .acceptance_artifact' control_plane/trace_map.json

HITL/Kill-Switch evidence minimal manifest schema (manifest.json): {"gate_policy": "BLOCK_RELEASE|RADAR_ONLY|EXECUTE_DISABLED","effective_date":"ISO8601","evidence_refs":["path/to/artifact"],"enforcement_points":["CI","runtime"]}

Gate_report minimal schema (gate_report.json): {"run_id":"string","gates":[{"name":"string","state":"SUCCESS|FAIL|SKIPPED","timestamp":"ISO8601"}],"conclusion":"PASS|FAIL"}

Do not modify other repository files without review.
