#!/usr/bin/env bash
set -u
OUT_DIR="evidence/_ssot_scan/$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$OUT_DIR" control_plane

# expected SSOT filenames (user-provided list)
cat > "$OUT_DIR/expected_files.txt" <<'EOF'
Spartoi-OMOC_開發實作方案.md
Spartoi-OMOC 工程實作指南.md
Spartoi｜P1_SRS_v7.0.0.md
Spartoi｜P1_ARCH_v6.0.0-r5.md
Spartoi｜P1_LBP-B(ICD)_v5.0.1.md
Spartoi｜P1_LBP-E(Fitness)_v3.0.1.md
Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI_v1.4.0.md
OMOC-GMA Lite 實作_任務交接報告_02042347.md
EOF

# locate files by basename
: > "$OUT_DIR/found_files.tsv"
while IFS= read -r base; do
  path="$(find . -type f -name "$base" -print -quit 2>/dev/null || true)"
  if [ -n "$path" ]; then
    sha="$(sha256sum "$path" | awk '{print $1}')"
    bytes="$(wc -c < "$path" | tr -d ' ')"
    printf "%s\t%s\t%s\t%s\n" "$base" "$path" "$sha" "$bytes" >> "$OUT_DIR/found_files.tsv"
  else
    printf "%s\t%s\t%s\t%s\n" "$base" "" "" "" >> "$OUT_DIR/found_files.tsv"
  fi
done < "$OUT_DIR/expected_files.txt"

# build minimal JSON (no external deps)
python3 - <<'PY'
import json, pathlib
from datetime import datetime, timezone
ts = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
out_dir = pathlib.Path("evidence/_ssot_scan").glob("*")
latest = sorted(out_dir)[-1]
rows=[]
for line in (latest/"found_files.tsv").read_text(encoding="utf-8").splitlines():
    base,path,sha,bytes_ = line.split("\t")
    rows.append({"basename":base,"path":path or None,"sha256":sha or None,"bytes":int(bytes_) if bytes_ else None})
doc_index={
  "generated_utc": ts,
  "ssot_files": rows
}
pathlib.Path("control_plane/doc_index.json").write_text(json.dumps(doc_index, ensure_ascii=False, indent=2), encoding="utf-8")
print("Wrote control_plane/doc_index.json")
PY

# also save raw scan outputs
cp "$OUT_DIR/expected_files.txt" "$OUT_DIR/found_files.tsv" -f
