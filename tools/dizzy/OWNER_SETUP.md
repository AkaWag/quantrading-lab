# Dizzy owner setup — what we need from you

Step-by-step checklist for Aka Wag. Do these in order. Do **not** paste tokens into chat,
commits, or screenshots.

Governing docs: [`ADR-009`](../../decisions/ADR-009-establish-dizzy-discord-intake-agent.md),
[`DIZZY_AGENT.md`](../../docs/onboarding/DIZZY_AGENT.md), [`README.md`](README.md).

Upstream token/ID reference (bot path only):
[DiscordChatExporter Token-and-IDs](https://github.com/Tyrrrz/DiscordChatExporter/blob/master/.docs/Token-and-IDs.md).

---

## What you will produce

| Deliverable | Where it goes | Shared with agent? |
|---|---|---|
| Discord bot application named for Dizzy | Discord Developer Portal | App name + invite confirmation only |
| Bot token | `tools/dizzy/.env` (gitignored) | **Never** |
| Authorized guild + channel IDs | `tools/dizzy/config/channels.json` (gitignored) | Channel labels + IDs OK |
| Permission basis note | `permissionBasis` field in allowlist | Yes |
| First successful quarantine export | `tools/dizzy/runtime/exports/` | Path + summary OK; no secrets |

---

## Step 0 — Confirm policy (2 minutes)

Reply or record that you accept:

1. Bot token only (no user-token / self-bot automation).
2. Only channels you explicitly authorize.
3. Exports quarantine first; no auto-trading, alerts, or TradingView actions.
4. DiscordDataMirror stays **not installed** until a later ADR.

If any item is rejected, stop here.

---

## Step 1 — Create the Discord bot

1. Open [Discord Developer Portal → Applications](https://discord.com/developers/applications).
2. Click **New Application**.
3. Name it clearly, e.g. `QuanTrading Dizzy Capture`.
4. Open the app → **Bot** → **Add Bot** (if prompted).
5. Under **Privileged Gateway Intents**, enable **Message Content Intent**.
   Without this, exports are empty.
6. Under **Token**, click **Reset Token** / **Copy**, and store it temporarily in a password
   manager — not in chat and not in Git.

Minimum invite permissions used by DiscordChatExporter’s documented bot invite:
`permissions=66560` (View Channel + Read Message History).

Invite URL (replace `YOUR_APP_ID` with the Application / Client ID from **General Information**):

```text
https://discord.com/oauth2/authorize?scope=bot&permissions=66560&client_id=YOUR_APP_ID
```

7. Invite the bot only into the server(s) you authorize for research capture.
8. Confirm the bot appears offline/online in that server’s member list.

**Tell the Director when done:** application name, which guild(s) invited, Message Content
Intent = on. Do **not** send the token.

---

## Step 2 — Collect channel IDs

1. Discord Settings → **Advanced** → enable **Developer Mode**.
2. Right-click each authorized channel → **Copy Channel ID**.
3. Right-click the server icon → **Copy Server ID**.
4. Write a short label for each channel (e.g. `gold-trade-ideas`).

Start with **one** channel for the D2 pilot.

**Tell the Director:** guild label, guild ID, channel label(s), channel ID(s), and whether
threads should be included (`Active` recommended).

---

## Step 3 — Local config on the Ubuntu workspace

Run from the continuity integration worktree (or later from `main` once promoted):

```bash
cd /home/aka/quantrading/workspaces/continuity-integration

# Confirm CLI still present (or reinstall)
bash tools/dizzy/scripts/install-discordchatexporter.sh

# Create local secrets + allowlist (never commit these)
cp tools/dizzy/config/example.env tools/dizzy/.env
cp tools/dizzy/config/channels.example.json tools/dizzy/config/channels.json
```

Edit `tools/dizzy/.env`:

```bash
DISCORD_TOKEN=<paste-bot-token-here>
DIZZY_EXPORT_FORMAT=Json
DIZZY_INCLUDE_THREADS=Active
DIZZY_MEDIA=true
DIZZY_UTC=true
```

Edit `tools/dizzy/config/channels.json` — replace placeholders:

```json
{
  "schemaVersion": 1,
  "permissionBasis": "Owner Aka Wag authorized capture for QuanTrading Dizzy D2 pilot on <date>.",
  "channels": [
    {
      "channelId": "<real-channel-id>",
      "label": "gold-trade-ideas",
      "guildId": "<real-guild-id>",
      "guildLabel": "<server-name>",
      "retentionClass": "research-quarantine",
      "includeThreads": "Active",
      "media": true,
      "enabled": true,
      "notes": "D2 pilot channel"
    }
  ]
}
```

Keep `enabled: false` on any channel not yet approved for export.

---

## Step 4 — Dry-run (no Discord call if config invalid)

```bash
bash tools/dizzy/scripts/export-channel.sh gold-trade-ideas --dry-run
```

Expected: allowlist + token checks pass; command printed with token redacted.

If it fails on placeholder IDs or missing token, fix Step 3 and retry.

**Tell the Director:** dry-run passed / failed (+ exact error text, no token).

---

## Step 5 — First live quarantine export (D2 pilot)

Only after dry-run passes:

```bash
bash tools/dizzy/scripts/export-channel.sh gold-trade-ideas
```

Optional date window:

```bash
bash tools/dizzy/scripts/export-channel.sh gold-trade-ideas --after 2026-07-01
```

Success looks like:

```text
tools/dizzy/runtime/exports/<UTC>_gold-trade-ideas_<channelId>/
  CAPTURE_MANIFEST.json
  *.json
  media/          # chart images / attachments when present
```

**Tell the Director:** export directory path, approximate message count, whether charts landed
in `media/`. Do not paste message contents with secrets or PII into chat unless intended for
intake.

---

## Step 6 — Hand off to Director / Dizzy intake

For each useful idea (human or Director):

1. Keep the quarantine export as the raw source.
2. Create `research/inbox/<YYYY-MM-DD-topic>/` with `SOURCE.md` + `OBSERVATION.md`.
3. Director decides: accept / attach / defer / reject.
4. Shotgun chart review only after Director approval (human-opened session).

Dizzy does **not** auto-place trades or auto-open TradingView.

---

## Step 7 — Optional later: DiscordDataMirror

Do nothing for now. If continuous archival becomes necessary, review
[`docs/DISCORDDATAMIRROR_COMPARISON.md`](docs/DISCORDDATAMIRROR_COMPARISON.md) and approve a
separate ADR before any Docker/.NET install.

---

## Security checklist

- [ ] Token only in `tools/dizzy/.env` (gitignored)
- [ ] `git status` does **not** list `.env` or `channels.json` as staged
- [ ] Bot invited only to authorized guilds
- [ ] Message Content Intent enabled
- [ ] User-token methods from upstream docs are ignored
- [ ] No live trading, broker, or TradingView credentials involved

If the token leaks: Discord Developer Portal → Bot → **Reset Token**, update `.env`, and tell
the Director the token was rotated (not the new value).

---

## Fast reply template (copy into chat)

```text
Dizzy owner setup status:
- Step 0 policy: accepted / rejected
- Bot app name:
- Guild(s) invited:
- Message Content Intent: on / off
- Pilot channel label + ID:
- Guild ID:
- Dry-run: pass / fail
- Live export path (if any):
- Blockers:
```


## Troubleshooting — Clyde "message could not be delivered" in DM

Dizzy-QT is **not** a conversational bot. Talking to it in DMs is unsupported.

Use `#trader-j` (mailbox). See [`docs/MAILBOX_AUTOPICKUP.md`](docs/MAILBOX_AUTOPICKUP.md).

Clyde's delivery error is a Discord privacy/delivery rejection (shared-server DM settings, screening, friend-only DMs, etc.). It is not fixed by Message Content Intent or by restarting DiscordChatExporter. The bot token path for exports is separate from receiving DMs.
