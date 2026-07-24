# Next Actions

Prioritized, non-destructive checklist for what to do after governance onboarding. Current
state is in [`PROJECT_STATUS.md`](PROJECT_STATUS.md); phases are in
[`docs/architecture/V2_5_TO_V3_ROADMAP.md`](docs/architecture/V2_5_TO_V3_ROADMAP.md).

Do **not** begin parameter optimization, production deployment, or live trading yet.

## Continuity (ADR-007 Signum external + GitHub bus — 2026-07-23)

**Immediate product next actions:**

1. **EXISTING gold/TV apparatus (ADR-008):** QT-R-002 baseline freeze → pin Pine → reproduce  
   ([`20260723-gold-4h-macd4c-signal-squatter`](research/strategies/20260723-gold-4h-macd4c-signal-squatter/)).
2. **Shotgun** may companion on QT-R-004 / 3MACD anytime (parked research, ground-zero OK).
3. **QT-R-001** Signum Agent Live / EV-001 remains parallel NEW_STRATEGY work when scheduled.

Not ADR-006. Not unsupervised live money.

**Operating model:** See
[`docs/onboarding/DIRECTOR_OPERATING_MODEL.md`](docs/onboarding/DIRECTOR_OPERATING_MODEL.md).

- **Agent Live:** Signum external (`~/signum-ai-strategy/`, panel `:8788`) — ADR-007.
- **Shotgun:** Cursor trading companion from ground zero — charts, quant+manual craft, feeds
  director ([`SHOTGUN_AGENT.md`](docs/onboarding/SHOTGUN_AGENT.md)).
- **Director (repo):** Cursor `research-director`.
- **Shared handoff bus:** private GitHub `origin` (keep).
- **ADR-006 HTTPS bridge:** **archived** — do not revive Action/tunnel for ops.
- **Port Signum into repo:** deferred (future ADR).

Pickup: [`PROJECT_STATUS.md`](PROJECT_STATUS.md) § Continuity pickup.

## Priority 1 — Repository health and capability audit (immediate next action)

- [ ] Run [`scripts/verify.sh`](scripts/verify.sh) and [`scripts/doctor.sh`](scripts/doctor.sh);
      record exact output.
- [ ] Inventory rules, skills, templates, checklists, prompts, and scripts; confirm each is
      understood and functional.
- [ ] Confirm the governance docs are internally consistent and correctly cross-linked.
- [ ] Note gaps or missing tooling (for example the missing `zip`).

## Priority 2 — Establish Git / version-control status (done)

- [x] Confirm whether the workspace is under version control.
- [x] Initialize Git with a `.gitignore` covering secrets (`.env`) and generated outputs
      (ADR-001 accepted; branch `main`; initial commit `5394f7a`).
- [x] Configure an off-machine Git **remote** — `origin` (private GitHub over SSH) is configured
      and `main` is pushed and up to date.
- [ ] **Procure the external backup drive (open requirement; not currently available).**
      Specification: 1 TB portable external SSD; USB 3.x or USB-C; a separate physical device;
      **ext4** if Ubuntu-only, **exFAT** only if cross-platform access is required.
- [ ] **After procurement**, complete off-machine resilience per
      [`decisions/ADR-003-backup-and-remote-repository-strategy.md`](decisions/ADR-003-backup-and-remote-repository-strategy.md)
      (review: [`reports/backup-and-remote-strategy-review-2026-07-20.md`](reports/backup-and-remote-strategy-review-2026-07-20.md)):
    - [ ] implement the **encrypted full-workspace backup** (covering untracked/gitignored content);
    - [ ] run **checksum / integrity verification** of the backup;
    - [ ] perform a **scratch restore test** into a throwaway location and confirm `scripts/verify.sh` passes;
    - [ ] write a **recovery report** recording date, result, RPO/RTO, and any gaps.
- [ ] **ADR-003 closure is blocked** until the restore test succeeds; a Git remote alone is not a
      full backup, and requires human approval of destination, encryption/auth, and retention.

## Priority 2b — Knowledge & Research department (done)

- [x] Establish the department structure and documentation (ADR-002 accepted): reusable
      [`knowledge/`](knowledge/README.md) base, [`research/`](research/README.md) registries/
      templates/examples, and governing standards under
      [`docs/research/`](docs/research/RESEARCH_DEPARTMENT.md).
- Note: this created the department only. The research chain is **not** exercised and validation
      capability is **not** demonstrated.

## Priority 2c — Ubuntu Operations Agent (done)

- [x] Install and authenticate the Cursor CLI (`agent` / `cursor-agent`) user-locally (no sudo).
- [x] Establish the permission-bounded Operations Agent (ADR-004 accepted): [`AGENTS.md`](AGENTS.md),
      [`.cursor/rules/ubuntu-operations.mdc`](.cursor/rules/ubuntu-operations.mdc), and
      [`.cursor/cli.json`](.cursor/cli.json).
