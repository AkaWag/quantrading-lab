# Research Question — XAUUSD session-aware London breakout (QT-R-001)

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Project status: HYPOTHESIS
- Date created: 2026-07-21
- Last clarified: 2026-07-21
- Source observation: [OBSERVATION](OBSERVATION.md)

## Precise question

Does market structure established during the **Asia** session provide useful information for
**identifying and managing XAUUSD directional breakouts during London**, and does subsequent
**New York** behaviour support **continuation, reversal, or session-specific exit decisions**
**after realistic costs and risk controls**?

## Scope

- XAUUSD, 15m primary
- Architecture: Asia → London → overlap → New York → next Asia
- Focal: London opportunity; Asia context; New York response
- Multi-year, DST via IANA; IS/OOS fixed before any optimization

## Exclusions

- Other symbols; isolated London-as-architecture (London-only is a **baseline**)
- Sub-15m HFT; claiming session relationships without linked evidence
- Optimization before pre-registered experiment plan

## Decision supported

Whether to advance a **session-aware** London-breakout concept toward specification/implementation
(`QT-S-###` later), or reject/park — including where London-only is as good as session-aware.
Negative results retained.

## Data required

XAUUSD 15m OHLC with reliable UTC · configurable Asia/London/NY/overlap mapping via IANA ·
realistic gold costs around transitions · enough independent session events

## Cannot answer when

Unreliable timestamps · undefined Asia anchor · unmodelable costs · too few events · unresolved
temporal integrity

## Next step

[HYPOTHESIS](HYPOTHESIS.md) · [SPECIFICATION](SPECIFICATION.md)
