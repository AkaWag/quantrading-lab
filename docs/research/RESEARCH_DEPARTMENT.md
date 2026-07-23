# Research Department

This document defines the QuanTrading Knowledge & Research Department: the institutional memory
of the lab and the single controlled entry point for future strategy development. It is a
**governing standard**. It complements, and does not replace, the charter and governance set in
[`../governance/`](../governance/), the gated workflow in [`../WORKFLOW.md`](../WORKFLOW.md), and
the strategy lifecycle in [`../governance/STRATEGY_LIFECYCLE.md`](../governance/STRATEGY_LIFECYCLE.md).
Where a more specific rule under [`../../.cursor/rules/`](../../.cursor/rules/) exists, that rule
takes precedence.

This department was adopted via
[`../../decisions/ADR-002-establish-knowledge-and-research-department.md`](../../decisions/ADR-002-establish-knowledge-and-research-department.md).

## Purpose

- Be the **controlled front door**: every investigation enters as an observation or research
  question before any Pine implementation, backtest, or optimization.
- Be the **institutional memory**: reusable knowledge, taxonomies, and lessons accumulate here
  so the lab does not repeat dead ends.
- Enforce **traceability**: an unbroken chain from observation to research question, hypothesis,
  specification, evidence, and decision, per the charter's traceability principle.

## Two halves of the department

| Area | Path | Role | Content type |
|---|---|---|---|
| Knowledge base | [`../../knowledge/`](../../knowledge/) | Reusable, cross-project knowledge | Taxonomies, Pine notes, research methods, lessons |
| Research operations | [`../../research/`](../../research/) | Project-specific investigations and evidence | Registries, per-project artifacts, examples |

The distinction is deliberate: **reusable knowledge** (knowledge base) is separated from
**project-specific evidence** (research operations). Evidence lives with its project; only
distilled, reviewed lessons are promoted into the knowledge base. See
[`KNOWLEDGE_MANAGEMENT.md`](KNOWLEDGE_MANAGEMENT.md).

## Identifiers

Every project and candidate strategy receives a stable identifier that never changes once
assigned, even if the title, owner, or status changes.

- **Research ID** — `QT-R-###` (zero-padded, assigned in
  [`../../research/registry/RESEARCH_REGISTRY.md`](../../research/registry/RESEARCH_REGISTRY.md)).
  Example: `QT-R-001`. This value should be recorded in the Pine `researchId` input
  (the `institutional_strategy_v6.pine` template defaults it to `QT-000`).
- **Strategy ID** — `QT-S-###` (assigned in
  [`../../research/registry/STRATEGY_REGISTRY.md`](../../research/registry/STRATEGY_REGISTRY.md)).
  A strategy ID is only created once a research project produces a candidate implementation.

A research project may never become a strategy; that is expected and acceptable. A strategy
always references the research ID that produced it. Strategy IDs are **stable across revisions**;
versions change with semantic versioning (see
[`RESEARCH_STREAMS.md`](RESEARCH_STREAMS.md)).

## Research streams

Research is coordinated in four streams — **not** a single undifferentiated process:

| Stream | Use when |
|---|---|
| `NEW_STRATEGY` | New market hypothesis or strategy concept |
| `EXISTING_STRATEGY` | Revising an existing Pine/manual/prior strategy (frozen baseline required) |
| `BLACK_BOX_STRATEGY` | Locked / source-unavailable TradingView strategy |
| `VALIDATION` | Independent verification of claims and evidence |

Full rules, EXISTING/BLACK_BOX controls, and the WIP guideline:
[`RESEARCH_STREAMS.md`](RESEARCH_STREAMS.md) (ADR-005).

