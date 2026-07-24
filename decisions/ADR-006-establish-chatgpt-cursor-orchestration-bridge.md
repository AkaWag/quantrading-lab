# ADR-006: Establish the ChatGPT–Cursor Orchestration Bridge

- Status: **superseded / archived** (2026-07-23) — not fit for QuanTrading day-to-day operations
- Superseded by: [`ADR-007-external-signum-agent-lab-archive-adr-006.md`](ADR-007-external-signum-agent-lab-archive-adr-006.md)
- Date: 2026-07-23
- Owner: Aka Wag
- Amendment: 2026-07-23 — local prototype implementation approved with the governed Cursor CLI
  as the default backend; the SDK adapter is retained but sandbox-gated.
- Archive note: Gate 1 local code/docs may remain as historical R&D. Do **not** resume Gates 2–5,
  Custom GPT Action, Cloudflare, or HTTPS claims. Ops path is **external Signum + GitHub bus**.

## Context

QuanTrading Lab uses repository-governed Cursor agents and specialist skills, while strategic
direction may originate in a private ChatGPT conversation. The present handoff is manual:
instructions and results are copied between the two products. That preserves human control but
creates delay, transcription risk, duplicate context, and weak run traceability.

The approved design is an asynchronous bridge: a private Custom GPT submits a bounded request to
an authenticated HTTPS API, the bridge creates or resumes a governed Cursor agent through an
approved runtime adapter, and the client polls for status and a final handover. Long-running agent work cannot
depend on a synchronous request or an unsolicited callback to ChatGPT.

The V2.5 → V3 roadmap does not yet authorize general platform services. The bridge therefore
requires a narrow, explicit exception with stronger constraints than a normal development tool.

## Decision

Adopt the architecture and staged gates documented in
[`../docs/architecture/ORCHESTRATION_BRIDGE.md`](../docs/architecture/ORCHESTRATION_BRIDGE.md)
and the threat model in
[`../docs/security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md`](../docs/security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md).

The target design is:

- a project-local TypeScript service on Node.js 22;
- an asynchronous REST contract for session creation, run submission, polling, and cancellation;
- durable local mappings between external session IDs, Cursor agent IDs, and run IDs;
- explicit local Cursor runtime rooted only at this workspace;
- fail-closed policy enforcement independent of prompts and independent of any assumed
  `.cursor/cli.json` behavior;
- a private Custom GPT Action as the intended external client;
- optional MCP access to the same bounded task core, disabled by default, with no arbitrary
  inbound or outbound MCP configuration;
- human approval at every existing architecture, credential, external-network, release, and
  live-trading gate.

### Explicit local-only prototype exception

ADR-006 authorizes an exception to the current V3 sequence **only** for a local prototype:

- bind to loopback only; do not expose a LAN, public, tunnel, or externally reachable endpoint;
- use project-local dependencies and runtime files only; do not use `sudo`, install system
  packages/services, or create `/srv/quantrading`;
- use no external credentials, network calls, Custom GPT Action, Cloudflare Tunnel, webhook, or
  remote MCP server;
- permit research and engineering tasks only; prohibit broker/exchange access, TradingView
  sessions, order routing, live trading, capital allocation, production deployment, `git push`,
  and arbitrary workspaces;
- keep the MCP adapter disabled and the outbound MCP allowlist empty;
- treat all generated work as reviewable proposals subject to the existing repository workflow.

The owner subsequently approved the exact project-local implementation and a constrained
credentialed read-only smoke test. This approval does not include external HTTPS ingress, Custom
GPT connection, service installation, production operation, MCP enablement, or scope expansion.
Those remain subject to their applicable staged gates. Production service adoption or
live-trading capability requires a separate ADR.

### Runtime amendment: governed CLI fallback

`@cursor/sdk` 1.0.24 bundles and hard-codes discovery of
`node_modules/@cursor/sdk-linux-x64/bin/cursorsandbox`. Its public
`SandboxOptions` exposes only `enabled`, and neither its published types nor official
documentation provides a helper-path override. The bundled SDK helper therefore does not attach
to the already-installed AppArmor profile for
`~/.local/share/cursor-agent/versions/*/cursorsandbox`. Profiling a user-writable
`node_modules` executable would broaden namespace/capability exposure and is rejected.

The local prototype therefore defaults to the installed Cursor CLI. The adapter uses only
documented options: headless JSON output, explicit workspace, explicit sandbox enablement,
project rules, Ask mode for repository reads, durable chat IDs with `--resume`, and bounded
process cancellation. The existing SDK adapter remains in source for future use but continues to
request SDK sandboxing and must fail closed where that sandbox is unsupported.

## Alternatives considered

- **Continue copy/paste only.** Safest and simplest, but rejected as the long-term workflow
  because it preserves transcription overhead and weak run traceability. It remains the fallback.
