# Triage: Missing MAI entries

Purpose: provide a minimal, verifiable plan to triage missing MAI entries listed in control_plane/missing_mai.json. This plan is intentionally conservative: it uses control_plane/missing_mai.json as the canonical worklist, references SSOT anchors when available, records unresolved decisions in CR_OPEN.md, and avoids inventing verification fields.

Preconditions:
- control_plane/missing_mai.json exists and is the canonical worklist.
- control_plane/doc_index.json contains SSOT file references (path + sha256) or this will be recorded as a precondition failure and deferred.

Workflow (pilot):
1. Process worklist in small batches (default 10 MAIs).
2. For each MAI: search SSOT files for the MAI id and pass_criteria hints.
3. If a confident mapping exists, produce a candidate mapping and add to control_plane/trace_map.json (only allowed keys: srs_anchor, impl_paths, gate_ids, evidence_refs, status). Changes must be minimal and reversible.
4. If ambiguous, append an entry to CR_OPEN.md with rationale and SRS references.
5. After each batch, run local acceptance: bash scripts/gates/run_gates.sh. Fix only minimal issues.

Acceptance criteria:
- Each MAI in the batch is either mapped in trace_map.json (with evidence_refs pointing to SSOT anchors) or listed in CR_OPEN.md with a clear rationale.
- run_gates.sh exits 0 locally after pilot batch (or produced reproducible failures documented in artifacts/).

Deliverables per batch:
- Updated control_plane/trace_map.json (partial updates only)
- Updated control_plane/missing_mai_triage.md (append mappings and CR_OPEN references)
- Updated CR_OPEN.md for unresolved items
- artifacts/* produced by run_gates.sh
