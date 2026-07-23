# Experiment-plan acceptance — QT-R-001 (2026-07-23)

- Research ID: QT-R-001
- Decision: **ACCEPT** pre-registered experiment plan (no revisions)
- Owner: Aka Wag
- Date: 2026-07-23
- Channel: Cursor Path A director chat (human acceptance)

## Accepted artifacts

- [`../EXPERIMENT_PLAN.md`](../EXPERIMENT_PLAN.md) — as written 2026-07-23
- Locked windows / `A-TK` in [`../SPECIFICATION.md`](../SPECIFICATION.md) §C
- Research review: [`2026-07-23-research-review.md`](2026-07-23-research-review.md)

## Consequences

1. Pre-registration lock is **in force** (amendments require a dated `reviews/` note).
2. Project status → **`EVIDENCE-GATHERING`**.
3. Next work is **evidence gathering only** — no Pine, no `QT-S-###`, no optimization, no ADR-006 bridge work.
4. GitHub handoff: commit local artifacts; **`git push` only with separate human approval**.

## First evidence gate

Obtain or link continuous multi-year **XAUUSD 15m UTC** OHLC; record feed/exchange label in the first
`EVIDENCE_RECORD`. Until data exists, baselines B1–B6 cannot run.
