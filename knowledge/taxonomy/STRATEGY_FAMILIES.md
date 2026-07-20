# Taxonomy — Strategy Families

> **Title:** Strategy Families Taxonomy
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (controlled vocabulary; no empirical claim about any family)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Controlled vocabulary for *how* the lab attempts to trade a market behavior. A strategy family
is an approach, not a validated edge. Families map to, but are distinct from, the behaviors in
[`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md).

## Controlled categories

| Code | Family | Typical behavior traded | Notes |
|---|---|---|---|
| `TREND-FOLLOW` | Trend following | `TREND`, `MOMENTUM` | Enter with direction; wide stops, trailing exits |
| `MEANREV` | Mean reversion | `MEANREV`, `VOL` | Fade extremes toward a reference; tight risk |
| `BREAKOUT` | Breakout / expansion | `BREAKOUT`, `VOL`, `STRUCTURE` | Trade range resolution; false-break risk |
| `MOMENTUM-ROT` | Momentum / rotation | `MOMENTUM` | Rank and rotate into relative strength |
| `VOL-TARGET` | Volatility targeting / regime | `VOL`, `RISKSIZE` | Scale exposure by volatility regime |
| `SESSION` | Session / time-based | `SESSION` | Exploit time-of-day/session structure |
| `STRUCTURE` | Market-structure / price-action | `STRUCTURE`, `LIQUIDITY` | Swing/level/order-flow logic |
| `MTF-CONFIRM` | Multi-timeframe confirmation | `MTF` | HTF context filters LTF entries |
| `LIQUIDITY` | Liquidity / microstructure | `LIQUIDITY`, `VOLUME` | Spread/depth/sweep-driven logic |
| `EXP` | Experimental / unclassified | any | Not yet fitting a family |

## Relationship to behaviors and indicators

- A family **acts on** one or more behaviors ([`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md)).
- A family **is measured with** indicator families ([`INDICATOR_FAMILIES.md`](INDICATOR_FAMILIES.md)).
- A family **is contained by** risk concepts ([`RISK_CONCEPTS.md`](RISK_CONCEPTS.md)).

## Extension policy

Add families through the same process as
[`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md#extension-policy). Prefer `EXP` over forcing a poor
fit. A family is not "proven" by inclusion here; inclusion only means the approach is recognized
for organizing research.

## Related documents

- [`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md) · [`INDICATOR_FAMILIES.md`](INDICATOR_FAMILIES.md) · [`RISK_CONCEPTS.md`](RISK_CONCEPTS.md)
- [`../../docs/governance/STRATEGY_LIFECYCLE.md`](../../docs/governance/STRATEGY_LIFECYCLE.md)
