# Observation — XAUUSD global session transitions and London expansion (QT-R-001)

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Project status: HYPOTHESIS
- Date created: 2026-07-21
- Last clarified: 2026-07-23
- Related: XAUUSD (Gold), 15-minute; Asia → London → overlap → New York → next Asia
- Asia anchor (pre-registered): `A-TK` Tokyo — see [SPECIFICATION](SPECIFICATION.md) §C

> **Unvalidated candidate observation.** Level-1 draft note. No empirical test performed.

## Fixed global-session architecture

```text
1. Asia
2. London
3. London–New York overlap
4. New York
5. Transition into the next Asia session
```

London is **not** an isolated session. Convention:
[`../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md).

## What was observed (candidate)

XAUUSD may establish measurable **range, direction, and volatility** during **Asia**. **London**
participation may then produce **directional expansion, continuation, reversal, or failed
breakouts**. **New York** participation (including the **London–New York overlap**) may
**continue, reverse, or otherwise alter** the London move. The handoff into the **next Asia**
session closes the day cycle.

Whether Asia structure **informs** London opportunities, and whether New York **supports**
management decisions, is what must be tested — **not assumed**.

## Where and when

- Market: **XAUUSD (Gold)** · Primary TF: **15 minutes**
- Time: **UTC** internal; IANA `Asia/Tokyo`, `Europe/London`, `America/New_York`
- Focus: Asia context → London opportunity → New York response
- Focal event: **London breakout / expansion** (first research focus)

Exact windows are **pre-registered** ([`SPECIFICATION.md`](SPECIFICATION.md) §C;
[`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md)). Relationships remain unvalidated.

## Why it may matter

If session transitions are informative, a session-aware model could improve identification and
management of London directional moves versus London-only — after costs. Tags: **BREAKOUT**,
**SESSION**, **VOL**, **MOMENTUM**.

## Alternative explanations

- Symmetric London volatility (no directional edge)
- Asia structure is noise relative to London alone
- New York / overlap only injects news noise
- Cost illusion at transitions
- Regime / outlier concentration

## Evidence currently available

EVIDENCE NOT YET AVAILABLE.

## Confidence level

**Low** — structural conjecture; untested.

## Unsupported assumptions

- That Asia→London→NY relationships are predictive
- That `A-TK` is empirically best (it is a pre-registered primary, not a finding)
- Fixed UTC offsets for London/NY
- After-cost expectancy

## Evidence still required

Multi-year XAUUSD 15m UTC data · TEMPORAL audit · six baselines under Base costs · IS→VAL→OOS ·
sensitivity · NULL retention

## Next step

Human accept/revise [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md) → evidence gathering (no Pine yet).
