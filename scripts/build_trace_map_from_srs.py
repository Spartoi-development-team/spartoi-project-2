#!/usr/bin/env python3
"""Build control_plane/trace_map.json from SRS markdown (§10 MAI table)

Conservative behavior:
- Try to use markdown-it-py if available to parse headings and tables.
- Fallback to a robust regex-based extractor for GitHub-style tables.
- Do NOT synthesize missing fields. If fields missing, mark missing_fields on the MAI entry
  and append a human-readable line to control_plane/CR_OPEN.md.
- Always write control_plane/trace_map.json atomically.

Usage: python3 scripts/build_trace_map_from_srs.py [path/to/SRS.md]
Defaults to ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md
"""
from pathlib import Path
import sys
import json
import re
import tempfile

SRS_DEFAULT = Path('ssot/inputs/Spartoi｜P1_SRS_v7.0.0.md')
OUT = Path('control_plane/trace_map.json')
CR_OPEN = Path('control_plane/CR_OPEN.md')
MAI_FLAG = Path('control_plane/mai_missing.flag')


def atomic_write(path: Path, data: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile('w', delete=False, dir=str(path.parent)) as tf:
        tf.write(data)
        tmp = Path(tf.name)
    tmp.replace(path)


def parse_tables_with_markdown_it(text: str):
    try:
        from mdit_py_plugins.tables import table_parser  # type: ignore
        from markdown_it import MarkdownIt
    except Exception:
        return None
    md = MarkdownIt('commonmark')
    md.use(table_parser)
    tokens = md.parse(text)
    # Find heading tokens and table tokens; simple linear scan
    tables = []
    current_heading = None
    i = 0
    while i < len(tokens):
        t = tokens[i]
        if t.type == 'heading_open':
            # next token is inline with content
            inline = tokens[i+1]
            current_heading = inline.content if inline.type == 'inline' else None
            i += 1
        elif t.type == 'table_open':
            # naive: extract raw markdown slice for table by searching for the next 'table_close'
            # fallback: use the token stream to reconstruct rows
            # For our purposes, just collect raw tokens between table_open and table_close
            j = i
            cols = []
            rows = []
            # attempt simple reconstruction
            # Look ahead for 'inline' tokens that contain cell text
            cell_texts = []
            k = i+1
            while k < len(tokens) and tokens[k].type != 'table_close':
                if tokens[k].type == 'inline' and tokens[k].content.strip():
                    cell_texts.append(tokens[k].content)
                k += 1
            # Heuristic: first N items are header cells until a 'thead_close' appears; rest are body cells
            tables.append({'heading': current_heading, 'cells': cell_texts})
            i = k
        i += 1
    return tables


def parse_github_tables(section_text: str):
    """Parse GitHub-style Markdown tables from a text block.

    Returns list of tables; each table is list of rows where each row is list of cells.
    """
    lines = section_text.splitlines()
    tables = []
    i = 0
    while i < len(lines):
        if re.match(r"^\s*\|.*\|\s*$", lines[i]):
            # potential table; ensure next line looks like separator
            if i+1 < len(lines) and re.match(r"^\s*\|?\s*:?[-]+[:]?\s*(\|\s*:?[-]+[:]?\s*)+\|?\s*$", lines[i+1]):
                # collect until non-table line
                j = i
                tbl = []
                while j < len(lines) and re.match(r"^\s*\|.*\|\s*$", lines[j]):
                    # split cells but preserve inner pipes by simple split and strip
                    cells = [c.strip() for c in lines[j].strip().strip('|').split('|')]
                    tbl.append(cells)
                    j += 1
                tables.append(tbl)
                i = j
                continue
        i += 1
    return tables


def parse_mai_from_text(text: str, path: Path):
    """Fallback extractor: find MAI ids in prose and build minimal entries.

    Heuristics:
    - Find tokens like MAI-XXX (ASCII letters/digits and hyphens)
    - For each match, capture the surrounding line(s) and try to extract an acceptance_artifact
      via patterns like '驗證 `artifact`' or '`artifact`'.
    - Do NOT invent pass_criteria or gate_ref; mark them as missing_fields.
    """
    mai_pattern = re.compile(r"\b(MAI[-A-Z0-9-]+)\b", re.I)
    lines = text.splitlines()
    found = {}
    for idx, line in enumerate(lines):
        for m in mai_pattern.finditer(line):
            mid = m.group(1).strip()
            if mid in found:
                continue
            # look for artifact in the same line or nearby lines
            artifact = ''
            # pattern for Chinese '驗證 `artifact`' or English 'verify `artifact`'
            am = re.search(r"驗證\s+`([^`]+)`", line)
            if not am:
                am = re.search(r"verify\s+`([^`]+)`", line, re.I)
            if am:
                artifact = am.group(1).strip()
            else:
                # fallback: look in next 2 lines for backticked artifact
                for j in range(idx, min(len(lines), idx+3)):
                    bm = re.search(r"`([^`]+)`", lines[j])
                    if bm:
                        artifact = bm.group(1).strip()
                        break

            obj = {
                'mai_id': mid,
                'srs_req_id': '',
                'acceptance_artifact': artifact,
                'verification_method': '',
                'pass_criteria': '',
                'gate_ref': '',
                'source_locator': f"{path}:{idx+1}"
            }
            # mark missing fields explicitly
            mf = []
            for f in ['pass_criteria', 'gate_ref']:
                if not obj.get(f):
                    mf.append(f)
            if mf:
                obj['missing_fields'] = mf
            found[mid] = obj
    return list(found.values())


def extract_section_by_heading(text: str, heading_regex: re.Pattern):
    # split into lines and find heading lines matching regex
    lines = text.splitlines()
    start = None
    for idx, line in enumerate(lines):
        if heading_regex.search(line):
            start = idx
            break
    if start is None:
        return None
    # find next top-level heading (start with '#') after start
    for j in range(start+1, len(lines)):
        if re.match(r"^#{1,2}\s+", lines[j]):
            end = j
            break
    else:
        end = len(lines)
    return '\n'.join(lines[start:end])


def rows_to_mai_objects(rows):
    # Expect header row then separator then data rows
    if len(rows) < 2:
        return []
    headers = [h.lower().strip() for h in rows[0]]
    objs = []
    for r in rows[2:]:
        # pad shorter rows
        cells = r + [''] * (len(headers) - len(r))
        obj = dict()
        missing = []
        for h, c in zip(headers, cells):
            key = h.replace(' ', '_')
            obj[key] = c
        mai_id = obj.get('mai_id') or obj.get('id') or obj.get('mai') or ''
        if not mai_id:
            # skip rows with no identifier but log to CR_OPEN
            continue
        out = {
            'mai_id': mai_id.strip(),
            'srs_req_id': obj.get('srs_req_id','').strip(),
            'acceptance_artifact': obj.get('acceptance_artifact','').strip(),
            'verification_method': obj.get('verification_method','').strip(),
            'pass_criteria': obj.get('pass_criteria','').strip(),
            'gate_ref': obj.get('gate_ref','').strip(),
            'source_locator': ''
        }
        mf = []
        for f in ['pass_criteria','gate_ref']:
            if not out.get(f):
                mf.append(f)
        if mf:
            out['missing_fields'] = mf
        objs.append(out)
    return objs


def main():
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else SRS_DEFAULT
    # ensure control_plane dir exists before any writes
    OUT.parent.mkdir(parents=True, exist_ok=True)
    if not path.exists():
        CR_OPEN.write_text(f"SRS file not found: {path}\n")
        MAI_FLAG.write_text('No SRS')
        atomic_write(OUT, '[]')
        print('SRS not found; wrote empty trace_map.json')
        return
    text = path.read_text(encoding='utf-8')

    # Try to extract section by known anchors or headings
    sec = extract_section_by_heading(text, re.compile(r"MAI|Master Acceptance Index|\b§?10\b|ANCHOR:SRS-V700-MAI", re.I))
    if sec is None:
        # fallback: search for anchor explicitly
        if re.search(r"\[ANCHOR:SRS-V700-MAI", text):
            # include some context lines around anchor
            m = re.search(r"\[ANCHOR:SRS-V700-MAI[^\]]*\]", text)
            start = max(0, m.start()-200)
            sec = text[start:start+2000]
    if not sec:
        CR_OPEN.write_text('No MAI sections detected in SRS.\n')
        MAI_FLAG.write_text('No MAI lines detected in SRS.\n')
        atomic_write(OUT, '[]')
        print('No MAI section found; wrote empty trace_map.json and mai_missing.flag')
        return

    # Attempt markdown-it parser
    tables = parse_tables_with_markdown_it(sec)
    mai_objs = []
    if tables:
        # our markdown-it output is heuristic; try to parse first table found using github table parser
        for t in tables:
            # if t contains 'mai' in cells, try regex parse
            if any(re.search(r"mai", s, re.I) for s in t.get('cells',[])):
                # reconstruct a simple table: split cells by newline if needed
                # fallback to regex table parsing
                pass
    # Fallback: parse GitHub tables directly from section
    gh_tables = parse_github_tables(sec)
    for tbl in gh_tables:
        # convert to mai objects
        try:
            objs = rows_to_mai_objects(tbl)
            if objs:
                for o in objs:
                    # set source locator as filename + heading summary
                    o['source_locator'] = f"{path}:MAI_section"
                mai_objs.extend(objs)
        except Exception:
            continue

    # Fallback: if no table rows parsed, try a prose-based MAI extractor
    if not mai_objs:
        try:
            fallback = parse_mai_from_text(sec, path)
            if fallback:
                mai_objs.extend(fallback)
        except Exception:
            pass

    # If nothing found, create empty map and raise flag
    if not mai_objs:
        CR_OPEN.write_text('No MAI table rows detected in SRS section.\n')
        MAI_FLAG.write_text('No MAI rows detected in SRS.\n')
        atomic_write(OUT, '[]')
        print('No MAI rows parsed; wrote empty trace_map.json and mai_missing.flag')
        return

    # Write trace_map.json
    atomic_write(OUT, json.dumps(mai_objs, ensure_ascii=False, indent=2))
    # Append CR_OPEN notes for any missing fields
    notes = []
    for o in mai_objs:
        if 'missing_fields' in o:
            notes.append(f"{o['mai_id']}: missing {', '.join(o['missing_fields'])}")
    if notes:
        existing = CR_OPEN.read_text(encoding='utf-8') if CR_OPEN.exists() else ''
        existing += '\n'.join(notes) + '\n'
        CR_OPEN.write_text(existing, encoding='utf-8')

    print(f'Wrote {OUT} with {len(mai_objs)} MAI entries; CR_OPEN.md updated for missing fields')


if __name__ == '__main__':
    main()
