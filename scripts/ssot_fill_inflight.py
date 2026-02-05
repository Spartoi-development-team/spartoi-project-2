#!/usr/bin/env python3
"""Build trace_map_inflight.json and audit prior heuristic updates.

Usage: python3 scripts/ssot_fill_inflight.py
Produces:
- control_plane/pass_criteria_audit.json
- control_plane/trace_map_inflight.json
- control_plane/pass_criteria_update_report.json (augmented)

This script follows the Momus-enforced rules in .sisyphus/plans/rebuild-missing-mai.md
"""
import json,os,re,hashlib
from pathlib import Path

ROOT = Path('.').resolve()
CP = ROOT / 'control_plane'

def load_json(p):
    with open(p,'r',encoding='utf-8') as f:
        return json.load(f)

def save_json(p, obj):
    with open(p,'w',encoding='utf-8') as f:
        json.dump(obj,f,indent=2,ensure_ascii=False)

doc_index = load_json(CP / 'doc_index.json')
ssot_paths = { (ROOT / entry['path']).resolve(): entry for entry in doc_index.get('ssot_files',[]) }

trace_map = load_json(CP / 'trace_map.json')
trace_by_id = {e['mai_id']: e for e in trace_map}

missing = load_json(CP / 'missing_mai.json')
missing_ids = {e['mai_id'] for e in missing}

report = load_json(CP / 'pass_criteria_update_report.json')
updated = report.get('updated', []) if isinstance(report, dict) else report

# load check run names
check_runs = set()
check_file = CP / 'check_run_names.txt'
if check_file.exists():
    for l in open(check_file,'r',encoding='utf-8'):
        name = l.strip()
        if name:
            check_runs.add(name)

KEYWORDS = [
    'Fit Criterion','Fit-criterion','FitCriterion','Verification Method','Verification Procedure',
    'Verification','Verify','Pass Criteria','Pass','verdict','schema','schema id','JSON schema','schema validation',
    'validate','evidence','evidence file','test','unit test','integration test','Gate','CI job','check-run',
    'job name','verified by','validated by','ANCHOR','Route-Out','Route Out','MUST','SHOULD','REQUIRE'
]

mai_pattern = re.compile(r"MAI-[A-Z0-9\-]+")

audit = []
updated_by_id = {u.get('mai_id'): u for u in updated}

def contains_keyword(s):
    for k in KEYWORDS:
        if k.lower() in s.lower():
            return True
    return False

for u in updated:
    mai = u.get('mai_id')
    pc = (u.get('pass_criteria') or '')
    src = u.get('source_locator')
    reasons = []
    classification = 'unknown'
    if contains_keyword(pc):
        classification = 'criteria'
    # heuristic: if contains 'schema' or '.json' treat procedurally verifiable
    if 'schema' in pc.lower() or '.json' in pc.lower() or 'validate' in pc.lower() or 'pass' in pc.lower():
        classification = 'procedure'
    # detect cross-MAI contamination
    other_mais = set(re.findall(mai_pattern, pc)) - ({mai} if mai else set())
    if other_mais:
        reasons.append('cross_mai')
    if classification == 'unknown':
        reasons.append('no_keyword')
    # index-like detection: presence of 'index' or 'table' or 'APPX' or 'TOC'
    if any(tok in pc for tok in ['index','TOC','APPX','Appendix','目錄','附錄']):
        reasons.append('index_like')
    entry = {
        'mai_id': mai,
        'pass_criteria': pc,
        'source_locator': src,
        'classification': classification,
        'flags': reasons,
    }
    audit.append(entry)

save_json(CP / 'pass_criteria_audit.json', {'audit': audit})

# Build inflight trace map
inflight = []
accepted = []
rejected = []

for orig in trace_map:
    mid = orig.get('mai_id')
    entry = dict(orig)  # copy
    if mid in missing_ids:
        cand = updated_by_id.get(mid)
        if cand:
            # find audit record
            aud = next((a for a in audit if a['mai_id']==mid), None)
            ok = False
            reason = None
            if aud and aud['classification'] in ('criteria','procedure') and not aud['flags']:
                # ensure source_locator file listed in doc_index
                src = aud.get('source_locator') or ''
                pathpart = src.split(':',1)[0] if ':' in src else src
                # normalize path
                candidate_path = (ROOT / pathpart).resolve()
                if candidate_path in ssot_paths:
                    # exclude RUNBOOK unless allowlist (none)
                    if 'RUNBOOK' in str(candidate_path).upper() or 'SFHB' in str(candidate_path).upper():
                        ok = False
                        reason = 'runbook_source_excluded'
                    else:
                        ok = True
                else:
                    ok = False
                    reason = 'source_not_listed_in_doc_index'
            else:
                ok = False
                reason = 'not_criteria_or_flags'

            if ok:
                # propose updates
                entry['pass_criteria'] = cand.get('pass_criteria')
                entry['source_locator'] = cand.get('source_locator')
                # gate_ref: exact match against check_runs
                gate_ref = ''
                for cr in check_runs:
                    if cr and cr in (cand.get('pass_criteria') or ''):
                        gate_ref = cr
                        break
                if gate_ref:
                    entry['gate_ref'] = gate_ref
                    # remove gate_ref from missing_fields if present
                # update missing_fields
                mf = entry.get('missing_fields', [])
                if 'pass_criteria' in mf and entry.get('pass_criteria'):
                    try:
                        mf.remove('pass_criteria')
                    except ValueError:
                        pass
                if 'gate_ref' in mf and entry.get('gate_ref'):
                    try:
                        mf.remove('gate_ref')
                    except ValueError:
                        pass
                entry['missing_fields'] = mf
                accepted.append({'mai_id':mid,'reason':'accepted'})
            else:
                rejected.append({'mai_id':mid,'reason':reason})
    inflight.append(entry)

save_json(CP / 'trace_map_inflight.json', inflight)

# augment pass_criteria_update_report.json with metadata
for u in updated:
    pc = u.get('pass_criteria','')
    h = hashlib.sha256(pc.encode('utf-8')).hexdigest()
    u['snippet_hash'] = h
    # evidence type
    if 'schema' in pc.lower() or 'schema-' in pc.lower() or 'SCHEMA' in pc:
        u['evidence_type'] = 'schema'
    elif '.sh' in pc or 'script' in pc.lower():
        u['evidence_type'] = 'script'
    elif '.json' in pc:
        u['evidence_type'] = 'file'
    else:
        u['evidence_type'] = 'text'
    # candidate status
    aud = next((a for a in audit if a['mai_id']==u.get('mai_id')), None)
    if aud and aud['classification'] in ('criteria','procedure') and not aud['flags']:
        u['candidate_status'] = 'accepted'
    else:
        u['candidate_status'] = 'needs_review'

save_json(CP / 'pass_criteria_update_report.json', {'updated': updated})

print('pass_criteria_audit.json, trace_map_inflight.json, pass_criteria_update_report.json written.')
