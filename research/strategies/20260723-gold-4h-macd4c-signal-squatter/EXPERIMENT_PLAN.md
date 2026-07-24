# Experiment Plan — QT-R-002 short-side design

- Research ID: QT-R-002
- Owner: Aka Wag
- Director: research-director
- Date: 2026-07-24
- Status: **LOCKED — INSUFFICIENT_EVIDENCE; no parameter selection authorized**
- Source: [`INTAKE.md`](INTAKE.md), [`BASELINE.md`](BASELINE.md),
  [`PRE_OPTIMIZATION_AUDIT.md`](PRE_OPTIMIZATION_AUDIT.md)

## Requirement and hypothesis

**Owner requirement:** the target strategy must trade both long and short.

The frozen long-only run is the comparison control. Enabling the existing mirrored short logic
degrades aggregate performance. The falsifiable working hypothesis is:

> Short trades can add useful downside participation without materially degrading the long-side
> control only if short behavior is designed and validated asymmetrically for bearish Gold
> regimes.

Failure means no tested short-side design meets the declared risk/robustness bar. In that case,
shorts remain a required but unresolved research requirement; they are not silently removed.

## Baseline controls

All diagnostic runs use:

- XAUUSD · OANDA · 4H;
- **2018-01-01 → 2026-05-19**;
- MACD 18/36/12, oscillator EMA, signal SMA;
- EMA(300), slope lookback 3, minimum slope 0.03%;
- trend filter and trend exit on;
- MACD rising/falling qualifiers on;
- Cross Exit Any off; Zero Line Exit off; TP/SL off;
- initial capital 1,000 USD; order size 100% equity;
- commission 0.1%; slippage 0 ticks, verified in captured Properties;
- pyramiding 1; bar magnifier off; standard-OHLC fills on.

No run may change long logic, costs, dates, fill assumptions, and short logic simultaneously.

## Phase 0 — direction decomposition (not optimization)

Run exactly three direction states with every other input fixed:

| Run | Long | Short | Existing evidence | Purpose |
|---|---:|---:|---|---|
| D0-L | On | Off | EV-002 | Frozen comparison control |
| D0-S | Off | On | EV-004 | Isolate current short-only expectancy and risk |
| D0-C | On | On | EV-003 | Measure combined interaction |

Required metrics for each: net profit, maximum drawdown, profit factor, trades, win rate, average
trade, exposure, largest loss, and recovery duration. Export the trade list where available.

Recorded Overview results:

| Run | Net % | MaxDD % | PF | Trades | Winners |
|---|---:|---:|---:|---:|---:|
| D0-L | 101.31 | 7.98 | 3.532 | 39 | 18 |
| D0-S | −10.63 | 13.95 | 0.529 | 17 | 6 |
| D0-C | 78.74 | 15.29 | 2.092 | 56 | 24 |

### Direction accounting check

Before accepting D0-S / D0-C:

- confirm combined trade count and P&L reconcile plausibly with the direction-isolated runs;
- identify whether reversals close one direction and enter the other on the same signal/bar;
- record any same-bar or next-bar fill ambiguity;
- do not infer short-only performance by subtracting aggregate percentages.

Current accounting result: counts reconcile exactly (`39 + 17 = 56`; `18 + 6 = 24`), while
P&L/risk metrics require ledger-level reconciliation. See
[`evidence/EV-004-short-only-diagnostic.md`](evidence/EV-004-short-only-diagnostic.md).

## Phase 1 — failure classification

Classify every short loss into one primary category:

1. counter-trend short during structurally bullish regime;
2. late bearish entry after most of the move;
3. false MACD bear cross / momentum failure;
4. trend-exit giveback;
5. cross-exit delay;
6. cost/fill sensitivity;
7. gap or tail event;
8. implementation/order-timing ambiguity.

Record performance by year, EMA slope bucket, volatility bucket, entry distance from EMA, holding
bars, MAE, and MFE. The first short-side change family must address the dominant evidenced
category.

Phase 1 is recorded in
[`evidence/EV-006-short-failure-classification.md`](evidence/EV-006-short-failure-classification.md).
Among 11 losses, **6** are low-MFE momentum failures and **5** are trend-exit givebacks. Exact
entry slope and broader regime labels are not exported and remain unknown.

## Phase 2 — one short subfamily only

**Pre-registered selection:** short-specific bearish-regime qualification.

- **short regime filter** — short-specific trend/slope qualification;
- ~~short confirmation~~ — not opened;
- ~~short exit~~ — retained as the second evidenced family, not opened;
- ~~short sizing/risk~~ — not opened.

Falsifiable hypothesis:

> Requiring a stronger negative EMA(300) three-bar slope for short entries will remove enough
> low-follow-through bearish crosses to produce positive short-only OOS expectancy after stressed
> costs without changing the frozen long logic.

