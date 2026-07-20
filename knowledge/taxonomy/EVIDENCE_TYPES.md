# Taxonomy — Evidence Types

> **Title:** Evidence Types Taxonomy
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (controlled vocabulary; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Controlled vocabulary for the kinds of evidence a research project may produce or cite. Every
evidence record ([`../../research/templates/EVIDENCE_RECORD.md`](../../research/templates/EVIDENCE_RECORD.md))
declares its type. Evidence must be **linked, not merely summarized**.

## Evidence strength ladder

Ordered from weakest to strongest for supporting a claim. Strength is about *how much a result
constrains belief*, not about how favorable it is.

| Code | Type | What it is | Typical strength |
|---|---|---|---|
| `ANECDOTE` | Anecdotal observation | A noticed instance; not systematic | Very low |
| `DESCRIPTIVE` | Descriptive statistic | Summary stats over a sample | Low |
| `INSAMPLE` | In-sample backtest | Result on the optimization window | Low (bias-prone) |
| `COMPILE` | Compiler evidence | TradingView compile success/output | Factual (build only) |
| `TEMPORAL` | Temporal-integrity audit | Repaint/lookahead review result | Gating |
| `BASELINE` | Baseline comparison | Result vs a defined baseline | Medium |
| `OOS` | Out-of-sample result | Result on untouched data | Medium–high |
| `SENSITIVITY` | Sensitivity / parameter sweep | Behavior across neighborhoods | Medium–high |
| `WALKFWD` | Walk-forward | Rolling re-fit / re-test | High |
| `MONTECARLO` | Monte Carlo / resampling | Distribution of outcomes | High (stress) |
| `FORWARD` | Forward / paper test | Out-of-time live-like observation | High |
| `NULL` | Null / negative result | A test that failed to support the claim | High (retained) |

## Rules

- **Backtest is not proof.** `INSAMPLE` and even `OOS` results are hypothesis-consistent
  observations, never guarantees, per
  [`../../docs/governance/QUANTRADING_CHARTER.md`](../../docs/governance/QUANTRADING_CHARTER.md).
- **Report context.** Any performance evidence must carry symbol, timeframe, window, cost model,
  and fill assumptions, or it is not admissible.
- **Retain negatives.** `NULL` results are first-class evidence and are never deleted, per
  [`../../docs/governance/RESEARCH_GOVERNANCE.md`](../../docs/governance/RESEARCH_GOVERNANCE.md).
- **No fabrication.** Never record `COMPILE` or performance evidence that was not actually
  produced (`20-research-integrity.mdc`, AI operating principles).

## Extension policy

Extend as in [`MARKET_BEHAVIOURS.md`](MARKET_BEHAVIOURS.md#extension-policy).

## Related documents

- [`../research/RESEARCH_METHODS.md`](../research/RESEARCH_METHODS.md) · [`../research/BASELINE_COMPARISONS.md`](../research/BASELINE_COMPARISONS.md)
- [`../../checklists/research-quality.md`](../../checklists/research-quality.md)
