# Research Registry

Authoritative index of research projects. Each project receives a stable **research ID**
(`QT-R-###`) that never changes or is reused. This registry is the source of truth for project
status; per-project artifacts live under [`../strategies/`](../strategies/).

Governed by [`../../docs/research/RESEARCH_DEPARTMENT.md`](../../docs/research/RESEARCH_DEPARTMENT.md).

## Conventions

- **Research ID:** `QT-R-###`, assigned sequentially. Never reuse a retired ID.
- **Status:** one of `OBSERVED`, `QUESTION`, `HYPOTHESIS`, `SPECIFIED`, `EXPERIMENT-PLANNED`,
  `EVIDENCE-GATHERING`, `REVIEWED`, `CLOSED` (see the lifecycle in
  [`../../docs/research/RESEARCH_DEPARTMENT.md`](../../docs/research/RESEARCH_DEPARTMENT.md)).
- **Category:** a code from [`../../knowledge/taxonomy/MARKET_BEHAVIOURS.md`](../../knowledge/taxonomy/MARKET_BEHAVIOURS.md)
  (use `EXP` when unclassified).
- **Evidence stage:** the strongest evidence type reached
  ([`../../knowledge/taxonomy/EVIDENCE_TYPES.md`](../../knowledge/taxonomy/EVIDENCE_TYPES.md)).
- **Next decision:** the concrete decision the next review must make.

## Register (columns are mandatory)

| Research ID | Title | Owner | Status | Category | Market | Timeframe | Hypothesis link | Evidence stage | Last review | Next decision |
|---|---|---|---|---|---|---|---|---|---|---|
| _none yet_ | | | | | | | | | | |

<!--
Row example (do not treat as a real project):
| QT-R-001 | <title> | <owner> | OBSERVED | EXP | <symbol> | <tf> | ../strategies/<folder>/HYPOTHESIS.md | none | 2026-07-19 | Draft research question |
-->

## Adding a project

1. Claim the next `QT-R-###`.
2. Add a row with owner, status `OBSERVED`, and category.
3. Link artifacts as they are produced.
4. Update `Status`, `Evidence stage`, `Last review`, and `Next decision` at each review.
5. On closeout, set `Status` to `CLOSED` and record the disposition in the project's
   [`RESEARCH_CLOSEOUT`](../templates/RESEARCH_CLOSEOUT.md); do not delete the row.

## Related documents

- [`STRATEGY_REGISTRY.md`](STRATEGY_REGISTRY.md) · [`../README.md`](../README.md)
