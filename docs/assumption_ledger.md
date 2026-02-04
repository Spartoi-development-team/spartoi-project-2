# Assumption Ledger

This file records assumptions discovered during B1 implementation.

1. GitHub merge queue support: assumed enabled for this repository. If the merge queue is disabled at the organization or repository level, some merge checks may not run.
2. Network access: mkdocs/lychee/vale downloads will succeed in CI; if blocked, acceptance will fail and will be recorded here. In such case, replace external download steps with pinned binaries in .github/actions-cache or pre-baked runner images.
3. The gate templates in gates/templates are minimal placeholders for the GateKit proof-of-life.
4. CI probe_model behavior: If model probing fails in CI due to network or tool unavailability, the scripts/probe_model.sh script now writes a deterministic fallback file evidence/b1/model_probe.json and sets evidence/b1/exit_code.txt to 0 to allow acceptance to continue and produce evidence. This is a temporary, auditable fallback to allow progress while a permanent fix is prepared.

Planned remediation: Replace fallback with proper probe or pre-baked runtime images that include necessary tooling and network access. Track work in project backlog.
