# Common Pine Failures

> **Title:** Common Pine / Backtest Failure Modes
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (catalogue of known failure modes; not derived from a specific
> failed project yet)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

A catalogue of recurring failure modes to check for. When a project actually hits one, record it
as a `FAILURE_RECORD`
([`../../research/templates/FAILURE_RECORD.md`](../../research/templates/FAILURE_RECORD.md)) and,
if reusable, promote a lesson.

## Temporal / repainting failures

- Using unconfirmed values so historical ≠ realtime behavior.
- `barmerge.lookahead_on` without a correct offset → future leak.
- Requesting equal/lower timeframe as "higher" context.

## Execution-realism failures

- No commission/slippage, or unrealistic values.
- Ambiguous stop semantics (entry-fixed vs recomputed each bar) producing misleading results.
- Unspecified quantity/sizing so the emulator default silently drives results.
- Reversal logic assuming a flatten-before-reverse that the emulator does not perform.

## Research-integrity failures (see also [`../research/RESEARCH_ANTI_PATTERNS.md`](../research/RESEARCH_ANTI_PATTERNS.md))

- Optimizing before fixing the in-sample/out-of-sample split.
- Changing multiple assumptions between runs without disclosure.
- Reporting net profit without drawdown, exposure, and cost context.
- Curve-fitting to a single optimum instead of a stability region.

## Engineering failures

- More than one `strategy()`/`indicator()` call, or missing `//@version=6`.
- Excessive labels/lines/arrays/loops or repeated `request.*()` calls (see
  [`PERFORMANCE_NOTES.md`](PERFORMANCE_NOTES.md)).
- Alerts that do not match the actual logic or misstate intrabar vs bar-close timing.

## Related documents

- [`MTF_AND_REPAINTING.md`](MTF_AND_REPAINTING.md) · [`TRADINGVIEW_EXECUTION_NOTES.md`](TRADINGVIEW_EXECUTION_NOTES.md)
- [`../../.cursor/skills/failure-analysis-investigator/SKILL.md`](../../.cursor/skills/failure-analysis-investigator/SKILL.md)
