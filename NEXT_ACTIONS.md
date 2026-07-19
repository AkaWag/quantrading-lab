# Next Actions

Prioritized, non-destructive checklist for what to do after governance onboarding. Current
state is in [`PROJECT_STATUS.md`](PROJECT_STATUS.md); phases are in
[`docs/architecture/V2_5_TO_V3_ROADMAP.md`](docs/architecture/V2_5_TO_V3_ROADMAP.md).

Do **not** begin parameter optimization, production deployment, or live trading yet.

## Priority 1 — Repository health and capability audit (immediate next action)

- [ ] Run [`scripts/verify.sh`](scripts/verify.sh) and [`scripts/doctor.sh`](scripts/doctor.sh);
      record exact output.
- [ ] Inventory rules, skills, templates, checklists, prompts, and scripts; confirm each is
      understood and functional.
- [ ] Confirm the governance docs are internally consistent and correctly cross-linked.
- [ ] Note gaps or missing tooling (for example the missing `zip`).

## Priority 2 — Establish Git / version-control status

- [ ] Confirm whether the workspace is under version control (currently it is not).
- [ ] Propose initializing Git with a `.gitignore` covering secrets (`.env`) and generated
      outputs, and a backup routine (roadmap Phase 2). Record the decision via an ADR
      ([`docs/governance/DECISION_GOVERNANCE.md`](docs/governance/DECISION_GOVERNANCE.md)).

## Priority 3 — Create a first controlled research project

- [ ] Start one research project through the gated workflow in
      [`docs/WORKFLOW.md`](docs/WORKFLOW.md): intake → hypothesis → specification.
- [ ] Use the templates in [`templates/`](templates/) and record status per
      [`docs/governance/STRATEGY_LIFECYCLE.md`](docs/governance/STRATEGY_LIFECYCLE.md).

## Not yet

- [ ] Do not begin optimization.
- [ ] Do not deploy to production or enable live/automated trading.
- [ ] Do not create `/srv/quantrading`, service accounts, or V3 services (roadmap Phases 3+).
