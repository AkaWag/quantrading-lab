#!/usr/bin/env bash
set -euo pipefail
usage(){ echo "Usage: $0 --project PATH | --global"; }
[[ $# -ge 1 ]] || { usage; exit 2; }
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
case "$1" in
  --project)
    [[ $# -eq 2 ]] || { usage; exit 2; }
    TARGET="$(mkdir -p "$2" && cd "$2" && pwd)"
    mkdir -p "$TARGET/.cursor/skills" "$TARGET/.cursor/rules"
    cp -a "$ROOT/.cursor/skills/." "$TARGET/.cursor/skills/"
    cp -a "$ROOT/.cursor/rules/." "$TARGET/.cursor/rules/"
    for item in docs templates prompts checklists pine scripts research decisions releases reports journals experiments production; do
      mkdir -p "$TARGET/$item"
      cp -an "$ROOT/$item/." "$TARGET/$item/" 2>/dev/null || true
    done
    cp -n "$ROOT/VERSION" "$TARGET/VERSION" 2>/dev/null || true
    echo "Installed QuanTrading Lab into $TARGET"
    ;;
  --global)
    TARGET="$HOME/.cursor/skills"
    mkdir -p "$TARGET"
    cp -a "$ROOT/.cursor/skills/." "$TARGET/"
    echo "Installed global skills into $TARGET"
    echo "Project rules were not installed globally."
    ;;
  *) usage; exit 2;;
esac
