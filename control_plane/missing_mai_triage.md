Title: missing_mai triage (pilot)

Source: control_plane/missing_mai.json

Note: The acceptance summary referenced by the user (`evidence/_acceptance/20260205T105524Z/final/summary.json`) was not found. Using control_plane/missing_mai.json as canonical MAI list.

Pilot mappings (to be expanded):

- MAI-STRUCTURE
  - source_locator: ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md:312
  - pass_criteria: §3.23/3.24/3.25 references (TVE, SEM3, Playwright)
  - candidate gate_ref: GATE-RL-002 (candidate; derive from SRS FR/NFR anchors)
  - verification_method: TVE equivalence tests, SEM3 pipeline tests, Playwright test suite

- MAI-FR
  - source_locator: ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md:312
  - pass_criteria: §3.23/3.24/3.25
  - candidate gate_ref: GATE-RL-002
  - verification_method: TVE/SEM3/Playwright (see SRS anchors)

- MAI-NFR
  - source_locator: ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md:312
  - pass_criteria: §3.23/3.24/3.25
  - candidate gate_ref: GATE-RL-003 (NFR gate)
  - verification_method: TVE/SEM3/Playwright

CR_OPEN:
- Any MAI where `gate_ref` cannot be confidently mapped from SSOT text will be recorded in CR_OPEN.md with SRS preferred as authoritative.
