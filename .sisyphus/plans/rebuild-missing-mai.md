# Plan: Rebuild missing_mai.json and fill pass_criteria from SSOT

## Purpose
Rebuild control_plane/missing_mai.json from the current control_plane/trace_map.json, search SSOT files listed in control_plane/doc_index.json for explicit pass_criteria and gate_ref for missing MAI entries, write candidate updates into an inflight trace_map, produce pass_criteria_update_report.json, and run the acceptance loop to collect evidence.

## Preconditions
- Do not guess gate_ref. Only set gate_ref when SSOT text explicitly names a CI job/check-run and that name exists in control_plane/check_run_names.txt.
- pass_criteria must be a verbatim excerpt or an explicit, machine-verifiable step (schema name + validation instruction, script name + expected exit code, or existence/parseability of evidence file). Include source_locator (filepath:line or filepath:anchor).
- All changes will be written to control_plane/trace_map_inflight.json first. After review, atomically replace control_plane/trace_map.json.

## Files referenced
- control_plane/trace_map.json
- control_plane/doc_index.json
- control_plane/check_run_names.txt
- ssot/inputs/* (as listed in doc_index.json)
- control_plane/pass_criteria_update_report.json (output)
- control_plane/CR_OPEN.md (update)

## High-level steps
1. Rebuild missing list (produce control_plane/missing_mai.json)
2. For each MAI in missing_mai.json, search SSOT files (from doc_index.json) for whole-word MAI id matches and for nearby keywords.
3. If a qualifying excerpt is found, append to candidate updates with fields: mai_id, pass_criteria (excerpt), source_locator, gate_ref (only if exact match and name exists in check_run_names.txt), evidence_type (text|schema|script|file).
4. Write candidates to control_plane/trace_map_inflight.json and pass_criteria_update_report.json (record original vs candidate values and source_locator).
5. Pause for review (automated Momus review). On approval, atomically replace control_plane/trace_map.json and update CR_OPEN.md accordingly.
6. Run scripts/auto_acceptance_loop.sh (up to 5 rounds), snapshot evidence to evidence/_acceptance/<TS>.

## Search heuristics
- Search window: when a MAI id match is found, capture the matched line plus 6 lines before and after (context window = 6). Prefer structural capture instead of fixed window when possible: capture the surrounding paragraph, full bullet list, or table row containing the match up to the next blank line or heading. Cap captures at 1200 chars or 60 lines.
- Keywords to prioritize (ordered):
  - "Fit Criterion", "Fit-criterion", "FitCriterion"
  - "Verification Method", "Verification", "Verify", "Verification Procedure"
  - "Pass Criteria", "Pass", "verdict", "PASS"
  - "schema", "schema id", "JSON schema", "schema validation", "validate"
  - "evidence", "evidence file", "test", "unit test", "integration test"
  - "Gate", "CI job", "check-run", "job name", "verified by", "validated by"
  - "ANCHOR", "Route-Out", "Route Out"
- File types to search: markdown (.md), rst (.rst), text (.txt), and code files that are likely documentation (.py/.sh/.yaml/.yml) but only for explicit annotations (avoid scanning large code files unless referenced in doc_index.json).
- Matching rules: require whole-word MAI id match (case-insensitive). When keywords appear in the context window, mark as candidate. Do not auto-fill if only the MAI id appears with no qualifying keywords.

## Verification checklist (per MAI candidate) - MUST be satisfied before writeback
1. Source_locator present (filepath and approximate line number or anchor)
2. Excerpt contains one of the prioritized keywords or is an explicit machine-verifiable instruction (e.g., "run script X and expect exit code 0")
3. If gate_ref is proposed: the exact gate name appears in the excerpt and matches an entry in control_plane/check_run_names.txt
4. Evidence type determined (text|schema|script|file) and corresponding verification step provided (e.g., for schema: schema id + sample validation command)
5. pass_criteria excerpt length <= 1000 chars and preserves original wording (no paraphrase)

## Additional hard rules from Momus review (enforced)
- MAI allowlist: only MAI IDs that already exist in control_plane/trace_map.json are eligible for automated candidates. Reject any candidate for unknown IDs.
- Exclude RUNBOOK/SFHB sources: files with names matching /RUNBOOK/i or /SFHB/i are excluded from auto-fill unless explicitly allowlisted in doc_index.json with a flag "normative": true.
- Snippet classification: every candidate must be classified as one of {criteria, procedure, index, heading, narrative}. Only {criteria, procedure} are auto-eligible; others become needs_review.
- Multi-candidate blocking: if >1 eligible candidate for a MAI exists, mark the MAI status=needs_review and do not auto-select.
- Snippet verifiability: store start_line/end_line (or anchor), snippet_hash (sha256), and evidence_type. These are required fields in pass_criteria_update_report.json.

## Audit of prior heuristic updates
- Before any new writeback, run an audit over control_plane/pass_criteria_update_report.json and flag entries that:
  - contain only index/TOC/heading text
  - reference other MAI IDs in the same snippet
  - have no qualifying keywords
- Output an audit report control_plane/pass_criteria_audit.json listing suspect entries for manual review.

## Inflight workflow (atomic and safe)
1. Write all candidate changes to control_plane/trace_map_inflight.json and pass_criteria_update_report.json.
2. Run automated checks: verify each candidate meets the 5-item verification checklist. Generate a report of failures.
3. Invoke Momus reviewer (automated) to validate the inflight file and report approval decision. Momus must return explicit approval per MAI or a list to reject.
4. On approval, move trace_map_inflight.json -> control_plane/trace_map.json (atomic file replace). Update CR_OPEN.md accordingly.

## Rollback and safety
- If any step fails (scripts crash, lsp diagnostics errors, or Momus rejects), do not modify control_plane/trace_map.json. Keep inflight file for manual inspection.
- Keep backups: control_plane/trace_map.json.bak.<timestamp> before replacing.

## Logging and evidence
- Record who ran the update and when in pass_criteria_update_report.json (script user and ISO timestamp).
- For the acceptance run, snapshot control_plane/trace_map.json to evidence/_acceptance/<TS>/control_plane/trace_map.json and copy final verdict files.

## Parameters that can be tuned
- context window (default 6)
- keyword list (defaults above). Consider adding more after initial pass.

## Expected deliverables
- control_plane/missing_mai.json (new)
- control_plane/trace_map_inflight.json (candidates)
- control_plane/pass_criteria_update_report.json (detailing changes)
- Updated control_plane/trace_map.json (after review)
- Updated control_plane/CR_OPEN.md
- evidence/_acceptance/<TS> with verdict files

---
Please review and approve. This plan will be submitted to Momus for automated review before any writeback.
