# Platform Vision (V3)

This document describes the intended future architecture for QuanTrading Lab. It is a **plan,
not a description of installed infrastructure**. Nothing here should be assumed to exist today.
Current state is recorded in [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md); the sequenced
plan is in [`V2_5_TO_V3_ROADMAP.md`](V2_5_TO_V3_ROADMAP.md).

## Intent

V3 is intended to be a centrally managed platform and service layer, hosted on an Ubuntu
server, that **manages V2.5 workspaces rather than replacing their research standards**. The
research discipline defined in [`../governance/`](../governance/) remains authoritative;
V3 provides hosting, structure, and operational services around it.

## Authoritative host

The Ubuntu server is intended to be the **authoritative host** and, over time, the system of
record (see [`SYSTEM_BOUNDARIES.md`](SYSTEM_BOUNDARIES.md)). Workspaces, history, and evidence
live on the server; client machines do not hold the canonical copy.

## Client access

- Client desktops connect through **controlled remote access** (for example SSH, or a remote
  desktop such as Remmina with an automatic screen lock).
- Cursor runs as a **development client**, not the system of record.
- No client is assumed to be trusted with secrets or canonical data.

## Separation of concerns

The intended layout separates, at minimum:

- **Platform** — management services and configuration for the server itself;
- **Workspaces** — V2.5 research workspaces (like this one);
- **Services** — supporting services (see "Future possibilities" below);
- **Data** — market/reference data stores;
- **Logs** — operational and audit logs;
- **Backups** — recoverable copies of workspaces and data;
- **Archives** — retired strategies, old releases, and historical evidence.

A candidate root such as `/srv/quantrading` is discussed in
[`V2_5_TO_V3_ROADMAP.md`](V2_5_TO_V3_ROADMAP.md); it is a proposal, not a created path.

## Future possibilities (not yet implemented)

The following are possibilities to be introduced incrementally and only after their own review
and ADR. None currently exist:

- version control (Git) and hosting;
- code/document indexing and search;
- databases for research metadata and results;
- locally hosted models for assistance;
- automation and scheduling services;
- dashboards and reporting;
- backup and restore services.

Each item must be justified, scoped, and recorded before implementation, per
[`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md).

## Related documents

- [`V2_5_TO_V3_ROADMAP.md`](V2_5_TO_V3_ROADMAP.md)
- [`SYSTEM_BOUNDARIES.md`](SYSTEM_BOUNDARIES.md)
- [`../governance/QUANTRADING_CHARTER.md`](../governance/QUANTRADING_CHARTER.md)
