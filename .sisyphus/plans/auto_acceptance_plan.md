# Auto Acceptance / Self-Heal Plan

Purpose: implement Tasks A/B/C from user request to ensure deterministic acceptance, control-plane evidence fallback, and an automated self-heal loop (max 5 rounds). This plan will be reviewed by Momus before any code changes are applied.

Scope:
- Modify scripts/acceptance.sh to set a forced LATEST_ACCEPTANCE_DIR (per user) and ensure deterministic final verdict JSON includes fields: verdict, latest_acceptance_dir, evidence_paths.
- Ensure scripts/select_latest_acceptance_dir.sh enforces directory-only selection and prefers directories containing final/verdict.json or final/verdict.txt.
- Update scripts/control_plane_snapshot.sh to detect when ruleset_12397323.json has required_status_checks==null and then call `gh api repos/<owner>/<repo>/rules/branches/main` and write to rules_effective_main.json. Also capture PR #11 URL, latest PR runs, and latest merge_group runs into control_plane snapshot files.
- Add scripts/auto_acceptance_loop.sh to run up to 5 rounds, invoking scripts/safe_run.sh if present else scripts/acceptance.sh. On failures apply minimal repairs and re-run until verdict.json exists, is parseable JSON, and verdict=="PASS" or max rounds reached.

Verification & Evidence:
- Every round writes evidence into evidence/_acceptance/<TS>/ with control_plane/ and final/ subfolders.
- The final deterministic verdict JSON must be present at <evidence_dir>/final/verdict.json and include at least: verdict, latest_acceptance_dir, evidence_paths.
- Control plane snapshot must contain: ruleset_12397323.json (if fetchable), rules_effective_main.json (when ruleset missing required_status_checks), pr11_url.txt, latest_pr_run.json, latest_merge_group_run.json.

Fail-Closed Requirements (non-negotiable):
- If required checks are not all PASS, or verdict.json missing/unparseable, or evidence bundle missing, consider the overall process FAILED.
- The workflow must support merge_group (merge queue) semantics; evidence must include run IDs/URLs for merge_group runs when available.

Execution Plan (high-level steps):
1. Add this plan file (.sisyphus/plans/auto_acceptance_plan.md).
2. Run Momus review (blocking) to confirm plan completeness.
3. On APPROVAL, apply code patches to scripts: acceptance.sh, control_plane_snapshot.sh, add auto_acceptance_loop.sh (and minor edits to select_latest_acceptance_dir.sh only if necessary).
4. Run lsp_diagnostics on edited files.
5. Execute scripts/auto_acceptance_loop.sh (dry-run first, then real) up to 5 rounds; collect evidence.
6. Produce final audit output: PR #11 URL, latest PR run URL/ID, latest merge_group run URL/ID, required checks list, latest_acceptance_dir path and its final/verdict.json path, and one-line verification command.

Notes & Risks:
- Requires gh CLI and jq in the runtime environment to fully fetch GH API and produce JSON. If missing, control_plane_snapshot.sh will write placeholders and process will continue but evidence may be incomplete.
- Calls to GH API may be rate-limited or require auth token with repo scope. The plan does not assume availability of tokens; when absent, placeholders are recorded.
- All code modifications will not be committed/pushed unless user explicitly requests.

Contact: Sisyphus agent will run Momus review and ask for approval before applying changes.
