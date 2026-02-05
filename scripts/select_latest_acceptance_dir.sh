#!/usr/bin/env bash
set +e
root="evidence/_acceptance"
[ -d "$root" ] || { echo ""; exit 0; }

# 只挑「目錄」，且必須包含 final/verdict.json 或 final/verdict.txt
# Ensure we only consider directories and prefer those containing a final/verdict file
candidates=$(find "$root" -mindepth 1 -maxdepth 2 -type d 2>/dev/null | sort -r)
for d in $candidates; do
  if [ -d "$d" ]; then
    if [ -f "$d/final/verdict.json" ] || [ -f "$d/final/verdict.txt" ]; then
      echo "$d"
      exit 0
    fi
  fi
done

# fallback：挑最新「目錄」但仍提示缺 verdict
latest_dir=$(find "$root" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -r | head -n 1)
echo "$latest_dir"
exit 0
