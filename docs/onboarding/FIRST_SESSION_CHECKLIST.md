# First Session Checklist

Use this checklist at the start of a new session. It is non-destructive: it only reads state and
runs read-only verification. Pair it with [`CURSOR_HANDOVER.md`](CURSOR_HANDOVER.md).

## Checklist

- [ ] **Confirm repository root.** You are in the workspace root if
      [`../../VERSION`](../../VERSION) and [`../../README.md`](../../README.md) are present.
- [ ] **Confirm `.cursor` rules and skills are detected.** Verify
      [`../../.cursor/rules/`](../../.cursor/rules/) and
      [`../../.cursor/skills/`](../../.cursor/skills/) exist and are populated.
- [ ] **Confirm scripts are executable where applicable.** Check
      [`../../scripts/`](../../scripts/); scripts may be run with `bash <script>` if the
      executable bit is not set. Do not `chmod` system paths or use `sudo`.
- [ ] **Run non-destructive verification tools:**
      - `bash scripts/verify.sh .` — checks required rules, skills, and script syntax.
      - `bash scripts/doctor.sh` — reports available tooling (bash, git, zip/unzip, etc.).
      Record the exact output.
- [ ] **Check Git status if Git exists.** Run `git status`. If the workspace is not yet a Git
      repository, note that and see [`../architecture/V2_5_TO_V3_ROADMAP.md`](../architecture/V2_5_TO_V3_ROADMAP.md)
      Phase 2. Do not initialize Git without approval.
- [ ] **Review current state and priorities.** Read
      [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md) and
      [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md).
- [ ] **Do not create a trading strategy during a governance/onboarding session.** Strategy
      work follows the workflow in [`../WORKFLOW.md`](../WORKFLOW.md) and the lifecycle in
      [`../governance/STRATEGY_LIFECYCLE.md`](../governance/STRATEGY_LIFECYCLE.md).

## Related documents

- [`CURSOR_HANDOVER.md`](CURSOR_HANDOVER.md)
- [`../../PROJECT_STATUS.md`](../../PROJECT_STATUS.md)
- [`../../NEXT_ACTIONS.md`](../../NEXT_ACTIONS.md)