One new Pine input is permitted: `shortMinSlopePct`. The shared long-side `i_minSlope` remains
unchanged at **0.03%**.

Long logic remains bit-for-bit frozen. A second short subfamily requires a separate experiment.

## Parameter governance

- Use exactly **one** tunable degree of freedom: `shortMinSlopePct`.
- Locked complete coarse grid: **0.03% control, 0.05%, 0.07%, 0.10%, 0.15%**.
- Do not use values justified only by the upstream Gold 1H tooltips.
- Inspect neighboring values and stability plateaus, not the single best point.
- Record every attempted value, including null and failed results.
- No broad MACD 18/36/12 retuning in this experiment.
- No short exit, confirmation, sizing, MACD, date, cost, or fill change in the same run.

## IS / validation / OOS lock

The chronological windows are now locked:

| Segment | Dates | D0-S trades | D0-S result |
|---|---|---:|---:|
| IS | 2018-01-01 → 2021-12-31 | 9 | −52.813 USD |
| Validation | 2022-01-01 → 2023-12-31 | 6 | +3.178 USD |
| Untouched OOS | 2024-01-01 → 2026-05-19 | **2** | −56.630 USD |

The OOS segment is not interpretable with two trades. Rolling or anchored folds cannot create
independent evidence from only 17 total trades. The current study therefore returns
`INSUFFICIENT_EVIDENCE`; boundaries must not be moved to improve the result.

## Robustness and stress plan

Any selected short candidate must survive:

- commission stress at **0.2% and 0.3% per side** versus the 0.1% baseline;
- slippage stress at **2 and 5 ticks** versus the zero-tick baseline;
- one-bar delayed entry;
- worse-fill / gap assumptions;
- year and regime segmentation;
- neighboring parameter values;
- rolling or anchored walk-forward OOS aggregation;
- trade-order/bootstrap or Monte Carlo review when the trade sample permits.

Adjacent symbols/timeframes are transfer checks only and are not pooled into selection.

## Acceptance criteria

A candidate cannot pass unless all gates hold:

- the locked OOS segment contains at least **10** short trades; **20+** aggregated independent
  walk-forward/OOS trades is the preferred evidence target;
- short-only OOS expectancy is positive after stressed costs;
- stressed OOS profit factor remains above **1.0**;
- target short-only stressed OOS profit factor is **1.20 or greater**;
- combined OOS performance does not rely on one trade or one regime;
- short-only maximum drawdown target is **10% or lower**, with a hard ceiling below D0-S
  **13.95%**;
- combined maximum drawdown target is **12% or lower**, with a hard ceiling below EV-003
  **15.29%**;
- combined full-window net profit must exceed EV-003 **78.74%**; the promotion floor is **90%**
  and the target is the unchanged long-only control **101.31%**;
- combined profit factor must exceed EV-003 **2.092**, with a target of **2.50 or greater**;
- win rate is diagnostic, not an isolated gate: target **40% or greater**, or approximately 35%
  only when average win is at least **2.25 times** average loss;
- when marked-to-market daily or weekly equity is available, OOS Sharpe must be positive and
  should reach **0.75 or greater** (stretch **1.0**), with Sortino target **1.0 or greater**;
  closed-trade Sharpe from a sparse sample is not a promotion gate;
- no single trade or year contributes more than **50%** of candidate profit;
- parameter behavior forms a stable region;
- the candidate improves the short-enabled EV-003 control on a balanced scorecard;
- no critical temporal, semantic, or execution defect remains.

With only two OOS trades, no value in the locked slope grid is authorized for selection or
promotion.

## Stop conditions

Stop and retain a negative result if:

- Properties evidence contradicts the fixed assumptions;
- D0-S has too few trades for defensible validation;
- the proposed benefit is confined to in-sample;
- stressed costs remove the edge;
- only an isolated parameter peak works;
- more than one short subfamily must change to produce improvement;
- the required short behavior cannot be represented without a specification/Pine revision.

## Required evidence

- [x] EV-002 Properties and timezone completion;
- [x] D0-S Overview + trade export;
- [ ] D0-C EV-003 trade export (Overview exists; ledger not required to establish D0-S stop);
- [x] direction reconciliation table;
- [x] short failure-classification record;
- [x] search manifest — locked grid recorded; **not executed** after OOS hard stop;
- [x] OOS feasibility and commission-stress result:
  [`evidence/EV-007-short-validation-gate.md`](evidence/EV-007-short-validation-gate.md);
- [x] rejected/null result retained in `evidence/`.

## Immediate next action

Retain the pre-registration and acquire additional chronologically later short evidence. Do not
run or select the grid against the current two-trade OOS segment. The formal current result is
`INSUFFICIENT_EVIDENCE`, not a winning parameter.