- [x] Validate the `Shell(...)` permission matcher with an execute-capable test (safe read-only
      commands auto-run; secrets/sudo/`rm -rf`/`git push` denied).
- Note: re-run the execute-capable test after any `agent update`, since matcher semantics can
      change with the CLI version.

## Priority 2d — ChatGPT–Cursor Orchestration Bridge (**ARCHIVED — ADR-007**)

- [x] ADR-006 accepted historically; Gate 1 local prototype may exist as R&D only.
- [x] **2026-07-23 — ADR-007:** ADR-006 **superseded/archived** as ops path. Gates 2–5 **will not
      be pursued** for day-to-day operations. Do not spend on Action/tunnel/smoke.
- [x] Replacement ops path: **Signum Agent Live external** + GitHub bus (see Priority 2e / 3).
- [ ] Do not describe ADR-006 as connected, secure, or ChatGPT-operational.

## Priority 2g — Signum gold/TV → QuanTrading EXISTING streams (ADR-008 — active)

- [x] Accept ADR-008; intake index:
      [`research/inbox/2026-07-23-signum-gold-tv-intake/`](research/inbox/2026-07-23-signum-gold-tv-intake/README.md).
- [x] Register QT-R-002 (active), QT-R-003 (parked), QT-R-004 (parked queue).
- [ ] **QT-R-002:** complete [`BASELINE.md`](research/strategies/20260723-gold-4h-macd4c-signal-squatter/BASELINE.md)
      freeze; pin Pine into QT or hash-pin; reproduce under declared costs (first EXISTING loop).
- [ ] Queue QT-R-004 (3MACD) baseline after R-002 or on owner reprioritise; Shotgun companionship allowed now.
- [ ] Do not assign `QT-S-###` until EXISTING baseline + reproduce gates pass.
- [ ] Do not treat Signum fleet grades / “production ready” as QuanTrading-verified.

- [x] Create Shotgun skill + mandate:
      [`.cursor/skills/shotgun/`](.cursor/skills/shotgun/),
      [`docs/onboarding/SHOTGUN_AGENT.md`](docs/onboarding/SHOTGUN_AGENT.md).
- [x] Wire into director operating model and Cursor handover (ground zero; not QA-locked).
- [ ] Owner: open a Cursor chat as **Shotgun** on a chart (any QT-R / draft / live ruleset) and
      confirm feedback-packet → director flow.
- [ ] Later iteration: record a directed-TV checklist pass (load strategy, alert, paper trade);
      deepen webhook/middleman automation under explicit gates.
- [ ] **Parked (2026-07-24) — Shotgun straighten-out (analyze + update):** Symptoms — Cursor internal
      browser ≠ user Brave session; private TV layout (e.g. `6x62i3DT`) inaccessible when Cursor
      browser logged out (“Chart Not Found”). Desired — update Shotgun skill/mandate so chart engage
      is reliable (session/seat guidance; engage-wait intact). Review prior Shotgun chat / this note;
      **not** QT-R-001 EV-001 or open PR work.

## Priority 2e — Signum Agent Live external (ADR-007 — active)

- [x] Accept ADR-007; ingest handover:
      [`research/inbox/2026-07-23-signum-bridge-handover/`](research/inbox/2026-07-23-signum-bridge-handover/).
- [x] Gold pilot packet + kickoff:
      [`PILOT_SIGNUM_EXTERNAL.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/PILOT_SIGNUM_EXTERNAL.md)
      and `~/signum-ai-strategy/docs/QUANTRADING-QT-R-001-PILOT-KICKOFF.md`.
- [ ] **Owner:** confirm Signum panel LIVE; clear STOP if intentional; start bridge with QT-R-001
      `BRIDGE_KICKOFF`; test in line with agents.
- [ ] Port Signum → `agent-development/`: **deferred** (future ADR).

## Priority 3 — Research streams + QT-R-001 gold (**active critical path**)

- [x] Establish research streams (ADR-005):
      [`docs/research/RESEARCH_STREAMS.md`](docs/research/RESEARCH_STREAMS.md).
- [x] Establish global session architecture (Asia → London → overlap → NY → next Asia):
      [`knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md).
- [x] Register/revise `QT-R-001` — stream `NEW_STRATEGY`, status `EVIDENCE-GATHERING`.
- [x] Research review + experiment plan accepted (2026-07-23).
- [x] Signum external pilot positioned (ADR-007).
- [ ] **Next — Agent Live on gold:** run Signum kickoff → close EV-001 → TEMPORAL → B1–B6.
- [ ] Do **not** implement Pine / assign `QT-S-###` / optimize / live-trade without separate approval.
- [ ] Do **not** claim QT-R-001 session relationships are empirically validated.

## Not yet

- [ ] Do not begin optimization.
- [ ] Do not deploy to production or enable live/automated trading.
- [ ] Do not create `/srv/quantrading`, service accounts, or V3 services (roadmap Phases 3+).
