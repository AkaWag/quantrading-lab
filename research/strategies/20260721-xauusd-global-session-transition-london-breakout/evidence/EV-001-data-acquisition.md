# EV-001 — XAUUSD 15m data acquisition & continuity gate

- Evidence ID: EV-001
- Research ID: QT-R-001
- Type: DATA (precondition for TEMPORAL / BASELINE)
- Date opened: 2026-07-23
- Owner: Aka Wag
- Status: **open — blocking**
- Linked plan: [`../EXPERIMENT_PLAN.md`](../EXPERIMENT_PLAN.md)

## Purpose

Confirm continuous multi-year XAUUSD 15-minute OHLC with reliable UTC timestamps so the
pre-registered IS / VAL / OOS calendars can be applied without silent window shrinkage.

## Required inputs (to record when obtained)

| Field | Value (fill when known) |
|---|---|
| Feed / exchange label | _TBD_ |
| Symbol as stored | _TBD_ (must map to XAUUSD) |
| Bar size | 15m |
| Timestamp convention | UTC (required) |
| First usable bar (UTC) | _TBD_ |
| Last usable bar (UTC) | _TBD_ |
| Storage path / link | _TBD_ (prefer gitignored data path or external store; do not commit secrets) |
| Gaps / holidays policy | _TBD_ |

## Pass criteria

1. Continuous enough history for **IS ≥ 24 months** and **OOS ≥ 12 months** under the plan
   contingency (prefer full calendars: IS 2020–2023, VAL 2024, OOS 2025).
2. UTC timestamps verified; no invented offsets.
3. Feed/exchange label fixed for all subsequent baseline runs.

## Fail / pause criteria

- Cannot meet minimum IS/OOS lengths → **pause** and amend experiment plan (do not silently shrink OOS).
- Timestamps unreliable → do not run baselines.

## Result

_Not yet obtained. No dataset linked in-repo as of 2026-07-23._

## Interpretation

Evidence gathering is authorized but **blocked on data**. No baseline metrics exist.

## Next step

Owner supplies or points to XAUUSD 15m UTC data → complete this record → TEMPORAL audit → B1–B6.
