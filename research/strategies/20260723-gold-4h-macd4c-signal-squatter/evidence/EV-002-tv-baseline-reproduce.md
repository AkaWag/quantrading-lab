# EV-002 — TradingView baseline reproduce (QT-R-002)

Status: **PASS** (2026-07-24). Correct QT window Overview and shared execution Properties captured
on the Controllable TV Seat.

- Research ID: QT-R-002
- Checklist: [`../REPRODUCE.md`](../REPRODUCE.md)
- Freeze table: [`../BASELINE.md`](../BASELINE.md)

## Run metadata

| Field | Value |
|---|---|
| Date of run | 2026-07-24 (~17:33 UTC+1 / chart clock UTC+2) |
| Operator | Director on Controllable TV Seat (`cursor-ide-browser`) |
| Layout | Quantrading Scripts - The Lab |
| Symbol / TF | **XAUUSD** · **4H** · OANDA (chart header) |
| Capital | **1 K USD** |
| Date range tested | **2018-01-01 → 2026-05-19** (DEEP) |
| QT remit window | Pine Start **2018-01-01**; freeze end **2026-05-19** |
| Signum JSON claim window | 2013-01-01 → 2026-05-19 (upstream claim only — not QT override) |
| Pine file | `pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine` |
| Commission / slippage | **0.1% / 0 ticks**, Strategy-Properties verified |
| Chart display timezone | **UTC+2** |

## Execution settings

The captured Properties confirm initial capital **1,000 USD**; order size **100% of equity**;
commission **0.1%**; slippage **0 ticks**; pyramiding **1**; default four-ticks-per-bar
detalization; script execution **on bar close**; limit execution at requested price; and
one-tick order execution delay. Long and short leverage display as **Infinity**.

## Strategy Tester results (Overview)

| Metric | Signum/TV claim (2013 start) | This run (2018 start) | Notes |
|---|---|---|---|
| Net profit % | 98.82 | **101.31** (+1,013.12 USD) | Different start window — not like-for-like |
| Max drawdown % | 7.93 | **7.98** (106.82 USD) | Near magnitude |
| Profit factor | 3.376 | **3.532** | Different window |
| Trades | 41 | **39** | Expected fewer with later start |
| Win rate % | 46.34 (19/41) | **46.15** (18/39) | |
| CAGR % | 5.27 | _not on Overview bar_ | Unknown |

## Attachments

- [x] Overview screenshot (Controllable seat): [`EV-002-overview-2018-20260519.png`](EV-002-overview-2018-20260519.png)
- [x] Strategy Properties: [`EV-005-strategy-properties.png`](EV-005-strategy-properties.png)
- [x] Direction/input state: [`EV-005-short-only-inputs.png`](EV-005-short-only-inputs.png)
- [x] Chart display timezone: UTC+2 visible on the captured seat
- Prior Brave crops (wrong window) retained for audit only:
  - `EV-002-capture-brave-*.png`

## Verdict

- [x] **PASS** — correct QT window and shared execution Properties evidenced
- [ ] FAIL
- [ ] PARTIAL

## Notes

1. Lab rule applied: start **2018-01-01** (Pine default), end freeze claim **2026-05-19**.
2. Do not treat 2013 JSON start as QT override.
3. Direct Controllable-seat snapshot at ~18:16 confirmed the header remained
   **Jan 1, 2018 — May 19, 2026 (Deep)**. A delegated browser report that observed the old
   2013→2026-07-24 range is rejected as a separate/stale browser state and is not used as evidence.
4. Properties were captured later while D0-S was selected. Direction toggles are Inputs; the
   captured execution Properties are shared by the same strategy instance and reconcile with the
   Pine declaration.
