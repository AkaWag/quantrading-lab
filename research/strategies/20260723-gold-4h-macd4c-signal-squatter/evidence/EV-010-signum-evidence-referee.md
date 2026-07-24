# EV-010 — Signum evidence referee (QT-R-002)

- Date: 2026-07-24
- Implementer: Codex
- Required independent referee: Claude/Hermes
- Status: **COMPLETE — INDEPENDENT VERDICT RECORDED**
- Controlling verdict: **INSUFFICIENT_EVIDENCE**

## Material submitted for adversarial review

The scoped Signum bridge received the EV-008 arithmetic, EV-009 inventory and two-trade
diagnostic, and both unexecuted M3 proposals. The request explicitly asks the referee to challenge:

- cost-stress arithmetic and rounding;
- UTC+2-to-UTC conversion and 4H boundary alignment;
- missing-hour aggregation and EMA initialization;
- exact-fill parity versus broader feed/fill equivalence;
- OOS leakage, slope-search risk, and transfer pooling;
- whether each mission is PASS, FAIL, or BLOCKED.

## Implementer disposition submitted

| Mission | Implementer finding |
|---|---|
| M1 | PASS WITH ROUNDING NOTE: all reported counts, partitions, PF, stresses, and failure counts reproduce; final cumulative CSV differs from displayed-row sum by 0.001 USD |
| M2 | PASS for partial two-trade diagnostic parity; BLOCKED for full 2018-2026 feed/ledger reproduction |
| M3 | PASS: separate forward and transfer proposals filed; neither executed |

## Independent Claude/Hermes verdict

| Mission | Verdict | Referee finding |
|---|---|---|
| M1 | **PASS** | Independent clean-interpreter recomputation confirmed counts, partitions, PF, commission stresses, and the 0.001 USD row-rounding explanation. This proves internal ledger consistency, not fill fidelity or an edge. |
| M2 | **BLOCKED** | Exact parity is limited to 2 of 2 known locked-OOS trades in one EDT epoch. Native 4H semantics, EST/EDT boundary transitions, gappy 1H aggregation, tick size, spreads, unrounded sizing, and the 2018-2024 ledger remain unreconciled. It creates zero new observations. |
| M3 | **PASS AS DESIGN** | Forward and transfer proposals preserve the firewall and remain unexecuted. Forward collection must require 20+ sequential, non-pyramided, non-overlapping events and survival at >=0.2% commission per side. Transfer remains Director-gated and quarantined. |

The referee independently inspected the local files and re-ran M1 arithmetic. Codex and the
referee agree on the controlling result.

## Gate protection

- The exact-feed cache reproduces only the two already-known locked-OOS trades.
- It creates no new independent observations.
- No slope value was evaluated.
- No transfer study was run or pooled.
- The dormant performance scorecard was not used.
- No candidate or strategy edge was validated.

The required referee verdict is now recorded. M1-M3 filing is complete, but M2's substantive
full-window blocker and the research verdict remain unchanged.
