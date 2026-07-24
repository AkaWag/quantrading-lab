# Research Methods

> **Title:** Research Methods
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (method reference distilled from governance; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Reusable reference for how the lab conducts research. It distills
[`../../docs/governance/RESEARCH_GOVERNANCE.md`](../../docs/governance/RESEARCH_GOVERNANCE.md) and
the research-integrity rules into a working method.

## The method

```text
observation → research question → falsifiable hypothesis → specification
→ experiment plan → evidence (incl. negatives) → review → closeout → lessons
```

Each step is falsifiable-first: define what would disprove the idea before testing it.

## Required for every study

- **Falsifiable hypothesis** with explicit invalidation criteria.
- **Market/timeframe assumptions**: symbol, asset class, exchange, timeframe, session, timezone,
  expected regime. Session-aware projects follow the Asia → London → New York architecture in
  [`GLOBAL_SESSION_ARCHITECTURE.md`](GLOBAL_SESSION_ARCHITECTURE.md) (UTC internal; IANA named
  zones; sessions not modeled in isolation).
- **Baseline comparison** ([`BASELINE_COMPARISONS.md`](BASELINE_COMPARISONS.md)).
- **In-sample / out-of-sample separation** fixed before optimizing.
- **Sensitivity / robustness** across parameter neighborhoods
  ([`ROBUSTNESS_METHODS.md`](ROBUSTNESS_METHODS.md)).

## Bias controls

Explicitly address overfitting, survivorship, selection, lookahead, and data-mining/
multiple-testing bias, plus sample size, trade clustering, regime dependence, and turnover, per
`20-research-integrity.mdc`.

## Evidence discipline

- Classify evidence by type ([`../taxonomy/EVIDENCE_TYPES.md`](../taxonomy/EVIDENCE_TYPES.md)).
- Link evidence; never rely on a bare summary.
- Retain negative and failed results.
- Do not present a backtest as proof of future profitability.

## Related documents

- [`HYPOTHESIS_DESIGN.md`](HYPOTHESIS_DESIGN.md) · [`BASELINE_COMPARISONS.md`](BASELINE_COMPARISONS.md) · [`ROBUSTNESS_METHODS.md`](ROBUSTNESS_METHODS.md) · [`RESEARCH_ANTI_PATTERNS.md`](RESEARCH_ANTI_PATTERNS.md)
- [`../../docs/research/RESEARCH_ARTIFACT_MODEL.md`](../../docs/research/RESEARCH_ARTIFACT_MODEL.md)
