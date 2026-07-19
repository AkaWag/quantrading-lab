# QuanTrading Lab Charter

This charter defines the mission, scope, and guiding principles of QuanTrading Lab.
It sits above individual strategies and tools. Where more specific rules exist under
[`.cursor/rules/`](../../.cursor/rules/), those rules and this charter are intended to agree;
if they ever conflict, the safety, Pine Script, research-integrity, and security rules take precedence.

## Mission

QuanTrading Lab exists to research, engineer, and evaluate trading strategies as
falsifiable hypotheses under disciplined controls. The goal is durable, evidence-based
capability, not the pursuit of a single profitable backtest.

## Scope: V2.5 and V3

- **V2.5 (current)** is the quantitative research and Pine Script development workspace.
  It holds hypotheses, specifications, Pine source, tests, reviews, and release records.
  V2.5 is where research is performed and documented.
- **V3 (future)** is intended to be the centrally managed platform and service layer that
  hosts and manages V2.5 workspaces. V3 is a plan, not an existing system. It should manage
  V2.5 workspaces rather than replace their research standards. See
  [`../architecture/PLATFORM_VISION.md`](../architecture/PLATFORM_VISION.md) and
  [`../architecture/V2_5_TO_V3_ROADMAP.md`](../architecture/V2_5_TO_V3_ROADMAP.md).

## Guiding principles

- **Capital preservation.** Risk control is a design input, not a later addition. Avoiding
  ruin outranks maximizing return.
- **Evidence over intuition.** Claims require reproducible evidence. Intuition may generate
  hypotheses; it does not validate them.
- **Reproducibility.** Any reported result must be reconstructable from recorded assumptions,
  data windows, parameters, and code versions.
- **Simplicity.** Prefer the simplest logic that explains the behavior. Complexity must earn
  its place with evidence.
- **Traceability.** Maintain an unbroken chain from requirement to code, test evidence, review
  finding, and release note.
- **Controlled change.** Significant changes are proposed, reviewed, and recorded. Nothing
  material is introduced silently.

## Backtest performance is not proof

A profitable backtest is a hypothesis-consistent observation, not proof of future
profitability. Historical results are subject to overfitting, selection bias, survivorship
bias, lookahead bias, data-mining bias, and regime change. No document, review, or approval in
this repository may treat a backtest as a guarantee of live performance.

## Strategy evidence tiers

These tiers describe how much a strategy has been demonstrated, not how profitable it is.
They map to the statuses in [`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md).

- **Research.** An idea under active investigation. Assumptions may be incomplete; no claim of
  validity is made.
- **Validated research.** A falsifiable hypothesis with a completed specification, verified
  implementation, and a backtest whose assumptions and limitations are fully documented.
  Validity is limited to the tested conditions.
- **Candidate strategy.** Validated research that has additionally passed robustness testing
  (sensitivity, in-sample vs out-of-sample separation, regime awareness) and independent
  review, and is proposed for a release decision.
- **Production-approved strategy.** A candidate for which a governance approval has been
  recorded. Approval is a governance state indicating controls and reviews are satisfied. It
  is **not** a profitability guarantee, and it does not authorize live capital by itself.

## Prohibited claims

The following are prohibited unless objectively justified by supplied evidence:

- Guaranteed, safe, risk-free, optimal, institutional-grade, or production-ready as
  descriptions of expected returns.
- Presenting a backtest, or any in-sample result, as proof of future profitability.
- Reporting performance figures without their symbol, timeframe, cost model, window, and
  fill assumptions.
- Claiming TradingView compilation, backtest performance, or live behavior without evidence.

## Related documents

- [`AI_OPERATING_PRINCIPLES.md`](AI_OPERATING_PRINCIPLES.md)
- [`ENGINEERING_STANDARDS.md`](ENGINEERING_STANDARDS.md)
- [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md)
- [`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md)
- [`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md)
- [`DECISION_GOVERNANCE.md`](DECISION_GOVERNANCE.md)
