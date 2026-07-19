#!/usr/bin/env bash
set -u
printf 'QuanTrading Lab doctor\n'
printf 'OS: '; uname -a
for cmd in bash git unzip zip sha256sum; do
  if command -v "$cmd" >/dev/null 2>&1; then printf 'OK   %s: %s\n' "$cmd" "$(command -v "$cmd")"; else printf 'MISS %s\n' "$cmd"; fi
done
if command -v cursor >/dev/null 2>&1; then echo "OK   cursor CLI: $(command -v cursor)"; else echo "INFO cursor CLI not found; desktop launch is still usable"; fi
