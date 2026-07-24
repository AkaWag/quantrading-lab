# EV-006 — Short-trade failure classification (QT-R-002)

- Date: 2026-07-24
- Run: D0-S / short-only
- Sample: 17 trades; 6 winners; 11 losers
- Source ledger: [`EV-004-short-only-trades.csv`](EV-004-short-only-trades.csv)
- Row classifications:
  [`EV-004-short-trade-classification.csv`](EV-004-short-trade-classification.csv)
- Workbook:
  [`EV-004-QT-R-002-short-side-recovery.xlsx`](EV-004-QT-R-002-short-side-recovery.xlsx)
- Status: **DIAGNOSTIC COMPLETE — selection evidence is sparse**

## Classification method

The TradingView export supplies entry/exit timestamps, signal labels, prices, commission,
favorable excursion (MFE), adverse excursion (MAE), cumulative P&L, and duration.

Losses are classified mechanically:

- **false bear cross / momentum failure:** MFE below 1.50%;
- **trend-exit giveback:** MFE at or above 1.50%, but final P&L is negative.

The 1.50% boundary is a diagnostic separator, not an optimized trading parameter.

## Result

| Primary loss class | Losses | Share of losses | Evidence pattern |
|---|---:|---:|---|
| False bear cross / momentum failure | **6** | **54.5%** | Little downside follow-through; MFE 0.00%–1.06% |
| Trend-exit giveback | **5** | **45.5%** | MFE 1.52%–3.99% later became a loss |

The largest single loss is trade 16: **−4.42%**, only **0.22% MFE**, **−5.19% MAE**, and
12 bars. This is the clearest immediate momentum failure. Trade 4 also produced no favorable
excursion before failing.

Giveback is also material. Trades 3, 6, 8, 13, and 17 all had meaningful favorable excursion
before closing at a loss. This remains the second short-side family; it is not changed in the
first experiment.

## Regime, timing, slope, and exit interpretation

- Every trade met the frozen local bearish entry gate:
  `close < EMA(300)` and three-bar EMA slope `<= −0.03%`.
- Exact entry EMA slope values are not exported. They are recorded as bounded facts, not invented.
- The export signal for every close is `Close entry(s) order Short`. With frozen inputs this means
  either price reclaimed EMA(300) or MACD produced a positive-region bull cross. TradingView does
  not distinguish those causes in this export.
- Entry timing is classified from duration and excursion:
  - immediate failure: trades 4 and 16;
  - no sustained downside: trades 7, 9, 14, and 15;
  - downside developed then reversed: trades 3, 6, 8, 13, and 17.
- A broader structural-bull/bear regime is unavailable from the trade export and remains
  unclassified. Local bearish-gate membership is not proof of a durable bearish regime.

## Family decision

The first controlled family is **short-specific bearish-regime qualification**, implemented as
one independent degree of freedom: a short-only minimum EMA(300) slope magnitude.

Rationale:

1. momentum failure is the largest loss class by count;
2. the two fastest failures have negligible MFE;
3. the current shared `0.03%` threshold may be too permissive for shorts;
4. long logic can remain bit-for-bit frozen;
5. no MACD periods, exits, sizing, or costs need to change in the same experiment.

This is a research hypothesis, not evidence that a stricter threshold will work.

## Evidence limits

- Seventeen trades over eight years are insufficient for broad search.
- The locked OOS period contains only two short trades, both losses.
- Exact EMA slope, broader regime label, and distinct exit cause are not exported.
- MAE/MFE are TradingView bar-path results under the captured fill model, not tick-level truth.
