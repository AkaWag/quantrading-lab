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

## Priority 2 — Establish Git / version-control status (done)

- [x] Confirm whether the workspace is under version control.
- [x] Initialize Git with a `.gitignore` covering secrets (`.env`) and generated outputs
      (ADR-001 accepted; branch `main`; initial commit `5394f7a`).
- [ ] Optional / deferred: configure a backup remote — requires a separate ADR
      (credentials / external trust boundary).

## Priority 2b — Knowledge & Research department (done)

- [x] Establish the department structure and documentation (ADR-002 accepted): reusable
      [`knowledge/`](knowledge/README.md) base, [`research/`](research/README.md) registries/
      templates/examples, and governing standards under
      [`docs/research/`](docs/research/RESEARCH_DEPARTMENT.md).
- Note: this created the department only. The research chain is **not** exercised and validation
      capability is **not** demonstrated.

## Priority 3 — Run one controlled research project (recommended next task)

- [ ] Register the project in
      [`research/registry/RESEARCH_REGISTRY.md`](research/registry/RESEARCH_REGISTRY.md) to obtain
      a research ID (`QT-R-###`).
- [ ] Exercise observation → research question → hypothesis → specification using the templates in
      [`research/templates/`](research/templates/), consistent with the artifact model in
      [`docs/research/RESEARCH_ARTIFACT_MODEL.md`](docs/research/RESEARCH_ARTIFACT_MODEL.md).
- [ ] Do **not** implement Pine, backtest, or optimize in this project; stop at a falsifiable
      specification with explicit invalidation criteria.
- [ ] Record status per
      [`docs/governance/STRATEGY_LIFECYCLE.md`](docs/governance/STRATEGY_LIFECYCLE.md) and the
      department lifecycle in
      [`docs/research/RESEARCH_DEPARTMENT.md`](docs/research/RESEARCH_DEPARTMENT.md).

## Not yet

- [ ] Do not begin optimization.
- [ ] Do not deploy to production or enable live/automated trading.
- [ ] Do not create `/srv/quantrading`, service accounts, or V3 services (roadmap Phases 3+).
