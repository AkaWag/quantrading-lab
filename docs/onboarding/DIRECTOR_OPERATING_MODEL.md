# Director Operating Model

How QuanTrading Lab directs work across Cursor, Desktop assistants, tokens, MCP, and GitHub.
This is the operational SOP for Path A + Option 3 hybrid tokens + GitHub shared handoff.
It does **not** authorize live trading, production deploy, or ADR-006 external bridge stages.

## Layers (do not conflate)

| Layer | Choice |
|---|---|
| Director seat (repo work) | Cursor Agent with `research-director` |
| Optional offline directors | ChatGPT Desktop and/or Claude Desktop (subscription) |
| Shared handoff bus | Private GitHub `origin` (`AkaWag/quantrading-lab`) |
| Primary Agent billing | Cursor account tokens |
| Catalog / cost routing | OpenRouter only when deliberate (Option 3) |
| Direct OpenAI API | Not the default underlayer |
| MCP Shape A | Curated Cursor tool MCP after review |
| MCP Shape B | Desktop host + MCP for offline work |
| MCP Shape C | Unofficial LLM-bridge MCP — deferred |
| ADR-006 HTTPS bridge | Dormant / paused for cost |

## Tokens (Option 3 hybrid)

1. **Default:** use Cursor-native models in Agent mode.
2. **Director turns:** frontier model (e.g. Claude Opus or latest GPT class in the Cursor picker).
3. **Implementer turns / subagents:** cost-effective model (e.g. Grok 4.5 Fast).
4. **OpenRouter:** enable only for a deliberate session — OpenAI key field + override base URL
   `https://openrouter.ai/api/v1/cursor`, add explicit OpenRouter model IDs. Toggle off when
   Cursor-native routing conflicts. Never commit `sk-or-` keys.
5. OpenRouter is **not** the orchestrator and does not replace GitHub handoff.

## GitHub shared handoff (primary Desktop ↔ Cursor path)

This is why the private GitHub remote was established. Prefer it over paste storms and over the
paused HTTPS Custom GPT bridge.

```text
ChatGPT Desktop or Claude Desktop
  → write decisions/specs into repo artifacts (or PR / issue text)
  → commit + human-approved push to origin
  → Cursor Agent pulls / reads artifacts
  → implements under skills and rules
  → commit locally; push only with human approval
```

### Operational viability

| Item | Status |
|---|---|
| Private `origin` configured; `main` pushed | Ready |
| Cursor agents implement from workspace/repo | Ready |
| Either Desktop product as offline director | Viable — same bus |
| Silent Desktop → `origin` sync | Not automatic — needs write path (human commit, PR, or reviewed GitHub MCP) |
| Agent `git push` | Human-approved only (by design) |
| Uncommitted local work | Not on the bus until committed/pushed |
| Cost vs ADR-006 Action/tunnel | Prefer GitHub bus |

### Handoff packet convention

Desktop (or human) should land durable text in the repo, for example:

- updates under `research/strategies/.../` for QT-R-### work;
- a short dated note under `research/inbox/<date-topic>/` with `SOURCE.md` if ingesting external material;
- or a clear PR/issue body that points at files to change.

Avoid “director only in chat history” with nothing committed.

### Cursor pickup ritual

1. `PROJECT_STATUS.md` + `NEXT_ACTIONS.md`.
2. `git status` / branch vs `origin` — note uncommitted trees.
3. Open director chat (frontier) + `research-director` (or `prompts/00-run-full-pipeline.md`).
4. Implement on a cost-effective model / specialist skills.
5. End with gate, blockers, files changed, next action. Push only if the human approves.

## MCP shapes

- **Shape A — tool MCP:** Cursor Agent → reviewed MCP → SaaS/OAuth or local tools (e.g. docs,
  browser). Not LLM API billing. Add only for a real tool gap; review auth, egress, retention.
- **Shape B — subscription Desktop host:** ChatGPT/Claude Desktop uses MCP for *their* tools;
  direction still lands in GitHub for Cursor. Offline OK.
- **Shape C — unofficial LLM-bridge MCP:** Cursor → third-party MCP → another subscription CLI.
  Deferred. Needs separate security and cost review (nested usage / ToS). Do not install under
  this SOP.
- **ADR-006 bridge MCP adapter:** remains disabled; empty outbound allowlist.

## Explicitly paused

- Custom GPT Action, Cloudflare Tunnel, OpenAI API as orchestration.
- Bridge Gates 2–5 smoke/verification spend unless explicitly reopened.
- Live trading, brokers, production V3 services.

## Pickup phrase

> Continue QuanTrading V2.5. Path A director on Cursor tokens (frontier director, cheap
> implementers). OpenRouter only when deliberate. Shared handoff = private GitHub. ChatGPT/Claude
> Desktop may write artifacts into the repo; Cursor implements. ADR-006 HTTPS bridge paused.
> Next product work is QT-R-001 EV-001 data then TEMPORAL + B1–B6 (evidence only).

## Related documents

- [`CURSOR_HANDOVER.md`](CURSOR_HANDOVER.md)
- [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md)
- [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md)
- [`../architecture/ORCHESTRATION_BRIDGE.md`](../architecture/ORCHESTRATION_BRIDGE.md)
- [`../../.cursor/skills/research-director/SKILL.md`](../../.cursor/skills/research-director/SKILL.md)
- [`../../prompts/00-run-full-pipeline.md`](../../prompts/00-run-full-pipeline.md)
