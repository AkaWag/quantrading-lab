# Pre-optimization audit — QT-R-002

- Research ID: QT-R-002
- Stream: EXISTING_STRATEGY
- Date: 2026-07-24
- Status: **COMPLETE — experiment locked; promotion blocked by insufficient OOS evidence**
- Canonical Pine: [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine)
- Baseline: [`BASELINE.md`](BASELINE.md)
- Evidence: [`evidence/EV-002-tv-baseline-reproduce.md`](evidence/EV-002-tv-baseline-reproduce.md)

## Purpose

Identify implementation, execution, and evidence risks before selecting any improvement family.
This is not an optimization result and does not authorize parameter search.

## Facts established

- Correct QT reproduce window: **2018-01-01 → 2026-05-19**.
- Current Overview evidence: 39 trades, 46.15% win rate, 7.98% maximum drawdown,
  profit factor 3.532, net profit 101.31%.
- Strategy is long-only by default.
- Frozen signal settings: MACD 18/36/12; oscillator EMA; signal SMA; EMA(300);
  slope lookback 3; minimum slope 0.03%; MACD-rising qualifier on.
- Fixed TP and SL are disabled in the baseline.
- Pine declares 1,000 USD initial capital, 100% equity sizing, 0.1% commission,
  zero slippage, pyramiding 1, no tick recalculation, no order-fill recalculation,
  no bar magnifier, and standard-OHLC fills.
- TradingView Properties and UTC+2 display timezone are captured in EV-002 / EV-005.

## Semantic and execution findings

### A1 — Fixed TP/SL implementation does not match its stated intent

If enabled, `strategy.exit()` receives `profit` / `loss` tick distances recalculated from each
bar's `close`:

```text
close × percentage ÷ syminfo.mintick
```

The tooltips describe a fixed percentage from entry. Because the order is updated while the
position is open, this implementation requires correction and separate compile/behavior evidence
before the risk-exit family can be tested. Baseline results are unaffected because TP/SL are off.

### A2 — Sample size is weak for optimization

Thirty-nine trades across roughly eight years cannot support a broad multi-parameter search.
Chronological subdivisions may contain too few trades for reliable selection. Any study must use
few degrees of freedom, report trade clustering, and retain an honest `INSUFFICIENT_EVIDENCE`
outcome.

### A3 — Several candidate families are not Pine parameters

- `atr_pct_max` exists in the upstream Python/JSON path but is explicitly absent from this Pine.
- No session/clock filter is exposed in the Pine.

Adding either changes implementation logic and requires a specification amendment, new Pine
version, compilation evidence, temporal audit, and baseline comparison. It is not parameter
tuning of the frozen script.

### A4 — Execution realism needs explicit evidence

- Full-equity compounding and zero slippage can overstate deployable performance.
- Captured Properties display long and short leverage as **Infinity**; this is not a deployable
  leverage assumption.
- Captured execution is **on bar close** with a **one-tick order execution delay**.

## Required diagnostic evidence

Before choosing any baseline-wide family, obtain the 39-trade list or equivalent export and
record:

1. profit/loss, entry/exit time, holding bars, MAE and MFE per trade;
2. results by year and market regime;
3. loss clusters and recovery duration;
4. entry and exit reason;
5. exposure and turnover;
6. sensitivity to commission, spread/slippage, one-bar entry delay, and worse fills.

## Family-selection rule

Choose the smallest family that addresses the largest evidenced failure mode:

- **Owner requirement (2026-07-24): shorts are required.** Therefore short-side design is the
  first improvement family. The long-only EV-002 run remains the comparison control, while
  EV-003 records the current combined long/short degradation.
- chop / false entries → trend-filter or confirmation family;
- excessive giveback / adverse excursion → corrected risk-exit family;
- high-volatility failure concentration → volatility-gate implementation experiment;
- clock/session concentration → session-filter implementation experiment.

Do not select a family from net profit alone.

## Stop conditions

- proposed family requires more than one independent logic family;
- OOS evidence is too sparse to distinguish signal from noise;
- apparent improvement exists only at an isolated parameter value;
- improvement disappears under realistic cost/fill stress;
- temporal, execution, or implementation audit finds an unresolved critical defect.

## Next gate

1. Retain EV-002 PASS and the D0-S trade ledger.
2. Retain the locked short-regime hypothesis and complete grid without searching it.
3. Acquire enough chronologically later short evidence to satisfy the OOS minimum.
4. Do not select a parameter while the formal result is `INSUFFICIENT_EVIDENCE`.
