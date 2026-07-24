# Experiment Plan — QT-R-001 XAUUSD session-aware London breakout

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Date: 2026-07-23
- Status: **accepted** (owner Aka Wag, 2026-07-23) — evidence gathering authorized
- Acceptance: [reviews/2026-07-23-experiment-plan-acceptance.md](reviews/2026-07-23-experiment-plan-acceptance.md)
- Source specification: [SPECIFICATION](SPECIFICATION.md)
- Research review: [reviews/2026-07-23-research-review.md](reviews/2026-07-23-research-review.md)
- Architecture: [`../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md)

> Fixes open variables, baselines, IS/OOS, and costs **before** any optimization or implementation.
> No Pine, no `QT-S-###`, no performance claim. Extends
> [`../../../templates/test-plan.md`](../../../templates/test-plan.md).

---

## 0. Pre-registration lock

Once human-accepted, do **not** change the following without a dated amendment in `reviews/`:

- Asia anchor and primary session windows (§1)
- Six baselines (§2)
- IS / validation / OOS calendars (§4)
- Cost ladder (§3)
- Stop conditions and evidence bar (§7–§8)

Sensitivity neighborhoods (§5) may be explored **only after** the primary locked configuration is scored on IS; OOS remains untouched until primary validation.

---

## 1. Fixed assumptions (held constant across primary runs)

| Item | Locked value |
|---|---|
| Symbol | XAUUSD (Gold); exact feed/exchange label recorded in first evidence record |
| Primary timeframe | 15 minutes |
| Timebase | UTC internal; named windows via IANA only |
| Asia market anchor | **`A-TK` Tokyo** — IANA `Asia/Tokyo` |
| Asia context window | **09:00–15:00 `Asia/Tokyo`** |
| Pre-London range (breakout box) | **06:00–08:00 `Europe/London`** |
| London entry window | **08:00–10:00 `Europe/London`** |
| London diagnostic block | 08:00–16:30 `Europe/London` |
| London–NY overlap | **Derived** in UTC: intersection of London diagnostic block and NY session 08:00–17:00 `America/New_York` |
| NY observe/manage | **08:00–12:00 `America/New_York`** |
| Session flat | **Hard flat by 17:00 `America/New_York`** |
| Next-Asia cycle close | Architectural handoff at next **09:00 `Asia/Tokyo`** (no new entries after NY flat) |
| DST | IANA only (`Europe/London`, `America/New_York`); Tokyo has no DST |
| Bar integrity | Confirmed-bar decisions; session H/L/close from **completed** bars only |
| Lookahead / repaint | Forbidden |
| Pyramiding | Off (max 1 position) |
| Default sizing (primary) | Fixed fractional risk per trade (risk % recorded at run time; same for all baselines) |
| News blackout | Out of scope for v1 (state in every evidence record) |

### Primary logic skeleton (conceptual — not Pine)

Shared across baselines that trade a London breakout:

1. Build pre-London range high/low from completed bars in 06:00–08:00 `Europe/London`.
2. In the London entry window, require **close beyond** range boundary (preferred integrity rule).
3. Entry on confirm close or next open (fix one method before first run; same for all baselines).
4. Stop: opposite range edge (primary); ATR multiple as sensitivity only.
5. Exit: R-multiple and/or session flat at 17:00 `America/New_York` (same exit family across comparable baselines).

Asia-aware variant additionally requires pre-registered Asia filters from the Tokyo context window (range size vs ATR, Asia direction, Asia volatility percentile — exact thresholds fixed in an amendment **before** first Asia-aware IS run, not tuned on OOS).

---

## 2. Required baselines (all six)

Fair comparison: **same** symbol, TF, windows, costs, sizing, fill assumptions, and sample calendars.

| ID | Baseline | Role |
|---|---|---|
| B1 | London breakout **without** Asia context | Primary competitor — session-aware must beat this after costs |
| B2 | London breakout **with** Asia context | Candidate session-aware model |
| B3 | Comparable breakout **outside** London (same range/entry recipe shifted to a non-London block) | Session-specificity control |
| B4 | New York **continuation** of London direction (NY morning observe window) | NY response control |
| B5 | New York **reversal** of London direction (NY morning observe window) | NY response control |
| B6 | Unconditional / **random** session-matched entries (same windows, no breakout rule) | Chance / structure control |

**Claim rule:** session-aware claims require **B2 materially beats B1 after costs** on the balanced scorecard and **survives B3–B6** (not dominated by session-naive, NY-only, or chance controls).

---

## 3. Costs and execution assumptions

Record as assumptions until a named broker quote is attached.

| Scenario | Spread (USD/oz one-way proxy) | Slippage (USD/oz per side) | Commission | Use |
|---|---|---|---|---|
| Optimistic | 0.20 | 0.05 | 0 | Sensitivity floor |
| **Base (primary)** | **0.35** | **0.10** | **0** | **Primary accept/reject** |
| Stress | 0.50 | 0.20 | 0 | Cost-destruction check |

- Fill model: stated per evidence record (default: next-bar open after confirm close, or close fill if and only if documented).
- Same-bar stop/target priority: must be stated before first run.
- Round-turn cost ≈ 2 × (spread proxy + slippage) under this ladder unless commission is later added.

Primary decision uses **Base**. If Base fails but Optimistic passes, treat as **cost-fragile** (do not promote).

---

## 4. In-sample / validation / out-of-sample plan

Calendars are **UTC date boundaries**. OOS stays untouched until primary locked config + Base costs are finalized on IS (and optional validation).

| Split | UTC window | Purpose |
|---|---|---|
| In-sample (IS) | **2020-01-01 → 2023-12-31** | Design / primary scoring / limited sensitivity |
| Validation (VAL) | **2024-01-01 → 2024-12-31** | One-shot check after IS freeze; no retuning |
| Out-of-sample (OOS) | **2025-01-01 → 2025-12-31** | Untouched final holdout for this plan |
| Forward observe (optional) | **2026-01-01 → run date** | Forward note only; not used to accept the hypothesis |

### Contingency if data are shorter

1. Prefer keeping **OOS ≥ 12 months** and **IS ≥ 24 months**.
2. If impossible, **pause** evidence gathering and amend this plan — do not silently shrink OOS to “make it fit.”
3. If data start after 2020-01-01, set IS start to first full month of continuous data and record the amendment.

### Anti-leakage

- No parameter search on VAL or OOS.
- No discarding of losing regimes after seeing OOS.
- Multiple-testing: primary locked config is one family; sensitivity results are exploratory unless pre-registered in a dated amendment.

---

## 5. Sensitivity plan (after IS primary freeze)

Neighborhoods only — not an optimization tournament:

- Pre-London range: 05:00–08:00 and 07:00–08:00 `Europe/London`
- London entry: 08:00–09:00 and 08:00–11:00 `Europe/London`
- Asia anchor swap (exploratory): `A-HK` 09:00–16:00 `Asia/Hong_Kong` (do not replace primary without amendment)
- Range filters: ATR-normalised min/max band ± one step
- Stop: opposite-edge vs 1.0× / 1.5× ATR
- Cost ladder: Optimistic and Stress

**Stability rule:** prefer a stable region over a single optimum. Knife-edge winners invalidate promotion.

---

## 6. Robustness plan (post-primary, still pre-implementation ID)

- DST split-sample: GMT vs BST subsets within London windows (via IANA, not fixed offsets)
- Regime segmentation: vol quartile and trend/range proxy (method fixed before run)
- Trade-count / clustering check (session events are not fully independent)
- Optional walk-forward later — only if primary B2 vs B1 survives Base costs on IS→VAL; new amendment required
- Monte Carlo / shuffle of B6-style entries as stress if tooling available

See [`../../../knowledge/research/ROBUSTNESS_METHODS.md`](../../../knowledge/research/ROBUSTNESS_METHODS.md).

---

## 7. Stop conditions

Halt and return to hypothesis/spec when any of:

1. B2 does **not materially outperform B1** after Base costs on IS (balanced scorecard).
2. Advantage **vanishes** under Stress costs or is only Optimistic-cost.
3. Results depend on a **narrow** parameter island (sensitivity failure).
4. VAL or OOS **materially deteriorates** vs IS.
5. Edge concentrated in a **small number** of trades/days.
6. Drawdown / false-breakout rate operationally unsuitable (thresholds set in first evidence protocol).
7. Temporal-integrity / lookahead issues cannot be resolved.
8. Insufficient independent session events after contingency rules.

Accept path (research-level only): B2 beats B1 after Base costs, survives B3–B6, holds on VAL, then OOS — still **not** a live or production claim; still **no** automatic `QT-S-###`.

---

## 8. Required evidence (minimum bar)

| Evidence type | Requirement |
|---|---|
| TEMPORAL | Confirmed-bar / IANA / no lookahead audit before trusting metrics |
| BASELINE | All six baselines under Base costs on IS |
| IS | Primary locked config scored; sensitivity labeled exploratory |
| VAL | One-shot after IS freeze |
| OOS | Untouched holdout |
| SENSITIVITY | Neighborhoods in §5; stability narrative |
| Costs | Optimistic / Base / Stress table filled with run IDs |
| NULL / FAILURE | Negative outcomes retained as `FAILURE_RECORD`s |

Balanced scorecard (not net profit alone): after-cost expectancy, trade count, max DD / recovery, exposure, turnover, tail risk, vs B1–B6.

---

## 9. Metrics (record per baseline × split × cost scenario)

- Trade count; avg R; expectancy after costs
- Max drawdown; recovery bars/days
- Win rate (secondary only)
- Exposure / time in market
- Profit factor (secondary)
- Tail: worst N days; concentration share of total PnL
- Versus B1 delta on the same metrics

---

## 10. Known limitations

- Single symbol / single TF
- Cost ladder is assumed, not broker-certified
- News not modeled in v1
- Session events cluster (macro days)
- No claim that Tokyo is the only valid Asia anchor — only the pre-registered primary
- Implementation medium (Pine vs external) undecided; this plan does not authorize either

## Next step

Evidence gathering: complete [evidence/EV-001-data-acquisition.md](evidence/EV-001-data-acquisition.md),
then TEMPORAL + B1–B6 under this lock. Record results as evidence / failure artifacts.
**No Pine / `QT-S-###` until a separate implementation approval.**
