Title: CR_OPEN (record of conflicts and missing SSOT)

Summary:
- Several MAI entries in control_plane/missing_mai.json lacked `gate_ref` and/or `pass_criteria` fields and could not be fully mapped using SSOT files available in the repo.
- Where conflicts or missing SSOT prevented a confident mapping, entries below record the issue and note that SRS is authoritative.

Missing files noted (referenced in other artifacts but not required to run triage):
- evidence/_acceptance/20260205T105524Z/final/summary.json (not found)

Sample CR entries (pilot):
- MAI-STRUCTURE: candidate gate mapping proposed in control_plane/missing_mai_triage.md; confirm with SRS anchors. If conflict arises, SRS wins.
