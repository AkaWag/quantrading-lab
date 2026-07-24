# Baseline freeze — QT-R-002 Gold 4H MACD 4C Signal Squatter

- Research ID: QT-R-002
- Stream: EXISTING_STRATEGY
- Status: **frozen** (2026-07-24); EV-002 **PASS** — short experiment remains blocked by
  `INSUFFICIENT_EVIDENCE`
- Owner: Aka Wag
- Freeze date: 2026-07-24

## Frozen original (pinned)

| Field | Value |
|---|---|
| Signum strategy ID | `Gold_4H_MACD_v20` |
| Pine (QT pin) | [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine) |
| Pine SHA-256 | `2b770e44a82e0a79917db3adaf9f79557be6be77108d20c0e076f69b0e81b0cc` |
| JSON (QT pin) | [`pins/Gold_4H_MACD_v20.json`](pins/Gold_4H_MACD_v20.json) |
| JSON SHA-256 | `2601dc93259832558b0dc46056b2d51871b12122229075a6a55cfb44507b7cb4` |
| Checksums file | [`pins/SHA256SUMS.txt`](pins/SHA256SUMS.txt) |
| Upstream Signum path (at freeze) | `~/signum-ai-strategy/incoming/Backtest_engine_v22.0.0/strategies/production/` |
| Symbol / exchange label | XAUUSD / OANDA (claimed in JSON) |
| Timeframe | 4H |
| Direction | long_only |

## Frozen parameters

| Param | Value |
|---|---|
| fast_length | 18 |
| slow_length | 36 |
| signal_length | 12 |
| trend_ema_length | 300 |
| slope_lookback_bars | 3 |
| atr_pct_max | 2.0 |

## QuanTrading execution declaration (baseline)

These are the assumptions under which QT will attempt reproduce. They may differ from
TradingView defaults; differences must be recorded in the evidence record.

| Field | QT baseline declaration |
|---|---|
| Initial capital | **1,000 USD** (`strategy()` pin and captured Tester capital) |
| Commission | **0.1%** per side — pin and captured TV Properties |
| Slippage | **0 ticks** — pin and captured TV Properties |
| Sizing | `strategy.percent_of_equity`, **100%** — pin and captured TV Properties |
| Pyramiding | **1** — pin and captured TV Properties |
| Fill model | On bar close; default four-ticks-per-bar detalization; requested-price limit execution; one-tick order delay |
| Sample window (Signum/TV JSON claim) | 2013-01-01 → 2026-05-19 (~13.4y) — upstream claim only |
| Sample window (Python claim) | 2023-12-17 → 2026-05-11 (~2.4y) — **not** the freeze target |
| QT reproduce window (pin remit) | **2018-01-01 → 2026-05-19** — Pine `Start Date` default; end = claim end |
| Lab start-date rule | Prefer **1 Jan 2018**; shorten only when data does not reach 2018; record actual |

## Frozen baseline metrics (claims vs QT reproduce)

| Metric | Signum/TV claim (2013 start) | QT reproduce (EV-002 PASS, 2018→2026-05-19) |
|---|---|---|
| Net % | 98.82 | **101.31** |
| Max DD % | −7.93 | **7.98** |
| PF | 3.376 | **3.532** |
| Trades | 41 | **39** |
| WR % | 46.34 | **46.15** (18/39) |
| CAGR % | 5.27 | _not shown on Overview bar_ |

Evidence: [`evidence/EV-002-tv-baseline-reproduce.md`](evidence/EV-002-tv-baseline-reproduce.md).

Python-engine inflated window (PF ~11.3 / 13 trades) is **not** accepted as the frozen baseline.

## Known risks at freeze

- Only 39 trades over the QT 2018→2026 window — sample-size / clustering risk
- EV-002 is **PASS** (correct-window Overview, Properties, and UTC+2 display timezone captured)
- README previously pointed at `engine_repo/strategies/production/`; freeze uses the located
  `incoming/Backtest_engine_v22.0.0/...` paths and local `pins/`

## Rule

No parameter search, indicator “improvement,” or Signum optimisation acceptance until:

1. This freeze remains unchanged, and  
2. A reproduce `evidence/EV-###-*.md` exists under this project.

One change family at a time thereafter, compared to this freeze.

## Next gate

EV-002 is **PASS** on the QT remit window **2018-01-01 → 2026-05-19**. Short-side recovery is
pre-registered but returns `INSUFFICIENT_EVIDENCE` under the locked OOS gate; see
[`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md).
