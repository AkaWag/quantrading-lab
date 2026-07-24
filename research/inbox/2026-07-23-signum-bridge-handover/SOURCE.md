# Handover — Signum Bridge & Agents Cockpit → QuanTrading

**From:** Claude (offline Desktop director / Signum bridge referee — "Hermes")
**To:** QuanTrading Lab (`~/quantrading/`) — owner Aka Wag
**Date:** 2026-07-23
**Status:** Inbound handover artifact for review. Not a governance change — no ADR is claimed, nothing here is committed or pushed. Placement/commit is the owner's call under `docs/governance/DECISION_GOVERNANCE.md`.

---

## 1. Purpose

This documents a working multi-agent **director + top-level-agents** setup built in `~/signum-ai-strategy/` (the "Signum bridge"), and how it maps onto QuanTrading's own **`agent-development`** scaffold and **Director Operating Model**. It is offered as a reference implementation and an integration proposal — a portable control layer that can be pointed at *any* strategy under QuanTrading's governance to jointly research and improve it.

Full internal spec: `~/signum-ai-strategy/docs/SIGNUM-BRIDGE-CAPABILITIES.md`.

## 2. What the setup is

Two AI engineers working in tandem behind a hard live-money firewall:

- **Codex** (OpenAI Codex CLI, GPT-5 class) — implementer/optimiser: runs backtests, writes/mutates strategy variants.
- **Claude / "Hermes"** (Opus 4.8) — referee/peer: research, adversarial overfit review, cross-engine validation, direction-setting.

They collaborate over a **file bus** mediated by a daemon; a **GUI Control Centre** (`http://127.0.0.1:8788`) shows each agent's live status and the "position" it holds, with **independent on/off toggles**. The whole thing is systemd-supervised with **STOP-aware boot/crash resume**, so long autonomous runs survive unplanned downtime and resume where they left off.

## 3. Direct mapping onto QuanTrading's `agent-development` scaffold

QuanTrading's `agent-development/` defines six priorities but its directories are currently empty (`.gitkeep`). The Signum bridge is a working implementation of exactly those:

| `agent-development` priority | Signum bridge component |
|---|---|
| Agent registry | `bridge/agents.json` (editable names/roles) |
| Workflow orchestrator | `bridge/daemon.py` |
| Agent runner | `bridge/start.sh` + `bridge/watchdog.sh` |
| **Control Centre UI** | `bridge/panel.py` (:8788) |
| Testing / governance | STOP flag · circuit breakers · `boundary.py` firewall · resume-guard |

It is also a concrete seed of the **V3** vision (a layer that *hosts and manages* V2.5 workspaces): a control/orchestration layer that sits above a strategy workspace and drives agents on it.

## 4. "Works on any given strategy"

The bridge is strategy-agnostic. `BRIDGE_KICKOFF` scopes the agents to a specific task/workspace — point it at a `QT-S-###` strategy and its gated workflow, and the Codex↔Claude loop works that strategy. First candidate targets already in the repo: `pine/strategies/{baseline,institutional}_strategy_v6.pine`, or the active **QT-R-001** XAUUSD London-breakout research.

The bridge's **two-engine referee + out-of-sample firewall** directly serves QuanTrading's research-integrity mandate (falsifiability, baseline-before-promotion, retained negatives, evidence) — the demonstrated validation capability `PROJECT_STATUS.md` notes is not yet exercised.

## 5. Recommended integration (respects your cost + governance choices)

QuanTrading deliberately uses **GitHub repo-artifacts as the handoff bus** and has **paused the real-time HTTPS bridge (ADR-006) for cost**. This setup does **not** reintroduce that cost:

> Run the Signum bridge as a **local, on-machine, real-time joint-work engine** (Codex + Claude iterate a strategy live, cheaply). Land **accepted results as GitHub artifacts** into `AkaWag/quantrading-lab` for the Cursor `research-director` to consume.

It complements the GitHub bus (adds real-time collaboration the artifact flow lacks); it is not the paused HTTPS bridge; it adds no external/cloud cost. `git push` stays human-approved.

## 6. Known adapter gap

QuanTrading strategies are **Pine v6 / TradingView**; the Signum bridge currently drives Python / trader-dev (Pine v5) / Signum engines. Joint Pine-v6 work would use the **TradingView MCP** + QuanTrading's `.cursor/skills` for Pine development and review. This is the one real piece of adapter work before a Pine-v6 strategy can be jointly improved end-to-end.

## 7. Self-test (owner can run directly)

```bash
bash ~/signum-ai-strategy/bridge/ping.sh codex     # Codex identifies itself
bash ~/signum-ai-strategy/bridge/ping.sh claude    # Claude identifies itself
```

## 8. Suggested next steps (for owner decision)

1. Pick one strategy as a joint-improvement demo (e.g. `baseline_strategy_v6.pine` or QT-R-001).
2. Decide: port the bridge/panel *into* the `agent-development` scaffold, or keep it external and feed the GitHub bus.
3. Settle naming/roles of director vs implementer agents (registry: `bridge/agents.json`).
4. Build the Pine-v6 / TradingView-MCP adapter for §6.

*Nothing in this setup writes live-money state or performs live trading. All strategy work is backtest/shadow/paper until deliberately promoted.*
