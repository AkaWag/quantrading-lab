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
| QT-R-001 | NEW_STRATEGY | XAUUSD Global Session Transition and London Breakout Research | Aka Wag | EVIDENCE-GATHERING | BREAKOUT (SESSION, VOL, MOMENTUM) | XAUUSD | 15m | ../strategies/20260721-xauusd-global-session-transition-london-breakout/HYPOTHESIS.md | none | 2026-07-23 | Signum Agent Live pilot (external): close EV-001 then TEMPORAL + B1–B6 — no Pine / QT-S-### / live money |
| QT-R-002 | EXISTING_STRATEGY | Gold 4H MACD 4C Signal Squatter (Signum Gold_4H_MACD_v20) | Aka Wag | EXPERIMENT-PLANNED | TREND (MACD) | XAUUSD | 4H | ../strategies/20260723-gold-4h-macd4c-signal-squatter/EXPERIMENT_PLAN.md | EV-002 PASS; EV-003/004 direction diagnostics; EV-006/007 INSUFFICIENT_EVIDENCE; Signum handover ready | 2026-07-24 | Owner-authorized Signum M1–M3 evidence-expansion run; no slope-grid search |
| QT-R-003 | EXISTING_STRATEGY | Gold 1H MACD 4C Signal Squatter (Signum Gold_1H_MACD_v21) | Aka Wag | OBSERVED | TREND (MACD) | XAUUSD | 1H | ../strategies/20260723-gold-1h-macd4c-signal-squatter/INTAKE.md | none (external claims only) | 2026-07-23 | **Parked** (fleet Grade C); revisit after QT-R-002 loop or retire vs QT-R-004 |
| QT-R-004 | EXISTING_STRATEGY | Gold 1H 3-MACD Confluence v2.2 | Aka Wag | OBSERVED | TREND (MACD, T3) | XAUUSD | 1H | ../strategies/20260723-gold-1h-3macd-confluence/INTAKE.md | none (external claims only) | 2026-07-23 | **Parked queue** (Shotgun OK); baseline freeze after QT-R-002 or on owner reprioritise |

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
