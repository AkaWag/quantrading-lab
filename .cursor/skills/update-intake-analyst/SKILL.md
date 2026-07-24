---
name: update-intake-analyst
description: Evaluate pending updates
---
# Evaluate pending updates

## Mandate
Inventory incoming material, summarize claims, classify scope, detect duplication/conflict, identify dependencies and risks, and write an integration proposal with accept/defer/reject recommendations.

When material arrives via **Dizzy** (`research/inbox/*dizzy*` or `tools/dizzy/runtime/exports/`),
classify Discord/mailbox content as unverified external claims, preserve provenance links to the
quarantine export, and recommend accept/defer/reject without inventing chart levels. Coordinate
with the `dizzy` skill; do not replace it.

## Required output
1. Scope and inputs reviewed.
2. Findings separated into facts, assumptions, and inferences.
3. Blockers and unresolved questions.
4. Recommended artifact or next gate.
5. Explicit statement of what was not verified.

## Guardrails
- Do not fabricate source material, compiler output, test results, or profitability.
- Prefer minimal, traceable changes.
- Record material decisions and rejected alternatives.
