# Research Anti-Patterns

> **Title:** Research Anti-Patterns
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (catalogue of pitfalls; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Recurring research mistakes to detect and reject. These operationalize the bias controls in
[`../../docs/governance/RESEARCH_GOVERNANCE.md`](../../docs/governance/RESEARCH_GOVERNANCE.md) and
`20-research-integrity.mdc`.

## Hypothesis anti-patterns

- **Non-falsifiable claim** — no result could disprove it.
- **Post-hoc hypothesis** — invented to fit a favorable backtest.
- **Mechanism-free claim** — no reason the behavior should exist.

## Testing anti-patterns

- **Optimize-then-split** — tuning before fixing the IS/OOS boundary.
- **Peeking at OOS** — repeatedly consulting held-out data until it passes.
- **Multiple-testing without accounting** — many trials, best one reported.
- **Multi-change runs** — altering several assumptions at once without disclosure.
- **Curve-fitting** — a single knife-edge optimum instead of a stability region.

## Evidence anti-patterns

- **Net-profit-only ranking** — ignoring drawdown, exposure, turnover, tail risk.
- **Context-free performance** — reporting returns without symbol/timeframe/window/costs/fills.
- **Summary-without-link** — claiming a result with no linked artifact.
- **Hiding negatives** — discarding failed or null results.

## Process anti-patterns

- **Backtest-as-proof** — treating historical results as guaranteed future performance.
- **Silent knowledge rewrite** — editing established knowledge without marking supersession.
- **Scope creep to deployment** — enabling optimization or live routing from research artifacts.

## What to do instead

For each anti-pattern, the corresponding correct method is in
[`RESEARCH_METHODS.md`](RESEARCH_METHODS.md),
[`BASELINE_COMPARISONS.md`](BASELINE_COMPARISONS.md), and
[`ROBUSTNESS_METHODS.md`](ROBUSTNESS_METHODS.md). Record real occurrences as
`FAILURE_RECORD`s and promote reusable lessons.

## Related documents

- [`../../checklists/research-quality.md`](../../checklists/research-quality.md) · [`../pine/COMMON_FAILURES.md`](../pine/COMMON_FAILURES.md)
