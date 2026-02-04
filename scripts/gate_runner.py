#!/usr/bin/env python3
"""
Deterministic Gate Runner (self-test)

This script validates gate templates under gates/templates/ and
emits verdict.json in evidence/_b1/ when run with --selftest.
"""
import argparse
import json
import os
import sys
from jsonschema import validate, Draft7Validator

THIS_DIR = os.path.dirname(__file__)
TEMPLATES_DIR = os.path.join(THIS_DIR, '..', 'gates', 'templates')
OUT_DIR = os.path.join(THIS_DIR, '..', 'evidence', '_b1')
os.makedirs(OUT_DIR, exist_ok=True)

TRIAD_SCHEMA = {
    "$schema": "http://json-schema.org/draft-07/schema#",
    "type": "object",
    "properties": {
        "triad": {"type": "array"}
    },
    "required": ["triad"]
}

TEMPLATE_SCHEMA = {
    "type": "object",
    "properties": {
        "name": {"type": "string"},
        "description": {"type": "string"},
        "type": {"type": "string"},
        "policy": {"type": "object"}
    },
    "required": ["name","type","policy"]
}


def load_templates():
    files = []
    if not os.path.isdir(TEMPLATES_DIR):
        return files
    for fn in sorted(os.listdir(TEMPLATES_DIR)):
        if fn.endswith('.json'):
            files.append(os.path.join(TEMPLATES_DIR, fn))
    return files


def selftest():
    files = load_templates()
    results = []
    for p in files:
        try:
            with open(p, 'r') as f:
                obj = json.load(f)
            validate(instance=obj, schema=TEMPLATE_SCHEMA)
            results.append({'file': p, 'valid': True})
        except Exception as e:
            results.append({'file': p, 'valid': False, 'error': str(e)})

    triad = {'triad': [{'file': r['file'], 'valid': r['valid']} for r in results]}

    out_verdict = os.path.join(OUT_DIR, 'verdict.json')
    with open(out_verdict, 'w') as f:
        json.dump({'results': results, 'triad': triad}, f, indent=2)

    # Validate triad against triad schema
    try:
        validate(instance=triad, schema=TRIAD_SCHEMA)
    except Exception as e:
        print('Triad validation failed:', e, file=sys.stderr)
        return 2

    # If any template invalid -> return non-zero
    if any(not r['valid'] for r in results):
        return 3
    return 0


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--selftest', action='store_true')
    args = parser.parse_args()
    if args.selftest:
        rc = selftest()
        if rc == 0:
            print('SELFTEST: OK')
        else:
            print('SELFTEST: FAILED rc=', rc)
        sys.exit(rc)


if __name__ == '__main__':
    main()