- **Use Cursor alone as director.** Technically efficient and already governed, but rejected for
  this decision because it does not meet the requested ChatGPT-led interaction model.
- **Install the OpenAI Codex extension beside Cursor.** Rejected: co-location does not create a
  bidirectional ChatGPT-to-Cursor orchestration channel.
- **Use a synchronous HTTPS proxy.** Rejected: agent runs may exceed client request limits and
  need durable status, cancellation, and recovery.
- **Expose MCP directly as the first client interface.** Deferred: the selected private Custom
  GPT uses an Action, while MCP remains an optional, separately authenticated adapter.
- **Deploy a managed cloud service immediately.** Rejected for the prototype: it introduces
  credentials, data residency, operations, cost, and a larger attack surface before local policy
  enforcement is proven.
- **Expose this Ubuntu host publicly from the start.** Rejected: it conflicts with the local-only
  exception and would prematurely cross external, client, service, and workspace trust boundaries.
- **Allow prompt-defined tools, workspaces, or MCP servers.** Rejected: prompt text is untrusted
  data and cannot grant authority.

## Consequences

- Positive: defines a traceable path from ChatGPT requests to governed Cursor work and structured
  results while retaining human authority.
- Positive: asynchronous job IDs and durable mappings support retries, polling, cancellation, and
  auditability without pretending ChatGPT can receive unsolicited agent messages.
- Positive: local-first staging permits policy and failure-mode testing before any external
  exposure.
- Positive: REST and an optional MCP adapter can reuse one policy-controlled task core.
- Cost: adds an application, local state, dependency lifecycle, audit records, and operational
  responsibilities that do not exist today.
- Cost: external integration cannot proceed until authentication, ingress, privacy, retention,
  denial tests, and incident handling pass review.
- Limitation: the bridge does not make AI an autonomous director or decision-maker; human
  approval and research lifecycle gates remain authoritative.
- Limitation: acceptance of this ADR is not evidence that the service, Cursor SDK flow, Custom GPT
  Action, tunnel, MCP adapter, or end-to-end workflow works.

## Risks

- **Prompt injection or authority escalation** — treat all request text and repository content as
  untrusted; enforce operation, workspace, tool, shell, Git, and MCP allowlists in code.
- **Secret disclosure** — prohibit secret-bearing inputs and outputs, redact logs, keep runtime
  credentials outside Git, and test denial of `.env`, key, and token access.
- **Remote code execution or destructive mutation** — use least privilege, loopback-only binding,
  fail-closed hooks, payload limits, and explicit denies for destructive shell and remote Git
  actions.
- **Cross-session data leakage** — authenticate every request, use opaque IDs, authorize access to
  each session/run, serialize sends per Cursor agent, and test isolation.
- **Replay, duplicate work, or runaway cost** — require idempotency, replay protection, rate and
  concurrency limits, timeouts, cancellation, and bounded output.
- **False reliance on one control layer** — verify CLI behavior and duplicate critical denies in
  bridge policy and fail-closed hooks; retain the same requirement if the SDK is reconsidered.
- **External service compromise or outage** — keep external ingress outside the local gate,
  minimize shared data, preserve manual copy/paste fallback, and fail closed.
- **Trading-control bypass** — expose no broker, exchange, TradingView-session, order-routing, or
  live-trading operation; prompt wording cannot override this prohibition.

## Verification

ADR acceptance is verified by review of the governance artifacts and consistency checks only.
The bridge must remain described as **approved, not implemented, and not operational**.

Before the local prototype can be considered verified, a later implementation must provide exact
evidence for:

- unit tests covering schemas, authentication, policy, redaction, idempotency, state transitions,
  serialization, cancellation, and timeouts;
- mocked integration tests at Cursor CLI/SDK and MCP boundaries;
- denial tests for secrets, private keys, destructive shell commands, remote Git mutation,
  arbitrary workspaces, live-trading requests, and unapproved MCP servers;
- a constrained real local Cursor CLI smoke test performing a read-only repository task;
- type checking, linting, tests, `git diff --check`, `bash scripts/verify.sh .`, and
  `bash scripts/doctor.sh`, with exact results recorded.

External Custom GPT, HTTPS ingress, Cloudflare, MCP, and end-to-end behavior are not verified by
this ADR and cannot be claimed until their later gates are explicitly approved and evidenced.

## Rollback

Before implementation, rollback is documentation-only: supersede ADR-006, remove the bridge
architecture and threat-model documents, and remove its entries from system boundaries, project
status, and next actions.

After a local prototype exists, stop the process, remove only its project-local ignored runtime
state and dependencies using a separately reviewed narrow procedure, and revert the implementing
change. Do not delete audit evidence needed for review. If external ingress was separately
approved, disable ingress first and revoke bridge-specific credentials before removing local
components. Record withdrawal or replacement in a superseding ADR; retain this historical record.
