# Director Operating Model

How QuanTrading Lab directs work across Cursor, Desktop assistants, Signum Agent Live, tokens,
MCP, and GitHub. Operational SOP after **ADR-007** (Signum external; ADR-006 archived).
Does **not** authorize live trading, production deploy, or revival of the HTTPS Custom GPT bridge.

## Layers (do not conflate)

| Layer | Choice |
|---|---|
| Director seat (repo governance) | Cursor Agent with `research-director` |
| Agent Live (real-time dual-agent lab) | **Signum external** — `~/signum-ai-strategy/` (Codex + Claude/Hermes, panel `:8788`) |
| Optional offline directors | ChatGPT Desktop and/or Claude Desktop (subscription) |
| Shared durable handoff bus | Private GitHub `origin` (`AkaWag/quantrading-lab`) |
| Primary Cursor billing | Cursor account tokens |
| Catalog / cost routing | OpenRouter only when deliberate (Option 3) |
| Direct OpenAI API as orchestrator | Not the default underlayer |
| MCP Shape A | Curated Cursor tool MCP after review |
| MCP Shape B | Desktop host + MCP for offline work |
| MCP Shape C | Unofficial LLM-bridge MCP — deferred |
| ADR-006 HTTPS bridge | **Archived** (superseded by ADR-007) |
| Port Signum → `agent-development/` | **Deferred** (future ADR) |

## Agent Live vs live money

| Term | Meaning |
|---|---|
| **Agent Live** | Agents RUNNING in Signum Control Centre on a scoped kickoff (lab Screen 2) |
| **Live money / live trading** | Real capital / order routing — **forbidden** unless separately approved |

Signum must keep its live-money firewall. QuanTrading gates (no Pine/`QT-S-###` without approval,
experiment locks) still apply to work landed in this repo.

## Tokens (Option 3 hybrid)

1. **Default:** Cursor-native models in Agent mode for repo director/implementer work.
2. **Director turns (Cursor):** frontier model.
3. **Implementer turns / subagents (Cursor):** cost-effective model (e.g. Grok 4.5 Fast).
4. **Signum agents:** billed/operated under Signum’s own Codex/Claude setup (external tree).
5. **OpenRouter:** only for deliberate Cursor catalog/cost routing; never commit `sk-or-` keys.
6. OpenRouter is **not** the orchestrator and does not replace GitHub handoff.

## Operating flow (gold pilot default)

```text
Signum Agent Live (external)
  → scoped BRIDGE_KICKOFF on QT-R-001 (or later QT-S-###)
  → accepted files land in quantrading workspace
  → human-approved git commit / push to origin
  → Cursor research-director continuity / governance
```

Pilot packet:
[`../../research/strategies/20260721-xauusd-global-session-transition-london-breakout/PILOT_SIGNUM_EXTERNAL.md`](../../research/strategies/20260721-xauusd-global-session-transition-london-breakout/PILOT_SIGNUM_EXTERNAL.md)

## GitHub shared handoff (durable bus — keep)

```text
Signum / Desktop / Cursor
  → durable artifacts in repo
  → commit + human-approved push to origin
  → other seats pull / continue
```

| Item | Status |
|---|---|
| Private `origin` configured; `main` pushed | Ready |
| Signum external Agent Live | Ops path (ADR-007); port deferred |
| Agent `git push` | Human-approved only |
| Uncommitted local work | Not on the bus until committed/pushed |
| ADR-006 Action/tunnel | Archived — do not revive for ops |

### Cursor pickup ritual

1. `PROJECT_STATUS.md` + `NEXT_ACTIONS.md`.
2. `git status` / branch vs `origin`.
3. Check Signum pilot / QT-R-001 `evidence/` for Agent Live outputs.
4. Director chat + `research-director` as needed.
5. End with gate, blockers, next action. Push only with human approval.

## MCP shapes

- **Shape A — tool MCP:** after review, for real tool gaps.
- **Shape B — Desktop host MCP:** OK offline; direction still lands in GitHub.
- **Shape C — unofficial LLM-bridge MCP:** deferred.
- **ADR-006 bridge MCP:** archived with ADR-006; do not enable for ops.

## Explicitly out of ops path

- Custom GPT Action, Cloudflare Tunnel, OpenAI API as Cursor orchestrator (ADR-006).
- Live trading, brokers, production V3 services.
- Porting Signum into this repo before a dedicated ADR.

## Pickup phrase

> Continue QuanTrading V2.5. ADR-007: Signum Agent Live external; GitHub handoff bus; ADR-006
> archived. Gold pilot QT-R-001 — EV-001 then TEMPORAL + B1–B6. No live money. No Pine /
> QT-S-### until separate approval. Port Signum later.

## Related documents

- [`ADR-007`](../../decisions/ADR-007-external-signum-agent-lab-archive-adr-006.md)
- [`CURSOR_HANDOVER.md`](CURSOR_HANDOVER.md)
- [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md)
- [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md)
- Inbox: [`../../research/inbox/2026-07-23-signum-bridge-handover/`](../../research/inbox/2026-07-23-signum-bridge-handover/)
- [`../../.cursor/skills/research-director/SKILL.md`](../../.cursor/skills/research-director/SKILL.md)
