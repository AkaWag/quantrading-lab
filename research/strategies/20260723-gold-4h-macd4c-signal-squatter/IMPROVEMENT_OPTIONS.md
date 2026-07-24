# One-family improvement options — QT-R-002 (planning only)

Status: **DRAFT — do not execute until EV-002 PASS**.

Constraint: after reproduce, change **one family at a time**. No multi-knob optimise.

## Candidate families (pick one first)

1. **Short-side design — OWNER-SELECTED FIRST FAMILY (2026-07-24)**
   Requirement: the target strategy must trade shorts. Freeze all long-side logic while isolating
   short-only entry, trend/regime filter, exit, and sizing behavior. The preliminary short-enabled
   run is recorded in [`evidence/EV-003-short-enabled-observation.md`](evidence/EV-003-short-enabled-observation.md).
   Do not tune multiple short subfamilies in one run; trade-level diagnosis selects the first
   short-side hypothesis.
2. **Trend filter** — `trend_ema_length` / slope lookback only
   Hypothesis: fewer chop entries; trade count may drop further (already low ~41).
3. **Volatility gate implementation** — ATR percentage logic is **not present in the Pine**
   Hypothesis: skip high-ATR regimes that inflate adverse excursions. This requires a
   specification amendment, new Pine version, compile evidence, and temporal audit; the upstream
   Python/JSON `atr_pct_max` is not a tunable Pine input.
4. **MACD geometry** — keep 18/36/12 frozen; only signal-cross confirmation rules
   Hypothesis: reduce false crosses without retuning periods (periods = second family).
5. **Session / clock filter implementation** — no session input exists in the Pine
   Hypothesis: Gold 4H may have London/NY quality differences. Requires specification, new Pine
   version, IANA timezone/session definition, compile evidence, and temporal audit.
6. **Risk exits** — fixed TP/SL family only after semantic correction
   Hypothesis: exits may reduce giveback or adverse excursion. Current optional TP/SL tick
   distances are recalculated from `close`, not fixed explicitly from entry as the tooltips state;
   do not optimize them in their current form.

## Ranking heuristic (after EV-002)

Prefer the family that:

- touches the largest known failure mode from reproduce notes, and
- changes the fewest free parameters, and
- keeps trade count interpretable (avoid going to &lt;20 trades without disclosure).

## Explicitly deferred

- Grid / Signum sweep of many MACD lengths  
- Simultaneous filter + exit changes  
- Assigning `QT-S-###` or “production” language  

## Owner decision

**Decided 2026-07-24:** shorts are required. The first family is a short-specific bearish-regime
filter using one slope degree of freedom. It is pre-registered but not validated or selected:
the locked OOS has only two trades and the result is `INSUFFICIENT_EVIDENCE`.

Decision input: [`PRE_OPTIMIZATION_AUDIT.md`](PRE_OPTIMIZATION_AUDIT.md),
[`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md), and EV-004–007. Do not choose from Overview net
profit alone.
