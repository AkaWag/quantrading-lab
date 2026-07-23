# ChatGPT–Cursor Orchestration Bridge

> **ARCHIVED (ADR-007, 2026-07-23).** Not the QuanTrading ops path. Superseded by external Signum
> Agent Live + GitHub handoff. Retain for historical design/threat-model reference only. Do not
> resume Gates 2–5, Custom GPT Action, or Cloudflare for day-to-day operations.

This document defines the (archived) target architecture and staged gates for the
ChatGPT–Cursor Orchestration Bridge. The governing decision is
[`../../decisions/ADR-006-establish-chatgpt-cursor-orchestration-bridge.md`](../../decisions/ADR-006-establish-chatgpt-cursor-orchestration-bridge.md)
(**superseded** by
[`../../decisions/ADR-007-external-signum-agent-lab-archive-adr-006.md`](../../decisions/ADR-007-external-signum-agent-lab-archive-adr-006.md));
security controls are defined in
[`../security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md`](../security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md).

## Current state

**Archived.** Local Gate 1 prototype may exist as R&D only. Ops path is Signum external Agent Live
(ADR-007). The service is not an externally connected or production system.

## Purpose

Reduce manual handoff between a private ChatGPT director conversation and repository-governed
Cursor agents while preserving:

- human ownership of material decisions;
- repository rules, skills, research lifecycle, and evidence gates;
- least privilege and explicit approval for side effects;
- durable run status and an auditable final handover;
- a complete prohibition on live-trading and order-routing capability.

“Bidirectional” means request submission followed by status/result retrieval. It does not mean
that ChatGPT and Cursor have an unrestricted peer channel, or that the bridge can send an
unsolicited message to an idle ChatGPT conversation.

## Target components

### Private Custom GPT client (future external stage)

- Uses an authenticated HTTPS Action to create a session, submit a run, poll status, and request
  cancellation.
- Receives only bounded, redacted status and handover data.
- Is external and untrusted with respect to authority; its prompt cannot grant permissions.
- Cannot be connected during the local-only prototype gate.

### HTTPS ingress (future external stage)

- Terminates public HTTPS and forwards only the bridge route to the loopback service.
- Cloudflare Tunnel is the selected candidate, not an installed or approved operational service.
- Requires separate human approval for provider review, authentication, tunnel creation,
  credential handling, configuration, logging, and an external network test.
- The application port must never be exposed directly.

### Local orchestration service

- Project-local TypeScript application targeting Node.js 22.
- Binds to loopback only unless a later external gate is approved.
- Validates authentication, schema, payload size, idempotency, rate/concurrency limits, and policy
  before work enters the queue.
- Returns a run ID promptly and performs agent work asynchronously.
- Redacts audit events and responses; it must not log prompts or outputs by default without an
  approved retention need.

### Durable task and session store

- Stores opaque external session IDs, Cursor agent IDs, run IDs, state transitions, cancellation
  state, and minimum audit metadata.
- Uses project-local SQLite under an ignored runtime directory for the prototype.
- Must not store credentials, `.env` content, private keys, broker data, or TradingView sessions.
- Requires explicit retention, cleanup, migration, corruption recovery, and file-permission tests
  before external exposure.

### Cursor runtime adapters

- The governed Cursor CLI adapter is the default and fixes the workspace root to this repository.
- It invokes only documented CLI options, explicitly enables sandboxing, loads project rules,
  uses Ask mode for repository reads, and persists CLI chat IDs for `--resume`.
- It bounds runtime and captured output, supports cancellation, and redacts terminal errors and
  result text before persistence.
- The Cursor SDK adapter remains available for future use, with
  `local.sandboxOptions.enabled=true`; it must not run unsandboxed.
- `@cursor/sdk` 1.0.24 cannot select the already-profiled CLI sandbox helper and its bundled
  `node_modules` helper is not covered by the installed AppArmor profile. SDK selection therefore
  remains blocked unless a later supported configuration passes sandbox preflight and smoke
  verification.
- Creates or resumes one governed Cursor director agent per bridge session.
- Persists identifiers before waiting or streaming, serializes sends per agent, always waits for
  terminal state, and closes resources.
- Distinguishes startup failure, rejected policy, running, cancelled, failed, and completed states.
- Loads project governance and routes appropriate work through
  [`../../prompts/00-run-full-pipeline.md`](../../prompts/00-run-full-pipeline.md) and
  [`../../.cursor/skills/research-director/SKILL.md`](../../.cursor/skills/research-director/SKILL.md).
- Does not treat [`.cursor/cli.json`](../../.cursor/cli.json), prompts, or the sandbox as sufficient
  alone; critical denies are duplicated in bridge policy and fail-closed hooks.

### Policy enforcement

Policy is code and configuration controlled by the repository owner, not instruction text.
The bridge must:

- allow only named operations and this canonical workspace;
- constrain shell, file, Git, network, and MCP capabilities;
- deny secrets, destructive operations, remote Git mutation, arbitrary workspaces, production
  release/deployment, broker/exchange access, TradingView sessions, capital allocation, order
  routing, and live trading;
