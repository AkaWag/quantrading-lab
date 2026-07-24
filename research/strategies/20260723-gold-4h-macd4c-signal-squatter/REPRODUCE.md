# Reproduce checklist — QT-R-002

Status: **Director-owned foundation evidence** (Controllable TV Seat). Ready after baseline freeze
(2026-07-24).

## Goal

Reproduce the frozen TradingView-source metrics under declared costs, using the pinned Pine/JSON.
Do not change parameters. Do not optimize.

## Who runs it

| Role | Action |
|---|---|
| **Director** | Owns the gate; orders UI on Controllable TV Seat; verdict PASS/PARTIAL/FAIL |
| **Shotgun / Director UI** | Drive `cursor-ide-browser` TradingView: load pin, freeze window, properties, capture |
| **Owner** | Authenticate Cursor TV seat if logged out; unlock 2FA/captcha — **not** click-drive dates |

Owner Brave is companion-only unless that session is agent-controllable. PARTIAL ≠ PASS when the
freeze window was not run.

## Steps (Controllable TV Seat)

1. Open TradingView on Controllable seat: layout *Quantrading Scripts - The Lab*, **XAUUSD / OANDA / 4H**.
2. Load Pine from  
   [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine)
3. Set inputs exactly to frozen params in [`BASELINE.md`](BASELINE.md).
4. Strategy properties:
   - TF: **4H**
   - Commission: **0.1%** per side (or record deviation)
   - Slippage: set and **write the exact value used**
   - Order size mode: match percent-of-equity claim or record actual
5. Date range (project remit — read the pin, do not invent):
   - **Start:** Pine `Start Date` default **2018-01-01** (lab rule: start from 1 Jan 2018
     unless chart data does not reach that far — then use first available and record it).
   - **End:** freeze claim end **2026-05-19** (strict EV-002; not “today”).
   - Signum JSON `backtest_start: 2013-01-01` is an **upstream claim**, not a QT override of
     the Pine start input. Do not silently replace 2018 with 2013.
6. Screenshot / export Strategy Tester Overview + Properties.
7. Write evidence file:

```text
evidence/EV-002-tv-baseline-reproduce.md
```

## Must record

- Exact symbol + broker
- TV account/chart timezone
- Commission + slippage actually used
- Window actually tested
- Net %, MaxDD %, PF, trades, WR, CAGR
- Pass/fail vs freeze table
- Limitations (partial history, different fill model, etc.)

## Pass condition

Freeze metrics table in `BASELINE.md` filled under **QT reproduce**, with linked evidence path.
Discrepancies are OK if explained — silent “close enough” is not. Window must use Pine start
(**2018-01-01**, unless data-limited) and freeze claim end (**2026-05-19**) for strict PASS.
If Signum/TV claim used 2013 start, record that as claim-vs-QT-window divergence — do not
quietly change the Pine start to chase the claim.

## After pass

Only then open a one-family improvement plan. Hand heavy sweeps to Signum only under an
accepted experiment plan.
