# Project Status

Point-in-time snapshot of QuanTrading Lab. Update this file as state changes. Use placeholders
where facts cannot be confirmed. For the prioritized task list see
[`NEXT_ACTIONS.md`](NEXT_ACTIONS.md).

## Summary

- QuanTrading Lab V2.5 workspace opened successfully in Cursor on Ubuntu.
- Governance onboarding is being established.
- No V3 services are assumed to be installed.
- No live execution or automated trading is enabled.
- Controlled research may continue; production deployment, live trading, and closure of ADR-003
  remain **blocked** until an off-machine backup restore test succeeds.

## Current phase

Phase 1 — Stabilise and validate V2.5 (governance onboarding). See
[`docs/architecture/V2_5_TO_V3_ROADMAP.md`](docs/architecture/V2_5_TO_V3_ROADMAP.md).

## Completed

- Repository inspected (structure, rules, skills, docs, templates, checklists, scripts).
- Governance document set created under [`docs/governance/`](docs/governance/).
- Architecture document set created under [`docs/architecture/`](docs/architecture/).
- Onboarding document set created under [`docs/onboarding/`](docs/onboarding/).
- Root `README.md`, `PROJECT_STATUS.md`, and `NEXT_ACTIONS.md` created.
- Non-destructive verification run (`scripts/verify.sh`, `scripts/doctor.sh`).
- Repository health & capability audit completed:
  [`reports/repository-health-audit-2026-07-19.md`](reports/repository-health-audit-2026-07-19.md).
- Git version control initialized (ADR-001 accepted, owner Aka Wag): branch `main`, initial
  commit `5394f7a`, `.gitignore` excluding secrets and release artifacts.
- Knowledge & Research department created (structure and documentation only, ADR-002 accepted):
  [`knowledge/`](knowledge/README.md), [`research/`](research/README.md) registries/templates/
  examples, and governing standards under [`docs/research/`](docs/research/RESEARCH_DEPARTMENT.md).
  This establishes institutional memory and a controlled research entry point; it does **not**
  exercise the research chain or demonstrate validation capability. Buildout follow-up:
  [`reports/knowledge-research-department-buildout-2026-07-19.md`](reports/knowledge-research-department-buildout-2026-07-19.md).
- **Ubuntu Operations Agent operational (ADR-004 accepted, owner Aka Wag):** Cursor CLI
  (`agent` / `cursor-agent`, version `2026.07.17-3e2a980`) installed user-locally and
  authenticated. Governed by [`AGENTS.md`](AGENTS.md) (operational onboarding),
  [`.cursor/rules/ubuntu-operations.mdc`](.cursor/rules/ubuntu-operations.mdc) (always-applied
  rule), and [`.cursor/cli.json`](.cursor/cli.json) (project permission boundary). Permission
  matcher validated by an execute-capable test (safe read-only commands auto-run; secrets/sudo/
  `rm -rf`/`git push` denied). It automates safe read-only operations only; approval gates remain
  for architecture, releases, credentials, remotes, and live trading.

## In progress

- Governance review and adoption by the team/next session.
- **Research-stream architecture established** (ADR-005): `NEW_STRATEGY`, `EXISTING_STRATEGY`,
  `BLACK_BOX_STRATEGY`, `VALIDATION` — see
  [`docs/research/RESEARCH_STREAMS.md`](docs/research/RESEARCH_STREAMS.md). Registry/templates
  carry a **Stream** field. Strategy IDs remain stable across revisions (semver).
- **Global session architecture established:** Asia → London → London–NY overlap → New York →
  next Asia; UTC + IANA (`Europe/London`, `America/New_York`); London not isolated —
  [`knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md).
- **QT-R-001** — *XAUUSD Global Session Transition and London Breakout Research* — stream
  `NEW_STRATEGY`, status `HYPOTHESIS`, under
  [`research/strategies/20260721-xauusd-global-session-transition-london-breakout/`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/README.md).
  Focus: Asia context → London opportunity → New York response. Observation/Q/H/spec options
  drafted; **not validated**; evidence stage `none`. No strategy ID, Pine, backtest, or
  optimization. **Next:** controlled research specification review (not Pine implementation).

## Known issues

- **Off-machine resilience is partial.** The GitHub **remote** (`origin`, private GitHub over
  SSH) and **source replication** of committed history are **operational** (`main` pushed). The
  **encrypted off-machine full-workspace backup is not yet implemented** — a Git remote replicates
  only committed, tracked files, not untracked/gitignored content (e.g. `.env`), external data,
  logs, or service config.
- **External backup drive is a deferred operational dependency (not currently available).**
  Required hardware: a **1 TB portable external SSD**, **USB 3.x or USB-C**, a **separate physical
  device**, formatted **ext4** (Ubuntu-only) or **exFAT** only if cross-platform access is
  required. The hybrid backup-and-remote strategy in
  [`decisions/ADR-003-backup-and-remote-repository-strategy.md`](decisions/ADR-003-backup-and-remote-repository-strategy.md)
  is therefore **partially implemented, not complete** (see also the review
  [`reports/backup-and-remote-strategy-review-2026-07-20.md`](reports/backup-and-remote-strategy-review-2026-07-20.md)).
  Implementing the encrypted backup requires the drive plus human approval (credentials /
  external trust boundary).
- `zip` is not installed (reported by `scripts/doctor.sh`). This is **not** a release blocker:
  `scripts/package-release.sh` uses `tar` + `sha256sum`. `unzip` is present.
- `README.md` did not previously exist and was created during this session (placeholder-level,
  governance-focused).

## Risks

- Version history and rollback are covered by Git with an off-machine remote; disaster recovery
  of non-Git content (untracked/gitignored files, data) remains a gap until the full backup in
  ADR-003 is implemented.
- Backtest/compilation cannot be verified inside this workspace; TradingView is external
  (see [`docs/architecture/SYSTEM_BOUNDARIES.md`](docs/architecture/SYSTEM_BOUNDARIES.md)).

## Environment assumptions

- OS: Ubuntu (Linux). Shell: bash.
- Workspace path: this repository root (`VERSION` = `2.5.0`).
- Tooling present per `doctor.sh`: bash, git, unzip, sha256sum, cursor CLI. Missing: zip.
- Cursor CLI agent installed user-locally (`~/.local/bin/agent`, `~/.local/bin/cursor-agent`),
  version `2026.07.17-3e2a980`; authenticated.
- Secrets, if any, are expected in a non-committed `.env` and are not present in source.

## Last verified

- 2026-07-21 — Ubuntu Operations Agent established and verified (ADR-004). Re-verify on each new
  session using [`docs/onboarding/FIRST_SESSION_CHECKLIST.md`](docs/onboarding/FIRST_SESSION_CHECKLIST.md).
