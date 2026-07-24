# Research review — QT-R-001 (2026-07-23)

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Reviewer role: Path A `research-director` (advisory)
- Human owner: Aka Wag (accountable for accept/reject)
- Date: 2026-07-23
- Scope: research review only — Asia anchor, session windows, pre-registered experiment plan
- Explicitly out of scope: Pine, `QT-S-###`, backtest execution, optimization, ADR-006 bridge

## 1. Scope and inputs reviewed

| Input | Path | Outcome |
|---|---|---|
| Research streams | [`docs/research/RESEARCH_STREAMS.md`](../../../../docs/research/RESEARCH_STREAMS.md) | **Accept** as governing (ADR-005) |
| Global session architecture | [`knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md) | **Accept** as structural convention (no empirical claim) |
| Observation → Question → Hypothesis → Spec options | sibling artifacts in this folder | **Accept** chain integrity; hypothesis remains unvalidated |
| Registry row | [`research/registry/RESEARCH_REGISTRY.md`](../../../registry/RESEARCH_REGISTRY.md) | Update after this review |
| Research-quality checklist | [`checklists/research-quality.md`](../../../../checklists/research-quality.md) | Pass at hypothesis stage (falsifiable, null, alternatives, failure conditions) |

## 2. Findings

### Facts

- QT-R-001 is registered `NEW_STRATEGY`, status was `HYPOTHESIS`, evidence stage `none`.
- Architecture sequence Asia → London → overlap → NY → next Asia is a **lab convention**, not a validated edge.
- Spec §C left Asia anchor and exact clocks open; six baselines and cost requirement were already stated.
- No TradingView compile, backtest, or live evidence exists for this project.

### Assumptions (pre-registered by this review)

- **Asia market anchor = `A-TK` (Tokyo)** via IANA `Asia/Tokyo` (no DST).
- Primary session windows locked in [`../SPECIFICATION.md`](../SPECIFICATION.md) §C and [`../EXPERIMENT_PLAN.md`](../EXPERIMENT_PLAN.md).
- Cost ladder (optimistic / base / stress) is an **execution assumption**, not a broker quote.
- IS/OOS calendar windows assume continuous multi-year XAUUSD 15m UTC history; shorten only per the contingency rule in the experiment plan.

### Inferences (not evidence)

- Tokyo is the best **primary** Asia anchor for XAUUSD overnight context among the listed options: liquid Asia OTC/FX reference, clean IANA zone without DST, and a natural gap before London open.
- A separate **pre-London range** (06:00–08:00 `Europe/London`) is a better breakout box than using the full Tokyo block alone as the range to break.

## 3. Decisions (material)

| Decision | Choice | Rejected alternatives |
|---|---|---|
| Asia anchor | **`A-TK` Tokyo** (`Asia/Tokyo`) | `A-HK` (defer sensitivity); `A-SY` (earlier open + DST mixing); `A-CU` (invents a lab default) |
| Asia context window | **09:00–15:00 `Asia/Tokyo`** (full Tokyo block) | Late-Asia-only as primary; overnight custom UTC block as primary |
| Pre-London range | **06:00–08:00 `Europe/London`** | 05:00–08:00 / 07:00–08:00 as primary (kept as sensitivity) |
| London entry | **08:00–10:00 `Europe/London`** | 08:00–09:00 / 08:00–11:00 as primary (sensitivity) |
| Overlap | **Derived:** max(London start, NY start) → min(London end, NY end) in UTC | Fixed UTC offsets |
| NY observe/manage | **08:00–12:00 `America/New_York`** (morning block) | Fuller NY day as primary (sensitivity) |
| Day flat / handover | **Hard flat by 17:00 `America/New_York`** | Flat-before-NY as primary; next-Asia-only flat as primary |
| Status transition | **`HYPOTHESIS` → `EXPERIMENT-PLANNED`** via locked windows + experiment plan (no `QT-S-###`) | Implementation / Pine |

## 4. Blockers and unresolved questions

| Item | Severity | Notes |
|---|---|---|
| Human owner acceptance of this review + experiment plan | **Critical** (gate) | Required before evidence gathering or any Pine |
| Continuous XAUUSD 15m UTC data availability / vendor | Major | Windows contingent; see experiment-plan contingency |
| Realistic gold cost calibration to a named broker | Major | Use ladder until broker-specific quote is recorded |
| News blackout data | Minor | Out of scope for v1 unless a dated news calendar is linked |
| Which feed/exchange label for “XAUUSD” | Major | Must be fixed in first evidence record |

## 5. Recommended next gate

1. Human owner **accepts or revises** [`../EXPERIMENT_PLAN.md`](../EXPERIMENT_PLAN.md) and locked §C windows.
2. Only then: obtain/link multi-year XAUUSD 15m UTC data and begin **evidence gathering** under the pre-registered plan (still no Pine / `QT-S-###` until a later, separate implementation approval).

## 6. Explicitly not verified

- Any Asia→London→NY predictive relationship
- Profitability, expectancy, or robustness
- TradingView compilation or fills
- Broker-true spreads/slippage for any account
- Data continuity across the proposed IS/OOS calendars
- ADR-006 bridge (out of scope; not used)

## Related artifacts

- [`../EXPERIMENT_PLAN.md`](../EXPERIMENT_PLAN.md)
- [`../SPECIFICATION.md`](../SPECIFICATION.md)
- [`../README.md`](../README.md)
