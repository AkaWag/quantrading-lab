# EV-004 — Short-only direction diagnostic (QT-R-002)

- Date: 2026-07-24
- Run ID: D0-S
- Classification: **diagnostic evidence — not optimization**
- Source: owner-directed TradingView Strategy Tester capture
- Strategy: MACD 4C Signal Squatter v2.0 [Gold 4H]

## Run controls

| Field | Value |
|---|---|
| Symbol / broker | XAUUSD / OANDA |
| Timeframe | 4H |
| Window | 2018-01-01 → 2026-05-19 (Deep) |
| Initial capital shown | 1 K USD |
| Long direction | OFF |
| Short direction | ON |
| Properties | Captured: 100% equity, pyramiding 1, 0.1% commission, 0 ticks slippage, on-bar-close execution |
| Chart display timezone | UTC+2 shown on captured seat |

## Overview

| Metric | D0-S short-only |
|---|---:|
| Net profit | **−106.27 USD / −10.63%** |
| Maximum drawdown | **144.86 USD / 13.95%** |
| Profit factor | **0.529** |
| Trades | **17** |
| Profitable trades | **35.29% / 6 of 17** |
| Losing trades (derived from total − winners) | **11 of 17** |

Attachment:
[`EV-004-short-only-overview.png`](EV-004-short-only-overview.png)

Supporting artifacts:

- [`EV-004-short-only-trades.csv`](EV-004-short-only-trades.csv)
- [`EV-004-short-trade-classification.csv`](EV-004-short-trade-classification.csv)
- [`EV-004-QT-R-002-short-side-recovery.xlsx`](EV-004-QT-R-002-short-side-recovery.xlsx)
- [`EV-005-strategy-properties.png`](EV-005-strategy-properties.png)
- [`EV-005-short-only-inputs.png`](EV-005-short-only-inputs.png)
- [`EV-006-short-failure-classification.md`](EV-006-short-failure-classification.md)

## Direction reconciliation

| Run | Long | Short | Net % | MaxDD % | PF | Trades | Winners |
|---|---:|---:|---:|---:|---:|---:|---:|
| D0-L / EV-002 | On | Off | 101.31 | 7.98 | 3.532 | 39 | 18 |
| D0-S / EV-004 | Off | On | −10.63 | 13.95 | 0.529 | 17 | 6 |
| D0-C / EV-003 | On | On | 78.74 | 15.29 | 2.092 | 56 | 24 |

Trade and winner counts reconcile exactly:

- `39 + 17 = 56` trades;
- `18 + 6 = 24` winners.

Percentage P&L, drawdown, and profit factor are not additive. Combined sequencing, reversals,
equity compounding, and order timing must be assessed from the trade ledger rather than inferred
by subtraction.

## Verdict

The current mirrored short logic is **negative expectancy in this diagnostic sample** and is
rejected unchanged:

- net loss;
- profit factor below 1;
- drawdown exceeds the profitable long-only control;
- only 17 trades, creating severe validation uncertainty.

This does not remove shorts from scope. Shorts are an owner requirement. The evidence routes work
to short-side redesign while the long-side control remains frozen.

## Evidence limits

- Exposure and recovery duration are not supplied by the trade table.
- Exact EMA slope and broader regime labels are not exported.
- The common close signal does not distinguish EMA reclaim from positive-MACD bull cross.
- Only two trades occur in the locked OOS window; selection evidence is insufficient.

## Next gate

Apply the pre-registered one-degree-of-freedom short-regime study only when a defensible OOS or
walk-forward sample can be obtained. No candidate is selected or promoted from the current
17-trade sample.
