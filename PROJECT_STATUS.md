# Project Status

Point-in-time snapshot of QuanTrading Lab. Update this file as state changes. Use placeholders
where facts cannot be confirmed. For the prioritized task list see
[`NEXT_ACTIONS.md`](NEXT_ACTIONS.md).

## Summary

- QuanTrading Lab V2.5 workspace opened successfully in Cursor on Ubuntu.
- Governance onboarding is being established.
- No V3 services are assumed to be installed.
- No live execution or automated trading is enabled.

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

## In progress

- Governance review and adoption by the team/next session.
- Ready to scaffold the first controlled research project (Priority 3).

## Known issues

- No Git **remote** is configured (local repository only). Backup to a remote would require a
  separate ADR (credentials / external trust boundary).
- `zip` is not installed (reported by `scripts/doctor.sh`). This is **not** a release blocker:
  `scripts/package-release.sh` uses `tar` + `sha256sum`. `unzip` is present.
- `README.md` did not previously exist and was created during this session (placeholder-level,
  governance-focused).

## Risks

- Without version control, history and rollback are not yet guaranteed (see roadmap Phase 2).
- Backtest/compilation cannot be verified inside this workspace; TradingView is external
  (see [`docs/architecture/SYSTEM_BOUNDARIES.md`](docs/architecture/SYSTEM_BOUNDARIES.md)).

## Environment assumptions

- OS: Ubuntu (Linux). Shell: bash.
- Workspace path: this repository root (`VERSION` = `2.5.0`).
- Tooling present per `doctor.sh`: bash, git, unzip, sha256sum, cursor CLI. Missing: zip.
- Secrets, if any, are expected in a non-committed `.env` and are not present in source.

## Last verified

- 2026-07-19 — initial governance onboarding session. Re-verify on each new session using
  [`docs/onboarding/FIRST_SESSION_CHECKLIST.md`](docs/onboarding/FIRST_SESSION_CHECKLIST.md).
