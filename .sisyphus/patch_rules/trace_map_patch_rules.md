Trace map patch rules

Purpose: define the allowed, minimal, reversible edits to control_plane/trace_map.json when triaging MAI items.

Allowed keys to modify or add per "items" entry:
- mai_id (required): string. Use the canonical MAI identifier from the worklist.
- srs_anchor (required if mapping): string. Short identifier or anchor pointing to the SSOT (e.g. "Spartoi｜P1_SRS_v7.0.0#3.2.1"). Must be referenced to control_plane/doc_index.json sha256 when available.
- impl_paths (optional): array of file paths (strings). Only add if you can point to an implementation file in repo.
- gate_ids (optional): array of gate identifier strings (e.g. "gates:links", "gates:vale"). Only include when the SSOT/pass_criteria explicitly mentions a gate or standard.
- evidence_refs (optional): array of strings pointing to evidence artifact paths or SSOT anchors. Prefer SSOT sha256 anchors where possible.
- status (required): one of ["OPEN","MAPPED","CR_OPEN","BLOCKED"]. Use MAPPED when confident, CR_OPEN when deferred to SRS owner.

Forbidden changes:
- Do NOT invent new verification_method or acceptance_artifact fields not present in SSOT. If missing, record CR_OPEN instead.
- Do NOT remove existing entries without explicit revertable rationale recorded in commit message.
- Do NOT alter control_plane/doc_index.json entries to claim new sha256 values; instead populate doc_index.json with correct values (separate task).

Patch process:
1. Add or update a single "items" entry per MAI. Keep other array items unchanged.
2. Keep edits minimal: change only the keys above. Avoid reformatting unrelated areas of the file.
3. Run local gates (scripts/gates/run_gates.sh) after a small batch (<=10) of changes.
4. If local gates fail for unrelated reasons (CI environment), document logs in artifacts/logs and revert or adjust only the minimal changes required.

Example item (MAPPED):
{
  "mai_id": "MAI-STRUCTURE",
  "srs_anchor": "Spartoi｜P1_SRS_v7.0.0#5.1",
  "impl_paths": ["docs/architecture/structure.md"],
  "gate_ids": ["gates:links"],
  "evidence_refs": ["ssot/Spartoi｜P1_SRS_v7.0.0.md#5.1 (sha256:49005...)"] ,
  "status": "MAPPED"
}

Example item (CR_OPEN):
{
  "mai_id": "MAI-FOO-123",
  "status": "CR_OPEN",
  "srs_anchor": "Spartoi｜P1_SRS_v7.0.0#X.Y",
  "evidence_refs": ["CR_OPEN.md#MAI-FOO-123"]
}
