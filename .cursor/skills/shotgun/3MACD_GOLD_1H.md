# Shotgun focus — 3-MACD Gold (XAU) 1H

**Source of truth (Signum):**
`~/signum-ai-strategy/backtest/engine_repo/strategies/active/GOLD_1H_3MACD_STRATEGY_SPEC.md`
**Production-ready report (Signum, 2026-05-18):**
`~/signum-ai-strategy/backtest/engine_repo/reports/optimization/GOLD_1H_3MACD_PRODUCTION_READY_2026-05-18.md`
**Desk staging:** `~/signum-ai-strategy/docs/DESKS-3MACD-ASSIST-STAGING.md`
**Ingested into QuanTrading for Shotgun:** 2026-07-23
**QuanTrading status:** intake as **QT-R-004** (`EXISTING_STRATEGY`, parked queue per ADR-008).
Shotgun may companion now. Signum backtest claims are **external evidence**, not re-verified here.
Lab improvement requires [`BASELINE.md`](../../../research/strategies/20260723-gold-1h-3macd-confluence/BASELINE.md) freeze first.

---

## One-line pitch

Long-only Gold **1H** trend strategy: three MACDs converge → **T3(10)** confirms entry → **20%** off at **1.5× ATR** → **80%** rides until **T3 turns down** → initial SL **4× ATR**, then BE after partial.

---

## Champion config (v2.2)

| Item | Value |
|---|---|
| Asset / TF | XAU (OANDA-class) / **1H** |
| Direction | **Long-only** (shorts rejected in their research) |
| Flip / paths | Relaxed: Path A + B + 0-Lag lead |
| T3 | Length **10**, factor **0.7** |
| Entry gate | T3 slope bullish |
| Exit | T3 slope bearish (runner) |
| TP1 | **1.5× ATR(14)** — close **20%** |
| SL | **4.0× ATR(14)**; after TP1 → **breakeven** |
| Size | 100% equity, no pyramiding (1 position) |
| Costs (their BT) | 0.06% per side |

---

## Logic — three MACDs

| MACD | Construction | Speed | Role |
|---|---|---|---|
| **0-Lag** | ZLEMA 12/26, signal EMA 9 | Fastest | Lead cross |
| **Standard** | EMA 12/26, signal EMA 9 | Medium | Confirm + HTF/direction gate (MACD > 0) |
| **4C** | EMA 12/26, signal **SMA 9** | Slowest | Trend anchor / zero-line |

Critical: 4C uses **SMA** signal so it is not a clone of Standard.

### Entry paths (any + T3 confirm)

1. **Path A — Simultaneous:** 0-Lag bullish cross **and** Standard bullish cross **and** 4C histogram ≥ 0
2. **Path B — 4C zero:** 4C crosses up through zero **and** 0-Lag gap > 0 **and** Standard gap > 0
3. **Relaxed — 0-Lag lead:** 0-Lag bullish cross **and** Standard gap already > 0

All require HTF/direction gate: Standard MACD > 0 (same TF when HTF = base).

**T3 confirm:** T3(10) rising (current > previous) before entry fires.

### Exits

| Exit | Trigger | Size |
|---|---|---|
| Partial TP | Entry + 1.5× ATR | 20% |
| Runner | T3 turns bearish | Remaining 80% |
| Stop | Entry − 4× ATR (then BE after partial) | Rest / all |

---

## Chart / TV companions (their stack)

- 3-MACD Alert System (sub-panel)
- 3-MACD Signal Overlay v4.5
- T3 Tillson
- ATR(14) in strategy
- Optional visual: EMA 200, VWAP, Stoch RSI (confluence scorer — not core gate)

Pine v2.2 partial-exit port was still **PENDING** in the May 2026 spec — confirm which Pine version is on the owner’s TV before Shotgun loads it.

---

## When NOT to lean on the edge (per their ops notes)

- Major news (FOMC, NFP, CPI) — spread/slippage
- Confirmed range / flat T3 — no trend edge
- No session filter — runs 24/5; London/NY most active

---

## Signum-reported performance (refresh only — not QT-verified)

Period ~Jun 2024–May 2026, 0.06%/side: **268** trades, **+33.52%**, MaxDD **−6.73%**, WR **64.18%**, PF **1.560**.
Their walk-forward: OOS PF **1.628** vs IS **1.457** (they claim not overfit).
Q1 window weak (choppy gold); Dec 2024 onward stronger in their rolling windows.

---

## Shotgun behaviour when this is the focus

1. Assume **1H XAU long-only 3MACD v2.2** rules unless owner overrides.
2. On charts: check path A/B/relaxed + T3 slope + ATR distances; label rule vs discretion.
3. Directed TV: load the named Pine/overlay the owner specifies; alerts map to entry / partial / T3 exit / SL.
4. Do **not** treat Signum “PRODUCTION READY” as QuanTrading release — propose director tasks for QT intake / `QT-S-###` if promoting.
5. Signum desk `desk_3macd` assist/paper is a parallel path — not automatic live.
