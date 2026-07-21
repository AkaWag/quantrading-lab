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
- [x] Configure an off-machine Git **remote** — `origin` (private GitHub over SSH) is configured
      and `main` is pushed and up to date.
- [ ] **Procure the external backup drive (open requirement; not currently available).**
      Specification: 1 TB portable external SSD; USB 3.x or USB-C; a separate physical device;
      **ext4** if Ubuntu-only, **exFAT** only if cross-platform access is required.
- [ ] **After procurement**, complete off-machine resilience per
      [`decisions/ADR-003-backup-and-remote-repository-strategy.md`](decisions/ADR-003-backup-and-remote-repository-strategy.md)
      (review: [`reports/backup-and-remote-strategy-review-2026-07-20.md`](reports/backup-and-remote-strategy-review-2026-07-20.md)):
    - [ ] implement the **encrypted full-workspace backup** (covering untracked/gitignored content);
    - [ ] run **checksum / integrity verification** of the backup;
    - [ ] perform a **scratch restore test** into a throwaway location and confirm `scripts/verify.sh` passes;
    - [ ] write a **recovery report** recording date, result, RPO/RTO, and any gaps.
- [ ] **ADR-003 closure is blocked** until the restore test succeeds; a Git remote alone is not a
      full backup, and requires human approval of destination, encryption/auth, and retention.

## Priority 2b — Knowledge & Research department (done)

- [x] Establish the department structure and documentation (ADR-002 accepted): reusable
      [`knowledge/`](knowledge/README.md) base, [`research/`](research/README.md) registries/
      templates/examples, and governing standards under
      [`docs/research/`](docs/research/RESEARCH_DEPARTMENT.md).
- Note: this created the department only. The research chain is **not** exercised and validation
      capability is **not** demonstrated.

## Priority 2c — Ubuntu Operations Agent (done)

- [x] Install and authenticate the Cursor CLI (`agent` / `cursor-agent`) user-locally (no sudo).
- [x] Establish the permission-bounded Operations Agent (ADR-004 accepted): [`AGENTS.md`](AGENTS.md),
      [`.cursor/rules/ubuntu-operations.mdc`](.cursor/rules/ubuntu-operations.mdc), and
      [`.cursor/cli.json`](.cursor/cli.json).
- [x] Validate the `Shell(...)` permission matcher with an execute-capable test (safe read-only
      commands auto-run; secrets/sudo/`rm -rf`/`git push` denied).
- Note: re-run the execute-capable test after any `agent update`, since matcher semantics can
      change with the CLI version.

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
