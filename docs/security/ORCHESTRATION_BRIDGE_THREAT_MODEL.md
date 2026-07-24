# Orchestration Bridge Threat Model

This threat model governs the approved target architecture in
[`../architecture/ORCHESTRATION_BRIDGE.md`](../architecture/ORCHESTRATION_BRIDGE.md) and
ADR-006. It is a design control, not evidence that a bridge is implemented, exposed, secure, or
operational.

## Scope and security objective

The bridge is intended to accept a bounded request from an approved client, run only authorized
research or engineering work through a repository-governed Cursor agent, and return a redacted
status or handover. Its security objective is to preserve human authority, workspace integrity,
confidentiality, session isolation, auditability, and all trading/deployment prohibitions even
when requests, model output, repository text, dependencies, or external services are malicious or
fail unexpectedly.

The initial authorized prototype boundary is local-only: loopback, no external network, no
credentials, no Custom GPT Action, no tunnel, MCP disabled, and no live-trading capability.

## Protected assets

- repository source, research, governance, history, and uncommitted work;
- secrets outside source control, including `.env`, API keys, private keys, tokens, and sessions;
- host account, filesystem, processes, network access, and local Cursor authentication;
- bridge authentication material and runtime configuration at later stages;
- task/session mappings, run state, audit events, prompts, responses, and handovers;
- Cursor agent identity, tool authority, quotas, and service/API spend;
- human approval gates and the integrity of research, release, and deployment decisions.

## Actors and trust assumptions

- **Human principal:** trusted to authorize gates and protect credentials; may still make mistakes.
- **Bridge application and policy:** trusted only after review and verification; must fail closed.
- **Cursor CLI/SDK and Cursor service:** privileged dependencies whose behavior and availability
  must be verified. The CLI loads project rules; critical controls remain duplicated outside it.
- **Cursor agent/model output:** untrusted for authorization and potentially vulnerable to prompt
  injection or hallucination.
- **Private Custom GPT and OpenAI:** future external client/provider; authenticated use does not
  make submitted content authoritative.
- **HTTPS/tunnel provider:** future external transport and metadata processor; not trusted with
  workspace authority or secrets.
- **MCP servers and tools:** untrusted unless individually reviewed, pinned, scoped, authenticated,
  and allowlisted.
- **Repository content and external source material:** data, not instructions with authority.
- **Unauthenticated or malicious client:** assumed capable of scanning, replaying, flooding, and
  crafting adversarial payloads once external ingress exists.

## Trust boundaries and data flows

1. **External client → HTTPS provider/ingress:** crosses from an external system into controlled
   ingress. Protect confidentiality, client authentication, request integrity, replay, and rate.
2. **Ingress → local bridge:** crosses into a local privileged service. Forward only the intended
   route and verified metadata; do not trust source headers unless set by the reviewed ingress.
3. **Bridge API → queue/store:** crosses from untrusted input into durable state. Validate,
   authorize, bound, normalize, and redact first.
4. **Worker → Cursor runtime/service:** grants model-mediated access to local tools and repository
   context. Enforce workspace and capability policy independently of prompts.
5. **Cursor agent → workspace/tools:** highest-impact boundary. Repository text and model output
   cannot grant shell, Git, network, secret, deployment, or trading authority.
6. **Bridge → client result:** crosses back to an external system. Minimize and redact output,
   authorize every lookup, and prevent cross-session disclosure.
7. **Bridge/Cursor → MCP:** optional future boundary. Both inbound adapter and outbound servers are
   disabled unless separately approved and authenticated.

During the local-only prototype, boundaries 1 and 2 do not exist operationally and boundary 7 is
disabled.

## Principal threats and required controls

### Spoofing and unauthorized access

Threats include stolen API keys, guessed run IDs, forged proxy headers, confused client identity,
and unauthorized access to another session.

Required controls:

- high-entropy bridge-specific credentials only after the credential gate;
- constant-time credential comparison or a reviewed authentication library;
- opaque identifiers with authorization on every session/run operation;
- trusted-proxy configuration fixed to the reviewed ingress;
- no identity or authority accepted from prompt text or client-supplied headers;
- credential rotation, revocation, expiry, and failed-auth rate limiting before exposure.

### Tampering, replay, and duplicate execution

Threats include modified requests, repeated submissions, retry storms, state races, and
cancellation/completion conflicts.

Required controls:

- TLS at any external ingress and authenticated forwarding to loopback;
- strict schemas, content types, payload limits, and operation allowlists;
- idempotency keys bound to client, operation, and normalized request;
- replay windows and durable state transitions;
- one active send per Cursor agent and transactional run claiming;
- cancellation as a requested state until worker confirmation;
- no automatic retry where execution outcome is uncertain.

### Prompt injection and tool escalation

Threats include instructions embedded in requests, repository files, fetched content, model
output, or tool output that attempt to override governance.

Required controls:

- classify all natural-language and retrieved content as untrusted data;
- enforce capability, workspace, path, command, Git, network, and MCP rules outside the model;
- reject arbitrary tool definitions, MCP URLs, shell commands, environment overrides, and
  workspace paths supplied by a client;
- duplicate critical denies in bridge policy and test actual selected-runtime behavior;
- require human approval at existing architecture, credential, external, release, deployment, and
  trading gates.

### Information disclosure

Threats include reading secrets, returning source or uncommitted research unnecessarily,
cross-session leakage, verbose errors, logs containing prompts/tokens, and provider retention.

Required controls:

