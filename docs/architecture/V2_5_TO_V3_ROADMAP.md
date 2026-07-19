# V2.5 → V3 Roadmap

This roadmap sequences the move from the current V2.5 workspace toward the V3 platform vision
in [`PLATFORM_VISION.md`](PLATFORM_VISION.md). Phases are ordered by dependency and risk. **No
phase beyond the current state is implemented.** Each phase that changes architecture requires
an ADR (see [`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md)).

Current state is tracked in [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md); the prioritized
task list is [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md).

## Phase 1 — Stabilise and validate V2.5
- Confirm the workspace, rules, skills, and scripts function.
- Establish governance (this document set) and a health/capability audit.
- Outcome: a trustworthy, well-understood research workspace.

## Phase 2 — Establish Git and backup discipline
- Initialize version control for the workspace.
- Define commit hygiene, `.gitignore` for secrets/outputs, and a backup routine.
- Outcome: reproducible history and recoverable state.

## Phase 3 — Prepare the `/srv/quantrading` structure
- Design (on paper first) the server directory layout separating platform, workspaces,
  services, data, logs, backups, and archives.
- Outcome: an agreed target layout, recorded via ADR, before any files are moved.

## Phase 4 — Introduce service accounts and permissions
- Define unprivileged service accounts and minimum-privilege permissions.
- Outcome: an access model that avoids running work as root or with unrestricted `sudo`.

## Phase 5 — Add V3 management services incrementally
- Introduce management services one at a time, each with its own review and ADR.
- Outcome: a growing platform layer that manages workspaces without altering research standards.

## Phase 6 — Migrate active workspaces under controlled procedures
- Move workspaces into the server structure with backups, verification, and rollback steps.
- Outcome: workspaces hosted on the authoritative server with no loss of history.

## Phase 7 — Add optional data, model, indexing, and automation services
- Add data stores, local models, indexing/search, and automation only as justified needs arise.
- Outcome: optional capabilities layered on a stable platform.

## Not to be implemented yet

Until the earlier phases are complete and individually approved, do **not**:

- create `/srv/quantrading` or move workspaces onto the server;
- create service accounts or change system permissions;
- install databases, local models, indexing, dashboards, or automation services;
- enable any live trading, order routing, or external execution;
- begin parameter optimization or production deployment of strategies.

## Related documents

- [`PLATFORM_VISION.md`](PLATFORM_VISION.md)
- [`SYSTEM_BOUNDARIES.md`](SYSTEM_BOUNDARIES.md)
- [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md)
