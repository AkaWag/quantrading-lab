# Cursor Handover

This document explains how a new Cursor session should onboard to QuanTrading Lab and hand work
back cleanly. It works alongside [`FIRST_SESSION_CHECKLIST.md`](FIRST_SESSION_CHECKLIST.md).

## Onboarding sequence

A new session should, before broad changes, read:

1. The workspace [`../../README.md`](../../README.md) and this onboarding folder.
2. The charter and governance set in [`../governance/`](../governance/), starting with
   [`QUANTRADING_CHARTER.md`](../governance/QUANTRADING_CHARTER.md) and
   [`AI_OPERATING_PRINCIPLES.md`](../governance/AI_OPERATING_PRINCIPLES.md).
3. The applicable rules in [`../../.cursor/rules/`](../../.cursor/rules/) (always-applied rules
   plus any matching the files being edited, e.g. Pine rules for `*.pine`).
4. The current state in [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md) and the prioritized
   work in [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md).
5. The relevant skill files for the task under [`../../.cursor/skills/`](../../.cursor/skills/).

## Choosing specialist skills

Pick the smallest set of specialist skills that fits the task, for example:

- Framing a market behavior or hypothesis → `market-behavior-researcher`, `hypothesis-designer`.
- Specifying a strategy → `strategy-architect`, `risk-architect`.
- Implementing Pine → `pine-v6-engineer` / `pine-v6-developer`.
- Fixing compiler errors → `pine-compiler-triage`.
- Temporal / backtest / robustness review → `repaint-lookahead-auditor`, `backtest-auditor`,
  `robustness-analyst`, `walk-forward-analyst`, `monte-carlo-reviewer`.
- Release decisions → `release-gatekeeper` / `release-reviewer`.
- Ingesting external material → `update-intake-analyst`.

The full list is in [`../../.cursor/skills/`](../../.cursor/skills/); prefer the skill whose
description matches the current gate in [`../WORKFLOW.md`](../WORKFLOW.md).

## Plan before broad changes

Before broad or multi-file changes, produce a short plan describing intent, files to be
touched, and expected verification. Confirm the plan is consistent with governance before
editing. Avoid silent architectural changes (see
[`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md)).

## Summary after changes

At the end of a work session, provide a handover summary containing:

- **Files changed** — created, modified, or removed.
- **Decisions made** — including any assumptions and defaults chosen.
- **Tests performed** — commands run and their exact results, or a clear statement that a step
  could only be verified externally (e.g. TradingView compilation).
- **Unresolved risks** — open issues, untested conditions, and known limitations.
- **Recommended next action** — the single most useful next step.

## Related documents

- [`FIRST_SESSION_CHECKLIST.md`](FIRST_SESSION_CHECKLIST.md)
- [`../governance/AI_OPERATING_PRINCIPLES.md`](../governance/AI_OPERATING_PRINCIPLES.md)
- [`../WORKFLOW.md`](../WORKFLOW.md)