Session-aware projects also follow
[`../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md)
(Asia → London → overlap → New York → next Asia; UTC + IANA; London not isolated).

## Naming and directory conventions

- **Research/strategy project folder:** `research/strategies/<YYYYMMDD>-<slug>/`, created by
  [`../../scripts/new-strategy.sh`](../../scripts/new-strategy.sh). The folder name is the
  historical creation date plus a kebab-case slug; the registries map the stable IDs to folders.
- **Slugs:** lowercase, ASCII, hyphen-separated (`[a-z0-9-]`), derived from the title.
- **Artifact filenames inside a project:** the gated-workflow names (`INTAKE.md`,
  `HYPOTHESIS.md`, `SPEC.md`, `RISK.md`, `TEST-PLAN.md`, `RELEASE.md`) plus department artifacts
  (`OBSERVATION.md`, `RESEARCH_QUESTION.md`, `EXPERIMENT_PLAN.md`, evidence and failure records).
  The mapping is in [`RESEARCH_ARTIFACT_MODEL.md`](RESEARCH_ARTIFACT_MODEL.md).
- **Evidence records:** `research/strategies/<project>/evidence/EV-###-<slug>.md`.
- **Failure records:** `research/strategies/<project>/evidence/FAIL-###-<slug>.md`.
- **Knowledge documents:** `UPPER_SNAKE_CASE.md` under `knowledge/…`; lessons as
  `knowledge/lessons/LES-###-<slug>.md`.

Encoding is UTF-8 with Unix line endings and portable relative links, per
`60-repository-hygiene.mdc`.

## Lifecycle states and ownership

Research projects use the following states (a superset front-end to the strategy lifecycle in
[`../governance/STRATEGY_LIFECYCLE.md`](../governance/STRATEGY_LIFECYCLE.md)):

```text
OBSERVED → QUESTION → HYPOTHESIS → SPECIFIED → EXPERIMENT-PLANNED
→ EVIDENCE-GATHERING → REVIEWED → CLOSED(promoted | archived | rejected)
```

- **OBSERVED..HYPOTHESIS** are pre-implementation and live entirely in the research department.
- **SPECIFIED** onward align with the gated workflow; a `SPECIFIED` project with a candidate
  implementation acquires a strategy ID and enters `STRATEGY_LIFECYCLE.md` (PROTOTYPE onward).
- **CLOSED** always records a disposition; a closed project is never deleted.

**Ownership:** every project has a single named human **owner** recorded in the registry. The
owner is accountable for the project's decisions; AI assistants are advisory only, per
[`../governance/AI_OPERATING_PRINCIPLES.md`](../governance/AI_OPERATING_PRINCIPLES.md). Knowledge
documents also carry an owner responsible for keeping them current.

## Required behavior (mandatory)

1. Every research project receives a stable research ID; every candidate strategy a stable
   strategy ID.
2. Observations must be recorded before hypotheses; see
   [`RESEARCH_ARTIFACT_MODEL.md`](RESEARCH_ARTIFACT_MODEL.md) for how an observation becomes a
   research question and then a hypothesis.
3. Hypotheses must be **falsifiable** and state explicit **invalidation criteria**, per
   `20-research-integrity.mdc` and
   [`../governance/RESEARCH_GOVERNANCE.md`](../governance/RESEARCH_GOVERNANCE.md).
4. **Baseline comparison** is required before any promotion; net profit alone is never
   sufficient.
5. Assumptions, data limitations, timeframe, market, session, and execution model must be
   recorded in the specification and every evidence record.
6. **Negative and failed results are retained**, not deleted, per `RESEARCH_GOVERNANCE.md`.
7. Evidence must be **linked** to its artifact (file path, commit, or external reference), not
   merely summarized.
8. Lessons must be **promoted into the knowledge base** at closeout (see
   [`KNOWLEDGE_MANAGEMENT.md`](KNOWLEDGE_MANAGEMENT.md)).
9. Significant, non-reversible decisions must reference an **ADR** in
   [`../../decisions/`](../../decisions/) per
   [`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md).
10. No document may claim empirical validation, compilation, backtest performance, or live
    behavior without supplied evidence, per
    [`../governance/QUANTRADING_CHARTER.md`](../governance/QUANTRADING_CHARTER.md).

## Related documents

- [`KNOWLEDGE_MANAGEMENT.md`](KNOWLEDGE_MANAGEMENT.md)
- [`RESEARCH_ARTIFACT_MODEL.md`](RESEARCH_ARTIFACT_MODEL.md)
- [`RESEARCH_STREAMS.md`](RESEARCH_STREAMS.md)
- [`RESEARCH_REVIEW_PROCESS.md`](RESEARCH_REVIEW_PROCESS.md)
- [`../WORKFLOW.md`](../WORKFLOW.md) · [`../governance/STRATEGY_LIFECYCLE.md`](../governance/STRATEGY_LIFECYCLE.md)
- [`../../knowledge/README.md`](../../knowledge/README.md) · [`../../research/README.md`](../../research/README.md)
