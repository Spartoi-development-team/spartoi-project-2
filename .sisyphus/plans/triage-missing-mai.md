# Plan: Triage and minimal patch for control_plane/missing_mai.json

Purpose
- Triage missing MAI entries (control_plane/missing_mai.json) using available SSOT inputs and SRS precedence.
- Produce artifacts: control_plane/missing_mai_triage.md, CR_OPEN.md, updated control_plane/trace_map.json with source_locator anchors, update doc_index if needed.
- Implement minimal, verifiable patches only to map MAI -> gate_ref, acceptance_artifact, verification_method where hints exist in SSOT; record CR_OPEN where unresolved.

Scope
- Work only inside repository. Do NOT call external services.
- Follow repo non-negotiables: create feature branch, open PR, run CI; do not push to main; keep required check name 'gates'.
- Prefer SRS text where conflicts exist.

Assumptions
- Available SSOT files in repo under ssot/inputs/: Spartoi-OMOC_開發實作方案.md, Spartoi-OMOC 工程實作指南.md
- Several referenced SSOT files (P1_SRS_v7.0.0, P1_ARCH_v6.0.0-r5, P1_LBP-B(ICD)_v5.0.1, P1_LBP-E(Fitness)_v3.0.1, SubP1-LITE+MVP RUNBOOK&WI v1.4.0) are NOT present — plan will note missing files and prefer SRS when available.

High-level Steps
1) Read control_plane/missing_mai.json and evidence/_acceptance/20260205T105524Z/final/summary.json needs_review list; extract MAI IDs.
2) For each MAI, search trace_map.json and SSOT files for pass_criteria hints. If a gate_ref or acceptance_artifact or verification_method is directly inferable from SSOT text, prepare a candidate mapping.
3) Create control_plane/missing_mai_triage.md summarizing mappings: MAI -> {gate_ref, acceptance_artifact, verification_method, source_locator}. Where mapping is uncertain or conflicts with missing SSOT, record CR_OPEN entry instead.
4) Update control_plane/trace_map.json by adding/patching entries to include source_locator lines (file path + approximate line number) for candidates. Do NOT invent new fields beyond existing shape.
5) Update doc_index (if present) to reference new triage docs.
6) Run local acceptance scripts (scripts/acceptance/*.sh or equivalent). If failures arise due to minor issues introduced by mapping, apply the smallest possible fix and re-run until local PASS.
7) Create feature branch, commit changes (only the files modified), push, and open PR. Monitor GitHub Actions; if CI fails, fetch logs and fix minimally until gates PASS for both pull_request and merge_group contexts.

Constraints and Safety
- Do not invent pass_criteria or verification_method fields — only map from existing SSOT hints.
- If SSOT conflicts, prefer SRS and create CR_OPEN.md documenting decision.
- Keep EXECUTE_DISABLED state present in relevant artifacts (do not enable EXECUTE by default).
- All edits are minimal and reversible; do not change unrelated files; do not suppress type errors.

Acceptance Criteria (for Momus review)
- control_plane/missing_mai_triage.md exists with mappings for at least 80% of MAI entries where SSOT provides explicit hints.
- control_plane/trace_map.json updated to include source_locator anchors for candidate mappings (unchanged schema).
- CR_OPEN.md created listing all unresolved conflicts and missing SSOT files.
- Local acceptance scripts complete with exit code 0 after minimal fixes.
- GitHub workflows modified only if necessary to ensure run_on: pull_request and merge_group; required check name remains 'gates'.

Next: Please review this plan for completeness, missing preconditions, risks, and provide a prioritized execution sequence (3 atomic tasks) before I proceed.
