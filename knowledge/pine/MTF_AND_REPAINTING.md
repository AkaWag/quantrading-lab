# MTF and Repainting

> **Title:** Multi-Timeframe and Repainting Notes
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (organizes known risks; the repository MTF template is documented
> but not independently temporal-audited)
> **Evidence references:** [`../../pine/indicators/mtf_confirmed_template_v6.pine`](../../pine/indicators/mtf_confirmed_template_v6.pine)
> **Supersedes:** none
> **Superseded by:** none

Reusable notes on multi-timeframe requests, repainting, and lookahead. This is a **special
review area** per `20-non-repainting.mdc` and
[`../../docs/governance/ENGINEERING_STANDARDS.md`](../../docs/governance/ENGINEERING_STANDARDS.md).

## Definitions

- **Repainting** — historical signals differ from what would have been available in realtime.
- **Lookahead** — using information not yet available at the decision bar.

## Confirmed HTF pattern

To request the last *confirmed* higher-timeframe value, the repository template uses an offset
with `lookahead_on` (documented in
[`../../pine/indicators/mtf_confirmed_template_v6.pine`](../../pine/indicators/mtf_confirmed_template_v6.pine)):

```text
request.security(syminfo.tickerid, htf, close[1], gaps=barmerge.gaps_off, lookahead=barmerge.lookahead_on)
```

- `barmerge.lookahead_on` is only acceptable when the requested series is **correctly offset**
  (e.g. `close[1]`) and the reason is documented, per `20-non-repainting.mdc`.
- Prefer confirmed-bar values; reject requests for equal or lower timeframes as HTF context.

## Review checklist pointers

- Temporal-integrity review: [`../../checklists/repainting-audit.md`](../../checklists/repainting-audit.md).
- MTF-specific review: [`../../checklists/mtf-audit.md`](../../checklists/mtf-audit.md).

## Open verification items

The repository MTF template's offset+`lookahead_on` pattern is **documented but not
independently validated** for any specific symbol/session in this workspace. Any project using it
as a dependency must run a temporal audit and record the result as `TEMPORAL` evidence
([`../taxonomy/EVIDENCE_TYPES.md`](../taxonomy/EVIDENCE_TYPES.md)).

## Related documents

- [`PINE_PATTERNS.md`](PINE_PATTERNS.md) · [`COMMON_FAILURES.md`](COMMON_FAILURES.md)
- [`../../.cursor/skills/repaint-lookahead-auditor/SKILL.md`](../../.cursor/skills/repaint-lookahead-auditor/SKILL.md)
