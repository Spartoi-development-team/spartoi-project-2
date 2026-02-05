#!/usr/bin/env python3
"""Minimal MAI extractor for Spartoi｜P1_SRS_v7.0.0.md

Produces control_plane/trace_map.json as an array of objects with fields:
mai_id, srs_req_id, acceptance_artifact, verification_method, pass_criteria, gate_ref, source_locator
If parsing fails for any MAI, append to control_plane/CR_OPEN.md and include placeholder entry.
"""
import json
import re
from pathlib import Path

INPUT = Path('ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md')
OUT = Path('control_plane/trace_map.json')
CR_OPEN = Path('control_plane/CR_OPEN.md')

def extract_mai_lines(text):
    # Very small parser: find lines starting with 'MAI-' or 'MAI ' and capture the rest
    lines = []
    for i,l in enumerate(text.splitlines()):
        if re.search(r'(?i)\bMAI[-\s]\w+', l):
            lines.append((i+1, l.strip()))
    # If parser finds no MAI, ensure control_plane/CR_OPEN.md is updated by caller.
    return lines

def main():
    OUT.parent.mkdir(parents=True, exist_ok=True)
    if not INPUT.exists():
        CR_OPEN.write_text(f"Missing SRS input: {INPUT}\n")
        print('SRS input missing', INPUT)
        return 1
    txt = INPUT.read_text(encoding='utf-8')
    mai_lines = extract_mai_lines(txt)
    rows = []
    if not mai_lines:
        # Record missing MAI evidence explicitly (CR_OPEN) and create a guard file
        CR_OPEN.write_text('No MAI sections detected in SRS.\n')
        mai_missing_flag = Path('control_plane/mai_missing.flag')
        mai_missing_flag.write_text('No MAI lines detected in SRS.\n', encoding='utf-8')

        # Write an empty trace map (truthful representation: no MAI -> no rows)
        rows = []
    else:
        # Clear stale flag if present
        mai_missing_flag = Path('control_plane/mai_missing.flag')
        if mai_missing_flag.exists():
            try:
                mai_missing_flag.unlink()
            except Exception:
                pass

        for ln, content in mai_lines:
            # naive splitting: assume format 'MAI-XXX : SRS-YYY | artifact | method | criteria | gate'
            parts = [p.strip() for p in re.split(r'[|,;]', content) if p.strip()]
            mai = parts[0] if parts else content
            rows.append({
                'mai_id': mai.split()[0],
                'srs_req_id': parts[1] if len(parts)>1 else '',
                'acceptance_artifact': parts[2] if len(parts)>2 else '',
                'verification_method': parts[3] if len(parts)>3 else '',
                'pass_criteria': parts[4] if len(parts)>4 else '',
                'gate_ref': parts[5] if len(parts)>5 else '',
                'source_locator': f"{INPUT}:{ln}"
            })

    OUT.write_text(json.dumps(rows, indent=2, ensure_ascii=False))
    return 0

if __name__=='__main__':
    raise SystemExit(main())
