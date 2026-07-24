# QT-R-002 — Gold 4H MACD 4C Signal Squatter (EXISTING)

> **EXISTING_STRATEGY** intake from Signum / TradingView fleet. External metrics are claims until
> reproduced under QuanTrading evidence. No `QT-S-###` yet.

| Field | Value |
|---|---|
| Research ID | **QT-R-002** |
| Stream | **EXISTING_STRATEGY** |
| Status | **EXPERIMENT-PLANNED** — EV-002 PASS; short recovery `INSUFFICIENT_EVIDENCE` |
| Signum ID | `Gold_4H_MACD_v20` |
| Symbol / TF | XAUUSD / **4H** |
| Direction | Frozen original long-only; target requires long + short |
| Fleet grade (Signum) | A (external) |
| Strategy ID | not assigned |
| Owner | Aka Wag |

## Artifacts

1. [`INTAKE.md`](INTAKE.md)
2. [`BASELINE.md`](BASELINE.md) — frozen 2026-07-24
3. [`pins/`](pins/) — Pine + JSON + SHA256SUMS
4. [`REPRODUCE.md`](REPRODUCE.md) — TV checklist → EV-002
5. [`evidence/EV-002-tv-baseline-reproduce.md`](evidence/EV-002-tv-baseline-reproduce.md) — **PASS**
6. [`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md) — locked short-regime family
7. [`evidence/EV-007-short-validation-gate.md`](evidence/EV-007-short-validation-gate.md) —
   `INSUFFICIENT_EVIDENCE`; no parameter selected
8. [`PILOT_SIGNUM_EXTERNAL.md`](PILOT_SIGNUM_EXTERNAL.md) — evidence-expansion handover; owner
   start required

## Source pins

Local (authoritative for QT):

- [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine)
- [`pins/Gold_4H_MACD_v20.json`](pins/Gold_4H_MACD_v20.json)
- [`pins/SHA256SUMS.txt`](pins/SHA256SUMS.txt)

Upstream Signum (origin):

- `~/signum-ai-strategy/incoming/Backtest_engine_v22.0.0/strategies/production/` (or engine_repo production)
- Fleet: `~/signum-ai-strategy/docs/FLEET_REGISTER.md`
