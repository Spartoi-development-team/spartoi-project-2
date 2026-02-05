#!/usr/bin/env python3
"""Emit a deterministic verdict.json for an acceptance run.

Usage:
  python3 scripts/emit_verdict_json.py --base-dir <dir> [--ts <TS>]
  python3 scripts/emit_verdict_json.py --latest-dir <dir>

This script is atomic (writes to a temp file then move) and does not rely on external
commands like jq/gh. It collects minimal audit fields required by the acceptance
pipeline: verdict, latest_acceptance_dir, required_checks, run_ids, evidence_paths,
HITL guard, timestamp.
"""
import argparse
import json
import os
import sys
import glob
from pathlib import Path


def load_json(path):
    try:
        return json.loads(Path(path).read_text(encoding='utf-8'))
    except Exception:
        return None


def gather_required_checks(base_dir):
    # Priority order:
    # 1) control_plane/rules_main.json (from ruleset_12397323)
    # 2) control_plane/rules_effective_main.json (fallback)
    # 3) pr10_checks_latest.json (historic fallback)
    checks = []
    cp = Path(base_dir) / 'control_plane'
    candidates = [cp / 'rules_main.json', cp / 'rules_effective_main.json', Path(base_dir) / 'pr10_checks_latest.json']
    for f in candidates:
        if not f.exists():
            continue
        j = load_json(f)
        if not j:
            continue
        # If rules_effective_main.json is a list of rule entries, handle that
        if isinstance(j, list):
            for entry in j:
                if not isinstance(entry, dict):
                    continue
                # look for required_status_checks entry
                if entry.get('type') == 'required_status_checks' or 'required_status_checks' in (entry.get('parameters') or {}):
                    params = entry.get('parameters') or {}
                    arr = params.get('required_status_checks') or []
                    if isinstance(arr, list):
                        for it in arr:
                            if isinstance(it, dict):
                                if it.get('context'):
                                    checks.append(it.get('context'))
                                elif it.get('name'):
                                    checks.append(it.get('name'))
                        if checks:
                            break
            if checks:
                break
        # Attempt multiple known structures
        # Case A: rules_main.json style: { required_status_checks: { parameters: { required_status_checks: [ { context: 'gates' }, ... ] } } }
        rsc = None
        if isinstance(j, dict):
            rsc = j.get('required_status_checks')
        if isinstance(rsc, dict):
            # parameters.required_status_checks -> array
            params = rsc.get('parameters') or rsc.get('parameter') or {}
            if isinstance(params, dict):
                arr = params.get('required_status_checks') or params.get('checks') or None
                if isinstance(arr, list):
                    for it in arr:
                        if isinstance(it, dict):
                            if it.get('context'):
                                checks.append(it.get('context'))
                            elif it.get('name'):
                                checks.append(it.get('name'))
                    if checks:
                        break
            # direct array
            if isinstance(rsc.get('contexts'), list):
                checks.extend([str(x) for x in rsc.get('contexts')])
                if checks:
                    break
            # sometimes required_status_checks is already an array
            if isinstance(rsc, list):
                for it in rsc:
                    if isinstance(it, dict):
                        if it.get('context'):
                            checks.append(it.get('context'))
                        elif it.get('name'):
                            checks.append(it.get('name'))
                if checks:
                    break
        # Case B: pr10_checks_latest.json style: [ { name: 'gates' }, ... ]
        if isinstance(j, list):
            for it in j:
                if isinstance(it, dict) and 'name' in it:
                    checks.append(it.get('name'))
            if checks:
                break
    # normalize and dedupe
    out = []
    for c in checks:
        if not c:
            continue
        s = str(c).strip()
        if s and s not in out:
            out.append(s)
    return out


