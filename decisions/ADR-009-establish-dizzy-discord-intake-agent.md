# ADR-009: Establish Dizzy as the Discord Trading-Idea Intake Agent

- Status: **accepted for mailbox pilot** (Cursor skill + DiscordChatExporter toolchain; 2026-07-24)
- Date: 2026-07-24
- Owner: Aka Wag
- Related: ADR-005 (research streams), ADR-007 (operating model), ADR-008 (external strategy intake)
- Skill: [`.cursor/skills/dizzy/SKILL.md`](../.cursor/skills/dizzy/SKILL.md)

## Context

Trading ideas are discussed in selected Discord channels. The lab needs a traceable way to
capture authorized messages, preserve their provenance, distinguish source claims from AI
interpretation, deduplicate related ideas, and route useful material into the governed research
workflow. Manual copy/paste loses continuity and makes edits, threads, attachments, and source
dates difficult to audit.

Discord is an external trust boundary. A message can contain mistakes, promotional claims,
malicious instructions, personal information, or content the owner has no right to retain.
Discord content is therefore untrusted source material, not executable instruction or evidence
of an edge.

## Decision

Adopt the name **Dizzy** for a proposed Discord-facing intake agent with the following authority:

1. Read only explicitly authorized guilds and channels through a Discord bot/application using
   the official API and minimum required permissions. User-account automation and self-bots are
   prohibited.
2. Preserve source metadata and an immutable raw capture reference before interpretation:
   guild/channel/message/thread IDs, message URL when available, author identifier, timestamps,
   edit state, attachment references, capture time, and content hash.
3. Classify each item as evidence, hypothesis, requirement, implementation idea, or unverified
   claim. Keep quoted source content separate from Dizzy's summary and inference.
4. Deduplicate messages and group threads into an intake candidate. Dizzy may recommend
   `NEW_STRATEGY`, `EXISTING_STRATEGY`, `BLACK_BOX_STRATEGY`, `VALIDATION`, attach-to-existing,
   defer, or reject; only the human owner or `research-director` assigns the governed route.
5. Land accepted captures under `research/inbox/<date-topic>/` with `SOURCE.md`,
   `OBSERVATION.md`, and `ANALYSIS.md` as applicable. A capture cannot directly create Pine,
   assign `QT-S-###`, alter a chart, issue an alert, or place/manage an order.
6. Use a queue with explicit status, priority, idempotency key, retry count, and failure reason.
   Scheduling means scheduling a research or chart-review task, not scheduling a trade.
7. Route chart-review candidates to a human-opened **Shotgun** session. Route compute candidates
   to Signum only after Director approval and within an accepted experiment plan.
8. Keep all broker connections, exchange access, TradingView credentials/session data,
   autonomous live trading, order routing, and capital allocation outside Dizzy's authority.

Implementation is staged:

- **D0 — specification:** approve this ADR, agent mandate, data model, permissions, retention,
  threat model, and test plan.
- **D1 — offline fixture:** parse exported synthetic/redacted messages without Discord access.
- **D2 — authorized read-only pilot:** ingest one approved channel into a quarantine queue;
  require human acceptance before repository writes. Near-term capture tool:
  project-local DiscordChatExporter.Cli (`tools/dizzy/`), bot token + channel allowlist only.
  Continuous archive candidates such as DiscordDataMirror require a separate comparison review
  before install.
- **D3 — governed scheduling:** enqueue Director and Shotgun review packets with deduplication,
  rate limits, audit logging, and failure recovery.
- **D4 — paper/forward-test assistance:** only under the existing alert and release gates.

Any capability that places, modifies, or manages a live order requires a separate ADR, explicit
human approval, paper/forward-test evidence, broker-specific risk controls, and a maintained
kill-switch. This ADR does not approve that capability.

## Alternatives considered

- **Continue manual copy/paste.** Retained as fallback but rejected as the target because source
  metadata, thread context, deduplication, and scheduling continuity remain weak.
- **Let Shotgun read Discord directly.** Rejected because source intake and chart companionship
  have different permissions, evidence duties, and failure modes.
- **Send Discord messages directly to Signum or TradingView.** Rejected because it bypasses the
  Director, research gates, provenance requirements, and human chart/session control.
- **Scrape with a user account.** Rejected because self-bot automation conflicts with Discord's
  supported integration model and expands credential and account risk.
- **Allow Dizzy to execute trades.** Rejected for this decision; it collapses intake, research,
  execution, and account-risk boundaries into one unreviewable authority.

## Consequences

- Positive: every idea has a durable source, classification, disposition, and downstream owner.
- Positive: Discord intake becomes compatible with the existing inbox and four research streams.
- Positive: Director, Shotgun, and Signum retain separate, testable responsibilities.
- Cost: requires a Discord application, access review, storage/retention policy, queue, audit log,
  redaction, deletion handling, monitoring, and operational ownership.
- Limitation: an interpreted idea is not validated evidence and cannot skip research gates.
- Limitation: chart review and paper trading remain human-directed; live execution is not enabled.

## Risks and mitigations

- **Unauthorized collection** — channel allowlist, bot permissions, owner approval, and periodic
  access review.
- **Prompt injection** — treat message text and attachments only as data; never execute embedded
  commands or let source text grant tools or permissions.
- **Privacy and retention** — minimize stored personal data, define retention/deletion rules,
  restrict raw captures, and preserve only what the approved research purpose requires.
- **Duplicate or edited ideas** — message IDs, content hashes, edit versions, idempotency keys,
  and thread-level grouping.
- **False urgency or promotional claims** — default low confidence and require evidence review.
- **Scheduling a stale setup** — record market, symbol, timeframe, observed-at, expiry, and
  invalidation; expired candidates cannot progress without renewed human review.
- **Execution boundary erosion** — policy denies for credentials, TradingView sessions, brokers,
  orders, live trading, and remote Git mutation.

## Verification required before D2

- Approved Discord guild/channel allowlist and bot permission inventory.
- Data-flow and threat-model review, including attachments, links, edits, deletions, and outages.
- Fixture tests for provenance, parsing, classification separation, deduplication, idempotency,
  malformed payloads, prompt injection, rate limits, retries, and redaction.
- Repository tests proving accepted items use the inbox/artifact chain and rejected items cannot
  create Pine, alerts, chart actions, or execution requests.
- Human acceptance test using synthetic or explicitly authorized non-sensitive messages.

No Discord API access, scheduling service, TradingView action, alert, paper order, or live-trading
behavior is verified by this proposed ADR.

## Rollback

Disable the Discord application, revoke its token outside the repository, stop consumers, retain
the minimum audit record required by the approved retention policy, and quarantine unresolved
queue items. Supersede this ADR and remove Dizzy from active operating-model documentation.
Research artifacts already accepted through normal gates remain governed records with their
source and limitations intact.
