# Hypothesis Design

> **Title:** Hypothesis Design
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (method reference; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

How to turn an idea into a falsifiable hypothesis. Supports the `hypothesis-designer` and
`market-behavior-researcher` skills, the template
[`../../research/templates/HYPOTHESIS.md`](../../research/templates/HYPOTHESIS.md), and the gate
in [`../../checklists/research-quality.md`](../../checklists/research-quality.md).

## A good hypothesis states

1. **A falsifiable claim** — a statement that could be shown false by evidence.
2. **A market mechanism** — *why* the behavior might exist (participants, incentives, structure).
3. **Preconditions** — the regime/conditions under which it should hold.
4. **Expected behavior** — the observable signature (direction, magnitude, frequency).
5. **Invalidation criteria** — the specific results that would disprove it.
6. **Competing hypotheses** — alternative explanations for the same observation.

## Falsifiability test

If no realistic result could disprove the claim, it is **not** a hypothesis — sharpen it. State a
null hypothesis and an observable proxy that is unambiguous.

## From observation to hypothesis

- Start from a recorded observation
  ([`../../research/templates/OBSERVATION.md`](../../research/templates/OBSERVATION.md)) and its
  alternative explanations.
- Narrow to a decision-relevant research question
  ([`../../research/templates/RESEARCH_QUESTION.md`](../../research/templates/RESEARCH_QUESTION.md)).
- Only then write the hypothesis. See
  [`../../docs/research/RESEARCH_ARTIFACT_MODEL.md`](../../docs/research/RESEARCH_ARTIFACT_MODEL.md).

## Anti-patterns

- Vague claims ("this works in trends") with no proxy or invalidation.
- Post-hoc hypotheses fitted to a favorable backtest.
- Confusing the indicator with the mechanism. See
  [`RESEARCH_ANTI_PATTERNS.md`](RESEARCH_ANTI_PATTERNS.md).

## Related documents

- [`RESEARCH_METHODS.md`](RESEARCH_METHODS.md) · [`../taxonomy/MARKET_BEHAVIOURS.md`](../taxonomy/MARKET_BEHAVIOURS.md)
- [`../../templates/hypothesis.md`](../../templates/hypothesis.md)
