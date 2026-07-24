# One-family improvement options — QT-R-002 (planning only)

Status: **DRAFT — do not execute until EV-002 PASS**.

Constraint: after reproduce, change **one family at a time**. No multi-knob optimise.

## Candidate families (pick one first)

1. **Trend filter** — `trend_ema_length` / slope lookback only  
   Hypothesis: fewer chop entries; trade count may drop further (already low ~41).
2. **Volatility gate** — `atr_pct_max` only  
   Hypothesis: skip high-ATR regimes that inflate adverse excursions.
3. **MACD geometry** — keep 18/36/12 frozen; only signal-cross confirmation rules  
   Hypothesis: reduce false crosses without retuning periods (periods = second family).
4. **Session / clock filter** — if Pine exposes session inputs  
   Hypothesis: Gold 4H may have London/NY quality differences; must not leak lookahead.
5. **Risk exits** — stop/trail family only (if present in Pine)  
   Hypothesis: MaxDD claim is already tight; exits may dominate PF more than entries.

## Ranking heuristic (after EV-002)

Prefer the family that:

- touches the largest known failure mode from reproduce notes, and
- changes the fewest free parameters, and
- keeps trade count interpretable (avoid going to &lt;20 trades without disclosure).

## Explicitly deferred

- Grid / Signum sweep of many MACD lengths  
- Simultaneous filter + exit changes  
- Assigning `QT-S-###` or “production” language  

## Owner decision needed after EV-002

Which single family to open as the first controlled experiment.
