# Hypothesis — XAUUSD session transitions condition London breakouts (QT-R-001)

- Research ID: QT-R-001
- Stream: NEW_STRATEGY
- Owner: Aka Wag
- Project status: HYPOTHESIS
- Date created: 2026-07-21
- Last clarified: 2026-07-21
- Source question: [RESEARCH_QUESTION](RESEARCH_QUESTION.md)

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

Configurable Asia/London/overlap/NY windows (UTC + IANA; Asia anchor chosen explicitly) · XAUUSD
15m · confirmed-bar features · no lookahead

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

IANA DST required · Asia anchor must be pre-registered · gold macro/news sensitivity · single
symbol/TF

## Evidence before implementation

TEMPORAL · all six baselines · IS then untouched OOS · sensitivity/ablations · cost sensitivity ·
trade-count sufficiency · NULL retained. No Pine / `QT-S-###` until reviewed and approved.

## Next step

[SPECIFICATION](SPECIFICATION.md) — then **controlled research specification review**.
