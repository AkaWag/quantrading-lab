# Decision Governance

This document defines how significant decisions are recorded in QuanTrading Lab using
Architecture Decision Records (ADRs). It complements `50-research-governance.mdc` in
[`.cursor/rules/`](../../.cursor/rules/) and the ingestion protocol in
[`../UPDATE-INGESTION.md`](../UPDATE-INGESTION.md).

## Architecture Decision Records

Significant decisions are captured as ADRs stored in [`../../decisions/`](../../decisions/),
created from [`../../templates/ADR.md`](../../templates/ADR.md). ADRs are numbered
sequentially (`ADR-001`, `ADR-002`, ...) and are append-only: superseded decisions are marked
as superseded rather than deleted, so rejected and replaced ideas remain visible and are not
repeatedly reconsidered.

## What requires an ADR

Create an ADR for decisions that are significant and not easily reversible, including:

- changes to repository structure, workflow, or governance;
- adoption or removal of tools, MCP servers, dependencies, or services;
- changes to platform/architecture direction (for example V2.5 → V3 steps, see
  [`../architecture/V2_5_TO_V3_ROADMAP.md`](../architecture/V2_5_TO_V3_ROADMAP.md));
- changes to trust boundaries, access model, or secret handling
  ([`../architecture/SYSTEM_BOUNDARIES.md`](../architecture/SYSTEM_BOUNDARIES.md));
- accepting a platform-level change proposed through update ingestion.

Routine, reversible, strategy-local choices do not need an ADR; record them in the strategy's
change log instead. Strategy-specific material must not silently alter global rules.

## Required ADR content

Each ADR must contain (see [`../../templates/ADR.md`](../../templates/ADR.md)):

- **Context** — the problem, forces, and constraints.
- **Alternatives considered** — realistic options and why they were not chosen.
- **Decision** — what was decided.
- **Consequences** — resulting effects, positive and negative.
- **Risks** — what could go wrong and how it is mitigated.
- **Rollback considerations** — how the decision could be reversed and at what cost.

## No silent architectural change

Architectural and governance changes must not be introduced silently. They require a proposal,
review, and a recorded ADR before or at the time of the change, consistent with the
"controlled change" principle in [`QUANTRADING_CHARTER.md`](QUANTRADING_CHARTER.md) and the
human-approval gate in [`AI_OPERATING_PRINCIPLES.md`](AI_OPERATING_PRINCIPLES.md).

## Related documents

- [`QUANTRADING_CHARTER.md`](QUANTRADING_CHARTER.md)
- [`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md)
- [`../architecture/SYSTEM_BOUNDARIES.md`](../architecture/SYSTEM_BOUNDARIES.md)
