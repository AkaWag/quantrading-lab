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
| Status | HYPOTHESIS |
| Owner | Aka Wag |
| Category | primary **BREAKOUT**; secondary **SESSION**, **VOL**, **MOMENTUM** |
| Market / TF | XAUUSD (Gold) / 15 minutes |
| Strategy ID | not assigned |
| Pine file | none |
| Evidence stage | none |
| Validation / release | not started / not applicable |
| Created / clarified | 2026-07-21 |
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

## Open research variables (summary)

Asia anchor/window · pre-London range · London entry · NY observe/manage · DST · range definition
· breakout confirmation · min/max range · vol/momentum/directional filters · false-breakout
controls · entry timing · stops/exits · session handover · costs · sizing · session risk · news ·
baselines · evidence thresholds. Full options: [`SPECIFICATION.md`](SPECIFICATION.md).

## Artifact chain (stops before implementation)

1. [`OBSERVATION.md`](OBSERVATION.md)
2. [`RESEARCH_QUESTION.md`](RESEARCH_QUESTION.md)
3. [`HYPOTHESIS.md`](HYPOTHESIS.md)
4. [`SPECIFICATION.md`](SPECIFICATION.md)

## Governance gate

No Pine, backtest, optimization, or `QT-S-###` until research review and explicit human approval.
Next recommended step: **controlled research specification review** (not Pine implementation).
