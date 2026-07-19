# ADR-001: Adopt Git version control and backup discipline

- Status: accepted
- Date: 2026-07-19
- Owners: Aka Wag

## Context

The V2.5 workspace is not currently under version control (confirmed by
[`../reports/repository-health-audit-2026-07-19.md`](../reports/repository-health-audit-2026-07-19.md),
findings F1/F2). Without Git there is no reliable history, diff, attribution, or rollback, which
conflicts with the charter principles of reproducibility, traceability, and controlled change
([`../docs/governance/QUANTRADING_CHARTER.md`](../docs/governance/QUANTRADING_CHARTER.md)).
Roadmap Phase 2 calls for establishing Git and backup discipline
([`../docs/architecture/V2_5_TO_V3_ROADMAP.md`](../docs/architecture/V2_5_TO_V3_ROADMAP.md)).
There is currently no `.gitignore`, and no `.env`/secrets are present in the tree.

## Decision

Proposed (not yet executed): initialize a Git repository at the workspace root, add a
`.gitignore` that excludes secrets and generated artifacts, make an initial commit of the current
tracked content, and define a simple backup routine (e.g. an SSH-key remote per
[`../docs/IMPLEMENTATION.md`](../docs/IMPLEMENTATION.md)). No remote, credentials, or automation
are configured without separate approval.

Proposed initial `.gitignore` entries:

```gitignore
.env
.env.*
releases/*.tar.gz
releases/*.sha256
*.tmp
```

## Alternatives considered

- **No version control (status quo).** Rejected: no history or rollback; violates traceability.
- **Tarball snapshots only.** Rejected: coarse, no diff/attribution, error-prone.
- **Immediately add a hosted remote (e.g. GitHub).** Deferred: introduces credentials and an
  external trust boundary; requires its own approval and ADR
  ([`../docs/architecture/SYSTEM_BOUNDARIES.md`](../docs/architecture/SYSTEM_BOUNDARIES.md)).

## Consequences

- Positive: reproducible history, diffs, rollback, and safer change management.
- Positive: `.gitignore` reduces the risk of committing secrets or large generated outputs.
- Negative/cost: contributors must follow commit hygiene; initial setup effort.

## Risks

- Accidentally committing secrets → mitigated by `.gitignore` and keeping secrets in `.env`.
- Committing large binaries (release tarballs) → mitigated by ignoring `releases/*.tar.gz`.
- Scope creep into remotes/automation → explicitly excluded here; requires a separate ADR.

## Rollback plan

Git initialization is reversible before any remote is added: removing the `.git/` directory
returns the workspace to its current unversioned state with no loss of working files. Because no
files are moved or deleted by this decision, working content is unaffected either way.

## Approval

Accepted by Aka Wag on 2026-07-19. Per
[`../docs/governance/AI_OPERATING_PRINCIPLES.md`](../docs/governance/AI_OPERATING_PRINCIPLES.md)
and [`../docs/governance/DECISION_GOVERNANCE.md`](../docs/governance/DECISION_GOVERNANCE.md),
this authorizes local `git init`, a `.gitignore`, and an initial commit. Configuring any remote,
credentials, or automation remains out of scope and requires a separate ADR.
