# Specification (draft of testable options) — QT-R-001

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Project status: HYPOTHESIS (**options draft**, not an accepted deterministic spec)
- Date created: 2026-07-21
- Last clarified: 2026-07-21
- Source hypothesis: [HYPOTHESIS](HYPOTHESIS.md)
- Architecture: [`../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md)
- Streams: [`../../../docs/research/RESEARCH_STREAMS.md`](../../../docs/research/RESEARCH_STREAMS.md)

> No fixed strategy logic; no performance claimed. Pre-register values in an experiment plan with
> IS/OOS fixed in advance. No Pine / `QT-S-###` until reviewed and human-approved.
> **No repainting or lookahead.**

---

## 0. Distinction map

| Layer | Content | Status |
|---|---|---|
| Fixed global-session architecture | Asia → London → overlap → NY → next Asia; UTC; IANA; London not isolated | Fixed |
| Fixed project inputs | XAUUSD, 15m, focus Asia→London→NY, costs required, no repaint/lookahead | Fixed |
| Open session-window definitions | Exact Asia/London/overlap/NY clocks; Asia **anchor** | Configurable |
| Testable session-transition variables | Asia features; London expand/fail/continue/reverse; NY continue/reverse/overlap | Unvalidated |
| Unsupported assumptions | That any relationship is predictive/profitable | Explicit |
| Evidence still required | Data, TEMPORAL, 6 baselines, costs, OOS, sensitivity | Missing |

---

## A. Fixed global-session architecture

1. Asia · 2. London · 3. London–New York overlap · 4. New York · 5. Transition → next Asia  
UTC internal · IANA `Europe/London`, `America/New_York` · no permanent UTC offsets · Asia anchor
not invented

## B. Fixed project inputs

- XAUUSD · 15m · London breakout as first focal event · Asia preceding context · NY subsequent
  response/management · realistic costs · no repaint/lookahead
- [Question](RESEARCH_QUESTION.md) · [Hypothesis](HYPOTHESIS.md)

---

## C. Open session-window definitions

### C1. Asia market anchor (choose explicitly)

`A-TK` Tokyo · `A-HK` Hong Kong/Singapore · `A-SY` Sydney · `A-CU` custom UTC overnight block

### C2–C6. Windows (examples to span space; all → UTC via IANA where named)

- Asia window for chosen anchor (full block / late-Asia / overnight accumulation)
- Pre-London range: e.g. 05:00–08:00 / 06:00–08:00 / 07:00–08:00 `Europe/London`
- London entry: 08:00–09:00 / 08:00–10:00 / 08:00–11:00 / first N bars after 08:00
- Overlap: derived or explicit
- NY observe/manage: open±N bars / morning block / fuller NY participation block
  (`America/New_York`)
- Next-Asia transition / flat-handover rules
- DST: IANA only; optional GMT/BST and EST/EDT split-sample robustness

---

## D. Open research variables (testable options)

| Area | Options / notes |
|---|---|
| Range definition | High−Low; body vs wick; range÷ATR; bar-count/touches |
| Min/max range size | ATR-normalised thresholds |
| Breakout confirmation | Close beyond boundary **[preferred: integrity]**; buffer; two closes; retest-hold |
| Volatility / momentum / directional filters | ATR percentile; ROC/momentum; Asia or HTF direction (confirmed HTF only) |
| False-breakout controls | Opposite-boundary reclaim; time stop; structure/ATR stop |
| Entry timing | On confirm close; next open; within entry window only |
| Stop architecture | Opposite range edge; m×ATR; fixed distance |
| Exit architecture | R-multiple; ATR/trail; session flat; NY-aware exit |
| Session handover rules | Flat before NY; manage through overlap; flat at NY cutoff; next-Asia handoff |
| Spread / commission / slippage | Conservative + optimistic + sensitivity (gold transitions) |
| Position sizing | Fixed-fractional risk; fixed size; vol-normalised |
| Maximum session risk | Daily loss; one trade/day; no pyramiding default |
| News-event handling | Blackout if data available; else out of scope and stated |
| Baseline definitions | §E (required set) |
| Evidence thresholds | TEMPORAL, BASELINE, IS, OOS, SENSITIVITY, costs, trade count; NULL retained |

### Asia / London / NY candidate features (record; unvalidated)

- Asia: range, high, low, direction, volatility, session close
- London: expansion, continuation, reversal, failed breakout
- Overlap / NY: continuation or reversal of London; overlap behaviour
- Previous-session context; cross-session liquidity/vol transitions

---

## E. Required baselines

1. London breakout **without** Asia context  
2. London breakout **with** Asia context  
3. Comparable breakout **outside** London  
4. New York **continuation** of London direction  
5. New York **reversal** of London direction  
6. Unconditional or **random** session-matched entries  

Session-aware claims require beating (1) after costs and surviving (3)–(6).

---

## F. Execution & temporal integrity

Confirmed-bar decisions · session H/L/close from completed bars · UTC + IANA · stated fill model ·
same-bar stop/target rule · MTF only with confirmed HTF if used · **no repaint/lookahead**

## G. Non-functional

Modular sections (sessions / Asia / London / overlap-NY / risk / costs / diagnostics); bounded
inputs; optional window/range plots.

## H. Unsupported assumptions / evidence still required

Do not treat Asia→London→NY relationships as findings. Evidence still required: multi-year data,
pre-registered windows/anchor, TEMPORAL audit, all six baselines, IS→OOS, ablations, cost
sensitivity, sufficient events, NULL retention.

## I. Approval gate

No experiment execution, Pine, optimization, or strategy ID until **controlled research
specification review** + human approval of a pre-registered experiment plan.
