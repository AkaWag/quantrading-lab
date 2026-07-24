#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-.}"
TARGET="$(cd "$TARGET" && pwd)"
fail=0
need(){ [[ -e "$TARGET/$1" ]] || { echo "MISSING: $1"; fail=1; }; }
need .cursor/rules/00-operating-model.mdc
need .cursor/skills/research-director/SKILL.md
need .cursor/skills/pine-v6-engineer/SKILL.md
need docs/WORKFLOW.md
need scripts/new-strategy.sh
need scripts/check-continuity.py
skills=$(find "$TARGET/.cursor/skills" -mindepth 2 -maxdepth 2 -name SKILL.md 2>/dev/null | wc -l)
rules=$(find "$TARGET/.cursor/rules" -maxdepth 1 -name '*.mdc' 2>/dev/null | wc -l)
echo "Skills: $skills"
echo "Rules:  $rules"
[[ "$skills" -ge 20 ]] || { echo "Expected at least 20 skills"; fail=1; }
[[ "$rules" -ge 7 ]] || { echo "Expected at least 7 rules"; fail=1; }
for s in "$TARGET"/scripts/*.sh; do bash -n "$s" || fail=1; done
python3 "$TARGET/scripts/check-continuity.py" "$TARGET" || fail=1
if [[ $fail -eq 0 ]]; then echo "Verification passed."; else echo "Verification failed."; exit 1; fi
