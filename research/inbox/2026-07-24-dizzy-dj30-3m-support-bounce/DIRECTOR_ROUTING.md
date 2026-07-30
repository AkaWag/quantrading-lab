# Director routing — DJ30 3m support bounce

- Decision date (UTC): 2026-07-24
- Seat: research-director (away-mode unattended)
- Inputs: SOURCE / OBSERVATION / ANALYSIS in this folder; parent context
  [`../2026-07-24-dizzy-trader-j-endweek-ideas/`](../2026-07-24-dizzy-trader-j-endweek-ideas/)

## Queue state

`AWAITING_DIRECTOR` → **ATTACHED** (to end-of-week DJ30 thread) + **DEFERRED** (Shotgun verify)

## Decisions

| Item | Decision | Rationale |
|---|---|---|
| Inbox packet | **ACCEPT_INBOX** (confirmed) | Forward + chart quarantine intact |
| Link to end-of-week DJ30 1h | **ATTACH** | Same symbol/day; support overlap (~51,730–51,755 vs ~51,720–51,760) |
| New `QT-R-###` | **REJECT** for now | Incomplete trigger/invalidation/target; 3m staleness risk |
| Priority vs QT-R-002 | **Lower** | Does not preempt Gold 4H MACD reproduce (H1/H2) |
| Shotgun chart verify | **Scheduled as review task only** | Owner-opened when back; not unattended |
| Auto alerts / Pine / live | **Denied** | Hard stop |

## Expiry note

Treat as time-sensitive. If Shotgun finds the 3m path already invalidated, mark **EXPIRED**
rather than promoting.

## Not verified

Live levels, fill realism, edge, or the “80 points” claim.