- preserve all lifecycle and human-decision gates;
- fail closed if policy, identity, state, SDK behavior, or configuration is uncertain.

### Optional MCP adapter

- Reuses the same authenticated task core for narrowly scoped `create_session`, `submit_run`,
  `get_run`, and `cancel_run` tools.
- Is disabled by default and is not used by the private Custom GPT Action.
- Requires separate authentication and verification before enablement.
- Accepts no client-supplied MCP server URL, command, credential, or tool definition.
- Starts with an empty outbound MCP allowlist. Every later server requires review, pinning,
  explicit scope, and inline SDK configuration.

## Asynchronous contract

The intended versioned API is:

- `POST /v1/sessions` — create a governed bridge session.
- `POST /v1/sessions/{sessionId}/runs` — validate and enqueue one request; return a run ID.
- `GET /v1/runs/{runId}` — return authorized state, blockers, evidence summary, and handover.
- `POST /v1/runs/{runId}/cancel` — request cancellation; cancellation is not claimed until the
  worker confirms terminal state.
- `GET /healthz` — return minimal health data with no environment, version, workspace, secret, or
  run details.

Requests must use authenticated opaque IDs, bounded schemas, idempotency keys, replay protection,
and consistent error responses. Polling is the source of status/result delivery; synchronous
requests must not wait for an agent run to complete.

## Staged gates

### Gate 0 — Governance accepted

- ADR-006, this architecture, the threat model, system boundaries, status, and next actions are
  reviewed and internally consistent.
- No runtime or external behavior is authorized.

### Gate 1 — Local implementation approval

- Human approves the exact service files and project-local dependencies before installation.
- Implementation remains loopback-only, credential-free, network-free, and MCP-disabled.
- Runtime data and generated output are ignored and scoped to the project.

### Gate 2 — Local automated verification

- Unit and mocked integration tests cover policy, state, authentication boundary behavior,
  redaction, idempotency, cancellation, timeout, and failure recovery.
- Denial tests cover secret access, destructive shell, remote Git mutation, arbitrary workspace,
  live-trading requests, and unapproved MCP.
- Exact command results are recorded; a passing test does not authorize external exposure.

### Gate 3 — Constrained local Cursor runtime smoke test

- Human approves a real CLI or sandbox-supported SDK invocation.
- The task is read-only and confined to this repository.
- Runtime permission behavior, session persistence, serialization, waiting, cleanup, and audit output are
  evidenced. Critical restrictions remain duplicated in bridge policy.

### Gate 4 — External ingress and private Custom GPT review

- Human separately approves provider use, credentials, tunnel creation, Action setup, privacy and
  retention, rate limits, incident response, and external testing.
- Authentication, authorization, replay, isolation, redaction, and abuse tests pass before the
  endpoint is made reachable.
- MCP remains a separate, disabled adapter unless separately approved.

### Gate 5 — Controlled end-to-end evidence

- An approved private Custom GPT submits a non-sensitive, read-only task, polls it, and receives a
  redacted handover.
- Exact evidence, limitations, failures, cost, and rollback results are recorded.
- Success establishes only the tested research/development workflow. It does not authorize a
  production service, broader automation, releases, deployment, or trading.

### Gate 6 — Any production or scope expansion

Requires a new ADR, operational ownership, monitoring, backups, recovery, credential rotation,
dependency maintenance, availability expectations, and a refreshed threat model. Live trading or
order routing remains separately prohibited until the repository's explicit human approval,
paper/forward-test evidence, risk, and deployment gates are satisfied.

## Failure behavior

- Reject malformed, unauthorized, duplicate, over-limit, or prohibited requests before enqueueing.
- Do not retry non-idempotent work automatically.
- Mark uncertain worker outcomes as failed or indeterminate, never completed.
- Preserve sufficient redacted evidence for diagnosis without retaining secrets or unnecessary
  prompt content.
- If policy or authentication cannot be loaded, accept no work.
- If the Cursor runtime, database, or ingress fails, preserve manual copy/paste as the fallback.

## Ownership and authority

- **Owner:** Aka Wag.
- **Human principal:** approves architecture, credentials, external access, lifecycle promotion,
  releases, deployment, and any trading-related capability.
- **Bridge:** transports and coordinates bounded work; it has no independent decision authority.
- **Cursor agents:** research and engineering assistants governed by repository rules.
- **ChatGPT client:** an external request origin and presentation surface, not the system of record.
- **Repository:** authoritative for approved artifacts once human-reviewed and stored in Git.

## Related documents

- [`SYSTEM_BOUNDARIES.md`](SYSTEM_BOUNDARIES.md)
- [`../security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md`](../security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md)
- [`../governance/AI_OPERATING_PRINCIPLES.md`](../governance/AI_OPERATING_PRINCIPLES.md)
- [`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md)
- [`V2_5_TO_V3_ROADMAP.md`](V2_5_TO_V3_ROADMAP.md)
