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
    f = Path(base_dir) / 'pr10_checks_latest.json'
    if f.exists():
        j = load_json(f)
        if isinstance(j, list):
            return [it.get('name') for it in j if isinstance(it, dict) and 'name' in it]
    return []


def gather_run_ids(base_dir):
    out = {'main': None, 'merge_group': None}
    cp = Path(base_dir) / 'control_plane'
    if cp.exists():
        p = cp / 'latest_main_runs.json'
        if p.exists():
            j = load_json(p)
            if isinstance(j, list) and len(j) > 0:
                out['main'] = j[0].get('id') if isinstance(j[0], dict) else None
        q = cp / 'latest_merge_group_run.json'
        if q.exists():
            j = load_json(q)
            if isinstance(j, dict):
                out['merge_group'] = j.get('id')
    return out


def find_hitl_files(base_dir):
    hits = []
    for p in Path(base_dir).rglob('*'):
        if p.is_file() and ('kill' in p.name.lower() or 'kill_switch' in p.name.lower()):
            hits.append(str(p))
    return hits


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
        'timestamp': ts or Path(base).name
    }
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
