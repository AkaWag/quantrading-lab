# Pine Patterns

> **Title:** Pine v6 Patterns
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (patterns distilled from repository templates and standards; not
> empirically validated for edge)
> **Evidence references:** [`../../pine/strategies/institutional_strategy_v6.pine`](../../pine/strategies/institutional_strategy_v6.pine), [`../../pine/strategies/baseline_strategy_v6.pine`](../../pine/strategies/baseline_strategy_v6.pine)
> **Supersedes:** none
> **Superseded by:** none

Reusable Pine Script v6 structural patterns consistent with `10-pine-v6-standards.mdc`,
`10-pine-v6-engineering.mdc`, and
[`../../docs/governance/ENGINEERING_STANDARDS.md`](../../docs/governance/ENGINEERING_STANDARDS.md).
These are code-organization patterns, not trading recommendations.

## Script skeleton

- One `//@version=6` header; exactly one of `indicator()` / `strategy()` / `library()`.
- Section order: metadata → inputs (grouped) → calculations → signals → filters → sizing →
  orders/exits → visuals → alerts → diagnostics.
- Descriptive camelCase identifiers; small pure helper functions where practical.

## Confirmed-bar signal pattern

Prefer confirmed-bar decisions for non-repainting behavior:

```text
bool longSignal = barstate.isconfirmed and ta.crossover(fast, slow)
```

Both repository strategy templates use this pattern
([`../../pine/strategies/baseline_strategy_v6.pine`](../../pine/strategies/baseline_strategy_v6.pine)).

## Explicit-cost strategy pattern

Make execution realism explicit in the `strategy()` call: `commission_type`/`commission_value`,
`slippage`, `initial_capital`, `pyramiding`, and `process_orders_on_close`. Consider `currency`
and quantity behavior. See [`TRADINGVIEW_EXECUTION_NOTES.md`](TRADINGVIEW_EXECUTION_NOTES.md).

## Risk / stop patterns

- **Entry-anchored stop:** compute the stop once at entry and hold it (see
  `institutional_strategy_v6.pine`).
- **Recomputed ATR stop:** distance recomputed each bar from current ATR (see
  `baseline_strategy_v6.pine`). Document which semantics you intend — they differ materially and
  are a frequent source of confusion (see [`COMMON_FAILURES.md`](COMMON_FAILURES.md)).

## Date-window control pattern

Gate entries with an explicit in-sample/out-of-sample window input so tests are reproducible
(see the `startDate`/`endDate`/`inWindow` inputs in `institutional_strategy_v6.pine`).

## Alert pattern

`alertcondition()` text should state that it is a research signal and whether it triggers
intrabar or at bar close, per [`../../checklists/alert-deployment.md`](../../checklists/alert-deployment.md).

## Related documents

- [`TRADINGVIEW_EXECUTION_NOTES.md`](TRADINGVIEW_EXECUTION_NOTES.md) · [`MTF_AND_REPAINTING.md`](MTF_AND_REPAINTING.md)
- [`COMMON_FAILURES.md`](COMMON_FAILURES.md) · [`PERFORMANCE_NOTES.md`](PERFORMANCE_NOTES.md)
