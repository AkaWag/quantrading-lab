# Next Actions

Prioritized, non-destructive checklist for what to do after governance onboarding. Current
state is in [`PROJECT_STATUS.md`](PROJECT_STATUS.md); phases are in
[`docs/architecture/V2_5_TO_V3_ROADMAP.md`](docs/architecture/V2_5_TO_V3_ROADMAP.md).

Do **not** begin parameter optimization, production deployment, or live trading yet.

## Continuity (Path A + Option 3 + GitHub bus — 2026-07-23)

**Immediate product next action:** Priority 3 — QT-R-001 **EV-001** (obtain/link XAUUSD 15m UTC
data), then TEMPORAL + B1–B6 under the accepted
[`EXPERIMENT_PLAN.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/EXPERIMENT_PLAN.md).
Not bridge work. Not Pine.

**Operating model:** See
[`docs/onboarding/DIRECTOR_OPERATING_MODEL.md`](docs/onboarding/DIRECTOR_OPERATING_MODEL.md).

- **Director:** Cursor `research-director` (frontier model) → specialist skills / subagents
  (cost-effective implementers, e.g. Grok 4.5 Fast).
- **Tokens:** Cursor subscription primary; **OpenRouter** only for deliberate catalog/cost
  routing (Option 3 hybrid). Direct OpenAI API is not the default underlayer.
- **Shared handoff bus:** private GitHub `origin` — ChatGPT Desktop and/or Claude Desktop may
  land decisions as repo artifacts; Cursor agents implement from the repo. `git push` remains
  human-approved.
- **MCP:** Shape A curated tool MCP after review; Shape B Desktop hosts OK offline; Shape C
  unofficial LLM-bridge MCP deferred. ADR-006 bridge MCP stays disabled.
- **ADR-006 HTTPS bridge:** Gate 1 dormant R&D; Gates 2–5 paused for cost. Do not claim ChatGPT
  drives Cursor over Actions/tunnel.

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

## Priority 2d — ChatGPT–Cursor Orchestration Bridge (Gate 1 done; Path A — paused for cost)

- [x] Accept ADR-006 and document the architecture, system trust boundaries, local-only prototype
      exception, and threat model:
      [`decisions/ADR-006-establish-chatgpt-cursor-orchestration-bridge.md`](decisions/ADR-006-establish-chatgpt-cursor-orchestration-bridge.md),
      [`docs/architecture/ORCHESTRATION_BRIDGE.md`](docs/architecture/ORCHESTRATION_BRIDGE.md), and
      [`docs/security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md`](docs/security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md).
- [x] **Gate 1 — local implementation approval:** project-local service and pinned dependencies
      approved and implemented. Default to the installed Cursor CLI with explicit sandboxing,
      loopback-only binding, fixed workspace, MCP disabled, and no production or trading capability.
      Retain the SDK adapter but do not use it while its local sandbox helper is unsupported by the
      installed AppArmor attachment.
- [ ] **Gate 2 — local automated verification:** **paused (Path A).** Do not run unless
      explicitly reopened. When reopened, record unit and mocked integration evidence for schemas,
      authentication, policy, redaction, idempotency, state transitions, serialization,
      cancellation, timeouts, recovery, and denial of secrets, destructive shell, remote Git
      mutation, arbitrary workspaces, live-trading requests, and unapproved MCP.
- [ ] **Gate 3 — constrained Cursor CLI smoke test:** **paused (Path A).** Do not burn agent/API
      budget on smoke unless explicitly reopened.
- [ ] **Gate 4 — external ingress and private Custom GPT review:** **paused for cost.** Separate
      human approval required before Cloudflare Tunnel, Custom GPT Action, public HTTPS, remote
      MCP, or external network tests.
- [ ] **Gate 5 — controlled end-to-end evidence:** **paused for cost.** Only after Gate 4 reopen.
- [ ] **Gate 6 — production or scope expansion:** create a separate ADR if ever needed. No gate
      authorizes broker/exchange access, TradingView sessions, order routing, capital allocation,
      live trading, `git push`, or production deployment.
- [x] **Path A decision (2026-07-23):** Cursor-native director is the operational path; bridge
      external stages paused; critical path is QT-R-001 review (Priority 3).
- [ ] Do not describe the bridge as connected, secure, or ChatGPT-operational. Manual copy/paste
      and Cursor-native director remain the supported workflows.

## Priority 3 — Research streams + QT-R-001 (**active critical path**)

- [x] Establish research streams (ADR-005):
      [`docs/research/RESEARCH_STREAMS.md`](docs/research/RESEARCH_STREAMS.md).
- [x] Establish global session architecture (Asia → London → overlap → NY → next Asia):
      [`knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md`](knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md).
- [x] Register/revise `QT-R-001` — *XAUUSD Global Session Transition and London Breakout Research*
      — stream `NEW_STRATEGY`, status now `EXPERIMENT-PLANNED`:
      [`research/strategies/20260721-xauusd-global-session-transition-london-breakout/`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/README.md).
- [x] **Research review (2026-07-23):** accept streams + session architecture; choose Asia anchor
      **`A-TK` Tokyo** and primary session windows; pre-register experiment plan (6 baselines,
      IS/VAL/OOS, cost ladder). Review:
      [`reviews/2026-07-23-research-review.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/reviews/2026-07-23-research-review.md);
      plan:
      [`EXPERIMENT_PLAN.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/EXPERIMENT_PLAN.md).
- [x] **Experiment plan accepted (2026-07-23):**
      [`reviews/2026-07-23-experiment-plan-acceptance.md`](research/strategies/20260721-xauusd-global-session-transition-london-breakout/reviews/2026-07-23-experiment-plan-acceptance.md);
      status `EVIDENCE-GATHERING`.
- [ ] **Next action — EV-001:** obtain/link continuous XAUUSD 15m UTC OHLC; record feed label;
      then TEMPORAL audit and B1–B6 under Base costs. Still no Pine / `QT-S-###`.
- [ ] Do **not** implement Pine, backtest for promotion, or optimize; do **not** assign `QT-S-###`
      yet.
- [ ] Do **not** claim QT-R-001, session relationships, or the workflow are empirically validated.

## Not yet

- [ ] Do not begin optimization.
- [ ] Do not deploy to production or enable live/automated trading.
- [ ] Do not create `/srv/quantrading`, service accounts, or V3 services (roadmap Phases 3+).
