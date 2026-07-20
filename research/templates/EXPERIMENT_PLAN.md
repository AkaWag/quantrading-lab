# Experiment Plan — <short title>

- Research ID: <QT-R-###>
- Owner: <human name>
- Date: YYYY-MM-DD
- Source specification: [SPECIFICATION](SPECIFICATION.md)

Defines how the hypothesis will be tested **before** any run. Extends
[`../../templates/test-plan.md`](../../templates/test-plan.md). Fix the in-sample/out-of-sample
split here, before optimizing.

## Baseline

<the baseline for comparison and why; see [`../../knowledge/research/BASELINE_COMPARISONS.md`](../../knowledge/research/BASELINE_COMPARISONS.md)>

## Variables

<the parameters/choices being tested>

## Fixed assumptions

<what is held constant across runs: symbol, costs, sizing, session — no multi-change runs>

## In-sample and out-of-sample plan

<exact windows; OOS remains untouched until validation>

## Sensitivity plan

<parameter neighborhoods to sweep; stability-region criteria>

## Robustness plan

<walk-forward, regime segmentation, Monte Carlo, cost stress; see
[`../../knowledge/research/ROBUSTNESS_METHODS.md`](../../knowledge/research/ROBUSTNESS_METHODS.md)>

## Stop conditions

<the results that halt the experiment early (accept, reject, or return to hypothesis)>

## Required evidence

<the evidence types and minimum bar to accept/reject; see
[`../../knowledge/taxonomy/EVIDENCE_TYPES.md`](../../knowledge/taxonomy/EVIDENCE_TYPES.md)>

## Next step

<record results as [EVIDENCE_RECORD](EVIDENCE_RECORD.md)s (and [FAILURE_RECORD](FAILURE_RECORD.md)s)>
