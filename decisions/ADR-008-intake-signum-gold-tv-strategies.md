# ADR-008: Intake Signum TradingView gold strategies into QuanTrading streams

- Status: accepted
- Date: 2026-07-23
- Owner: Aka Wag

## Context

Signum holds multiple **TradingView-oriented gold strategies** (MACD 4C Signal Squatter fleet
entries, 3-MACD confluence, sweeps/reports) that are already under backtest/optimisation and, in
places, trading/ops staging. QuanTrading Lab was built so that strategy work enters a **structured
research stream**, freezes baselines, and only then improves via gated evidence — not as an
orphan parallel to Signum.

QT-R-001 (session London breakout) remains a separate `NEW_STRATEGY` research stream. It does
**not** replace intake of these existing gold/TV strategies.

## Decision

1. **Bring all identified Signum gold/TV strategy families into QuanTrading** as
   `EXISTING_STRATEGY` research projects (stable `QT-R-###`), with source paths, frozen-baseline
   requirements, and linked Signum evidence — before further optimisation is treated as lab truth.
2. **Do not assign `QT-S-###` until** a candidate implementation is under QuanTrading control
   (copied/pinned Pine + declared execution assumptions) and the EXISTING_STRATEGY baseline gate
   is met.
3. **Respect WIP:** prefer **one active** `EXISTING_STRATEGY` at a time; register others as
   **parked/queued** with clear next decisions.
4. **Signum remains** the external Agent Live / desk compute path (ADR-007); QuanTrading remains
   the governance, evidence, and improvement apparatus. Accepted improvements land in GitHub.
5. **Shotgun** may companion on any gold focus from ground zero; research promotion still follows
   stream gates.

## Initial register (this ADR)

| Research ID | Stream | Focus | Initial activity |
|---|---|---|---|
| QT-R-002 | EXISTING_STRATEGY | Gold 4H MACD 4C Signal Squatter (`Gold_4H_MACD_v20`) | **Active** intake / baseline freeze |
| QT-R-003 | EXISTING_STRATEGY | Gold 1H MACD 4C Signal Squatter (`Gold_1H_MACD_v21`) | Parked (fleet Grade C / paper-only) |
| QT-R-004 | EXISTING_STRATEGY | Gold 1H 3-MACD Confluence v2.2 | Parked queue (Shotgun focus; high priority after R-002 baseline) |

QT-R-001 stays `NEW_STRATEGY` (session research) — parallel, not a substitute.

## Alternatives considered

- Leave gold strategies only in Signum — rejected: defeats the purpose of the QuanTrading apparatus.
- Force all into QT-R-001 — rejected: different hypothesis (session breakout vs MACD families).
- Assign `QT-S-###` immediately — rejected: no QT-controlled baseline/reproduce yet.
- Run all EXISTING projects active at once — rejected: WIP guideline; park with visibility.

## Consequences

- Positive: gold/TV work enters falsifiable improvement loops (baseline → one change → compare).
- Positive: Shotgun + Signum + director have named research IDs to attach feedback to.
- Cost: duplication of pointers until Pine/specs are copied or submodule-linked into QT.
- Limitation: Signum “production ready” / fleet grades are **external claims** until QT evidence
  records reproduce them under declared assumptions.

## Verification

- Registry rows exist for QT-R-002..004; each has a project folder with intake + baseline stub.
- PROJECT_STATUS / NEXT_ACTIONS name the active EXISTING project and parked queue.
- No live-trading authorization implied.

## Rollback

Supersede this ADR; park or close QT-R-002..004 without deleting historical intake rows.
