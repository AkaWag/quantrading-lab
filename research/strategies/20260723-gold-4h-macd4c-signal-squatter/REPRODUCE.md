# Reproduce checklist — QT-R-002

Status: **ready to run** after baseline freeze (2026-07-24).

## Goal

Reproduce the frozen TradingView-source metrics under declared costs, using the pinned Pine/JSON.
Do not change parameters. Do not optimize.

## Steps (owner / Shotgun / Signum)

1. Open TradingView on **XAUUSD** (OANDA or declare the exact broker symbol used).
2. Load Pine from  
   [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine)
3. Set inputs exactly to frozen params in [`BASELINE.md`](BASELINE.md).
4. Strategy properties:
   - TF: **4H**
   - Commission: **0.1%** per side (or record deviation)
   - Slippage: set and **write the exact value used**
   - Order size mode: match percent-of-equity claim or record actual
5. Date range: prefer **2013-01-01 → 2026-05-19** (or TV maximum available; record actual).
6. Screenshot / export Strategy Tester summary + list of settings.
7. Create evidence file:

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
Discrepancies are OK if explained — silent “close enough” is not.

## After pass

Only then open a one-family improvement plan. Hand heavy sweeps to Signum only under an
accepted experiment plan.
