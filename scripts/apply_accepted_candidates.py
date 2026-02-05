#!/usr/bin/env python3
"""
Apply accepted pass_criteria candidates into control_plane/trace_map.json safely.

Rules enforced:
- Only apply candidate_status == 'accepted'
- Do not set gate_ref unless the exact gate name appears in control_plane/check_run_names.txt
- Do not overwrite non-empty pass_criteria with empty strings
- Create timestamped backup of trace_map.json before write
- Produce evidence apply_report.json listing applied/skipped decisions
"""
import json
import shutil
from datetime import datetime
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
CP = ROOT / 'control_plane'

def load_json(p):
    return json.loads(p.read_text(encoding='utf-8'))

def main():
    report = {'updated_entries': 0, 'applied': [], 'skipped': [], 'skipped_gate_refs': []}

    update_report_p = CP / 'pass_criteria_update_report.json'
    trace_map_p = CP / 'trace_map.json'
    check_names_p = CP / 'check_run_names.txt'

    updates = load_json(update_report_p).get('updated', [])
    accepted = {u['mai_id']: u for u in updates if u.get('candidate_status')=='accepted'}

    check_names = set([l.strip() for l in check_names_p.read_text(encoding='utf-8').splitlines() if l.strip()])

    # read existing trace_map
    trace = load_json(trace_map_p)

    # prepare backup
    ts = datetime.utcnow().strftime('%Y%m%dT%H%M%SZ')
    bak = CP / f'trace_map.json.bak.{ts}'
    shutil.copy(trace_map_p, bak)

    gate_ref_pattern = re.compile(r'gate_ref\s+([A-Za-z0-9_\-]+)')

    for entry in trace:
        mai = entry.get('mai_id')
        if mai in accepted:
            cand = accepted[mai]
            applied_any = False
            # pass_criteria write: only if candidate has non-empty and different
            cand_pc = cand.get('pass_criteria','').strip()
            if cand_pc:
                if entry.get('pass_criteria','').strip() != cand_pc:
                    entry['pass_criteria'] = cand_pc
                    applied_any = True
                    report['applied'].append({'mai_id': mai, 'field': 'pass_criteria'})
                else:
                    report['skipped'].append({'mai_id': mai, 'reason': 'pass_criteria identical'})
            else:
                report['skipped'].append({'mai_id': mai, 'reason': 'candidate pass_criteria empty'})

            # gate_ref: only set if explicit token matches check_names
            existing_gate = (entry.get('gate_ref') or '').strip()
            match = gate_ref_pattern.search(cand.get('pass_criteria','') or '')
            if match:
                candidate_gate = match.group(1).strip()
                if candidate_gate in check_names:
                    if existing_gate != candidate_gate:
                        entry['gate_ref'] = candidate_gate
                        applied_any = True
                        report['applied'].append({'mai_id': mai, 'field': 'gate_ref', 'value': candidate_gate})
                else:
                    # explicit gate mentioned but not whitelisted -> skip and log
                    report['skipped_gate_refs'].append({'mai_id': mai, 'candidate_gate': candidate_gate})
            # recompute missing_fields
            missing = []
            if not entry.get('pass_criteria'):
                missing.append('pass_criteria')
            if not entry.get('gate_ref'):
                missing.append('gate_ref')
            entry['missing_fields'] = missing

            if applied_any:
                report['updated_entries'] += 1

    # write updated trace_map.json atomically
    tmp = CP / f'trace_map.json.tmp.{ts}'
    tmp.write_text(json.dumps(trace, indent=2, ensure_ascii=False), encoding='utf-8')
    trace_map_p.unlink()
    tmp.rename(trace_map_p)

    # rebuild missing_mai.json
    missing = [e for e in trace if e.get('missing_fields')]
    (CP / 'missing_mai.json').write_text(json.dumps(missing, indent=2, ensure_ascii=False), encoding='utf-8')

    # update CR_OPEN.md summary
    cr_lines = []
    cr_lines.append('Automated inflight scan summary:\n')
    cr_lines.append(f'- total MAI entries: {len(trace)}\n')
    cr_lines.append(f'- total missing MAI (rebuild): {len(missing)}\n')
    cr_lines.append(f"- candidate updates accepted by automated heuristics applied: {report['updated_entries']}\n\n")
    cr_lines.append('For details per MAI, see:\n')
    cr_lines.append('- control_plane/pass_criteria_audit.json (classification + flags)\n')
    cr_lines.append('- control_plane/trace_map_inflight.json (proposed inflight values)\n')
    cr_lines.append('- control_plane/pass_criteria_update_report.json (candidate metadata and snippet_hashes)\n\n')
    cr_lines.append('Entries below remain in CR_OPEN (missing fields). Use the audit file to prioritize manual review.\n\n')
    for e in missing:
        missing_fields = ', '.join(e.get('missing_fields', []))
        cr_lines.append(f"{e.get('mai_id')}: missing {missing_fields}\n")

    (CP / 'CR_OPEN.md').write_text(''.join(cr_lines), encoding='utf-8')

    # write apply report
    ar_p = CP / f'apply_report.{ts}.json'
    ar_p.write_text(json.dumps(report, indent=2, ensure_ascii=False), encoding='utf-8')

    print(json.dumps({'backup': str(bak), 'updated_entries': report['updated_entries'], 'apply_report': str(ar_p)}))

if __name__ == '__main__':
    main()
