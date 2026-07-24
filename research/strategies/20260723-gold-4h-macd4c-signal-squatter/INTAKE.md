# Intake — QT-R-002 Gold 4H MACD 4C Signal Squatter

- Research ID: QT-R-002
- Stream: EXISTING_STRATEGY
- Date: 2026-07-23
- Classification: existing TradingView/Signum strategy (implementation idea + external evidence)
- ADR: [`../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md`](../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md)

## What exists

Original Signum intake is a long-only Gold **4H** MACD “4C Signal Squatter” v2.0 (Grade A claim).
Pine + JSON parameter pack; TradingView-oriented. **Owner requirement added 2026-07-24:** the
target improved strategy must support shorts. Long-only remains the frozen comparison control.

## Declared parameters (from Signum JSON — verify on freeze)

| Param | Value |
|---|---|
| fast / slow / signal | 18 / 36 / 12 |
| trend_ema_length | 300 |
| slope_lookback_bars | 3 |
| atr_pct_max | 2.0 |
| direction | long_only |

Target requirement: `long_and_short`; this is not retroactively substituted into the frozen
original.

## External evidence (links only)

- Production JSON + Pine paths in [`README.md`](README.md)
- Manifest rank 9: net ~98.8%, MaxDD ~−7.9%, PF ~3.38, 41 trades, ~13.4y (TV source claim)

## Known limitations (intake)

- EV-002 **PASS** — correct QT window, Properties, and UTC+2 display timezone captured
- Low baseline trade count (39) and short-only trade count (17) — severe sample-size risk
- Short-family promotion blocked by a two-trade OOS segment and failed commission stress

## Next step

**Done:** [`BASELINE.md`](BASELINE.md) freeze + local [`pins/`](pins/); EV-002 **PASS** for
**2018-01-01 → 2026-05-19**
([`evidence/EV-002-tv-baseline-reproduce.md`](evidence/EV-002-tv-baseline-reproduce.md)).
**Now (Director):** retain the pre-registered short-regime family and the
`INSUFFICIENT_EVIDENCE` result in [`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md). Do not select a
slope value until a defensible chronological OOS sample exists.