- deny `.env`, `.env.*`, private keys, tokens, sessions, credentials, and secret-like paths;
- collect and return the minimum data needed for status and handover;
- redact structured logs and disable prompt/output logging by default;
- use generic external errors and keep diagnostic detail local and access-controlled;
- authorize every poll/cancel request and test session isolation;
- document provider privacy, retention, residency, and deletion behavior before external use;
- never include broker credentials, webhook secrets, exchange keys, or TradingView sessions.

### Denial of service and runaway resource use

Threats include oversized payloads, rapid polling, unbounded agent runs, queue starvation, disk
growth, model spend, deadlocks, and orphan processes.

Required controls:

- body, field, response, log, queue, concurrency, and per-client rate limits;
- run deadlines, bounded output, cancellation, backoff, and circuit breaking;
- durable leases/heartbeats and recovery rules for interrupted workers;
- disk quotas or bounded retention with reviewed cleanup;
- minimal `/healthz` response and no expensive unauthenticated operation;
- explicit budget and quota alerts before any external stage.

### Repudiation and weak evidence

Threats include inability to determine who submitted work, whether policy allowed it, what state
was reached, or whether a result was altered.

Required controls:

- append-oriented, timestamped, redacted audit events for authentication outcome, request hash,
  policy decision, state transition, cancellation, and final disposition;
- stable correlation IDs without logging credentials or full sensitive payloads;
- exact verification command output and human approvals recorded as evidence;
- never label an indeterminate run completed;
- Git review remains required before generated artifacts become authoritative.

### Dependency and supply-chain compromise

Threats include malicious or vulnerable packages, Cursor CLI/SDK changes, tunnel-agent updates,
transitive scripts, and MCP server substitution.

Required controls:

- project-local, pinned dependencies and reviewed lockfile;
- no `sudo`, global installation, or system service during the prototype;
- review install scripts, advisories, licenses, and update diffs;
- re-run permission and denial tests after CLI, SDK, runtime, ingress, or MCP changes;
- pin and individually approve every MCP server; outbound allowlist starts empty;
- a production dependency/update process is required by a separate ADR.

### Workspace or host compromise

Threats include path traversal, symlink escape, arbitrary workspaces, destructive commands,
remote Git mutation, privilege escalation, and persistence.

Required controls:

- canonicalize and fix the allowed workspace root;
- deny path traversal and access outside approved paths, including through symlinks;
- deny destructive shell, `sudo`, remote configuration, `git push`, history rewriting, arbitrary
  process execution, and persistence mechanisms;
- bind to loopback, run as an unprivileged user, and use restrictive runtime-file permissions;
- no system service, startup persistence, or `/srv/quantrading` creation under the prototype
  exception.

### Trading and deployment authority escalation

Threats include requests framed as research that attempt to place orders, access brokers,
allocate capital, publish releases, or automate deployment.

Required controls:

- no broker, exchange, webhook, TradingView-session, order-routing, deployment, or capital
  allocation connector exists in the bridge;
- explicit semantic and capability denies for live-trading and production actions;
- stop and return a blocker when a request crosses a human gate;
- successful backtests or model claims cannot authorize progression;
- any future production or trading integration requires separate governance and evidence.

## Mandatory verification by gate

### Before local implementation

- Review exact dependencies, file scope, ignored runtime paths, loopback binding, and shutdown.
- Confirm the implementation plan contains no credentials, external network, tunnel, or enabled
  MCP.

### Before a real local Cursor runtime run

- Pass unit and mocked integration tests.
- Demonstrate denial of secret paths, path escape, destructive shell, remote Git mutation,
  arbitrary workspace, live-trading requests, and unapproved MCP.
- Verify the selected runtime's permission behavior. Do not infer SDK behavior from CLI evidence.
- Use one approved read-only task and inspect redacted audit output and process cleanup.

### Before any external exposure

- Complete authentication, authorization, replay, idempotency, rate/concurrency, isolation,
  redaction, retention, dependency, and recovery tests.
- Review the HTTPS provider and configuration, credential lifecycle, trusted-proxy behavior,
  privacy terms, logs, costs, and incident contacts.
- Confirm the application port is loopback-only and only intended routes are forwarded.
- Exercise credential revocation and ingress shutdown before the first live test.

### Before production consideration

- Create and accept a separate ADR.
- Reassess threats using implementation evidence and external test findings.
- Establish operational owner, monitoring, alerting, backups, restore test, patching, incident
  response, availability targets, and credential rotation.

## Incident response and rollback

On suspected compromise or policy bypass:

1. stop accepting new work and stop the bridge worker;
2. disable external ingress, if present;
3. revoke bridge-specific and provider credentials without exposing them in logs or Git;
4. preserve redacted audit evidence and repository state;
5. inspect active Cursor runs and cancel only through the approved mechanism;
6. assess repository, host, account, and external-provider impact;
7. rotate affected credentials, remediate the cause, and repeat all applicable denial tests;
8. require human approval before restoring any stage.

Manual copy/paste remains the safe functional fallback. Withdrawal or material redesign must be
recorded by a superseding ADR.

## Residual risks and non-claims

- Model and prompt behavior cannot be made trustworthy through instructions alone.
- A local service can still damage data if application policy or runtime isolation is defective.
- External providers introduce metadata, availability, account, and supply-chain risks.
- Redaction can miss novel secret formats; data minimization is required in addition to masking.
- Cancellation may not undo side effects already performed; prohibited capabilities must be
  blocked before execution.
- Passing tests establishes only the tested scope and configuration.
- This document does not verify implementation, external connectivity, security, or operational
  readiness.
