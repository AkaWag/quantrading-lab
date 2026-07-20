# Robustness Methods

> **Title:** Robustness Methods
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (method reference; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

How the lab tests whether a result is stable rather than a lucky fit. Supports the
`robustness-analyst`, `robustness-optimizer`, `walk-forward-analyst`, and `monte-carlo-reviewer`
skills.

## Methods

| Method | Purpose | Evidence type |
|---|---|---|
| Parameter sensitivity | Behavior across neighborhoods; prefer stability regions over a single optimum | `SENSITIVITY` |
| In-sample / out-of-sample | Hold out untouched data; test generalization | `OOS` |
| Walk-forward | Rolling re-fit and re-test to mimic ongoing use | `WALKFWD` |
| Regime segmentation | Performance across trending/ranging/volatile regimes | `SENSITIVITY` |
| Monte Carlo / resampling | Distribution of outcomes; drawdown/tail stress | `MONTECARLO` |
| Cost/slippage stress | Sensitivity to worse execution assumptions | `SENSITIVITY` |

## Principles

- Fix the in-sample/out-of-sample split **before** optimizing.
- Prefer **stability regions** to knife-edge optima; a result that only works at one parameter
  setting is fragile.
- Resist multiple-testing bias: account for the number of trials.
- Record **failure regimes** — where the strategy breaks is as important as where it works.

## Recording

Log each method's result as the corresponding evidence type
([`../taxonomy/EVIDENCE_TYPES.md`](../taxonomy/EVIDENCE_TYPES.md)) with linked artifacts and
stated limitations. Robustness never repairs an invalid hypothesis or a biased backtest.

## Related documents

- [`BASELINE_COMPARISONS.md`](BASELINE_COMPARISONS.md) · [`RESEARCH_ANTI_PATTERNS.md`](RESEARCH_ANTI_PATTERNS.md)
- [`../../.cursor/skills/walk-forward-analyst/SKILL.md`](../../.cursor/skills/walk-forward-analyst/SKILL.md)
