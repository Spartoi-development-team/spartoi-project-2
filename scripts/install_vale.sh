#!/usr/bin/env bash
# Deterministic Vale installer: downloads linux/amd64 release and installs to ~/.local/bin/vale
set -euo pipefail

DEST_DIR="$HOME/.local/bin"
mkdir -p "$DEST_DIR"
TMP=$(mktemp -d)
echo "Fetching latest Errata AI Vale release metadata" >&2
metadata=$(curl -sS https://api.github.com/repos/errata-ai/vale/releases/latest)
asset_url=$(printf '%s' "$metadata" | python3 - <<PY
import sys, json
m=json.load(sys.stdin)
assets=m.get('assets',[])
for a in assets:
    name=a.get('name','').lower()
    if 'linux' in name and ('64' in name or 'amd64' in name or 'x86' in name):
        print(a.get('browser_download_url'))
        sys.exit(0)
if assets:
    print(assets[0].get('browser_download_url'))
    sys.exit(0)
sys.exit(1)
PY
)
if [ -z "$asset_url" ]; then
  echo "ERROR: no asset URL found" >&2
  exit 2
fi

echo "Downloading $asset_url" >&2
curl -L --fail -o "$TMP/vale_asset" "$asset_url"

# extract
if file "$TMP/vale_asset" | grep -qi gzip; then
  tar -xzf "$TMP/vale_asset" -C "$TMP"
  found=$(find "$TMP" -type f -name 'vale' -perm /111 -print -quit || true)
  if [ -z "$found" ]; then
    found=$(find "$TMP" -type f -name 'vale' -print -quit || true)
  fi
  if [ -z "$found" ]; then
    echo "ERROR: vale binary not found in archive" >&2
    ls -la "$TMP" >&2
    exit 3
  fi
  mv "$found" "$DEST_DIR/vale"
  chmod +x "$DEST_DIR/vale"
else
  mv "$TMP/vale_asset" "$DEST_DIR/vale"
  chmod +x "$DEST_DIR/vale"
fi

echo "Installed vale to $DEST_DIR/vale" >&2
"$DEST_DIR/vale" --version

exit 0
