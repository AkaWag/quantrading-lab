#!/usr/bin/env bash
set -euo pipefail
[[ $# -eq 2 ]] || { echo "Usage: $0 STRATEGY_DIR VERSION"; exit 2; }
dir="${1%/}"; version="$2"
[[ -d "$dir" ]] || { echo "Not a directory: $dir"; exit 1; }
name=$(basename "$dir")
out="releases/${name}-${version}.tar.gz"
mkdir -p releases
tar -czf "$out" -C "$(dirname "$dir")" "$(basename "$dir")"
sha256sum "$out" > "$out.sha256"
echo "$out"
