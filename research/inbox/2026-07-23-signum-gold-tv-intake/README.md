# Gold / TradingView strategy intake (Signum → QuanTrading)

**ADR:** [`../../decisions/ADR-008-intake-signum-gold-tv-strategies.md`](../../decisions/ADR-008-intake-signum-gold-tv-strategies.md)  
**Purpose:** All Signum gold TV strategies enter QuanTrading `EXISTING_STRATEGY` streams for
baseline freeze → reproduce → controlled improvement → evidence. Not ad-hoc optimisation outside
the lab.

## Why

The QuanTrading apparatus exists so strategies are not improved only in an external tree. Signum
may compute and stage; **QuanTrading owns the structured process**.

## Map

| QT-R | Title | Signum anchors | Activity |
|---|---|---|---|
| [QT-R-002](../strategies/20260723-gold-4h-macd4c-signal-squatter/) | Gold 4H MACD 4C Squatter | `Gold_4H_MACD_v20` · fleet Grade A | **Active** |
| [QT-R-003](../strategies/20260723-gold-1h-macd4c-signal-squatter/) | Gold 1H MACD 4C Squatter | `Gold_1H_MACD_v21` · fleet Grade C | Parked |
| [QT-R-004](../strategies/20260723-gold-1h-3macd-confluence/) | Gold 1H 3-MACD v2.2 | Spec + production-ready report + `three_macd_*` | Parked (queue) |
| [QT-R-001](../strategies/20260721-xauusd-global-session-transition-london-breakout/) | Session London breakout | NEW_STRATEGY research | Parallel (not MACD) |

## Process (every EXISTING gold project)

```text
INTAKE (source pin) → BASELINE freeze (params, costs, metrics claim, Pine path)
  → REPRODUCE under QT assumptions (evidence)
  → optional controlled change (one family at a time)
  → compare to frozen baseline → VALIDATION / QT-S-### only when earned
```

Optimisation sweeps in Signum are **inputs to review**, not automatic acceptance.

## Signum root

`~/signum-ai-strategy/backtest/engine_repo/`
