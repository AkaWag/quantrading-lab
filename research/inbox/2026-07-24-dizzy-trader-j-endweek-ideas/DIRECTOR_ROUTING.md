# Director routing — end-of-week BTC / Dow / Nasdaq / Gold

- Decision date (UTC): 2026-07-24
- Seat: research-director (away-mode unattended)
- Inputs: SOURCE / OBSERVATION / ANALYSIS in this folder; related
  [`../2026-07-24-dizzy-dj30-3m-support-bounce/`](../2026-07-24-dizzy-dj30-3m-support-bounce/)

## Queue state

`AWAITING_DIRECTOR` → **DEFERRED** (awaiting human-opened Shotgun chart verify)

## Decisions

| Item | Decision | Rationale |
|---|---|---|
| Inbox packet | **ACCEPT_INBOX** (confirmed) | Provenance + L1 reads present; untrusted external |
| New `QT-R-###` | **REJECT** for now | Discretionary multi-market zones; incomplete entry/stop/target/expiry |
| Ops/holiday / bare mentions | **REJECT** for strategy intake | Non-idea noise (per Dizzy ANALYSIS) |
| DJ30 1h chart | **DEFER** + candidate **ATTACH** for DJ30 3m follow-up | Same symbol/day; support ~51,720–51,760 overlaps 3m zone |
| XAUUSD 1h chart | **DEFER** | Do not interrupt QT-R-002 reproduce gate; optional later observe vs gold streams after Shotgun |
| BTCUSDT.P / NAS100 | **DEFER** | No open stream; Shotgun first if owner prioritises |
| Auto alerts / Pine / live | **Denied** | Hard stop |

## Next gate (owner / Shotgun)

Human-opened Shotgun on selected charts only. After verify: Director may ATTACH, open a draft
observation under an existing stream, or REJECT/EXPIRED. No parameter work, no TV metrics invented
here.

## Not verified

Any still-valid levels, alert configuration, edge, or profitability.
