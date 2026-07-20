# Research Review Process

This governing standard defines how research artifacts and knowledge are reviewed inside the
Knowledge & Research Department. It aligns with the review types in
[`../governance/REVIEW_AND_RELEASE.md`](../governance/REVIEW_AND_RELEASE.md) and the gated
workflow in [`../WORKFLOW.md`](../WORKFLOW.md), and supports
[`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md).

## Principles

- A human owner is accountable for every review decision; AI review is advisory.
- Review checks **integrity of reasoning and evidence**, not profitability.
- Findings are classified by severity; any unresolved **critical** finding blocks promotion,
  consistent with [`../governance/REVIEW_AND_RELEASE.md`](../governance/REVIEW_AND_RELEASE.md).

## Review points

| Transition | What is reviewed | Primary reference / skill |
|---|---|---|
| OBSERVATION → RESEARCH_QUESTION | Is the observation real, scoped, and are alternatives considered? | `market-behavior-researcher` |
| RESEARCH_QUESTION → HYPOTHESIS | Is the question decision-relevant and answerable by a falsifiable test? | `hypothesis-designer` |
| HYPOTHESIS accepted | Falsifiability, invalidation criteria, competing hypotheses | [`../../checklists/research-quality.md`](../../checklists/research-quality.md) |
| SPECIFICATION accepted | Deterministic behavior; costs, session, execution model recorded | [`../governance/ENGINEERING_STANDARDS.md`](../governance/ENGINEERING_STANDARDS.md) |
| EXPERIMENT_PLAN accepted | Baseline defined, IS/OOS split fixed before optimizing, stop conditions | [`../../checklists/backtest-audit.md`](../../checklists/backtest-audit.md) |
| EVIDENCE_RECORD accepted | Method, inputs, limitations, artifact links, reviewer present | [`../governance/RESEARCH_GOVERNANCE.md`](../governance/RESEARCH_GOVERNANCE.md) |
| CLOSEOUT | Supporting vs opposing evidence weighed; lessons promoted | [`KNOWLEDGE_MANAGEMENT.md`](KNOWLEDGE_MANAGEMENT.md) |
| Knowledge promotion | Draft → reviewed → governing gates | [`KNOWLEDGE_MANAGEMENT.md`](KNOWLEDGE_MANAGEMENT.md) |

For temporal, backtest, and robustness reviews of any implemented strategy, the existing
checklists and skills apply unchanged
([`../../checklists/repainting-audit.md`](../../checklists/repainting-audit.md),
[`../../checklists/mtf-audit.md`](../../checklists/mtf-audit.md),
[`../../checklists/backtest-audit.md`](../../checklists/backtest-audit.md)).

## Baseline-before-promotion rule

No project advances to a candidate strategy or promotes a knowledge claim about performance
without a recorded **baseline comparison** (buy-and-hold, a naive rule, or an existing
strategy), per [`../governance/RESEARCH_GOVERNANCE.md`](../governance/RESEARCH_GOVERNANCE.md).
Net profit alone is never sufficient; use a balanced scorecard.

## Severity and returning work

- **Critical** — invalidates the result (e.g. lookahead leak, biased sample, non-falsifiable
  hypothesis). Blocks promotion; returns work to the earliest affected artifact.
- **Major** — materially weakens confidence; must be resolved or explicitly accepted by the
  owner with rationale.
- **Minor** — noted and tracked.

A failed review returns work to the earliest affected stage, consistent with
[`../governance/STRATEGY_LIFECYCLE.md`](../governance/STRATEGY_LIFECYCLE.md).

## Recording reviews

Review outcomes are recorded in the project's `reviews/` folder (created by
[`../../scripts/new-strategy.sh`](../../scripts/new-strategy.sh)) or inline in the relevant
artifact's reviewer field, and referenced from the registry's `last review date` and
`next decision` columns.

## Related documents

- [`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md) · [`RESEARCH_ARTIFACT_MODEL.md`](RESEARCH_ARTIFACT_MODEL.md)
- [`../governance/REVIEW_AND_RELEASE.md`](../governance/REVIEW_AND_RELEASE.md) · [`../WORKFLOW.md`](../WORKFLOW.md)