def gather_run_ids(base_dir):
    out = {'main': None, 'merge_group': None}
    cp = Path(base_dir) / 'control_plane'
    if cp.exists():
        # Support multiple evidence file shapes collected by control_plane_snapshot.sh
        # 1) pr_mq_runs.json -> { pr_runs: [...], merge_group_runs: [...] }
        # 2) latest_pr_run_explicit.json -> [ {...} ]
        # 3) latest_pr_run.json -> {...} or [ ... ]
        # 4) latest_merge_group_run_explicit.json -> [ {...} ]
        # 5) latest_merge_group_run.json -> {...}
        # Prefer databaseId if present, fall back to id or url
        def extract_id(obj):
            if not isinstance(obj, dict):
                return None
            for key in ('databaseId', 'database_id', 'id'):
                if key in obj:
                    return obj.get(key)
            # fallback to url so we have something
            if 'url' in obj:
                return obj.get('url')
            return None

        # 1) pr_mq_runs.json
        p = cp / 'pr_mq_runs.json'
        if p.exists():
            j = load_json(p)
            if isinstance(j, dict):
                prrs = j.get('pr_runs') or []
                mgrs = j.get('merge_group_runs') or []
                if isinstance(prrs, list) and len(prrs) > 0:
                    out['main'] = extract_id(prrs[0])
                if isinstance(mgrs, list) and len(mgrs) > 0:
                    out['merge_group'] = extract_id(mgrs[0])

        # 2) explicit latest pr run list
        if out.get('main') is None:
            p2 = cp / 'latest_pr_run_explicit.json'
            if p2.exists():
                j = load_json(p2)
                if isinstance(j, list) and len(j) > 0:
                    out['main'] = extract_id(j[0])

        # 3) legacy latest_pr_run.json (may be object or array)
        if out.get('main') is None:
            p3 = cp / 'latest_pr_run.json'
            if p3.exists():
                j = load_json(p3)
                if isinstance(j, list) and len(j) > 0:
                    out['main'] = extract_id(j[0])
                elif isinstance(j, dict):
                    out['main'] = extract_id(j)

        # 3b) latest_main_runs.json - list of recent main runs (push events)
        if out.get('main') is None:
            p3b = cp / 'latest_main_runs.json'
            if p3b.exists():
                j = load_json(p3b)
                if isinstance(j, list) and len(j) > 0:
                    out['main'] = extract_id(j[0])

        # 4) explicit latest merge group run list
        if out.get('merge_group') is None:
            p4 = cp / 'latest_merge_group_run_explicit.json'
            if p4.exists():
                j = load_json(p4)
                if isinstance(j, list) and len(j) > 0:
                    out['merge_group'] = extract_id(j[0])

        # 5) legacy latest_merge_group_run.json
        if out.get('merge_group') is None:
            q = cp / 'latest_merge_group_run.json'
            if q.exists():
                j = load_json(q)
                if isinstance(j, dict):
                    out['merge_group'] = extract_id(j)
    # 5b) latest_merge_group_runs.json - list of merge_group runs
    if out.get('merge_group') is None:
        q2 = cp / 'latest_merge_group_runs.json'
        if q2.exists():
            j = load_json(q2)
            if isinstance(j, list) and len(j) > 0:
                out['merge_group'] = extract_id(j[0])
        # Final fallback: scan all control_plane JSON files for runs containing a url or databaseId
        if out.get('main') is None or out.get('merge_group') is None:
            for f in cp.glob('**/*.json'):
                try:
                    jj = load_json(f)
                except Exception:
                    jj = None
                if not jj:
                    continue
                # If list, inspect elements
                lst = jj if isinstance(jj, list) else [jj]
                for item in lst:
                    if not isinstance(item, dict):
                        continue
                    # detect PR run
                    if out.get('main') is None and (item.get('event') == 'pull_request' or item.get('headBranch')):
                        candidate = extract_id(item) or item.get('url')
                        if candidate:
                            out['main'] = candidate
                    # detect merge_group run
                    if out.get('merge_group') is None and (item.get('event') == 'merge_group' or (item.get('name') and 'merge' in item.get('name'))):
                        candidate = extract_id(item) or item.get('url')
                        if candidate:
                            out['merge_group'] = candidate
                    if out.get('main') and out.get('merge_group'):
                        break
                if out.get('main') and out.get('merge_group'):
                    break
    return out



def find_hitl_files(base_dir):
    hits = []
    tokens = ['kill', 'kill_switch', 'EXECUTE_DISABLED', 'RADAR_ONLY', 'PAPER']
    for p in Path(base_dir).rglob('*'):
        if not p.is_file():
            continue
        name = p.name.lower()
        for t in tokens:
            if t.lower() in name:
                hits.append(str(p))
                break
    return hits


