# QuanTrading Lab — V2.5 Workspace

QuanTrading Lab is a quantitative research and TradingView Pine Script v6 development workspace.
It treats every strategy as a falsifiable research hypothesis under disciplined controls.
Backtest performance is not proof of future profitability.

Workspace version: see [`VERSION`](VERSION).

## Repository layout

- [`.cursor/rules/`](.cursor/rules/) — always-applied engineering, research-integrity, and
  security rules.
- [`.cursor/skills/`](.cursor/skills/) — specialist skills for research, Pine development,
  review, and release.
- [`docs/`](docs/) — workflow, implementation, ingestion, and governance documentation.
- [`templates/`](templates/), [`checklists/`](checklists/), [`prompts/`](prompts/) — reusable
  artifacts and gate checklists.
- [`pine/`](pine/) — Pine Script indicators and strategies.
- [`knowledge/`](knowledge/) — reusable knowledge base (taxonomies, Pine notes, research
  methods, lessons); see the Knowledge & Research department below.
- [`research/`](research/), [`experiments/`](experiments/), [`journals/`](journals/),
  [`reports/`](reports/), [`decisions/`](decisions/), [`releases/`](releases/),
  [`production/`](production/) — research lifecycle folders.
- [`scripts/`](scripts/) — non-destructive verification and helper scripts.

## Knowledge & Research department

The department is QuanTrading's institutional memory and the controlled entry point for research.
It separates **reusable knowledge** from **project-specific evidence**, and front-ends (does not
replace) the gated workflow and strategy lifecycle. It was adopted via
[ADR-002](decisions/ADR-002-establish-knowledge-and-research-department.md).

- Governing standards: [Research department](docs/research/RESEARCH_DEPARTMENT.md),
  [Knowledge management](docs/research/KNOWLEDGE_MANAGEMENT.md),
  [Research artifact model](docs/research/RESEARCH_ARTIFACT_MODEL.md),
  [Research review process](docs/research/RESEARCH_REVIEW_PROCESS.md).
- Reusable knowledge: [`knowledge/`](knowledge/README.md) — taxonomies, Pine notes, research
  methods, and promoted lessons.
- Research operations: [`research/`](research/README.md) — the
  [research registry](research/registry/RESEARCH_REGISTRY.md),
  [strategy registry](research/registry/STRATEGY_REGISTRY.md), lifecycle
  [templates](research/templates/), and [examples](research/examples/README.md).

Every research project receives a stable research ID (`QT-R-###`) and every candidate strategy a
strategy ID (`QT-S-###`). Falsifiable hypotheses, baseline comparison before promotion, retained
negative results, linked evidence, and promoted lessons are mandatory. No knowledge item is
claimed empirically validated without supplied evidence.

## Governance

Governance defines how this lab researches, engineers, reviews, and releases work. New sessions
should start with the onboarding docs and read the charter before broad changes.

**Start here**

- [Charter](docs/governance/QUANTRADING_CHARTER.md) — mission, scope (V2.5 vs V3), principles.
- [Cursor handover](docs/onboarding/CURSOR_HANDOVER.md) and
  [First-session checklist](docs/onboarding/FIRST_SESSION_CHECKLIST.md).
- [Project status](PROJECT_STATUS.md) and [Next actions](NEXT_ACTIONS.md).
- [Dizzy owner setup](tools/dizzy/OWNER_SETUP.md) — Discord bot/channel checklist (proposed;
  ADR-009; no token in Git).

**Governance**

- [AI operating principles](docs/governance/AI_OPERATING_PRINCIPLES.md)
- [Engineering standards](docs/governance/ENGINEERING_STANDARDS.md)
- [Research governance](docs/governance/RESEARCH_GOVERNANCE.md)
- [Strategy lifecycle](docs/governance/STRATEGY_LIFECYCLE.md)
- [Review and release](docs/governance/REVIEW_AND_RELEASE.md)
- [Decision governance (ADRs)](docs/governance/DECISION_GOVERNANCE.md)

**Architecture (future-facing plans, not installed infrastructure)**

- [Platform vision](docs/architecture/PLATFORM_VISION.md)
- [V2.5 → V3 roadmap](docs/architecture/V2_5_TO_V3_ROADMAP.md)
- [System boundaries](docs/architecture/SYSTEM_BOUNDARIES.md)

**Existing process docs**

- [Gated workflow](docs/WORKFLOW.md) · [Implementation guide](docs/IMPLEMENTATION.md) ·
  [Update ingestion](docs/UPDATE-INGESTION.md)

## Verification

Run non-destructive checks at the start of a session:

```bash
bash scripts/verify.sh .
bash scripts/doctor.sh
```

## Safety

No live execution or automated trading is enabled. Secrets must never be committed; keep them in
a non-committed `.env`. See [System boundaries](docs/architecture/SYSTEM_BOUNDARIES.md) and the
security rule in [`.cursor/rules/`](.cursor/rules/).
