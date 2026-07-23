# Research Registry

Authoritative index of research projects. Each project receives a stable **research ID**
(`QT-R-###`) that never changes or is reused. This registry is the source of truth for project
status; per-project artifacts live under [`../strategies/`](../strategies/).

Governed by [`../../docs/research/RESEARCH_DEPARTMENT.md`](../../docs/research/RESEARCH_DEPARTMENT.md)
and [`../../docs/research/RESEARCH_STREAMS.md`](../../docs/research/RESEARCH_STREAMS.md).

## Conventions

- **Research ID:** `QT-R-###`, assigned sequentially across **all streams**. Never reuse a retired ID.
- **Stream:** one of `NEW_STRATEGY`, `EXISTING_STRATEGY`, `BLACK_BOX_STRATEGY`, `VALIDATION`
  (see [`../../docs/research/RESEARCH_STREAMS.md`](../../docs/research/RESEARCH_STREAMS.md)).
- **Status:** one of `OBSERVED`, `QUESTION`, `HYPOTHESIS`, `SPECIFIED`, `EXPERIMENT-PLANNED`,
  `EVIDENCE-GATHERING`, `REVIEWED`, `CLOSED` (see the lifecycle in
  [`../../docs/research/RESEARCH_DEPARTMENT.md`](../../docs/research/RESEARCH_DEPARTMENT.md)).
- **Category:** a code from [`../../knowledge/taxonomy/MARKET_BEHAVIOURS.md`](../../knowledge/taxonomy/MARKET_BEHAVIOURS.md)
  (use `EXP` when unclassified).
- **Evidence stage:** the strongest evidence type reached
  ([`../../knowledge/taxonomy/EVIDENCE_TYPES.md`](../../knowledge/taxonomy/EVIDENCE_TYPES.md)).
- **Next decision:** the concrete decision the next review must make.
- **WIP guideline:** prefer at most one active `NEW_STRATEGY`, one active `EXISTING_STRATEGY`, and
  one active `VALIDATION` assignment (starting governance limit).

## Register (columns are mandatory)

| Research ID | Stream | Title | Owner | Status | Category | Market | Timeframe | Hypothesis link | Evidence stage | Last review | Next decision |
|---|---|---|---|---|---|---|---|---|---|---|---|
| QT-R-001 | NEW_STRATEGY | XAUUSD Global Session Transition and London Breakout Research | Aka Wag | EVIDENCE-GATHERING | BREAKOUT (SESSION, VOL, MOMENTUM) | XAUUSD | 15m | ../strategies/20260721-xauusd-global-session-transition-london-breakout/HYPOTHESIS.md | none | 2026-07-23 | EV-001: obtain/link XAUUSD 15m UTC data; then TEMPORAL + B1–B6 under accepted EXPERIMENT_PLAN — no Pine / QT-S-### |

<!--
Row example (do not treat as a real project):
| QT-R-### | NEW_STRATEGY | <title> | <owner> | OBSERVED | EXP | <symbol> | <tf> | ../strategies/<folder>/HYPOTHESIS.md | none | YYYY-MM-DD | Draft research question |
-->

## Adding a project

1. Claim the next `QT-R-###` and set **Stream**.
2. Add a row with owner, status `OBSERVED`, category, and stream.
3. Link artifacts as they are produced.
4. Update `Status`, `Evidence stage`, `Last review`, and `Next decision` at each review.
5. On closeout, set `Status` to `CLOSED` and record the disposition in the project's
   [`RESEARCH_CLOSEOUT`](../templates/RESEARCH_CLOSEOUT.md); do not delete the row.
6. Do **not** assign a strategy ID here — that belongs in [`STRATEGY_REGISTRY.md`](STRATEGY_REGISTRY.md)
   only when an implementation candidate exists.

## Related documents

- [`STRATEGY_REGISTRY.md`](STRATEGY_REGISTRY.md) · [`../README.md`](../README.md)
- [`../../docs/research/RESEARCH_STREAMS.md`](../../docs/research/RESEARCH_STREAMS.md)
