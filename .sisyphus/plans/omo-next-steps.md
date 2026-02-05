# OMOC Next Steps Plan

Date: 2026-02-05T09:40:00Z

Goal: Implement missing OPENCODE configuration and verification scripts required by the OMOC acceptance pipeline. This plan contains three atomic tasks; Momus review is required before execution.

Tasks:

1) Update/create opencode configuration
- Files: opencode.json (root), .opencode/oh-my-opencode.jsonc
- Changes:
  - Set model: github-copilot/gpt-5-mini
  - Set small_model: github-copilot/gpt-4.1
  - Include enabled_providers and disabled_providers (wildcard '*' entries first, specific overrides last)
  - Do NOT enable EXECUTE or any automatic execution provider
  - Add permissions block (wildcard '*' first, specific last):
    - call_omo_agent = allow
    - task/delegate_task = allow
    - bash = ask
    - write = ask

2) Add scripts/verify_omo_subagents.sh
- Purpose: Run a minimal opencode run that lists configured subagents/providers, save stdout/stderr to evidence/_omoc_verify/<ts>/, and validate presence/absence rules.
- Validations:
  - call_omo_agent appears as allowed in the configuration output
  - subagent names appear (non-empty list)
  - providerID=github-copilot appears
  - providerID=opencode does NOT appear
  - modelID=gpt-5-nano does NOT appear

3) Collect final hard evidence summary
- Script: scripts/collect_final_evidence.sh
- Output: evidence/_omoc_verify/<ts>/final_evidence_summary.txt
- Contents to collect (best-effort): required checks names (from verdict.json), latest run URLs, PR URL, merge commit (if present), path to verdict.json, CR_OPEN excerpt and verification commands with PASS/FAIL markers. Missing items must be marked FAIL with minimal next-step action.

Verification/acceptance criteria:
- Momus review approves plan
- Files added/updated pass lsp_diagnostics (no syntax errors)
- scripts are non-destructive and exit non-zero on failure with helpful logs

Safety constraints:
- Never enable EXECUTE
- Do not commit or push changes without explicit user authorization
- Do not include secrets in any files

Implementation notes:
- Wildcard precedence: include an entry with key "*" first in JSONC, then specific keys to override. Where JSON merging is applied, last-writer wins; include comments to explain intent.
- Scripts must tolerate missing opencode CLI and produce clear logs.
