# Research Governance

This document defines how research is conducted and evidenced in QuanTrading Lab. It expands on
the enforced rules `20-research-integrity.mdc`, `30-backtest-integrity.mdc`, and
`50-research-governance.mdc` in [`.cursor/rules/`](../../.cursor/rules/), and complements the
gated workflow in [`../WORKFLOW.md`](../WORKFLOW.md) and the intake protocol in
[`../UPDATE-INGESTION.md`](../UPDATE-INGESTION.md). Those documents take precedence where more
specific; this document is the narrative overview.

## Research workflow

```text
idea → hypothesis → specification → implementation → verification
→ backtest → robustness testing → review → release decision
```

Each stage produces an artifact and can send work back to an earlier stage. Optimization never
repairs an invalid hypothesis or a biased backtest. The gate/artifact/skill mapping lives in
[`../WORKFLOW.md`](../WORKFLOW.md); the lifecycle statuses are in
[`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md).

## Requirements for every study

- **Falsifiable hypothesis.** State what would make the hypothesis false and under what
  conditions. Use [`../../templates/hypothesis.md`](../../templates/hypothesis.md).
- **Market and timeframe assumptions.** Symbol, asset class, exchange, timeframe, session,
  timezone, and the regime the edge is expected in.
- **Baseline comparison.** Compare against a defined baseline (for example buy-and-hold, a
  naive rule, or an existing strategy). Net profit alone is never sufficient.
- **In-sample / out-of-sample separation.** Define the windows before optimizing. Keep
  out-of-sample data untouched until validation.
- **Sensitivity testing.** Examine behavior across parameter neighborhoods; prefer stability
  regions over a single optimum. Resist parameter instability and knife-edge settings.

## Bias controls

Every evaluation must explicitly address:

- **Overfitting** — too many parameters or degrees of freedom for the sample.
- **Survivorship bias** — delisted or failed instruments excluded from the sample.
- **Selection bias** — cherry-picking symbols, windows, or favorable runs.
- **Lookahead bias** — using information not available at decision time (see
  [`../../checklists/repainting-audit.md`](../../checklists/repainting-audit.md)).
- **Data-mining / multiple-testing bias** — many trials without accounting for the number of
  comparisons.

Also consider sample size, trade clustering, regime dependence, and turnover, per
`20-research-integrity.mdc`.

## Recording results, including failures

- **Record failed experiments** rather than hiding them. Keep null results and failure regimes
  in [`../../experiments/`](../../experiments/) or the strategy's own folder. Failure evidence
  is valuable and prevents repeated dead ends.
- Do not change multiple assumptions between runs without disclosure; such comparisons are
  rejected.
- Keep source and date metadata for incoming material (see
  [`../UPDATE-INGESTION.md`](../UPDATE-INGESTION.md)).

## Evidence package for promotion

Before a strategy is promoted toward CANDIDATE or APPROVED (see
[`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md)), assemble an evidence package containing:

- the hypothesis, specification, and risk spec;
- the exact code version / identifier;
- backtest configuration (symbol, timeframe, window, costs, sizing, fills) and results;
- in-sample vs out-of-sample results and the baseline comparison;
- robustness / sensitivity evidence and identified failure regimes;
- review findings and their resolutions;
- a statement of known limitations and untested conditions.

## Related documents

- [`QUANTRADING_CHARTER.md`](QUANTRADING_CHARTER.md)
- [`ENGINEERING_STANDARDS.md`](ENGINEERING_STANDARDS.md)
- [`STRATEGY_LIFECYCLE.md`](STRATEGY_LIFECYCLE.md)
- [`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md)
- Checklists: [`research-quality`](../../checklists/research-quality.md),
  [`backtest-audit`](../../checklists/backtest-audit.md),
  [`mtf-audit`](../../checklists/mtf-audit.md)
