# QT-R-002 — Gold 4H MACD 4C Signal Squatter (EXISTING)

> **EXISTING_STRATEGY** intake from Signum / TradingView fleet. External metrics are claims until
> reproduced under QuanTrading evidence. No `QT-S-###` yet.

| Field | Value |
|---|---|
| Research ID | **QT-R-002** |
| Stream | **EXISTING_STRATEGY** |
| Status | **BASELINE FROZEN** — awaiting TV reproduce (EV-002) |
| Signum ID | `Gold_4H_MACD_v20` |
| Symbol / TF | XAUUSD / **4H** |
| Direction | Long-only |
| Fleet grade (Signum) | A (external) |
| Strategy ID | not assigned |
| Owner | Aka Wag |

## Artifacts

1. [`INTAKE.md`](INTAKE.md)
2. [`BASELINE.md`](BASELINE.md) — frozen 2026-07-24
3. [`pins/`](pins/) — Pine + JSON + SHA256SUMS
4. [`REPRODUCE.md`](REPRODUCE.md) — TV checklist → EV-002
5. Next (blocked on you): TradingView reproduce → fill QT column in BASELINE

## Source pins

Local (authoritative for QT):

- [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine)
- [`pins/Gold_4H_MACD_v20.json`](pins/Gold_4H_MACD_v20.json)
- [`pins/SHA256SUMS.txt`](pins/SHA256SUMS.txt)

Upstream Signum (origin):

- `~/signum-ai-strategy/incoming/Backtest_engine_v22.0.0/strategies/production/` (or engine_repo production)
- Fleet: `~/signum-ai-strategy/docs/FLEET_REGISTER.md`
