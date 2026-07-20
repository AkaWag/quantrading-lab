# Taxonomy — Indicator Families

> **Title:** Indicator Families Taxonomy
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (controlled vocabulary; no empirical claim about any indicator)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Controlled vocabulary for *how the lab measures* market behavior. Indicators are measurement
tools; listing one here is not an endorsement of predictive power.

## Controlled categories

| Code | Family | Measures | Example measures |
|---|---|---|---|
| `TREND-IND` | Trend / moving averages | Direction, drift | EMA/SMA, MA slope, linear regression |
| `MOM-IND` | Momentum / oscillators | Rate of change, extremes | RSI, ROC, MACD, stochastic |
| `VOL-IND` | Volatility | Dispersion, range | ATR, stdev, Bollinger width, Keltner |
| `VOLUME-IND` | Volume / participation | Activity, flow | Volume, OBV, VWAP, delta, profile |
| `STRUCT-IND` | Structure / levels | Swings, S/R, gaps | Swing highs/lows, pivots, gap maps |
| `BAND-IND` | Bands / channels | Envelopes around price | Bollinger, Keltner, Donchian |
| `MTF-IND` | Multi-timeframe requests | HTF context | `request.security` HTF series (confirmed) |
| `STAT-IND` | Statistical / regime | Distributional / regime state | z-score, correlation, regime flags |
| `EXP` | Experimental / unclassified | any | Custom or novel measures |

## Temporal-integrity caveat

Any indicator that requests higher-timeframe or lower-timeframe data is a **special review area**
for repainting and lookahead. See
[`../pine/MTF_AND_REPAINTING.md`](../pine/MTF_AND_REPAINTING.md),
[`../../checklists/mtf-audit.md`](../../checklists/mtf-audit.md), and
[`../../checklists/repainting-audit.md`](../../checklists/repainting-audit.md). Prefer
confirmed-bar values.

## Extension policy

Add families through the same process as
[`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md#extension-policy). Use `EXP` rather than
mislabeling a novel measure.

## Related documents

- [`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md) · [`STRATEGY_FAMILIES.md`](STRATEGY_FAMILIES.md)
- [`../pine/PINE_PATTERNS.md`](../pine/PINE_PATTERNS.md)
