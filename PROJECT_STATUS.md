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
- **Operating model (2026-07-23):** Path A Cursor-native research director; **Option 3 hybrid
  tokens** (Cursor subscription primary; OpenRouter only when deliberately needed for catalog /
  cost); **private GitHub `origin` as the shared handoff bus** between optional Desktop directors
  (ChatGPT / Claude) and Cursor agents. Prefer a frontier model for director turns and a
  cost-effective model (e.g. Grok 4.5 Fast) for implementation. Full SOP:
  [`docs/onboarding/DIRECTOR_OPERATING_MODEL.md`](docs/onboarding/DIRECTOR_OPERATING_MODEL.md).
- ChatGPT–Cursor Orchestration Bridge (ADR-006): local loopback prototype exists (Gate 1 done).
  **External stages (Gates 4–5: Cloudflare / Custom GPT Action) are paused for cost.** Gates 2–3
  are not active work; do not burn agent/API budget on bridge smoke unless explicitly reopened.
  The bridge is **not** connected, production, or ChatGPT-operational. Desktop↔Cursor handoff
  uses **GitHub artifacts**, not the HTTPS bridge.

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
  **Next:** supply/link XAUUSD 15m UTC data → TEMPORAL → B1–B6.
- **ChatGPT–Cursor Orchestration Bridge local prototype dormant (ADR-006, Path A):** Gate 1 local
  implementation exists (CLI-backed, loopback-only). External Custom GPT / Cloudflare work and
  further verification spend are **paused for cost**. Critical path returns to **QT-R-001 research
  review**. See [`docs/architecture/ORCHESTRATION_BRIDGE.md`](docs/architecture/ORCHESTRATION_BRIDGE.md).

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
- The orchestration bridge has project-local service code and dependencies, but no tunnel, Custom
  GPT Action, enabled MCP connection, production service, or external end-to-end evidence.

## Risks

- Version history and rollback are covered by Git with an off-machine remote; disaster recovery
  of non-Git content (untracked/gitignored files, data) remains a gap until the full backup in
  ADR-003 is implemented.
- Backtest/compilation cannot be verified inside this workspace; TradingView is external
  (see [`docs/architecture/SYSTEM_BOUNDARIES.md`](docs/architecture/SYSTEM_BOUNDARIES.md)).
- The planned bridge creates high-impact external-client, ingress, service, Cursor SDK, workspace,
  state, and optional MCP trust boundaries. External exposure remains blocked until authentication,
  isolation, replay, denial, redaction, retention, rollback, and incident-response controls are
  separately approved and evidenced.

## Environment assumptions

- OS: Ubuntu (Linux). Shell: bash.
- Workspace path: this repository root (`VERSION` = `2.5.0`).
- Tooling present per `doctor.sh`: bash, git, unzip, sha256sum, cursor CLI. Missing: zip.
- Cursor CLI agent installed user-locally (`~/.local/bin/agent`, `~/.local/bin/cursor-agent`),
  version `2026.07.17-3e2a980`; authenticated.
- Secrets, if any, are expected in a non-committed `.env` and are not present in source.

## Continuity pickup (Path A + Option 3 + GitHub bus)

When resuming after a break:

1. Read this file and [`NEXT_ACTIONS.md`](NEXT_ACTIONS.md); follow
   [`docs/onboarding/DIRECTOR_OPERATING_MODEL.md`](docs/onboarding/DIRECTOR_OPERATING_MODEL.md).
2. Check Git shared-bus state: `git status`, branch vs `origin`; remember **uncommitted work is
   not on GitHub**. Prefer Cursor `research-director` +
   [`prompts/00-run-full-pipeline.md`](prompts/00-run-full-pipeline.md). Do not reopen ChatGPT
   Action / Cloudflare / OpenAI API orchestration spend without a separate cost-approved decision.
3. **Tokens:** Cursor subscription default; OpenRouter only for deliberate catalog/cost routing.
4. **MCP:** curated Cursor tool MCP (Shape A) after review; Desktop subscription hosts (Shape B)
   OK for offline direction that lands as GitHub artifacts; unofficial LLM-bridge MCP (Shape C)
   deferred. Bridge MCP adapter remains disabled.
5. **Next product work:** QT-R-001 evidence gathering — complete EV-001 (XAUUSD 15m UTC data),
   then TEMPORAL + six baselines. No Pine / QT-S-###.
6. **Ops:** ADR-003 backup remains blocked until the external SSD is available.
7. **Bridge:** treat ADR-006 local code as dormant R&D; Gates 4–5 deferred; do not claim ChatGPT
   can drive Cursor agents over HTTPS.

### GitHub shared-bus viability (snapshot)

| Item | Status |
|---|---|
| Private `origin` configured and `main` pushed | Ready |
| Desktop → GitHub write path | Process gap — land specs/decisions as committed artifacts or PR text (not silent sync) |
| Cursor agents implement from repo | Ready |
| Agent `git push` | Human-approved only (by design) |
| Uncommitted local trees | Not on the bus until committed/pushed |

Pickup phrase:

> Continue QuanTrading V2.5. Path A director on Cursor tokens (frontier director, cheap
> implementers). OpenRouter only when deliberate. Shared handoff = private GitHub. ChatGPT/Claude
> Desktop may write artifacts into the repo; Cursor implements. ADR-006 HTTPS bridge paused.
> Next product work is QT-R-001 EV-001 data then TEMPORAL + B1–B6 (evidence only).

## Last verified

- 2026-07-21 — Ubuntu Operations Agent established and verified (ADR-004). Re-verify on each new
  session using [`docs/onboarding/FIRST_SESSION_CHECKLIST.md`](docs/onboarding/FIRST_SESSION_CHECKLIST.md).
- 2026-07-23 — Path A + Option 3 hybrid tokens + GitHub shared-handoff bus documented; ADR-006
  external stages paused for cost. Bridge Gates 2–5 not evidenced as complete; ChatGPT↔Cursor
  HTTPS is not operational.
- 2026-07-23 — QT-R-001 experiment plan **accepted**; status `EVIDENCE-GATHERING`; EV-001 data
  gate open (blocking).
