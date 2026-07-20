# Baseline Comparisons

> **Title:** Baseline Comparisons
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (method reference; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Why and how to compare against a baseline. A **baseline comparison is required before any
promotion**, per
[`../../docs/governance/RESEARCH_GOVERNANCE.md`](../../docs/governance/RESEARCH_GOVERNANCE.md) and
[`../../docs/research/RESEARCH_REVIEW_PROCESS.md`](../../docs/research/RESEARCH_REVIEW_PROCESS.md).
Net profit alone is never sufficient.

## Choosing a baseline

| Baseline | When appropriate |
|---|---|
| Buy-and-hold | Directional strategies on a single instrument |
| Naive rule | A trivial version of the same idea (e.g. always-long, single MA) |
| Existing strategy | When improving on a known candidate |
| Random-entry / shuffle | To test whether structure beats chance (stress) |

State explicitly which baseline is used and why.

## Comparing fairly

- Use the **same** symbol, window, costs, and sizing for strategy and baseline.
- Compare on a **balanced scorecard**, not net profit: risk-adjusted return, max drawdown and
  recovery, exposure, turnover, trade count, and tail risk (per `20-research-integrity.mdc`).
- Report in-sample and out-of-sample separately.

## Recording

Record the comparison as `BASELINE` evidence
([`../taxonomy/EVIDENCE_TYPES.md`](../taxonomy/EVIDENCE_TYPES.md)) with links to the underlying
runs. A strategy that does not beat a fair baseline on the balanced scorecard does not advance.

## Related documents

- [`ROBUSTNESS_METHODS.md`](ROBUSTNESS_METHODS.md) · [`../../checklists/backtest-audit.md`](../../checklists/backtest-audit.md)
