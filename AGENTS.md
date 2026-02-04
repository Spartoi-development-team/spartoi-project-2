# AGENTS.md

Repository goal

- Provide a fail-closed multi-agent implementation standard for this repo: agents must follow SSOT contracts, run mandatory gates, and never bypass required checks.

Non-negotiables (Fail-Closed)

- CI gates must run on PRs and be required for merges.
- Do not skip required checks or mark them as successful manually.
- Do not modify rulesets that define required checks without an explicit, reviewed PR.

Workflows (roles)

- Vibe: project-level policy, governance decisions.
- Design: architecture, API contracts, UX decisions.
- Dev: implementation, unit tests, feature branches.
- Ops: CI, infra, release, monitoring.

Change process

- Always use a feature branch → open PR → run checks → merge after gates succeed and reviews complete.

Definition of Done (minimal)

- All required gates report success for the PR.
- At least one active ruleset is present and used by the gates.
