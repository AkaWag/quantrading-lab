# QT-R-001 — XAUUSD Global Session Transition and London Breakout Research

> **Applied `NEW_STRATEGY` research.** Candidate observations and hypotheses require evidence —
> nothing here is validated. No backtest, compilation, profitability, or strategy ID is claimed.
> See [`../../../docs/research/RESEARCH_STREAMS.md`](../../../docs/research/RESEARCH_STREAMS.md) and
> [`../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md).

## Research purpose

Exercise the QuanTrading **NEW_STRATEGY** stream on a real XAUUSD project: whether
**session-transition information** (Asia context → London opportunity → New York response)
improves a London breakout model versus required baselines after realistic costs and risk
controls — without skipping to implementation or optimization.

## Project identity

| Field | Value |
|---|---|
| Research ID | **QT-R-001** |
| Stream | **NEW_STRATEGY** |
| Title | XAUUSD Global Session Transition and London Breakout Research |
| Status | **EVIDENCE-GATHERING** |
| Owner | Aka Wag |
| Category | primary **BREAKOUT**; secondary **SESSION**, **VOL**, **MOMENTUM** |
| Market / TF | XAUUSD (Gold) / 15 minutes |
| Asia anchor | **`A-TK` Tokyo** (`Asia/Tokyo`) — pre-registered 2026-07-23 |
| Strategy ID | not assigned |
| Pine file | none |
| Evidence stage | none (EV-001 data gate open) |
| Validation / release | not started / not applicable |
| Created | 2026-07-21 |
| Experiment plan | **accepted** 2026-07-23 |
| Last research review | 2026-07-23 |
| Registry | [`../../registry/RESEARCH_REGISTRY.md`](../../registry/RESEARCH_REGISTRY.md) |

## Project focus

```text
Asia context → London opportunity → New York response
```

Inside the fixed day sequence: Asia → London → London–NY overlap → New York → next Asia.

## Fixed project inputs

- XAUUSD · 15m primary
- Global-session architecture (London not isolated)
- London breakout as **first focal event**
- Asia as preceding context; New York as subsequent response / management
- Realistic execution-cost requirement
- No repainting or lookahead

## Pre-registered session lock (2026-07-23)

| Window | Value |
|---|---|
| Asia context | 09:00–15:00 `Asia/Tokyo` |
| Pre-London range | 06:00–08:00 `Europe/London` |
| London entry | 08:00–10:00 `Europe/London` |
| NY observe/manage | 08:00–12:00 `America/New_York` |
| Session flat | 17:00 `America/New_York` |

Full detail: [`SPECIFICATION.md`](SPECIFICATION.md) §C · [`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md).

## Artifact chain (stops before implementation)

1. [`OBSERVATION.md`](OBSERVATION.md)
2. [`RESEARCH_QUESTION.md`](RESEARCH_QUESTION.md)
3. [`HYPOTHESIS.md`](HYPOTHESIS.md)
4. [`SPECIFICATION.md`](SPECIFICATION.md)
5. [`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md)
6. Review: [`reviews/2026-07-23-research-review.md`](reviews/2026-07-23-research-review.md)
7. Acceptance: [`reviews/2026-07-23-experiment-plan-acceptance.md`](reviews/2026-07-23-experiment-plan-acceptance.md)
8. Evidence: [`evidence/`](evidence/)

## Governance gate

Experiment plan **accepted**. Evidence gathering only — blocked on
[`evidence/EV-001-data-acquisition.md`](evidence/EV-001-data-acquisition.md).
No Pine, optimization, or `QT-S-###` until a separate implementation approval.
