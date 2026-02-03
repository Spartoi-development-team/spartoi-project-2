---
description: "Fail-Closed link gate (Lychee local if available, else CI hint)"
---
If lychee is available locally:
- lychee --verbose --no-progress .
Otherwise:
- Tell me to run the CI job "links-gate / link-check" and do not proceed until it is green.
