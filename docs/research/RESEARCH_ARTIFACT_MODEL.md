# Research Artifact Model

This governing standard defines the artifacts a research project produces, their order, and how
they map to the existing gated workflow and templates. It supports
[`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md).

## The chain

```text
OBSERVATION → RESEARCH_QUESTION → HYPOTHESIS → SPECIFICATION
→ EXPERIMENT_PLAN → EVIDENCE_RECORD(s) [+ FAILURE_RECORD(s)] → RESEARCH_CLOSEOUT
```

Each artifact links to the previous one. Nothing skips ahead: a hypothesis without a recorded
research question, or a specification without a falsifiable hypothesis, is incomplete and must
not proceed.

## How an observation becomes a hypothesis

1. **Observation** ([`../../research/templates/OBSERVATION.md`](../../research/templates/OBSERVATION.md)) —
   capture what was seen, where/when, why it may matter, alternative explanations, available
   evidence, and a confidence level. Observations are Level-1 draft notes.
2. **Research question** ([`../../research/templates/RESEARCH_QUESTION.md`](../../research/templates/RESEARCH_QUESTION.md)) —
   sharpen the observation into a precise, scoped question and state the decision it will
   support. Filter out questions that cannot lead to a falsifiable test.
3. **Hypothesis** ([`../../research/templates/HYPOTHESIS.md`](../../research/templates/HYPOTHESIS.md)) —
   convert the question into a falsifiable statement with a market mechanism, preconditions,
   expected behavior, explicit invalidation criteria, and competing hypotheses. Use the
   `market-behavior-researcher` and `hypothesis-designer` skills.

Only after a falsifiable hypothesis exists may specification and experimentation begin.

## Mapping to the existing gated workflow and templates

The department's research-lifecycle templates (`research/templates/`, UPPER_SNAKE_CASE) sit
**in front of and alongside** the existing strategy-build templates (`templates/`, lowercase)
referenced by [`../WORKFLOW.md`](../WORKFLOW.md) and
[`../../scripts/new-strategy.sh`](../../scripts/new-strategy.sh). They are complementary, not
duplicates:

| Department artifact | In-project filename | Gated-workflow gate | Existing template it feeds/extends |
|---|---|---|---|
| OBSERVATION | `OBSERVATION.md` | (pre-Intake) | — |
| RESEARCH_QUESTION | `RESEARCH_QUESTION.md` | (pre-Intake) | — |
| — (intake/sourcing) | `INTAKE.md` | Intake | [`../../templates/research-intake.md`](../../templates/research-intake.md) |
| HYPOTHESIS | `HYPOTHESIS.md` | Hypothesis | [`../../templates/hypothesis.md`](../../templates/hypothesis.md) |
| SPECIFICATION | `SPEC.md` | Specification | [`../../templates/strategy-spec.md`](../../templates/strategy-spec.md) |
| — (risk) | `RISK.md` | Risk pre-review | [`../../templates/risk-spec.md`](../../templates/risk-spec.md) |
| EXPERIMENT_PLAN | `EXPERIMENT-PLAN.md` | (spans Backtest/Robustness) | [`../../templates/test-plan.md`](../../templates/test-plan.md) |
| EVIDENCE_RECORD | `evidence/EV-###-*.md` | Compile/Temporal/Backtest/Robustness | — |
| FAILURE_RECORD | `evidence/FAIL-###-*.md` | any | — |
| RESEARCH_CLOSEOUT | `CLOSEOUT.md` | Release / archive | [`../../templates/release-record.md`](../../templates/release-record.md) |

**Conflict avoidance:** the existing lowercase `templates/` remain the canonical build artifacts
the workflow scripts copy. The department templates are the richer research-phase companions.
Where both exist for the same concept (e.g. hypothesis), the department template is a superset
and explicitly cross-references the existing one; neither silently overrides the other.

## Evidence must be linked, not summarized

Every claim in a closeout or knowledge document must point to an `EVIDENCE_RECORD` (or external
artifact) by path/ID. A summary sentence without a link is not evidence. Evidence records
themselves capture method, inputs, tool/environment, date, result, interpretation, limitations,
artifact links, and reviewer.

## Retention

Failure and negative results use `FAILURE_RECORD` and remain in the project's `evidence/` folder
permanently. Closeout summarizes both supporting and opposing evidence. Nothing is deleted.

## Related documents

- [`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md) · [`RESEARCH_REVIEW_PROCESS.md`](RESEARCH_REVIEW_PROCESS.md)
- [`../WORKFLOW.md`](../WORKFLOW.md) · [`../governance/RESEARCH_GOVERNANCE.md`](../governance/RESEARCH_GOVERNANCE.md)
- [`../../research/templates/`](../../research/templates/)
