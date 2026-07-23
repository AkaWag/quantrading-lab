# ADR-007: External Signum Agent Lab + Archive ADR-006 HTTPS Bridge

- Status: accepted
- Date: 2026-07-23
- Owner: Aka Wag
- Supersedes: ADR-006 (archived — not fit for QuanTrading day-to-day operations)

## Context

ADR-006 authorized a ChatGPT→HTTPS→Cursor orchestration bridge. A local Gate 1 prototype exists,
but external stages were paused for cost, and the design is **not fit for purpose** for the whole
operating model. The durable shared handoff that *does* fit is private GitHub `origin`.

Separately, a working multi-agent lab already exists **outside** this repository in
`~/signum-ai-strategy/` (Signum bridge + Agents Cockpit): Codex implementer + Claude referee over
a local file bus, Control Centre at `http://127.0.0.1:8788`, STOP/circuit breakers, and a hard
live-money firewall. Handover:
[`../../../HANDOVER-FROM-CLAUDE-signum-bridge.md`](../../../HANDOVER-FROM-CLAUDE-signum-bridge.md)
(and inbox copy under `research/inbox/`).

The owner decision is to **operate Signum externally now**, **archive ADR-006**, keep GitHub as
the handoff bus, and run an ASAP **gold (QT-R-001) Agent Live pilot** — agents LIVE on the gold
research path — with porting Signum into `agent-development/` deferred.

## Decision

1. **Archive ADR-006** as an ops path. Retain decision/docs/local prototype code only as
   historical R&D. Do not spend on Gates 2–5, Custom GPT Action, Cloudflare Tunnel, or claims that
   ChatGPT drives Cursor over HTTPS.
2. **Adopt Signum externally** (`~/signum-ai-strategy/`) as the on-machine real-time agent lab
   (Agent Live / Control Centre). It is **not** ported into this repo yet.
3. **Keep GitHub `origin`** as the shared durable handoff bus between Signum outcomes, Desktop
   directors, and Cursor `research-director`.
4. **First pilot target: gold / QT-R-001** (XAUUSD session-aware London breakout research). Goal:
   Agent Live interacting with this project under the accepted experiment plan; owner tests in
   line with the agents.
5. **Live-money wall remains closed.** “Agent Live” means agents running in the lab (Screen 2),
   not live capital, brokers, or order routing. Promotion to any live trading requires separate
   explicit approval.
6. **Port later.** Moving Signum into QuanTrading `agent-development/` requires a future ADR.

## Alternatives considered

- **Continue ADR-006 external stages** — rejected: cost and unfit operating shape.
- **Port Signum into the repo immediately** — deferred: slows the gold pilot; external works now.
- **GitHub-only handoff with no Agent Live** — rejected for this phase: lacks real-time dual-agent
  iteration the owner wants for the gold live test of the agent setup.
- **Point Signum at a Pine `QT-S-###` first** — deferred: no strategy ID yet; QT-R-001 is the
  active gold research path. Pine-v6 adapter remains a known gap for later joint Pine work.

## Consequences

- Positive: uses a proven local Agent Live stack without HTTPS/Action cost.
- Positive: gold research becomes the ASAP proving ground for agents + governance.
- Positive: GitHub bus and Path A Cursor director remain intact.
- Cost: two trees to operate (`signum-ai-strategy` + `quantrading` workspace) until a later port.
- Cost: Pine-v6 / TradingView joint improvement still needs an adapter before end-to-end Pine
  mutation loops.
- Limitation: ADR-006 prototype code may linger untracked/unmerged; it is not the ops path.

## Risks

- **Confusion of Agent Live vs live money** — mitigate with explicit language in status/pilot docs
  and Signum’s existing live-money firewall.
- **Agents mutating QT outside the experiment lock** — kickoff must bind to accepted
  `EXPERIMENT_PLAN` / EV-001; no Pine / `QT-S-###` without separate approval.
- **Uncommitted Signum results never reach GitHub** — land accepted artifacts in-repo; push only
  with human approval.
- **Split-brain governance** — Cursor remains research-director of record for QT artifacts;
  Signum proposes; human accepts.

## Verification

- ADR-006 status marked superseded/archived; operating model and `PROJECT_STATUS` / `NEXT_ACTIONS`
  point at Signum external + QT-R-001 pilot.
- Pilot packet and `BRIDGE_KICKOFF` text exist under QT-R-001.
- Owner can bring Agent Live up from Signum (`panel` + scoped `BRIDGE_KICKOFF`) without touching
  ADR-006 services.

## Rollback

Supersede this ADR: halt Signum bridge (`STOP`), revert operating-model pointers to GitHub-only
Path A (or a future replacement), and leave ADR-006 archived unless a new ADR explicitly revives
HTTPS orchestration.
