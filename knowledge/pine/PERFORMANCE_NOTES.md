# Pine Performance Notes

> **Title:** Pine Runtime / Resource Notes
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (general runtime guidance; not benchmarked in this workspace)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

Guidance for keeping Pine scripts within TradingView runtime and resource limits, consistent with
`10-pine-v6-standards.mdc` and the `pine-performance-engineer` / `performance-optimizer` skills.
Optimize runtime **without changing strategy semantics**.

## Cost drivers to watch

- Repeated `request.security()` / `request.*()` calls — consolidate and reuse.
- Unbounded or large arrays, and per-bar array growth.
- Excessive drawing objects (labels, lines, boxes) — respect object limits.
- Heavy loops executed every bar.
- Redundant recomputation of the same series.

## Techniques

- Compute a series once and reference it, rather than recomputing inline.
- Guard expensive work behind `barstate.isconfirmed` or event conditions where valid.
- Prefer built-in `ta.*` functions over hand-rolled equivalents.
- Cap the number of drawing objects and reuse/replace rather than accumulate.

## Discipline

- A performance change must be **semantics-preserving**; verify signals/orders are unchanged.
- Record any measured before/after runtime as evidence; do not claim a speedup without it.

## Related documents

- [`PINE_PATTERNS.md`](PINE_PATTERNS.md) · [`COMMON_FAILURES.md`](COMMON_FAILURES.md)
- [`../../.cursor/skills/pine-performance-engineer/SKILL.md`](../../.cursor/skills/pine-performance-engineer/SKILL.md)
