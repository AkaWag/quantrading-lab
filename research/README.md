# Research Operations

This is the **project-specific evidence** half of the Knowledge & Research Department. It holds
research registries, the per-project lifecycle templates, and worked examples. Reusable knowledge
lives separately under [`../knowledge/`](../knowledge/); only distilled, reviewed lessons are
promoted there.

Governed by [`../docs/research/RESEARCH_DEPARTMENT.md`](../docs/research/RESEARCH_DEPARTMENT.md),
[`../docs/research/RESEARCH_ARTIFACT_MODEL.md`](../docs/research/RESEARCH_ARTIFACT_MODEL.md), and
[`../docs/research/RESEARCH_REVIEW_PROCESS.md`](../docs/research/RESEARCH_REVIEW_PROCESS.md).

## Structure

| Path | Contents |
|---|---|
| [`registry/`](registry/) | [`RESEARCH_REGISTRY.md`](registry/RESEARCH_REGISTRY.md), [`STRATEGY_REGISTRY.md`](registry/STRATEGY_REGISTRY.md) |
| [`templates/`](templates/) | Research-lifecycle templates (observation → closeout) |
| [`examples/`](examples/) | Worked examples of completed artifacts |
| [`inbox/`](inbox/) | Incoming external material (see [`../docs/UPDATE-INGESTION.md`](../docs/UPDATE-INGESTION.md)) |
| [`library/`](library/) | Shared research assets |
| [`strategies/`](strategies/) | Per-project folders created by [`../scripts/new-strategy.sh`](../scripts/new-strategy.sh) |

## Identifiers

- **Research ID** `QT-R-###` — assigned in [`registry/RESEARCH_REGISTRY.md`](registry/RESEARCH_REGISTRY.md).
- **Strategy ID** `QT-S-###` — assigned in [`registry/STRATEGY_REGISTRY.md`](registry/STRATEGY_REGISTRY.md).

IDs are stable and never reused. Record the research ID in the Pine `researchId` input.

## Starting a project (no implementation yet)

1. Register the project in [`registry/RESEARCH_REGISTRY.md`](registry/RESEARCH_REGISTRY.md) to
   obtain a research ID.
2. Capture an [`OBSERVATION.md`](templates/OBSERVATION.md), then a
   [`RESEARCH_QUESTION.md`](templates/RESEARCH_QUESTION.md), then a falsifiable
   [`HYPOTHESIS.md`](templates/HYPOTHESIS.md).
3. Only after a falsifiable hypothesis exists, proceed to specification and experiment planning.
4. Use [`../scripts/new-strategy.sh`](../scripts/new-strategy.sh) to scaffold a project folder
   under [`strategies/`](strategies/) when an implementation phase begins.

## Non-negotiables

- Falsifiable hypotheses with explicit invalidation criteria.
- Baseline comparison before any promotion.
- Record assumptions, data limitations, timeframe, market, session, execution model.
- Retain negative and failed results; link evidence rather than summarizing it.
- Promote reusable lessons to [`../knowledge/lessons/`](../knowledge/lessons/) at closeout.
- No claim of validation/compilation/performance without supplied evidence.
