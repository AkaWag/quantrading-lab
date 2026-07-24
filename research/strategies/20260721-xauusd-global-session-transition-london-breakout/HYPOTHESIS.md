# Hypothesis — XAUUSD session transitions condition London breakouts (QT-R-001)

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Project status: HYPOTHESIS
- Date created: 2026-07-21
- Last clarified: 2026-07-23
- Source question: [RESEARCH_QUESTION](RESEARCH_QUESTION.md)
- Experiment plan: [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md)

> Falsifiable claim to be tested — **not** validated.

## Falsifiable hypothesis

XAUUSD **session transitions are not independent**. **Asia-session range, direction, and
volatility** may condition the **probability and magnitude of London expansion**. **New York**
participation may **continue or reverse** the London move. A **session-aware** model should
therefore **outperform an otherwise equivalent London-only baseline** after realistic costs (and
remain superior to the other required controls).

**Observable proxy:** OOS after-cost expectancy and balanced scorecard materially and stably beat
the London-only baseline; advantage is not a narrow parameter knife-edge or a few outlier days.

## Market mechanism

Asia sets overnight structure; London liquidity resolves/expands it; overlap and New York add a
second participation wave that can extend, fade, or reverse the London impulse.

## Preconditions

Pre-registered Asia/London/overlap/NY windows (UTC + IANA; Asia anchor **`A-TK`**) · XAUUSD 15m ·
confirmed-bar features · no lookahead · see [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md)

## Expected behaviour / null

Session-aware selection and/or management improves after-cost outcomes vs London-only.

**Null:** no material after-cost improvement vs London-only (or fails other baselines).

## Explicit invalidation criteria

Reject or revise where:

1. does **not materially outperform** the relevant baseline(s);
2. results **disappear after realistic costs**;
3. depends on a **narrow parameter combination**;
4. **OOS** behaviour **materially deteriorates**;
5. dominated by a **small number of trades**;
6. **drawdown or false-breakout** frequency is **operationally unsuitable**;
7. session-aware logic does **not outperform the London-only equivalent**;
8. **temporal-integrity / repainting** concerns **cannot be resolved**.

## Competing hypotheses

London independent of Asia · symmetric vol · NY/overlap is noise · generic breakout not
session-specific · cost illusion · outlier/news concentration

## Assumptions / limitations

IANA DST required · Asia anchor pre-registered as `A-TK` · gold macro/news sensitivity · single
symbol/TF

## Evidence before implementation

TEMPORAL · all six baselines · IS → VAL → untouched OOS · sensitivity/ablations · cost ladder ·
trade-count sufficiency · NULL retained. No Pine / `QT-S-###` until human accepts the experiment
plan **and** separately approves implementation.

## Next step

Human accept/revise [EXPERIMENT_PLAN](EXPERIMENT_PLAN.md).
