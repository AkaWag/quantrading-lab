# Intake — QT-R-003 Gold 1H MACD 4C Signal Squatter

- Research ID: QT-R-003
- Stream: EXISTING_STRATEGY
- Date: 2026-07-23
- Activity: **parked** (WIP)
- ADR: [`../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md`](../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md)

## What exists

Long-only Gold **1H** MACD 4C Signal Squatter v2.1. Signum fleet marks Grade C / paper-only
(marginal edge, negative Sharpe/Sortino claim on TV).

## Declared parameters (from Signum JSON — verify on freeze)

| Param | Value |
|---|---|
| fast / slow / signal | 24 / 36 / 12 |
| osc MA / signal MA | EMA / SMA |
| trend_ema_length | 150 |
| slope_lookback_bars | 10 |
| take_profit_pct | 7.0 |
| stop_loss_pct | 0.0 |
| require_macd_rising_long | true |
| use_trend_filter / exit | true |

## External evidence

- Manifest: net ~6.65%, MaxDD ~−10.8%, PF ~1.15, 58 trades, ~4.4y — **paper only**

## Next step

Remain parked until QT-R-002 baseline path is proven; then either retire, replace with QT-R-004
pathway, or freeze baseline for controlled repair.
