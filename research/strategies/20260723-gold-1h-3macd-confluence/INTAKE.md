# Intake — QT-R-004 Gold 1H 3-MACD Confluence

- Research ID: QT-R-004
- Stream: EXISTING_STRATEGY
- Date: 2026-07-23
- Activity: **parked (priority queue)** — Shotgun OK; no silent optimisation accept
- ADR: [`../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md`](../../../decisions/ADR-008-intake-signum-gold-tv-strategies.md)

## What exists

Long-only Gold **1H** triple-MACD (0-Lag + Standard + 4C) with T3(10) entry/exit, 20% partial at
1.5×ATR, 80% runner, 4×ATR SL → BE. Signum documents call it production-ready; **QuanTrading has
not yet frozen or reproduced**.

## Core logic (summary)

See Shotgun brief [`3MACD_GOLD_1H.md`](../../../../.cursor/skills/shotgun/3MACD_GOLD_1H.md) and
Signum spec path in README.

## Gaps at intake

- Pine v2.2 partial-exit port may still be pending in Signum notes — pin exact Pine on freeze
- Engine Python port ≠ automatic TV parity
- Desk is assist/paper, not live authorisation for QT

## Next step

After QT-R-002 demonstrate the EXISTING loop (or if owner reprioritises): complete BASELINE freeze
→ reproduce → then controlled improvement / VALIDATION stream as needed.
