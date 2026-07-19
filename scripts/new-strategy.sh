#!/usr/bin/env bash
set -euo pipefail
[[ $# -ge 1 ]] || { echo "Usage: $0 'Strategy Name' [symbol] [timeframe]"; exit 2; }
name="$1"; symbol="${2:-TBD}"; tf="${3:-TBD}"
slug=$(printf '%s' "$name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g;s/^-|-$//g')
datepart=$(date +%Y%m%d)
base="research/strategies/${datepart}-${slug}"
[[ ! -e "$base" ]] || { echo "Already exists: $base"; exit 1; }
mkdir -p "$base/evidence" "$base/tests" "$base/reviews"
cp templates/research-intake.md "$base/INTAKE.md"
cp templates/hypothesis.md "$base/HYPOTHESIS.md"
cp templates/strategy-spec.md "$base/SPEC.md"
cp templates/risk-spec.md "$base/RISK.md"
cp templates/test-plan.md "$base/TEST-PLAN.md"
cp templates/release-record.md "$base/RELEASE.md"
cp pine/strategies/institutional_strategy_v6.pine "$base/strategy.pine"
cat > "$base/METADATA.md" <<EOF
# Strategy metadata
- Name: $name
- Symbol: $symbol
- Timeframe: $tf
- Created: $(date -Iseconds)
- Lifecycle status: intake
EOF
printf '%s\n' "$base"
