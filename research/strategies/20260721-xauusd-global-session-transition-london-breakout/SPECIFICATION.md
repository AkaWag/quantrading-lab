# Specification (pre-registered windows) — QT-R-001

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Project status: EVIDENCE-GATHERING (**experiment plan accepted 2026-07-23**; not an
  implementation spec; not validated)
- Date created: 2026-07-21
- Last clarified: 2026-07-23
- Source hypothesis: [HYPOTHESIS](HYPOTHESIS.md)
- Experiment plan: [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md)
- Research review: [reviews/2026-07-23-research-review.md](reviews/2026-07-23-research-review.md)
- Architecture: [`../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md)
- Streams: [`../../../docs/research/RESEARCH_STREAMS.md`](../../../docs/research/RESEARCH_STREAMS.md)

> Pre-registers Asia anchor, session clocks, baselines, IS/OOS, and cost ladder.
> No Pine / `QT-S-###` until human approval to implement. **No repainting or lookahead.**
> No performance claimed.

---

## 0. Distinction map

| Layer | Content | Status |
|---|---|---|
| Fixed global-session architecture | Asia → London → overlap → NY → next Asia; UTC; IANA; London not isolated | Fixed (accepted) |
| Fixed project inputs | XAUUSD, 15m, focus Asia→London→NY, costs required, no repaint/lookahead | Fixed |
| Session-window definitions | Exact Asia/London/overlap/NY clocks; Asia **anchor** | **Pre-registered 2026-07-23** |
| Testable session-transition variables | Asia features; London expand/fail/continue/reverse; NY continue/reverse/overlap | Unvalidated |
| Unsupported assumptions | That any relationship is predictive/profitable | Explicit |
| Evidence still required | Data, TEMPORAL, 6 baselines, costs, OOS, sensitivity | Missing |

---

## A. Fixed global-session architecture

1. Asia · 2. London · 3. London–New York overlap · 4. New York · 5. Transition → next Asia
UTC internal · IANA `Europe/London`, `America/New_York`, `Asia/Tokyo` · no permanent UTC offsets

## B. Fixed project inputs

- XAUUSD · 15m · London breakout as first focal event · Asia preceding context · NY subsequent
  response/management · realistic costs · no repaint/lookahead
- [Question](RESEARCH_QUESTION.md) · [Hypothesis](HYPOTHESIS.md) · [Experiment plan](EXPERIMENT_PLAN.md)

---

## C. Pre-registered session-window definitions (2026-07-23)

### C1. Asia market anchor — **chosen**

| Code | Choice |
|---|---|
| **`A-TK`** | **Tokyo — IANA `Asia/Tokyo` (primary)** |

Rejected as primary: `A-HK` (sensitivity only), `A-SY` (earlier open + DST mixing), `A-CU`
(invented UTC block). Rationale:
[reviews/2026-07-23-research-review.md](reviews/2026-07-23-research-review.md).

### C2–C6. Primary windows (locked)

| Window | Locked definition |
|---|---|
| Asia context | **09:00–15:00 `Asia/Tokyo`** |
| Pre-London range (breakout box) | **06:00–08:00 `Europe/London`** |
| London entry | **08:00–10:00 `Europe/London`** |
| London diagnostic block | 08:00–16:30 `Europe/London` |
| Overlap | **Derived** UTC intersection of London diagnostic block and 08:00–17:00 `America/New_York` |
| NY observe/manage | **08:00–12:00 `America/New_York`** |
| Session flat | **Hard flat by 17:00 `America/New_York`** |
| Next-Asia cycle close | Next **09:00 `Asia/Tokyo`** (no new entries after NY flat) |
| DST | IANA only; optional GMT/BST and EST/EDT split-sample robustness |

Sensitivity-only alternates (not primary): pre-London 05:00–08:00 or 07:00–08:00; London entry
08:00–09:00 or 08:00–11:00; exploratory `A-HK` — see experiment plan §5.

---

## D. Open research variables (still parametric within locked windows)

| Area | Options / notes |
|---|---|
| Range definition | High−Low (**primary**); body vs wick / range÷ATR as sensitivity |
| Min/max range size | ATR-normalised thresholds — **fix before first Asia-aware IS run** |
| Breakout confirmation | Close beyond boundary **[preferred: integrity]**; buffer; two closes; retest-hold |
| Volatility / momentum / directional filters | ATR percentile; ROC/momentum; Asia direction (from Tokyo window); confirmed HTF only if used |
| False-breakout controls | Opposite-boundary reclaim; time stop; structure/ATR stop |
| Entry timing | On confirm close **or** next open — **pick one before first run**; same across baselines |
| Stop architecture | Opposite range edge (**primary**); m×ATR sensitivity |
| Exit architecture | R-multiple; ATR/trail; **NY flat 17:00** required |
| Session handover rules | Manage through overlap; hard flat 17:00 NY; next-Asia closes the day cycle |
| Spread / commission / slippage | See experiment plan cost ladder |
| Position sizing | Fixed-fractional risk (**primary**); fixed size / vol-normalised sensitivity |
| Maximum session risk | Daily loss cap; one trade/day; no pyramiding default |
| News-event handling | Out of scope v1 unless calendar linked |
| Baseline definitions | §E (required set) |
| Evidence thresholds | TEMPORAL, BASELINE, IS, VAL, OOS, SENSITIVITY, costs, trade count; NULL retained |

### Asia / London / NY candidate features (record; unvalidated)

- Asia (Tokyo window): range, high, low, direction, volatility, session close
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
Full protocol: [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md).

---

## F. Execution & temporal integrity

Confirmed-bar decisions · session H/L/close from completed bars · UTC + IANA · stated fill model ·
same-bar stop/target rule · MTF only with confirmed HTF if used · **no repaint/lookahead**

## G. Non-functional

Modular sections (sessions / Asia / London / overlap-NY / risk / costs / diagnostics); bounded
inputs; optional window/range plots — **only if/when implementation is separately approved**.

## H. Unsupported assumptions / evidence still required

Do not treat Asia→London→NY relationships as findings. Evidence still required: multi-year data,
TEMPORAL audit, all six baselines, IS→VAL→OOS, ablations, cost sensitivity, sufficient events,
NULL retention.

## I. Approval gate

- Research review (windows + plan): **accepted 2026-07-23** —
  [reviews/2026-07-23-experiment-plan-acceptance.md](reviews/2026-07-23-experiment-plan-acceptance.md).
- Evidence gathering authorized under [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md); blocked on EV-001 data.
- No Pine, optimization, or strategy ID until a **separate** implementation approval
  (still no automatic `QT-S-###`).
