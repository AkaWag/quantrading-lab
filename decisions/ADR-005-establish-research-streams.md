# ADR-005: Establish research-stream architecture

- Status: accepted
- Date: 2026-07-21
- Owners: Aka Wag

## Context

The Knowledge & Research Department (ADR-002) defined a single research entry path, but work
arrives in different forms: new hypotheses, revisions of existing strategies, locked TradingView
(“black box”) strategies, and independent validation. Treating all of these as the same
observation→implementation process risks baseline loss, false “replications,” and non-independent
validation.

## Decision

Adopt four coordinated **research streams**, documented in
[`../docs/research/RESEARCH_STREAMS.md`](../docs/research/RESEARCH_STREAMS.md):

1. `NEW_STRATEGY`
2. `EXISTING_STRATEGY`
3. `BLACK_BOX_STRATEGY`
4. `VALIDATION`

Rules:

- Continue a **single** research-ID series (`QT-R-###`) and strategy-ID series (`QT-S-###`).
- Require a **Stream** field on the research registry and relevant templates.
- Keep strategy IDs **stable** across revisions; change **semantic versions**.
- Require frozen baselines and one-change-at-a-time comparisons for `EXISTING_STRATEGY`.
- Require observable capture and uncertainty declaration for `BLACK_BOX_STRATEGY`.
- Prefer independence for `VALIDATION`.
- Adopt a starting WIP guideline: one active new, one active existing, one active validation.

## Alternatives considered

- **Single undifferentiated workflow.** Rejected: conflates discovery with revision and validation.
- **Separate ID series per stream.** Rejected: fragments registries; unnecessary complexity.
- **No WIP guideline.** Rejected: invites parallel overload without ownership.

## Consequences

- Positive: clear process separation; better baseline discipline; explicit black-box uncertainty.
- Cost: registry/template fields and stream-aware reviews; owners must classify work correctly.

## Risks

- Misclassification (e.g. editing existing Pine as NEW_STRATEGY) → mitigated by registry Stream
  field and EXISTING_STRATEGY checklist.
- WIP guideline treated as hard code → documented as a starting governance limit only.

## Rollback plan

Revert ADR-005 and `RESEARCH_STREAMS.md`, remove Stream columns/fields, and restore prior
registry schema via git. Historical QT-R / QT-S IDs remain valid.
