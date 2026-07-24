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
- **Operating model (ADR-007, 2026-07-23):** Cursor `research-director` for repo governance;
  **Shotgun** trading companion (charts / ground-zero support) → feeds director;
  **Signum Agent Live external** for heavy compute; **GitHub `origin`** as durable handoff bus.
  SOP: [`docs/onboarding/DIRECTOR_OPERATING_MODEL.md`](docs/onboarding/DIRECTOR_OPERATING_MODEL.md);
  Shotgun: [`docs/onboarding/SHOTGUN_AGENT.md`](docs/onboarding/SHOTGUN_AGENT.md).
- **ADR-006 HTTPS ChatGPT↔Cursor bridge: archived** (superseded by ADR-007). Gate 1 code may
  remain as historical R&D only — not the ops path.
- **ASAP critical path:** gold / **QT-R-001** Signum Agent Live pilot (lab agents, **not** live
  money) — [`PILOT_SIGNUM_EXTERNAL.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/PILOT_SIGNUM_EXTERNAL.md).
  Shotgun available in parallel for chart companionship from ground zero.

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
  `NEW_STRATEGY`, status **`EVIDENCE-GATHERING`**, under
  [`research/strategies/20260721-xauusd-global-session-transition-london-breakout/`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/README.md).
  Focus: Asia context → London opportunity → New York response. **Experiment plan accepted
  2026-07-23** (`A-TK` Tokyo, six baselines, IS/VAL/OOS, cost ladder) —
  [acceptance](research/strategies/20260721-xauusd-global-session-transition-london-breakout/reviews/2026-07-23-experiment-plan-acceptance.md).
  Evidence still `none`; **blocked on EV-001 data**. No strategy ID, Pine, or optimization.
  **Signum external Agent Live pilot ready:**
  [`PILOT_SIGNUM_EXTERNAL.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/PILOT_SIGNUM_EXTERNAL.md).
  **Next:** start Signum with QT-R-001 kickoff → close EV-001 → TEMPORAL → B1–B6.
- **ADR-008 accepted:** Signum TradingView **gold strategies** intake into `EXISTING_STRATEGY`
  streams (QT-R-002 active; QT-R-003/004 parked). Index:
  [`research/inbox/2026-07-23-signum-gold-tv-intake/`](research/inbox/2026-07-23-signum-gold-tv-intake/README.md).
  Purpose: structured baseline → reproduce → improve under QuanTrading — not orphan Signum-only
  optimisation.
- **QT-R-002** (active EXISTING): Gold 4H MACD 4C Squatter — **baseline frozen + pins**
  (2026-07-24); next TV reproduce / EV-002. No optimisation until reproduce evidence.
- **QT-R-001** remains parallel `NEW_STRATEGY` (session research), not a substitute for gold/TV intake.
- **Repository continuity restoration (2026-07-24):** accepted ADR-005–008, QT-R-001,
  Director, Shotgun, and Signum artifacts were assembled from their preserved feature branches
  onto one integration baseline. Internal links and required continuity artifacts are now checked
  by `scripts/check-continuity.py`; promotion to `main` remains subject to review and approval.
  Evidence record:
  [`repository-continuity-restoration-2026-07-24.md`](reports/repository-continuity-restoration-2026-07-24.md).
- **Dizzy active as Cursor skill (ADR-009 mailbox pilot):** skill
  [`.cursor/skills/dizzy/`](.cursor/skills/dizzy/); mandate
  [`docs/onboarding/DIZZY_AGENT.md`](docs/onboarding/DIZZY_AGENT.md); toolchain
  [`tools/dizzy/`](tools/dizzy/README.md) (DiscordChatExporter.Cli `2.47.3`). Pilot channel
  `#trader-j` on owner mailbox server; export → inbox demonstrated. No auto alerts, Pine, or live
  execution. DiscordDataMirror contemplated, not installed.

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
- The ADR-006 orchestration-bridge prototype remains separately preserved as historical R&D and
  is intentionally excluded from the continuity baseline. ADR-006 architecture and threat-model
  records remain for traceability; there is no tunnel, Custom GPT Action, enabled MCP connection,
  production service, or external end-to-end evidence.
