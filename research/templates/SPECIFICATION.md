# Specification — <short title>

- Research ID: <QT-R-###>
- Strategy ID (if assigned): <QT-S-###>
- Owner: <human name>
- Version: <semantic, e.g. 0.1.0>
- Date: YYYY-MM-DD
- Source hypothesis: [HYPOTHESIS](HYPOTHESIS.md)

Deterministic description of the intended logic. Extends the strategy-build templates
[`../../templates/strategy-spec.md`](../../templates/strategy-spec.md) and
[`../../templates/risk-spec.md`](../../templates/risk-spec.md). No implementation, optimization,
or performance claim belongs here.

## Signals

<entry/exit signal definitions; confirmed-bar vs intrabar>

## Filters

<regime, session, volatility, or MTF filters applied to signals>

## Entries

<long and short entry rules, deterministic>

## Exits

<signal, stop, target, time/session exits>

## Risk

<per-trade risk, stop behavior; link [`../../knowledge/taxonomy/RISK_CONCEPTS.md`](../../knowledge/taxonomy/RISK_CONCEPTS.md)>

## Position sizing

<sizing model and parameters; instrument point-value assumptions>

## Costs

<commission model/value, slippage, spread>

## Execution assumptions

<order types, fill model, `process_orders_on_close`, `calc_on_every_tick`, `calc_on_order_fills`,
bar magnifier if used; see [`../../knowledge/pine/TRADINGVIEW_EXECUTION_NOTES.md`](../../knowledge/pine/TRADINGVIEW_EXECUTION_NOTES.md)>

## Timeframe and session behavior

<chart timeframe, session, timezone, and expected regime>

## MTF behavior

<any higher/lower-timeframe requests and the confirmed-value handling; see
[`../../knowledge/pine/MTF_AND_REPAINTING.md`](../../knowledge/pine/MTF_AND_REPAINTING.md)>

## Non-functional requirements

<runtime/resource limits, readability, alert requirements, diagnostics>

## Assumptions and data limitations

<explicit assumptions; data availability, quality, and gaps>

## Next step

<usually: draft an [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md)>
