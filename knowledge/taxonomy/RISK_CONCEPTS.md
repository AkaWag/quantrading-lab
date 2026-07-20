# Taxonomy — Risk Concepts

> **Title:** Risk Concepts Taxonomy
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (controlled vocabulary; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Controlled vocabulary for risk, position sizing, and execution/cost assumptions. Risk control is
a **design input**, not a later addition, per
[`../../docs/governance/QUANTRADING_CHARTER.md`](../../docs/governance/QUANTRADING_CHARTER.md) and
`40-risk-and-deployment.mdc`.

## Risk layers

| Code | Layer | Question it answers |
|---|---|---|
| `SIGNAL-RISK` | Signal risk | Is the entry/exit logic itself sound and non-repainting? |
| `TRADE-RISK` | Trade risk | Per-trade stop, target, and R multiple |
| `ACCOUNT-RISK` | Account risk | Exposure, drawdown, correlation, risk-of-ruin |
| `OPS-RISK` | Operational risk | Alert/fill/connectivity/data failures |

## Position sizing concepts (`RISKSIZE`)

| Code | Concept | Notes |
|---|---|---|
| `FIXED-QTY` | Fixed quantity/contracts | Simplest; ignores volatility |
| `FIXED-FRACTIONAL` | Fixed % of equity per trade | Common risk-per-trade model |
| `ATR-RISK` | ATR / volatility-based sizing | Size from stop distance × point value |
| `VOL-TARGET` | Volatility targeting | Scale exposure to a target vol |
| `KELLY-CAPPED` | Capped Kelly / fractional Kelly | Use with caution; sensitive to estimates |

## Execution & cost assumptions (`EXEC`)

Every strategy must make these explicit (see
[`../pine/TRADINGVIEW_EXECUTION_NOTES.md`](../pine/TRADINGVIEW_EXECUTION_NOTES.md)):

- commission model and value; slippage; spread;
- order types and fill timing (`process_orders_on_close`, `calc_on_every_tick`,
  `calc_on_order_fills`, bar magnifier);
- initial capital, currency, pyramiding, and quantity behavior.

## Stop and exit concepts

| Code | Concept | Notes |
|---|---|---|
| `STOP-FIXED` | Fixed-distance / entry-anchored stop | Distance set at entry |
| `STOP-ATR` | ATR-based stop | Distinguish entry-fixed vs recomputed each bar |
| `STOP-STRUCT` | Structure-based stop | Below/above swing or level |
| `EXIT-SIGNAL` | Signal-based exit | Opposite/neutral signal |
| `EXIT-TIME` | Time/session-based exit | Flatten at session end |
| `TRAIL` | Trailing stop / profit lock | Trailing logic |

## Extension policy

Extend as in [`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md#extension-policy); use `EXP` where a
concept does not fit. Live-deployment limits remain governed by `40-risk-and-deployment.mdc` and
are never enabled from research artifacts.

## Related documents

- [`../../templates/risk-spec.md`](../../templates/risk-spec.md) · [`../../.cursor/skills/risk-architect/SKILL.md`](../../.cursor/skills/risk-architect/SKILL.md)
- [`EVIDENCE_TYPES.md`](EVIDENCE_TYPES.md)