- **Shotgun chart engage (2026-07-24, parked):** Cursor browser session isolation from user Brave;
  private TradingView layouts fail in Cursor when logged out — analyze and update Shotgun mandate
  when back online (see [`NEXT_ACTIONS.md`](NEXT_ACTIONS.md) § Priority 2g).

## Risks

- Version history and rollback are covered by Git with an off-machine remote; disaster recovery
  of non-Git content (untracked/gitignored files, data) remains a gap until the full backup in
  ADR-003 is implemented.
- Backtest/compilation cannot be verified inside this workspace; TradingView is external
  (see [`docs/architecture/SYSTEM_BOUNDARIES.md`](docs/architecture/SYSTEM_BOUNDARIES.md)).
- Reviving the archived bridge would recreate high-impact external-client, ingress, service,
  Cursor SDK, workspace-state, and optional MCP trust boundaries. Revival and external exposure
  remain blocked unless a new ADR separately approves and evidences authentication, isolation,
  replay protection, denial controls, redaction, retention, rollback, and incident response.

## Environment assumptions

- OS: Ubuntu (Linux). Shell: bash.
- Workspace path: this repository root (`VERSION` = `2.5.0`).
- Tooling present per `doctor.sh`: bash, git, unzip, sha256sum, cursor CLI. Missing: zip.
- Cursor CLI agent installed user-locally (`~/.local/bin/agent`, `~/.local/bin/cursor-agent`),
  version `2026.07.17-3e2a980`; authenticated.
- Secrets, if any, are expected in a non-committed `.env` and are not present in source.

## Continuity pickup (ADR-007 Signum external + GitHub bus)

When resuming after a break:

1. Read this file and [`NEXT_ACTIONS.md`](NEXT_ACTIONS.md); follow
   [`docs/onboarding/DIRECTOR_OPERATING_MODEL.md`](docs/onboarding/DIRECTOR_OPERATING_MODEL.md).
2. Check Git shared-bus state: `git status`, branch vs `origin`; **uncommitted work is not on
   GitHub**.
3. **Agent Live:** Signum external — panel `http://127.0.0.1:8788`; gold kickoff in
   [`PILOT_SIGNUM_EXTERNAL.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/PILOT_SIGNUM_EXTERNAL.md).
4. **Tokens:** Cursor subscription default for Cursor seats; Signum agents use Signum’s own stack.
5. **Next product work:** QT-R-001 Agent Live pilot — EV-001 → TEMPORAL → B1–B6. No Pine /
   QT-S-###. No live money.
6. **Ops:** ADR-003 backup remains blocked until the external SSD is available.
7. **ADR-006:** archived — do not revive HTTPS / Action / tunnel for ops.

### GitHub shared-bus viability (snapshot)

| Item | Status |
|---|---|
| Private `origin` configured and `main` pushed | Ready |
| Signum Agent Live (external) | Ops path (ADR-007); port deferred |
| Desktop / Signum → GitHub write path | Land accepted artifacts; human-approved push |
| Cursor agents implement from repo | Ready |
| Agent `git push` | Human-approved only (by design) |
| Uncommitted local trees | Not on the bus until committed/pushed |

Pickup phrase:

> Continue QuanTrading V2.5. ADR-007: Signum Agent Live external; GitHub handoff; ADR-006
> archived. Gold pilot QT-R-001 — EV-001 then TEMPORAL + B1–B6. No live money.

## Last verified

- 2026-07-21 — Ubuntu Operations Agent established and verified (ADR-004). Re-verify on each new
  session using [`docs/onboarding/FIRST_SESSION_CHECKLIST.md`](docs/onboarding/FIRST_SESSION_CHECKLIST.md).
- 2026-07-23 — QT-R-001 experiment plan **accepted**; status `EVIDENCE-GATHERING`; EV-001 data
  gate open (blocking).
- 2026-07-23 — **ADR-007 accepted:** Signum external Agent Live; ADR-006 archived; gold pilot
  packet ready.
