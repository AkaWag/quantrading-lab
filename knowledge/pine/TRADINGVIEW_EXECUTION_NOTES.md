# TradingView Execution Notes

> **Title:** TradingView Execution Notes
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (organizes execution assumptions; specific broker-emulator behavior
> must be verified against official TradingView documentation)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Notes on how the TradingView Pine broker emulator and execution settings shape backtest realism.
TradingView is the **external** compilation and backtest authority
([`../../docs/architecture/SYSTEM_BOUNDARIES.md`](../../docs/architecture/SYSTEM_BOUNDARIES.md));
nothing here is executed inside this workspace, and uncertain API behavior must be verified
against official documentation before it is relied upon.

## Assumptions to always record

For any strategy, record in the specification and every evidence record:

- symbol, asset class, exchange; timeframe; session and timezone;
- commission model and value; slippage; spread;
- initial capital; currency; pyramiding; quantity behavior;
- order types and the fill model.

## Settings that change results (verify against official docs)

| Setting | Effect (to verify) | Caution |
|---|---|---|
| `process_orders_on_close` | Orders fill on the closing price of the signal bar | Changes fill timing vs next-open |
| `calc_on_every_tick` | Recalculates intrabar in realtime | Historical vs realtime divergence; repaint risk |
| `calc_on_order_fills` | Recalculates after each fill | Can change order sequencing |
| Bar magnifier | Uses lower-TF data to model intrabar fills | Availability/plan-dependent; document if used |
| `pyramiding` | Number of allowed stacked entries | Affects sizing and exposure |

## Known uncertainty

- Intrabar fill ordering, stop/limit priority, and gap handling are **broker-emulator specific**
  and must be confirmed against TradingView documentation, not assumed.
- `syminfo.pointvalue` and contract behavior vary by instrument; verify sizing math per market
  (noted in [`../../pine/strategies/baseline_strategy_v6.pine`](../../pine/strategies/baseline_strategy_v6.pine)).

## Evidence discipline

Never claim compilation or backtest results without pasting the exact TradingView output as
`COMPILE`/performance evidence, per
[`../../docs/governance/AI_OPERATING_PRINCIPLES.md`](../../docs/governance/AI_OPERATING_PRINCIPLES.md).

## Related documents

- [`MTF_AND_REPAINTING.md`](MTF_AND_REPAINTING.md) · [`COMMON_FAILURES.md`](COMMON_FAILURES.md)
- [`../../checklists/backtest-audit.md`](../../checklists/backtest-audit.md)
