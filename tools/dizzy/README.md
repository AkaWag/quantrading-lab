# Dizzy capture tooling

Project-local Discord capture stack for the proposed Dizzy intake agent.

> Status: **mailbox pilot active** (owner `#trader-j`). Cursor skill:
> [`.cursor/skills/dizzy/SKILL.md`](../../.cursor/skills/dizzy/SKILL.md).
> No auto chart trading, alerts, or live execution from this folder alone.
>
> Governing docs: [`ADR-009`](../../decisions/ADR-009-establish-dizzy-discord-intake-agent.md),
> [`DIZZY_AGENT.md`](../../docs/onboarding/DIZZY_AGENT.md), owner checklist
> [`OWNER_SETUP.md`](OWNER_SETUP.md).

> **Talk to Dizzy via `#trader-j`, not DMs.** Dizzy-QT has no DM/chat handler; Clyde delivery errors in DM are not a capture outage.

## Selected tool: DiscordChatExporter

Upstream: [Tyrrrz/DiscordChatExporter](https://github.com/Tyrrrz/DiscordChatExporter)

Pinned release: see [`vendor/VERSION`](vendor/VERSION) (currently `2.47.3`).

Why this tool for Dizzy D1/D2:

- Official Discord API access via bot token
- JSON exports with message IDs, timestamps, and attachment/media download
- Bounded, reviewable quarantine files before any `research/inbox/` landing
- Low operational surface versus a continuous archive stack

Hard policy:

- **Bot token only.** User-account tokens / self-bots are prohibited.
- **Allowlisted channels only.** Unknown channel IDs are rejected.
- **Quarantine first.** Exports land under `runtime/exports/` (gitignored).
- **No automatic trading, alerts, TradingView actions, or broker access.**

## Contemplated later: DiscordDataMirror

Upstream: [JerrettDavis/DiscordDataMirror](https://github.com/JerrettDavis/DiscordDataMirror)

Not installed. Comparison and acceptance criteria:
[`docs/DISCORDDATAMIRROR_COMPARISON.md`](docs/DISCORDDATAMIRROR_COMPARISON.md).

## Owner setup (start here)

Step-by-step checklist of what the owner must do (bot, channel IDs, `.env`, first export):

→ [`OWNER_SETUP.md`](OWNER_SETUP.md)

## Setup (quick commands)

```bash
# 1) Install / reinstall the pinned CLI (project-local; no sudo)
bash tools/dizzy/scripts/install-discordchatexporter.sh

# 2) Create local secrets + allowlist (never commit)
cp tools/dizzy/config/example.env tools/dizzy/.env
cp tools/dizzy/config/channels.example.json tools/dizzy/config/channels.json
# Edit both files: bot token + real channel IDs; set enabled=true only for approved channels.

# 3) Dry-run an allowlisted channel (validates config; does not call Discord)
bash tools/dizzy/scripts/export-channel.sh example-trade-ideas --dry-run
```

Create a Discord application/bot in the Discord Developer Portal, invite it with the minimum
read permissions needed for the authorized channels, and put the bot token only in
`tools/dizzy/.env`.

## Export (after D2 approval)

```bash
bash tools/dizzy/scripts/export-channel.sh <channelId-or-label>
bash tools/dizzy/scripts/export-channel.sh <channelId-or-label> --after 2026-07-01
```

## Mailbox autopickup (recommended for `#trader-j`)

After you forward ideas into the mailbox channel:

```bash
bash tools/dizzy/scripts/mailbox-autopickup.sh trader-j
```

This exports, then creates inbox packets only for **new** actionable messages.
Schedule with user crontab — see [`docs/MAILBOX_AUTOPICKUP.md`](docs/MAILBOX_AUTOPICKUP.md).

Each run creates:

```text
tools/dizzy/runtime/exports/<UTC>_<label>_<channelId>/
  CAPTURE_MANIFEST.json
  <exported files>
  media/                 # charts / attachments when media=true
```

Human or Director review is still required before creating
`research/inbox/<date-topic>/SOURCE.md` and `OBSERVATION.md`.

## Layout

| Path | Purpose | Git |
|---|---|---|
| `scripts/install-discordchatexporter.sh` | Download + SHA verify CLI | tracked |
| `scripts/export-channel.sh` | Allowlisted export wrapper | tracked |
| `config/channels.example.json` | Allowlist template | tracked |
| `config/channels.json` | Real allowlist | ignored |
| `config/example.env` | Env template | tracked |
| `.env` | Bot token | ignored |
| `vendor/VERSION` + `.sha256` | Pin + checksum | tracked |
| `vendor/DiscordChatExporter.Cli.linux-x64/` | Installed binary tree | ignored |
| `runtime/exports/` | Quarantine captures | ignored |
| `docs/DISCORDDATAMIRROR_COMPARISON.md` | Future-tool planning | tracked |

## Not verified

- Discord bot creation, invite, or permissions
- Live channel export
- Attachment/chart quality for trading use
- DiscordDataMirror Docker/.NET stack
- Automatic inbox promotion or Shotgun chart application
