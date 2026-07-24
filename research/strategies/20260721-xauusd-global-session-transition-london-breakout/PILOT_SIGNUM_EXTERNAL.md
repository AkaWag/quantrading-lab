# QT-R-001 — Signum external Agent Live pilot (gold)

- Research ID: QT-R-001
- Pilot status: **ready to start** (Signum external; ADR-007)
- Date: 2026-07-23
- Owner: Aka Wag
- ADR: [`../../../../decisions/ADR-007-external-signum-agent-lab-archive-adr-006.md`](../../../../decisions/ADR-007-external-signum-agent-lab-archive-adr-006.md)

> **Agent Live** = Codex + Claude LIVE in the Signum lab Control Centre on this gold project.
> **Not** live money, brokers, order routing, or TradingView session automation.

## Why this pilot

ASAP prove the dual-agent loop against real QuanTrading gold research (accepted experiment plan),
with the owner testing in line with the agents. Porting Signum into the repo is **later**.

## Position checklist (get Agent Live up)

| Step | Action | Where |
|---|---|---|
| 1 | Panel up | `systemctl --user status signum-bridge-panel.service` → http://127.0.0.1:8788 |
| 2 | Optional self-test | `bash ~/signum-ai-strategy/bridge/ping.sh codex` and `… claude` |
| 3 | Clear STOP if deliberately halted | only if owner intends Agent Live |
| 4 | Start scoped bridge | paste kickoff below into `BRIDGE_KICKOFF` |
| 5 | Land accepted outputs | commit into this QT-R-001 tree; human-approved `git push` |

## Binding constraints (do not violate)

- Follow accepted [`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md) lock (windows, B1–B6, IS/VAL/OOS, costs).
- First evidence gate: [`evidence/EV-001-data-acquisition.md`](evidence/EV-001-data-acquisition.md).
- **No Pine**, **no `QT-S-###`**, no optimization tournament, no silent OOS peeking.
- Do not write Signum live-money / Reflex state; do not enable live trading from this pilot.
- Cursor remains research-director of record for governance wording in this repo.

## Immediate agent goal (GOAL ACHIEVED when)

1. EV-001 resolved: continuous XAUUSD 15m UTC OHLC linked; feed/exchange label recorded.
2. TEMPORAL mapping note drafted for A-TK / London / NY windows (confirmed-bar rules).
3. Runnable protocol for B1–B6 under Base costs on IS written as evidence stubs (even if full
   runs wait on tooling) — **or** first IS baseline runs completed if an allowed engine exists.
4. `PROGRESS.md` (Signum) states `GOAL ACHIEVED` only when owner agrees EV-001 is closed or an
   explicit pause/amendment is filed under `reviews/`.

## BRIDGE_KICKOFF (copy into Signum start)

```text
QuanTrading gold pilot QT-R-001 — Agent Live (lab only, no live money).

Workspace of record:
  ~/quantrading/workspaces/main/research/strategies/20260721-xauusd-global-session-transition-london-breakout/

Read first:
  README.md, EXPERIMENT_PLAN.md (ACCEPTED), SPECIFICATION.md §C,
  evidence/EV-001-data-acquisition.md,
  reviews/2026-07-23-experiment-plan-acceptance.md

Mission:
  1) Close EV-001 — obtain/link multi-year XAUUSD 15m UTC OHLC; record feed label in EV-001.
  2) Draft TEMPORAL session-window audit notes for A-TK Tokyo + locked London/NY windows.
  3) Prepare B1–B6 Base-cost IS protocol under the experiment lock; run only if data+engine allow.
  4) Land accepted notes/artifacts as files under that QT-R-001 folder (evidence/ or reviews/).
  5) Do NOT write Pine, QT-S-###, optimize parameters, touch OOS for tuning, or live-trade.

Codex = implementer (data plumbing, protocol, allowed runs).
Claude/Hermes = referee (overfit/adversarial, plan lock, evidence integrity).
Stop when EV-001 is closed (or blocked with a dated amendment) and TEMPORAL+baseline protocol
is filed — then set GOAL ACHIEVED for owner review.
```

## Start commands (Signum tree)

```bash
cd ~/signum-ai-strategy
# Panel should already be LIVE under systemd; confirm:
systemctl --user status signum-bridge-panel.service
# Scoped Agent Live start (owner-operated):
BRIDGE_KICKOFF="$(cat <<'EOF'
# paste kickoff text from above
EOF
)" bash bridge/start.sh
```

Halt: `bash bridge/stop.sh` or `touch STOP`.

## After Agent Live produces work

1. Owner reviews bus / `PROGRESS.md` / new QT-R-001 files.
2. Accept → keep in Git; reject → FAILURE_RECORD / amendment.
3. Human-approved `git push` to put results on the GitHub bus for Cursor continuity.

## Explicitly deferred

- Port Signum → QuanTrading `agent-development/`
- Pine v6 / TradingView MCP joint mutation loop
- Any revival of ADR-006 HTTPS / Custom GPT Action
