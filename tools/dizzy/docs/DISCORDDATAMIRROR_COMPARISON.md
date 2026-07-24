# DiscordDataMirror vs DiscordChatExporter for Dizzy

Planning note only. DiscordDataMirror is **not installed** in this workspace.

| Dimension | [DiscordChatExporter](https://github.com/Tyrrrz/DiscordChatExporter) | [DiscordDataMirror](https://github.com/JerrettDavis/DiscordDataMirror) |
|---|---|---|
| Role | On-demand channel export to files | Continuous archive + searchable dashboard |
| Auth model | Bot or user token (user token violates Discord ToS for automation) | Discord bot token |
| Runtime | Single self-contained CLI binary | .NET 10 + Aspire + PostgreSQL + Docker services |
| Data shape | Per-export JSON/HTML/CSV + optional media | Persistent DB of messages, edits, deletions, members, channels |
| Fit for Dizzy now | **Selected for D1/D2** — bounded, reviewable quarantine captures | Contemplated for later continuous mirror if volume justifies ops cost |
| Fit for charts/attachments | `--media` downloads attached images/embeds into a local media dir | Optional attachment caching; stronger long-term retention |
| Ops burden | Low: install script + bot token + allowlist | High: Docker stack, DB backups, dashboard hardening, retention policy |
| Governance risk | Medium if user tokens are used; mitigated by bot-only policy | Medium/high: always-on ingest expands privacy, retention, and incident surface |

## Recommendation (current)

1. Use **DiscordChatExporter.Cli** as Dizzy’s capture tool for authorized channels.
2. Keep exports under `tools/dizzy/runtime/exports/` until Director/human acceptance.
3. Treat DiscordDataMirror as a **future ADR candidate** only if:
   - multiple channels need continuous capture;
   - edit/delete history must be retained automatically;
   - search across months of Discord data becomes a research bottleneck; and
   - the owner accepts PostgreSQL/Docker operational ownership plus a retention/privacy review.

## If DiscordDataMirror is later accepted

Required before install:

- New ADR amending Dizzy’s capture backend (or a sibling service ADR).
- Bot permission inventory and channel allowlist identical to Dizzy policy.
- Retention, deletion, and GDPR-style request handling.
- Explicit statement that the mirror never places orders or drives TradingView.
- Backup alignment with ADR-003 (encrypted off-machine backup still incomplete).

Do **not** clone or `docker compose up` DiscordDataMirror until that ADR is approved.
