# Away mode — how Director progresses without you

Use this when you need to leave and still want safe progress.

## Principle

**Unattended = only work that does not need your secrets, TradingView clicks, approvals, or live risk.**  
Durable continuity is always the **repo**, not the chat.

## Turn on before you leave (2 minutes)

### 1) Cursor Agent auto-run (this is the “YOLO” idea)

In Cursor Settings, enable agent auto-run / auto-approve for **this workspace** so the agent
does not stop on every shell/edit prompt.

Keep denials in [`.cursor/cli.json`](../../.cursor/cli.json) (secrets, `sudo`, `git push`).

### 2) Leave one clear instruction in chat

Paste:

```text
AWAY MODE — Director continue without me.
Workspace: /home/aka/quantrading/workspaces/continuity-integration
Do only UNBLOCKED items in docs/onboarding/AWAY_MODE.md § Queue.
Do not commit, push, optimize, trade, or read .env.
Stop and write blockers to reports/away-mode-status.md when human input is required.
```

### 3) Keep Dizzy on cron (already installed)

Mailbox autopickup every 15 minutes — no Cursor needed.

## Queue

### UNBLOCKED (agent may do alone)

| ID | Task | Notes |
|---|---|---|
| U1 | Maintain QT-R-002 docs/pins/checklists | Already largely done |
| U2 | Prepare `evidence/` stub + reproduce template for QT-R-002 | No TV results invented |
| U3 | Dizzy mailbox autopickup via cron | Running |
| U4 | Triage new Dizzy inbox packets into SOURCE/OBSERVATION/ANALYSIS | No fake chart levels |
| U5 | Cross-link status / NEXT_ACTIONS / registry consistency | Docs only |
| U6 | Run `scripts/verify.sh` / continuity checks | Non-destructive |
| U7 | Draft one-family improvement **options** (not execute) after reproduce stub exists | Planning only |

### BLOCKED (needs you)

| ID | Task | Why blocked |
|---|---|---|
| H1 | TradingView load Pine + Strategy Tester reproduce | External TV UI / your session |
| H2 | Paste tester metrics / screenshots into EV-002 | Evidence must be real |
| H3 | Decide QT-R-004 vs stay on R-002 after reproduce | Owner priority |
| H4 | Approve git commit / push of continuity branch | Explicit approval |
| H5 | Any optimization sweep / live alerts / broker | Governance |

## Recommended chat layout while away

| Chat | Purpose |
|---|---|
| **This Director chat** (or one “Away Mode Director”) | Unblocked queue only |
| Later: **QT-R-002** dedicated chat | After you return, for TV reproduce walkthrough |
| Dizzy | Cron handles intake; open Dizzy chat only if something fails |

## When you return

1. Read `reports/away-mode-status.md` (if present)  
2. Do **H1–H2** (TV reproduce)  
3. Then Director can continue improvement planning  

## Hard stops (never unattended)

- Reading or printing `.env` / bot tokens  
- `git commit` / `git push` unless you pre-approved in the leave message  
- Parameter optimization presented as truth  
- Live trading, alerts to broker, production claims  
- Inventing TradingView results  
