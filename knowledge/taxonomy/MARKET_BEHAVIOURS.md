# Taxonomy — Market Behaviours

> **Title:** Market Behaviours Taxonomy
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (controlled vocabulary; no empirical claim about any behavior)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Controlled vocabulary for the market behaviors a research project may investigate. These are
**categories for organizing research**, not claims that any behavior produces a tradable edge.
Each project tags itself with one primary behavior (and optional secondary tags) in
[`../../research/registry/RESEARCH_REGISTRY.md`](../../research/registry/RESEARCH_REGISTRY.md).

## Controlled categories

| Code | Category | Working definition | Common observable proxies |
|---|---|---|---|
| `TREND` | Trend | Persistent directional drift over a horizon | MA slope, higher-highs/higher-lows, ADX |
| `MEANREV` | Mean reversion | Tendency to revert toward a reference level | Distance from MA/VWAP, z-score, RSI extremes |
| `BREAKOUT` | Breakout | Range resolution / expansion past a level | Range width, prior high/low breaks, NR bars |
| `MOMENTUM` | Momentum | Continuation of recent relative strength | ROC, relative strength, momentum rank |
| `VOL` | Volatility | Behavior of the volatility process itself | ATR, realized/implied vol, vol-of-vol |
| `SESSION` | Session behavior | Time-of-day / session effects | Open/close ranges, session VWAP, RTH vs ETH |
| `STRUCTURE` | Market structure | Swing/level structure, order-flow regimes | Swing points, break-of-structure, gaps |
| `LIQUIDITY` | Liquidity | Availability/withdrawal of resting liquidity | Spread, depth, sweeps, stop clusters |
| `VOLUME` | Volume | Participation and its relation to price | Volume, delta, VWAP, volume profile |
| `MTF` | Multi-timeframe behavior | Interaction across timeframes | HTF trend + LTF entry alignment |
| `EXEC` | Execution & cost assumptions | How fills/costs shape realized results | Slippage, commission, spread, fill timing |
| `RISKSIZE` | Risk & position sizing | Behavior of risk/sizing rules | Drawdown, exposure, risk-of-ruin, turnover |
| `EXP` | Experimental / unclassified | Ideas not yet fitting a category | free-text rationale |

## Extension policy

The taxonomy is extensible. To add a category:

1. Propose a new code and definition (draft note).
2. Confirm it is not a synonym of an existing category (see duplicate-avoidance below).
3. For a lab-wide addition, record it via ADR (this is a controlled vocabulary — a governing
   standard) per
   [`../../docs/research/KNOWLEDGE_MANAGEMENT.md`](../../docs/research/KNOWLEDGE_MANAGEMENT.md).

Never force a project into an unsuitable category. Use `EXP` (experimental / unclassified) rather
than mislabeling; the `EXP` tag is a signal that the taxonomy may need extension.

## Duplicate avoidance

Behavior categories describe *what the market does*. Do not confuse them with:

- **Strategy families** (how we trade a behavior) → [`STRATEGY_FAMILIES.md`](STRATEGY_FAMILIES.md)
- **Indicator families** (how we measure a behavior) → [`INDICATOR_FAMILIES.md`](INDICATOR_FAMILIES.md)
- **Risk concepts** (how we size/contain) → [`RISK_CONCEPTS.md`](RISK_CONCEPTS.md)

## Related documents

- [`STRATEGY_FAMILIES.md`](STRATEGY_FAMILIES.md) · [`INDICATOR_FAMILIES.md`](INDICATOR_FAMILIES.md)
- [`../../docs/research/RESEARCH_DEPARTMENT.md`](../../docs/research/RESEARCH_DEPARTMENT.md)
