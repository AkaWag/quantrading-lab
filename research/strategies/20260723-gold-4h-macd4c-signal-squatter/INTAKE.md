# Intake — QT-R-002 Gold 4H MACD 4C Signal Squatter

- Research ID: QT-R-002
- Stream: EXISTING_STRATEGY
- Date: 2026-07-23
- Classification: existing TradingView/Signum strategy (implementation idea + external evidence)
- ADR: [`../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md`](../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md)

## What exists

Long-only Gold **4H** MACD “4C Signal Squatter” v2.0 in Signum production fleet (Grade A claim).
Pine + JSON parameter pack; TradingView-oriented.

## Declared parameters (from Signum JSON — verify on freeze)

| Param | Value |
|---|---|
| fast / slow / signal | 18 / 36 / 12 |
| trend_ema_length | 300 |
| slope_lookback_bars | 3 |
| atr_pct_max | 2.0 |
| direction | long_only |

## External evidence (links only)

- Production JSON + Pine paths in [`README.md`](README.md)
- Manifest rank 9: net ~98.8%, MaxDD ~−7.9%, PF ~3.38, 41 trades, ~13.4y (TV source claim)

## Known limitations (intake)

- Metrics not yet reproduced inside QuanTrading
- Commission/slippage assumptions must be restated for QT baseline
- Low trade count (41) — sample-size risk
- Improvement work must freeze [`BASELINE.md`](BASELINE.md) first

## Next step

Complete [`BASELINE.md`](BASELINE.md) freeze → copy/pin Pine into QT tree or hash-pin Signum file →
reproduce IS metrics under declared costs → then one-change improvement plan.
