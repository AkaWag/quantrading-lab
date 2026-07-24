# Baseline freeze — QT-R-002 Gold 4H MACD 4C Signal Squatter

- Research ID: QT-R-002
- Stream: EXISTING_STRATEGY
- Status: **frozen for reproduce** (2026-07-24) — no optimisation until EV reproduce lands
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
| Initial capital | 100_000 (account currency USD unless TV chart says otherwise) |
| Commission | **0.1%** per side (from Signum JSON `commission_pct`) — verify in TV strategy properties |
| Slippage | **unknown / declare on reproduce** — record exact TV ticks or % used |
| Sizing | percent_of_equity; JSON qty_value 100 — treat as full-equity risk claim; confirm TV order size mode |
| Pyramiding | 0 (assume; confirm in Pine/`strategy()` call on reproduce) |
| Fill model | TradingView strategy tester fills — record version/settings used |
| Sample window (TV claim) | 2013-01-01 → 2026-05-19 (~13.4y) |
| Sample window (Python claim) | 2023-12-17 → 2026-05-11 (~2.4y) — **not** the freeze target |
| Freeze target | **TradingView-source claim window** (longer sample) |

## Frozen baseline metrics (claims vs QT reproduce)

| Metric | Signum/TV claim | QT reproduce |
|---|---|---|
| Net % | 98.82 | _pending_ |
| Max DD % | −7.93 | _pending_ |
| PF | 3.376 | _pending_ |
| Trades | 41 | _pending_ |
| WR % | 46.34 | _pending_ |
| CAGR % | 5.27 | _pending_ |

Python-engine inflated window (PF ~11.3 / 13 trades) is **not** accepted as the frozen baseline.

## Known risks at freeze

- Only 41 trades over ~13y — sample-size / clustering risk
- External claim until TradingView evidence is pasted into an `EVIDENCE_RECORD`
- Commission/slippage must be confirmed on the chart used for reproduce
- README previously pointed at `engine_repo/strategies/production/`; freeze uses the located
  `incoming/Backtest_engine_v22.0.0/...` paths and local `pins/`

## Rule

No parameter search, indicator “improvement,” or Signum optimisation acceptance until:

1. This freeze remains unchanged, and  
2. A reproduce `evidence/EV-###-*.md` exists under this project.

One change family at a time thereafter, compared to this freeze.

## Next gate

Follow [`REPRODUCE.md`](REPRODUCE.md).
