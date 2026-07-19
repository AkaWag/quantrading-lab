# Review and Release

This document defines the review types, release gating, versioning, and rollback expectations
for QuanTrading Lab. It aligns with the gate table in [`../WORKFLOW.md`](../WORKFLOW.md), the
lifecycle in [`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md), and the release checklist in
[`../../checklists/release-checklist.md`](../../checklists/release-checklist.md).

## Review types

| Review | Focus | Primary reference |
|---|---|---|
| Architecture | System/structure changes, boundaries, ADR need | [`DECISION_GOVERNANCE.md`](DECISION_GOVERNANCE.md) |
| Pine | Syntax, semantics, structure, maintainability | [`ENGINEERING_STANDARDS.md`](ENGINEERING_STANDARDS.md) |
| Repaint / temporal | Repainting, lookahead, HTF timing | [`../../checklists/repainting-audit.md`](../../checklists/repainting-audit.md) |
| Backtest | Cost, sizing, session, fill, window integrity | [`../../checklists/backtest-audit.md`](../../checklists/backtest-audit.md) |
| Risk | Sizing, stops, exits, exposure, containment | [`../../templates/risk-spec.md`](../../templates/risk-spec.md) |
| Robustness | Sensitivity, walk-forward, regime, stress | [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md) |
| Release | All mandatory gates satisfied | [`../../checklists/release-checklist.md`](../../checklists/release-checklist.md) |

## Blocking findings

- Findings are classified by severity (for example critical / major / minor).
- **Any unresolved critical finding blocks release.** It must be fixed, or explicitly accepted
  and recorded by a human owner with rationale, before promotion to APPROVED.
- A failed review returns work to the earliest affected stage
  ([`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md)).

## Versioning

Use semantic versioning (`MAJOR.MINOR.PATCH`) for strategies and tooling:

- **MAJOR** — behavior-changing logic, incompatible parameter/interface changes, or a new
  hypothesis basis.
- **MINOR** — additive, backward-compatible changes (new optional inputs, added diagnostics).
- **PATCH** — fixes and clarifications with no intended behavioral change.

Record the version in the script header and the change log. The workspace itself is versioned
via the root [`../../VERSION`](../../VERSION) file (currently the V2.5 line).

## Release notes and rollback

- Every release records: version, date, summary of changes, evidence package reference, known
  limitations, and the reviews performed. Use
  [`../../templates/release-record.md`](../../templates/release-record.md).
- Each release must define a **rollback expectation**: the previous known-good version and how
  to revert to it. Never modify a published release in place; create a new version
  (per `60-repository-hygiene.mdc`).
- Store release artifacts under [`../../releases/`](../../releases/); use
  [`../../scripts/package-release.sh`](../../scripts/package-release.sh) where applicable.

## Production approval is a governance state

Recording APPROVED means the required reviews and controls are satisfied and a human accepted
the decision. It is **not** a claim of future profitability and does not by itself enable live
trading. Live deployment remains blocked until explicit human approval and paper/forward-test
evidence exist (per `40-risk-and-deployment.mdc`).

## Related documents

- [`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md)
- [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md)
- [`DECISION_GOVERNANCE.md`](DECISION_GOVERNANCE.md)
