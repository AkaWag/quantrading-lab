# ADR-002: Establish the Knowledge & Research Department

- Status: accepted
- Date: 2026-07-19
- Owners: Aka Wag

## Context

The V2.5 workspace has strong governance but no operational home for institutional memory or a
single controlled entry point for research. The repository health audit
([`../reports/repository-health-audit-2026-07-19.md`](../reports/repository-health-audit-2026-07-19.md))
and its follow-up
([`../reports/knowledge-research-department-buildout-2026-07-19.md`](../reports/knowledge-research-department-buildout-2026-07-19.md))
found the designed traceability chain **unexercised**, no reusable-knowledge layer, no research or
strategy registries, and no place to retain lessons and negative results. Adding this structure
changes repository organization and process, which requires an ADR per
[`../docs/governance/DECISION_GOVERNANCE.md`](../docs/governance/DECISION_GOVERNANCE.md) and
`50-research-governance.mdc`.

This change was explicitly requested by the workspace owner, satisfying the human-approval gate in
[`../docs/governance/AI_OPERATING_PRINCIPLES.md`](../docs/governance/AI_OPERATING_PRINCIPLES.md).

## Decision

Establish a Knowledge & Research Department as documentation and repository structure only:

- `knowledge/` — reusable knowledge base (taxonomies, Pine notes, research methods, lessons).
- `research/registry/`, `research/templates/`, `research/examples/` — research operations
  (registries, lifecycle templates, worked examples), extending the existing `research/` folder.
- `docs/research/` — four governing standards defining the department, knowledge management, the
  artifact model, and the review process.

Adopt stable identifiers: research ID `QT-R-###` and strategy ID `QT-S-###`, tracked in the two
registries and aligned with the existing Pine `researchId` input. The department front-ends, and
does not replace, the gated workflow ([`../docs/WORKFLOW.md`](../docs/WORKFLOW.md)) and strategy
lifecycle ([`../docs/governance/STRATEGY_LIFECYCLE.md`](../docs/governance/STRATEGY_LIFECYCLE.md)).

This ADR creates structure and standards only. It does **not** create any research project,
strategy, Pine implementation, backtest, or release, and does not exercise the research chain.

## Alternatives considered

- **Extend existing governance docs in place.** Rejected: would overload governance docs and blur
  the line between reusable knowledge and project evidence.
- **Put everything under `docs/`.** Rejected: mixes reusable knowledge, project-specific evidence,
  and governing standards, which this department deliberately separates.
- **Introduce a database/index/service for registries now.** Rejected/deferred: prohibited by the
  V2.5→V3 roadmap without its own ADR; Markdown registries are sufficient and reversible.
- **Rename or restructure the existing lowercase `templates/`.** Rejected: would break
  `new-strategy.sh` and the workflow; the new templates cross-reference the existing ones instead.

## Consequences

- Positive: a controlled entry point, institutional memory, retained negatives/lessons, and
  explicit ID-based traceability from observation to decision.
- Positive: reusable knowledge is separated from project-specific evidence; contradictions are
  handled by supersession, not silent rewrites.
- Negative/cost: more documents to maintain; owners must keep registries and knowledge current;
  two template families (build vs research) must be kept cross-referenced to avoid drift.

## Risks

- **Documentation drift** between the department and existing governance → mitigated by
  cross-links and the knowledge-management supersession rules.
- **Template duplication/conflict** with `templates/` → mitigated by the artifact-model mapping
  in [`../docs/research/RESEARCH_ARTIFACT_MODEL.md`](../docs/research/RESEARCH_ARTIFACT_MODEL.md).
- **Scope creep** toward services/optimization/deployment → explicitly excluded here; each would
  require its own ADR.

## Verification

- `bash scripts/verify.sh .` and `bash scripts/doctor.sh` run after the change; results recorded
  in the follow-up report
  ([`../reports/knowledge-research-department-buildout-2026-07-19.md`](../reports/knowledge-research-department-buildout-2026-07-19.md)).
- New relative Markdown links checked; duplicate/conflicting definitions scanned.
- No remote, CI, secret scanner, service, database, or package was configured or installed.

## Rollback plan

The change is documentation-only and reversible: removing the `knowledge/`, `research/registry/`,
`research/templates/`, `research/examples/`, and `docs/research/` additions (and reverting the
`README.md`/`PROJECT_STATUS.md`/`NEXT_ACTIONS.md` edits) returns the workspace to its prior state
with no loss of pre-existing research or strategy files. Because no files are moved or deleted from
the existing tree, prior content is unaffected either way.
