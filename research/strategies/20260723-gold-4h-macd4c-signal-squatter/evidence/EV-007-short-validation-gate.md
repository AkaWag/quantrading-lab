# EV-007 — Short-family validation gate (QT-R-002)

- Date: 2026-07-24
- Control: D0-S mirrored short logic
- Proposed family: short-specific bearish-regime qualification
- Status: **INSUFFICIENT_EVIDENCE — no candidate selected**
- Workbook:
  [`EV-004-QT-R-002-short-side-recovery.xlsx`](EV-004-QT-R-002-short-side-recovery.xlsx)

## Locked chronological evaluation

| Segment | Dates | Trades | Winners | Net P&L | PF |
|---|---|---:|---:|---:|---:|
| IS | 2018-01-01 → 2021-12-31 | 9 | 3 | −52.813 USD | 0.552 |
| Validation | 2022-01-01 → 2023-12-31 | 6 | 3 | +3.178 USD | 1.062 |
| Untouched OOS | 2024-01-01 → 2026-05-19 | **2** | **0** | **−56.630 USD** | **0.000** |
| Full sample | 2018-01-01 → 2026-05-19 | 17 | 6 | −106.265 USD | 0.529 |

The OOS segment contains only two trades. It cannot distinguish a stable filter effect from one
or two path-dependent outcomes. Moving the boundaries would be post-selection leakage.

## Cost stress

The captured baseline uses 0.1% commission per side. Repricing the existing 17-trade ledger with
additional commission gives:

| Scenario | Full-sample net | IS net | Validation net | OOS net |
|---|---:|---:|---:|---:|
| Captured 0.1%/side | −106.265 | −52.813 | +3.178 | −56.630 |
| 0.2%/side | **−139.433** | −70.758 | −8.366 | −60.309 |
| 0.3%/side | **−172.601** | −88.703 | −19.910 | −63.988 |

The small positive validation segment fails under the first commission stress. The control is not
cost-robust.

Slippage values of 2 and 5 ticks remain locked for a future TradingView candidate run. They are
not fabricated from the ledger because TradingView did not export per-fill slippage or an
independently verified tick-size record.

## Walk-forward feasibility

Seventeen trades cannot support defensible rolling or anchored folds with independent selection
and test samples. Any plausible fold would contain too few trades, repeat the same observations,
or leave no meaningful OOS test. Bootstrap or Monte Carlo resampling would quantify uncertainty
around this weak sample; it would not create new regime evidence.

## Candidate-run decision

The pre-registered slope grid is:

`0.03% control, 0.05%, 0.07%, 0.10%, 0.15%`.

It was **not searched** against the current sample because:

1. the locked OOS minimum is 10 short trades and only 2 exist;
2. selecting a value now would optimize on effectively the full history;
3. the baseline already fails OOS and commission stress;
4. no parameter could be promoted under the declared acceptance gates.

This is the plan's explicit stop condition, not an incomplete profitable-result search.

## Verdict

- Current mirrored short logic: **REJECTED UNCHANGED**.
- Short-specific regime hypothesis: **PRE-REGISTERED, NOT VALIDATED**.
- Candidate promotion: **BLOCKED — INSUFFICIENT_EVIDENCE**.
- Long-side logic: **UNCHANGED**.
- MACD periods, exits, sizing, dates, and fill assumptions: **UNCHANGED**.

Required next evidence is chronologically later short activity or a separately approved
cross-market transfer study that is evaluated as transfer evidence, not pooled into this OOS
sample.
