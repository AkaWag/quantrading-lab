# AGENTS.md — QuanTrading Lab V2.5

Instructions for any AI agent working in this repository (Cursor IDE, the Cursor CLI `agent`,
and other CLI agents). This file is combined with the rules in
[`.cursor/rules/`](.cursor/rules/); those rules are authoritative and take precedence.

## What this repository is

QuanTrading Lab V2.5 — a quantitative research and TradingView Pine Script v6 development
workspace. Every strategy is treated as a falsifiable research hypothesis. Backtest performance
is never proof of future profitability.

## Read before broad changes

1. [`README.md`](README.md) and [`docs/onboarding/CURSOR_HANDOVER.md`](docs/onboarding/CURSOR_HANDOVER.md).
2. [`docs/governance/QUANTRADING_CHARTER.md`](docs/governance/QUANTRADING_CHARTER.md) and
   [`docs/governance/AI_OPERATING_PRINCIPLES.md`](docs/governance/AI_OPERATING_PRINCIPLES.md).
3. Applicable rules in [`.cursor/rules/`](.cursor/rules/) (always-applied, plus `*.pine` rules
   when editing Pine).
4. Current state: [`PROJECT_STATUS.md`](PROJECT_STATUS.md) and [`NEXT_ACTIONS.md`](NEXT_ACTIONS.md).
5. The relevant specialist skill under [`.cursor/skills/`](.cursor/skills/) for the task.

## How to work

- Follow the gated workflow in [`docs/WORKFLOW.md`](docs/WORKFLOW.md) and the lifecycle in
  [`docs/governance/STRATEGY_LIFECYCLE.md`](docs/governance/STRATEGY_LIFECYCLE.md).
- Declare assumptions (symbol, timeframe, session, costs, fills, sizing). Report uncertainty and
  missing evidence. Challenge weak or non-falsifiable hypotheses.
- Prefer the smallest specialist skill set; produce a plan before broad, multi-file changes.
- Record research artifacts per [`docs/research/RESEARCH_ARTIFACT_MODEL.md`](docs/research/RESEARCH_ARTIFACT_MODEL.md);
  keep failures (they are evidence). Promote knowledge only per
  [`docs/research/KNOWLEDGE_MANAGEMENT.md`](docs/research/KNOWLEDGE_MANAGEMENT.md).

## Must not

- Do not fabricate test results, backtests, sources, or TradingView compiler output. TradingView
  is external and its outputs must be supplied as evidence.
- Do not use `sudo`, modify system config, or install packages/services without human approval.
- Do not expose or commit secrets; secrets live in a non-committed `.env`.
- Do not begin optimization, production deployment, or any live/automated trading without the
  required approvals and evidence.
- Do not make architectural/governance changes silently — use an ADR
  ([`docs/governance/DECISION_GOVERNANCE.md`](docs/governance/DECISION_GOVERNANCE.md)).

## Verify

Run non-destructive checks and report exact results:

```bash
bash scripts/verify.sh .
bash scripts/doctor.sh
```

## Finish with a handover summary

Files changed · decisions made · tests performed (with exact results, or noting what could only
be verified externally) · unresolved risks · recommended next action.
