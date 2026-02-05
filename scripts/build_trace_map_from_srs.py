#!/usr/bin/env python3
"""保守的 SRS parser：從 ssot/inputs 中的 P1_SRS 抽出 MAI ID 與來源定位，輸出 control_plane/trace_map.json
此腳本為最小可行實作，僅提取標題中帶 MAI 的行。
"""
import json
import re
from pathlib import Path

out = Path('control_plane/trace_map.json')
out.parent.mkdir(parents=True, exist_ok=True)

entries = []
for p in Path('ssot/inputs').glob('**/*.md'):
    text = p.read_text(encoding='utf-8')
    for i, line in enumerate(text.splitlines(), start=1):
        m = re.search(r"(MAI[\w\-\.:]+|MAINT|MAINTENANCE|MAI)", line)
        if m:
            entries.append({
                'mai_id': m.group(0),
                'srs_req_id': '',
                'acceptance_artifact': '',
                'verification_method': '',
                'pass_criteria': '',
                'gate_ref': '',
                'source_locator': f"{p.as_posix()}:{i}"
            })

out.write_text(json.dumps(entries, indent=2, ensure_ascii=False))
print(f'Wrote {len(entries)} entries to {out}')
