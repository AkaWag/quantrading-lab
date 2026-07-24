# EV-003 — Short-enabled requirement observation (QT-R-002)

- Date: 2026-07-24
- Source: owner-directed TradingView run
- Classification: **requirement + preliminary observation**
- Verdict: **not optimized; not a replacement baseline**

## Owner requirement

Short trading is **required and wanted** in the target strategy. The long-only EV-002 run remains
the frozen comparison control; it is not the final desired direction set.

## Run shown

- Symbol / timeframe: XAUUSD · OANDA · 4H
- Window: 2018-01-01 → 2026-05-19 (Deep)
- Capital shown: 1 K USD
- Long + short enabled

| Metric | Short-enabled observation | Long-only EV-002 control |
|---|---:|---:|
| Net profit | 78.74% | 101.31% |
| Maximum drawdown | 15.29% | 7.98% |
| Profit factor | 2.092 | 3.532 |
| Trades | 56 | 39 |
| Profitable trades | 42.86% (24/56) | 46.15% (18/39) |

Attachment:
[`EV-003-short-enabled-overview.png`](EV-003-short-enabled-overview.png)

## Interpretation

Enabling the existing mirrored short logic adds 17 trades but materially worsens net return,
drawdown, profit factor, and win rate versus the long-only control. This does **not** justify
removing shorts because shorts are an owner requirement. It establishes that the current mirrored
short implementation is not acceptable unchanged and must be treated as its own controlled
improvement family.

The aggregate Overview does not isolate short-only trade performance. Trade-level export is
required before changing short entry, filter, exit, or sizing logic.

## Next gate

Pre-register a **short-side design** experiment after EV-002 Properties closure:

1. isolate long-only, short-only, and combined results;
2. diagnose short losses by trend/regime and exit reason;
3. modify only the short-side family while freezing long logic;
4. validate chronologically and under cost/fill stress.