def find_forbidden_execute_paths(repo_root):
    # Scan repository for likely trading execution entrypoints.
    # Only flag high-confidence patterns to avoid false positives: function calls like execute(...), place_order(...)
    import re
    # Only scan likely source files to reduce false positives
    file_ext_whitelist = ['.py', '.sh', '.js', '.ts', '.go', '.java', '.rs']
    patterns = [re.compile(r"\bplace_order\s*\(|\bsubmit_order\s*\(|\bexecute_order\s*\(|\bplaceOrder\s*\(|\bsend_order\s*\(|\bexecute\s*\(", re.IGNORECASE),
                re.compile(r"\bplace_order\b|\bsubmit_order\b|\bexecute_order\b|\bplaceOrder\b|\bsend_order\b", re.IGNORECASE)]
    found = []
    # apply allowlist if present in control_plane/EXECUTE_ALLOWLIST.json
    allowlist = []
    allowfile = Path(repo_root) / 'control_plane' / 'EXECUTE_ALLOWLIST.json'
    try:
        if allowfile.exists():
            aj = load_json(allowfile)
            if isinstance(aj, dict):
                allowlist = aj.get('allowed_paths') or []
    except Exception:
        allowlist = []
    for p in Path(repo_root).rglob('*'):
        if not p.is_file():
            continue
        # skip within evidence and .git to avoid matching logs and control artifacts
        sp = str(p)
        if '/evidence/' in sp or '/.git/' in sp or 'control_plane' in sp:
            continue
        # limit to source-like file extensions
        if not any(sp.endswith(ext) for ext in file_ext_whitelist):
            continue
        try:
            txt = p.read_text(encoding='utf-8', errors='ignore')
        except Exception:
            continue
        for pat in patterns:
            if pat.search(p.name) or pat.search(txt):
                # normalize path relative to repo_root and check allowlist
                try:
                    rel = str(p.resolve()).replace(str(Path(repo_root).resolve())+"/","")
                except Exception:
                    rel = str(p)
                if rel in allowlist:
                    # skip allowed path
                    break
                found.append(str(p))
                break
    return found


def determine_verdict(base_dir):
    txt = Path(base_dir) / 'final' / 'verdict.txt'
    if txt.exists():
        try:
            t = txt.read_text(encoding='utf-8', errors='ignore').splitlines()[0].strip()
            if t.upper() == 'PASS':
                return 'PASS'
        except Exception:
            pass
    return 'FAIL'


def atomic_write(path, data):
    p = Path(path)
    p.parent.mkdir(parents=True, exist_ok=True)
    tmp = p.with_suffix('.tmp')
    tmp.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding='utf-8')
    os.replace(str(tmp), str(p))


def build_payload(base_dir, ts=None):
    base = Path(base_dir)
    verdict = determine_verdict(base_dir)
    required_checks = gather_required_checks(base_dir)
    run_ids = gather_run_ids(base_dir)
    hitl_files = find_hitl_files(base_dir)
    # forbidden execute paths check (fail-closed)
    repo_root = Path(__file__).resolve().parents[1]
    forbidden = find_forbidden_execute_paths(repo_root)
    # evidence paths: list some files under base_dir (limit)
    ev = sorted([str(p) for p in base.rglob('*')])[:2000]
    # rules path heuristic
    rules_path = str(base / 'control_plane' / 'rules_effective_main.json')
    if not Path(rules_path).exists():
        rules_path = str(base / 'control_plane' / 'ruleset_12397323.json')
    payload = {
        'verdict': verdict,
        'latest_acceptance_dir': str(base),
        'required_checks': required_checks,
        'run_ids': {'main': run_ids.get('main'), 'merge_group': run_ids.get('merge_group')},
        'evidence_paths': [str(base), rules_path],
        'HITL_guard': {'present': len(hitl_files) > 0, 'files': hitl_files},
        'forbidden_execute_paths': forbidden,
        'timestamp': ts or Path(base).name
    }

    # Enforce Fail-Closed: required_checks must include 'gates'
    if 'gates' not in [c.lower() for c in payload.get('required_checks', [])]:
        payload['required_checks_missing_gates'] = True
        payload['verdict'] = 'FAIL'

    # If any forbidden execute paths found, fail and record
    if forbidden:
        payload['forbidden_execute_found'] = True
        payload['verdict'] = 'FAIL'
    return payload


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--base-dir', help='Base evidence dir to emit verdict for')
    ap.add_argument('--latest-dir', help='Emit deterministic verdict for latest acceptance dir')
    ap.add_argument('--ts', help='Optional timestamp string')
    args = ap.parse_args()
    if not args.base_dir and not args.latest_dir:
        print('Either --base-dir or --latest-dir required', file=sys.stderr)
        return 2
    target = args.base_dir or args.latest_dir
    if not target:
        print('Empty target dir', file=sys.stderr)
        return 3
    payload = build_payload(target, ts=args.ts)
    out = Path(target) / 'final' / 'verdict.json'
    try:
        atomic_write(out, payload)
        print('WROTE', out, 'verdict=', payload.get('verdict'))
        return 0
    except Exception as e:
        print('FAILED to write verdict.json:', e, file=sys.stderr)
        return 4


if __name__ == '__main__':
    raise SystemExit(main())
