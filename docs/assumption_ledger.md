# Assumption Ledger

This file records assumptions discovered during B1 implementation.

1. GitHub merge_group support: assumed enabled for this repository. If merge queue is disabled at org or repo level, some merge_group checks may not run.
2. Network access: mkdocs/lychee/vale downloads will succeed in CI; if blocked, acceptance will fail and advice will be recorded here.
3. The gate templates in gates/templates are minimal placeholders for the GateKit proof-of-life.
