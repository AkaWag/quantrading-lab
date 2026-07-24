# System Boundaries

This document defines the layers of the QuanTrading Lab system, who owns them, and the trust
boundaries between them. It supports [`PLATFORM_VISION.md`](PLATFORM_VISION.md) and the security
rule `30-security-and-operations.mdc` in [`.cursor/rules/`](../../.cursor/rules/).

## Layers

### Workspace Layer
- The V2.5 research workspace: hypotheses, specifications, Pine source, tests, reviews,
  releases, and governance docs (this repository).
- **Owner:** the researcher/engineer. **Trust:** trusted content, but treated as reproducible
  and backed up, not irreplaceable.

### Platform Layer (intended)
- The Ubuntu server management and configuration that hosts workspaces (V3 direction).
- **Owner:** the platform administrator. **Trust:** authoritative host; controls access to
  workspaces, services, and backups. Does not yet exist as a managed layer (see
  [`V2_5_TO_V3_ROADMAP.md`](V2_5_TO_V3_ROADMAP.md)).

### Service Layer (intended)
- Optional supporting services (version control, indexing, databases, automation, dashboards,
  backups). **Real-time Agent Live** for strategy/research iteration is operated **externally**
  via Signum (`~/signum-ai-strategy/`) under ADR-007 — not a QuanTrading-hosted service yet.
- The former ChatGPT–Cursor HTTPS Orchestration Bridge (ADR-006) is **archived**; local Gate 1
  prototype code may exist as historical R&D only and is not the ops path.
- **Owner:** the platform administrator (for future hosted services). **Trust:** each service is
  reviewed and scoped individually before being trusted.

### Signum Agent Lab (external; ADR-007)
- On-machine Codex↔Claude file-bus lab + Control Centre (`127.0.0.1:8788`), outside this git tree.
- **Owner:** Aka Wag. **Trust:** lab-only (backtest/shadow/paper); hard live-money firewall on the
  Signum side; accepted outputs enter QuanTrading only as reviewed repo artifacts.
- **Not** live trading authority. Port into `agent-development/` deferred.

### Orchestration Bridge (ADR-006 — archived)
- Historical local prototype for ChatGPT→HTTPS→Cursor. **Superseded by ADR-007.** Do not expose,
  tunnel, or claim operational. See archived
  [`ORCHESTRATION_BRIDGE.md`](ORCHESTRATION_BRIDGE.md) for design history only.

### Client Layer
- Developer machines and Cursor connecting via controlled remote access.
- **Owner:** the individual user. **Trust:** development clients only; **not the system of
  record** and not trusted with canonical data or secrets.

### External Systems
- TradingView (charting, compilation, and backtesting), brokers/exchanges/data vendors, ChatGPT/
  OpenAI, and any future HTTPS tunnel or MCP provider.
- **Owner:** third parties. **Trust:** external and outside our control.

## Trust boundaries

- **TradingView remains external.** It is the compilation and backtest authority, but it is not
  part of the platform and its outputs must be brought in as evidence, not assumed.
- **Cursor is a development client, not the system of record.** Work produced in Cursor becomes
  authoritative only when stored on the intended server of record.
- **ChatGPT is an external request origin, not an authority or system of record.** Authentication
  identifies an approved client; it does not make prompt text trusted or permit it to expand tool,
  workspace, release, deployment, or trading authority.
- **Signum Agent Live is an external lab, not an authority.** Its outputs become authoritative for
  QuanTrading only when accepted into this repository under existing research gates.
- **ADR-006 HTTPS bridge is archived.** Do not treat it as an ops trust path; do not revive
  ingress without a new ADR.
- **The Ubuntu server is intended to become the system of record.** Until then, treat the
  workspace copy plus backups as authoritative and keep them recoverable.
- Crossing from Client → Platform, or Platform → External, is a trust transition and must use
  controlled, minimum-privilege access.

## Secrets

- Secrets (broker credentials, webhook secrets, exchange API keys, TradingView session data)
  must remain **outside source-controlled content**. Use a non-committed `.env`.
- Secrets must never appear in source, prompts, logs, or version history. See
  [`../governance/AI_OPERATING_PRINCIPLES.md`](../governance/AI_OPERATING_PRINCIPLES.md).

## Related documents

- [`PLATFORM_VISION.md`](PLATFORM_VISION.md)
- [`V2_5_TO_V3_ROADMAP.md`](V2_5_TO_V3_ROADMAP.md)
- [`ORCHESTRATION_BRIDGE.md`](ORCHESTRATION_BRIDGE.md)
- [`../security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md`](../security/ORCHESTRATION_BRIDGE_THREAT_MODEL.md)
- [`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md)
