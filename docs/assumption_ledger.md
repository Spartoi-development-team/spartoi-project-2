# Assumption Ledger

This file records assumptions discovered during B1 implementation.

1. GitHub merge queue support: assumed enabled for this repository. If the merge queue is disabled at the organization or repository level, some merge checks may not run.
2. Network access: mkdocs/lychee/vale downloads will succeed in CI; if blocked, acceptance will fail and will be recorded here. In such case, replace external download steps with pinned binaries in .github/actions-cache or pre-baked runner images.
3. The gate templates in gates/templates are minimal placeholders for the GateKit proof-of-life.
