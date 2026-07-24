# Dizzy mailbox autopickup

Automates the **owner mailbox** side (`#trader-j`), not ChartHackers.

```text
You forward ideas into #trader-j
  → autopickup exports the channel
  → new actionable messages become research/inbox packets
  → Director / Shotgun decide next
```

## Do not DM Dizzy-QT

Dizzy-QT is a **capture bot** (DiscordChatExporter + mailbox autopickup), not a chat assistant.

- **Correct:** paste or forward trade ideas into `#trader-j` on aka_wag's server.
- **Incorrect:** open a DM with Dizzy-QT and type to it.

If Discord's Clyde says *"Your message could not be delivered"* in a DM with Dizzy-QT, that is expected friction — Discord privacy blocks many user→bot DMs, and Dizzy has **no DM handler** anyway. Use the mailbox channel instead.

Optional (only if you truly need DMs for another reason): Discord User Settings → Privacy & Safety → ensure direct messages from server members are allowed for aka_wag's server, and finish any membership screening. That still will not make Dizzy reply in DMs.

## One-shot (manual)

```bash
cd /home/aka/quantrading/workspaces/continuity-integration
bash tools/dizzy/scripts/mailbox-autopickup.sh trader-j
```

## Enable every 15 minutes (user crontab, no sudo)

```bash
crontab -e
```

Add:

```cron
*/15 * * * * cd /home/aka/quantrading/workspaces/continuity-integration && /usr/bin/bash tools/dizzy/scripts/mailbox-autopickup.sh trader-j >> tools/dizzy/runtime/logs/autopickup.log 2>&1
```

Verify:

```bash
crontab -l
tail -f /home/aka/quantrading/workspaces/continuity-integration/tools/dizzy/runtime/logs/autopickup.log
```

Disable: remove that line from `crontab -e`.

## State files (gitignored)

| Path | Role |
|---|---|
| `tools/dizzy/runtime/state/trader-j.json` | Seen message IDs / last export |
| `tools/dizzy/runtime/logs/autopickup.log` | Cron/manual logs |
| `tools/dizzy/runtime/exports/` | Quarantine captures |

## What gets an inbox packet

- Forwarded ideas (with text and/or charts)
- Messages with attachments
- Longer standalone text ideas

Skipped: empties, bare mentions, ops/schedule notices without charts, already-seen IDs.

## Hard limits

- Does **not** read ChartHackers directly
- Does **not** trade, alert, or open TradingView
- Bot token stays in `tools/dizzy/.env` only
