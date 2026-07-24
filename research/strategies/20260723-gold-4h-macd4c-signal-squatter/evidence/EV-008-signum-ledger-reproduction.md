# EV-008 — Signum ledger reproduction (QT-R-002)

- Date: 2026-07-24
- Scope: M1, independent arithmetic reproduction of EV-004
- Source: `EV-004-short-only-trades.csv` and `EV-004-short-trade-classification.csv`
- Method: read-only calculation with `~/signum-venv/bin/python`; no strategy run
- Verdict: **PASS WITH ROUNDING NOTE**
- Research gate: **INSUFFICIENT_EVIDENCE — preserved**

## Frozen interpretation

Partitions use entry timestamps and the locked boundaries in `EXPERIMENT_PLAN.md`:

- IS: 2018-01-01 through 2021-12-31;
- validation: 2022-01-01 through 2023-12-31;
- untouched OOS: 2024-01-01 through 2026-05-19.

Gross profit is the sum of positive displayed row `net_pnl_usd`; gross loss is the absolute sum
of negative displayed row `net_pnl_usd`; profit factor is gross profit divided by gross loss.
These are reproductions of the rounded exported ledger, not unrounded TradingView internals.

## Independent reproduction

| Segment | Trades | Winners | Net P&L USD | Gross profit | Gross loss | PF | Commission |
|---|---:|---:|---:|---:|---:|---:|---:|
| IS | 9 | 3 | -52.813 | 65.162 | 117.975 | 0.552337 | 17.945 |
| Validation | 6 | 3 | +3.178 | 54.310 | 51.132 | 1.062153 | 11.544 |
| Untouched OOS | **2** | **0** | **-56.630** | 0.000 | 56.630 | 0.000000 | 3.679 |
| Full sample | **17** | **6** | **-106.265** | **119.472** | **225.737** | **0.529253** | **33.168** |

The displayed full-sample PF rounds to **0.529**, matching EV-004 and EV-007. Trade and winner
counts, all partition net values, and commission totals reproduce.

## Commission stress reproduction

The CSV already includes the captured 0.1% commission per side. Holding fills, quantities, and
gross price P&L fixed:

- 0.2% per side subtracts one additional copy of each row's exported commission;
- 0.3% per side subtracts two additional copies.

| Commission per side | Full sample | IS | Validation | OOS |
|---|---:|---:|---:|---:|
| Captured 0.1% | -106.265 | -52.813 | +3.178 | -56.630 |
| 0.2% | **-139.433** | -70.758 | -8.366 | -60.309 |
| 0.3% | **-172.601** | -88.703 | -19.910 | -63.988 |

This exactly reproduces EV-007 at the precision recorded there. The only positive partition,
validation, becomes negative at the first stress.

## Failure-count reproduction

Applied only to the 11 losing trades, using the documented diagnostic separator:

| Rule | Count | Trade numbers |
|---|---:|---|
| MFE < 1.50%: false bear cross / momentum failure | **6** | 4, 7, 9, 14, 15, 16 |
| MFE >= 1.50%: trend-exit giveback | **5** | 3, 6, 8, 13, 17 |

This reproduces EV-006. The 1.50% separator is diagnostic and was not searched or treated as a
trading parameter.

## Mismatch and limits

- Summing the displayed row net values gives **-106.265 USD**; the final exported cumulative
  value is **-106.266 USD**. The 0.001 USD difference is consistent with row-display rounding.
  No unrounded per-fill values are available, so it is recorded rather than corrected.
- The TradingView Overview reports -106.27 USD, consistent after cent rounding.
- Exposure, recovery duration, unrounded quantity, spread, and per-fill slippage cannot be
  reconstructed from this CSV.
- No slope value was tested and no OOS boundary was changed.

## Result

M1 is **PASS WITH ROUNDING NOTE**. This verifies the supplied ledger arithmetic only. With two
locked-OOS shorts, it does not validate an edge or authorize candidate selection.
