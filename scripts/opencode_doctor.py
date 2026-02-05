#!/usr/bin/env python3
"""opencode_doctor.py
Reads opencode.json / opencode.jsonc, validates top-level keys against an allowlist,
and moves unknown top-level keys into .opencode/vendor/omoc.local.json while
producing evidence in evidence/_preflight/${ts}.
"""
import argparse
import json
import os
import re
import shutil
import hashlib
from datetime import datetime


def strip_jsonc(content: str) -> str:
    # remove // comments
    content = re.sub(r"//.*?$", "", content, flags=re.MULTILINE)
    # remove /* */ comments
    content = re.sub(r"/\*.*?\*/", "", content, flags=re.DOTALL)
    return content


ALLOW_TOP_LEVEL = set([
    "theme","model","autoupdate","agent","default_agent","permission",
    "command","keybinds","watcher","mcp","plugin","instructions",
    "formatter","compaction","share","$schema"
])


def sha256_of_bytes(b: bytes) -> str:
    return hashlib.sha256(b).hexdigest()


def load_json_file(path: str):
    with open(path, 'r', encoding='utf-8') as f:
        raw = f.read()
    try:
        obj = json.loads(raw)
        return obj, raw.encode('utf-8')
    except Exception:
        # try strip jsonc
        clean = strip_jsonc(raw)
        obj = json.loads(clean)
        return obj, clean.encode('utf-8')


def write_json(path: str, obj):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(obj, f, indent=2, ensure_ascii=False)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--ts', required=True)
    p.add_argument('--check', action='store_true')
    args = p.parse_args()
    ts = args.ts
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    evidence_dir = os.path.join(root, 'evidence', '_preflight', ts)
    os.makedirs(evidence_dir, exist_ok=True)

    # find config file
    candidates = [os.path.join(root, 'opencode.json'), os.path.join(root, 'opencode.jsonc')]
    found = None
    for c in candidates:
        if os.path.isfile(c):
            found = c
            break

    created_minimal = False
    if not found:
        # create minimal opencode.json
        minimal = {"$schema": "https://opencode.ai/config.json"}
        write_json(os.path.join(root, 'opencode.json'), minimal)
        found = os.path.join(root, 'opencode.json')
        created_minimal = True

    # read and compute before sha256
    obj, raw_bytes = load_json_file(found)
    before_sha = sha256_of_bytes(raw_bytes)

    detected_unknown = []
    removed = {}
    for k in list(obj.keys()):
        if k not in ALLOW_TOP_LEVEL:
            detected_unknown.append(k)
            removed[k] = obj.pop(k)

    report = {
        'paths': {
            'root': root,
            'config_path': found,
            'vendor_dump': os.path.join(root, '.opencode', 'vendor', 'omoc.local.json')
        },
        'detected_unknown_keys': detected_unknown,
        'fixed': False,
        'before_sha256': before_sha,
        'after_sha256': None,
    }

    # write opencode_config_path.txt for evidence
    with open(os.path.join(evidence_dir, 'opencode_config_path.txt'), 'w', encoding='utf-8') as f:
        f.write(found + "\n")

    # if check mode only, write report and exit with code 2 if unknowns
    if args.check:
        report['fixed'] = False
        report_path = os.path.join(evidence_dir, 'opencode_doctor_report.json')
        write_json(report_path, report)
        if detected_unknown:
            print(f"Unknown top-level keys detected: {detected_unknown}")
            exit(2)
        else:
            print("No unknown top-level keys detected.")
            exit(0)

    # If unknown keys found, perform fail-closed remediation
    if detected_unknown:
        # backup original
        bak_path = os.path.join(evidence_dir, os.path.basename(found) + '.bak')
        shutil.copyfile(found, bak_path)

        # write removed block to .opencode/vendor/omoc.local.json
        vendor_path = os.path.join(root, '.opencode', 'vendor', 'omoc.local.json')
        os.makedirs(os.path.dirname(vendor_path), exist_ok=True)
        # if file exists, merge by wrapping under ts
        if os.path.exists(vendor_path):
            try:
                with open(vendor_path, 'r', encoding='utf-8') as f:
                    existing = json.load(f)
            except Exception:
                existing = {}
        else:
            existing = {}
        existing[ts] = removed
        write_json(vendor_path, existing)

        # write cleaned config back to original path
        write_json(found, obj)
        # compute after sha
        with open(found, 'rb') as f:
            after_sha = sha256_of_bytes(f.read())
        report['fixed'] = True
        report['after_sha256'] = after_sha
        report['moved_keys'] = detected_unknown
        report['backup_path'] = bak_path
    else:
        # nothing to do
        with open(found, 'rb') as f:
            report['after_sha256'] = sha256_of_bytes(f.read())

    # write final report
    report_path = os.path.join(evidence_dir, 'opencode_doctor_report.json')
    write_json(report_path, report)

    # also write opencode_version if possible
    try:
        import subprocess
        out = subprocess.check_output(['opencode', '--version'], stderr=subprocess.STDOUT, text=True)
    except Exception:
        out = 'opencode: not found'
    with open(os.path.join(evidence_dir, 'opencode_version.txt'), 'w', encoding='utf-8') as f:
        f.write(out + '\n')

    print('Report written to', report_path)


if __name__ == '__main__':
    main()
