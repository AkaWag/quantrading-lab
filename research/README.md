# Research Operations

This is the **project-specific evidence** half of the Knowledge & Research Department. It holds
research registries, the per-project lifecycle templates, and worked examples. Reusable knowledge
lives separately under [`../knowledge/`](../knowledge/); only distilled, reviewed lessons are
promoted there.

Governed by [`../docs/research/RESEARCH_DEPARTMENT.md`](../docs/research/RESEARCH_DEPARTMENT.md),
[`../docs/research/RESEARCH_STREAMS.md`](../docs/research/RESEARCH_STREAMS.md),
[`../docs/research/RESEARCH_ARTIFACT_MODEL.md`](../docs/research/RESEARCH_ARTIFACT_MODEL.md), and
[`../docs/research/RESEARCH_REVIEW_PROCESS.md`](../docs/research/RESEARCH_REVIEW_PROCESS.md).

## Structure

| Path | Contents |
|---|---|
| [`registry/`](registry/) | [`RESEARCH_REGISTRY.md`](registry/RESEARCH_REGISTRY.md), [`STRATEGY_REGISTRY.md`](registry/STRATEGY_REGISTRY.md) |
| [`templates/`](templates/) | Research-lifecycle templates (observation → closeout); include **Stream** |
| [`examples/`](examples/) | Worked examples of completed artifacts |
| [`inbox/`](inbox/) | Incoming external material (see [`../docs/UPDATE-INGESTION.md`](../docs/UPDATE-INGESTION.md)) |
| [`library/`](library/) | Shared research assets |
| [`strategies/`](strategies/) | Per-project folders (`<YYYYMMDD>-<slug>/`) |

## Identifiers and streams

- **Research ID** `QT-R-###` — [`registry/RESEARCH_REGISTRY.md`](registry/RESEARCH_REGISTRY.md)
- **Strategy ID** `QT-S-###` — [`registry/STRATEGY_REGISTRY.md`](registry/STRATEGY_REGISTRY.md)
  (stable across revisions; semantic versions change)
- **Stream** — `NEW_STRATEGY` | `EXISTING_STRATEGY` | `BLACK_BOX_STRATEGY` | `VALIDATION`
  ([`../docs/research/RESEARCH_STREAMS.md`](../docs/research/RESEARCH_STREAMS.md))

IDs are stable and never reused. Record the research ID in the Pine `researchId` input when
implementation begins.

**New strategy and existing strategy development are not the same process.**

## Starting a project (no implementation yet)

1. Choose the correct **Stream** and register in
   [`registry/RESEARCH_REGISTRY.md`](registry/RESEARCH_REGISTRY.md).
2. For `NEW_STRATEGY`: observation → research question → falsifiable hypothesis → specification.
3. For `EXISTING_STRATEGY`: freeze baseline (original version, parameters, market/TF, costs,
   evidence, limitations) before any change.
4. For `BLACK_BOX_STRATEGY`: capture observables/exports; declare uncertainty; do not claim exact
   replication without evidence.
5. For `VALIDATION`: independent review of supplied claims/evidence.
6. Session-aware work follows
   [`../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md).
7. Use [`../scripts/new-strategy.sh`](../scripts/new-strategy.sh) only when an implementation phase
   begins (it seeds Pine — not for pre-implementation research alone).

## WIP guideline

Prefer at most one active `NEW_STRATEGY`, one active `EXISTING_STRATEGY`, and one active
`VALIDATION` assignment (starting governance limit).

## Non-negotiables

- Falsifiable hypotheses with explicit invalidation criteria.
- Baseline comparison before any promotion.
- Record assumptions, data limitations, timeframe, market, session, execution model.
- Retain negative and failed results; link evidence rather than summarizing it.
- Promote reusable lessons to [`../knowledge/lessons/`](../knowledge/lessons/) at closeout.
- No claim of validation/compilation/performance without supplied evidence.
