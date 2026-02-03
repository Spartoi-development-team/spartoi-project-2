#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

run_id="${1:-local-$(date -u +%Y%m%d-%H%M%S)}"
out_dir="evidence/${run_id}"
mkdir -p "${out_dir}"

echo "== collecting environment ==" | tee "${out_dir}/00-env.txt"
{
  date -Is
  uname -a || true
  echo "repo=$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  echo "commit=$(git rev-parse HEAD 2>/dev/null || echo unknown)"
  opencode --version || true
  lychee --version || true
  vale --version || true
} >> "${out_dir}/00-env.txt"

echo "== running gates ==" | tee "${out_dir}/01-gates.txt"
# capture full logs
bash scripts/gate_all_local.sh | tee "${out_dir}/01-gates.txt"

echo "== manifest ==" | tee "${out_dir}/02-manifest.txt"
git status --porcelain >> "${out_dir}/02-manifest.txt" || true
git diff --stat >> "${out_dir}/02-manifest.txt" || true

echo "== checksums ==" | tee "${out_dir}/03-sha256.txt"
(
  cd "${out_dir}"
  find . -maxdepth 1 -type f -print0 | xargs -0 -r sha256sum
) > "${out_dir}/03-sha256.txt"

echo "OK: evidence at ${out_dir}"
