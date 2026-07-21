# ADR-004: Establish the Ubuntu Operations Agent

- Status: accepted
- Date: 2026-07-21
- Owners: Aka Wag

Accepted and executed in the same session. This ADR records the adoption of a local,
permission-bounded Cursor CLI "Operations Agent" for the V2.5 workspace. It configures local
tooling and repository files only; it does **not** change global machine configuration, add
remotes, or enable any live/automated trading.

## Context

- The workspace is under Git (ADR-001) with a Knowledge & Research department (ADR-002) and a
  proposed backup/remote strategy (ADR-003).
- Work increasingly benefits from a command-line agent that can perform routine, read-mostly
  operations in the repository (status checks, verification) under explicit, reviewable limits.
- The Cursor CLI (`agent` / `cursor-agent`) was installed **user-locally** (`~/.local/bin`, no
  `sudo`) and authenticated; a read-only smoke test confirmed it loads workspace context.
- Without an explicit permission boundary and onboarding file, an autonomous CLI agent could run
  unsafe commands or miss governance. This ADR sets those boundaries.

## Decision

Adopt a **local Cursor CLI Operations Agent** for this workspace, defined by three project files:

1. **`AGENTS.md`** — the operational onboarding file read by the Cursor CLI (and other CLI
   agents). It points to the charter, governance, rules, current status, gated workflow, and the
   research department, and defers to [`../.cursor/rules/`](../.cursor/rules/) as authoritative.
2. **`.cursor/rules/ubuntu-operations.mdc`** — an **always-applied** rule (`alwaysApply: true`)
   codifying operational execution discipline on the Ubuntu host. It complements, and does not
   duplicate, `30-security-and-operations.mdc` and `60-repository-hygiene.mdc`.
3. **`.cursor/cli.json`** — the **project permission boundary** for the CLI. Project-level
   `cli.json` supports only a `permissions` object (`allow`/`deny`; deny wins). Model, editor, and
   sandbox settings are intentionally **not** placed here (they are global-only).

### Safe automatic operations (allow)

Permitted to run without prompting:

- Reading any repository file: `Read(**)`.
- Read-only Git inspection: `Shell(git status)`, `Shell(git diff)`, `Shell(git log)`.
- Non-destructive verification: `Shell(bash scripts/verify.sh)`, `Shell(bash scripts/doctor.sh)`.
- Writing only within research/output areas: `Write(research/**)`, `Write(experiments/**)`,
  `Write(journals/**)`, `Write(reports/**)`, `Write(knowledge/**)`.

The `Shell(...)` matcher was validated in an execute-capable headless test (see Verification):
`git status` and `bash scripts/verify.sh .` auto-ran without prompting or failure.

### Mandatory approval gates (deny / human-in-the-loop)

Denied outright in `cli.json` (deny overrides allow):

- Secrets: `Read(.env)`, `Read(.env.*)`, `Read(**/*.key)`, `Read(**/*.pem)`, `Write(.env)`,
  `Write(.env.*)`.
- Privilege / destruction / publication: `Shell(sudo)`, `Shell(rm -rf)`, `Shell(git push)`.

Additionally, per [`../docs/governance/AI_OPERATING_PRINCIPLES.md`](../docs/governance/AI_OPERATING_PRINCIPLES.md)
and [`../docs/governance/DECISION_GOVERNANCE.md`](../docs/governance/DECISION_GOVERNANCE.md), the
following require explicit human approval and must not be auto-run:

- architectural/governance changes (record via ADR);
- production releases or lifecycle promotion to APPROVED;
- credential/secret use, external execution, or network side effects;
- configuring Git remotes or pushing (remotes are gated by ADR-003);
- any live-trading or order-routing integration.

Operators should **not** use `--yolo` / `-f` (force-allow) for routine work, as it bypasses this
boundary; prefer default headless behavior or `--mode ask`/`--plan` for read-only tasks.

## Alternatives considered

- **No permission boundary (rely on defaults).** Rejected: unclear, easy to over-permit,
  no traceable governance.
- **Use `--yolo`/`-f` for convenience.** Rejected: force-allow bypasses the deny boundary and the
  approval gates.
- **Put agent settings in project `cli.json`.** Not possible: project `cli.json` honors only
  `permissions`; model/editor/sandbox are global-only and were deliberately left untouched.
- **Global-only configuration.** Rejected: a project boundary is version-controlled, reviewable,
  and travels with the workspace.

## Consequences

- Positive: routine read-only and research-area operations are fast and auditable; unsafe actions
  are denied or gated; onboarding is explicit and version-controlled.
- Positive: the boundary is a committed artifact, so changes are diffable and ADR-traceable.
- Negative/cost: the allow/deny list needs maintenance as workflows evolve; `Shell(...)` matcher
  granularity depends on the installed CLI version and should be re-checked after CLI updates.

## Risks

- **Over-broad writes** → mitigated: writes limited to research/output folders; source, `docs/`,
  `.cursor/`, and Pine are not in the write-allow set (edits there require explicit action).
- **Secret exposure via the agent** → mitigated: explicit secret denies plus `.gitignore`.
- **CLI update changes matcher semantics** → mitigated: re-run the execute-capable test after
  `agent update`; deny list and read-only defaults remain protective.
- **Force-mode misuse** → mitigated: documented prohibition of `--yolo`/`-f` for routine work.

## Verification

- CLI installed user-locally; `agent --version` and `cursor-agent --version` →
  `2026.07.17-3e2a980`. Authenticated (`cursor-agent status`: logged in).
- Read-only context load (`agent -p --mode ask --trust`): correctly listed the 10
  `alwaysApply: true` rules, including `ubuntu-operations.mdc`.
- Execute-capable test (`agent -p --trust`, no `--force`): `git status` and
  `bash scripts/verify.sh .` auto-ran; output correct; no prompt, no failure, no edits.
- `scripts/verify.sh` passes (Skills 28, Rules 12); `.cursor/cli.json` is valid JSON.

## Rollback plan

Fully reversible; no system or global changes were made.

- **Disable the boundary/agent files:** remove `.cursor/cli.json`, `AGENTS.md`, and
  `.cursor/rules/ubuntu-operations.mdc` (or `git revert` the establishing commit). The workspace
  returns to its prior state; no other files depend on them.
- **Uninstall the CLI (optional):** remove the symlinks `~/.local/bin/agent` and
  `~/.local/bin/cursor-agent` and the directory `~/.local/share/cursor-agent/`. Logout first with
  `cursor-agent logout` to clear stored auth. The `.bashrc` PATH line is shared with other tools
  and should be left in place.
- Record any withdrawal as a superseding ADR; do not delete this record.
