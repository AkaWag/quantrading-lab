# Repository Health & Capability Audit

- Date: 2026-07-19
- Scope: QuanTrading Lab V2.5 workspace (`VERSION` = `2.5.0`)
- Type: non-destructive (read-only inspection + read-only verification scripts)
- Related: [`../PROJECT_STATUS.md`](../PROJECT_STATUS.md), [`../NEXT_ACTIONS.md`](../NEXT_ACTIONS.md),
  [`../docs/architecture/V2_5_TO_V3_ROADMAP.md`](../docs/architecture/V2_5_TO_V3_ROADMAP.md)

## 1. Summary

The workspace is healthy and internally consistent. All verification passes, all scripts are
syntactically valid and executable, and governance documents cross-link cleanly. Two gaps are
relevant to the next roadmap phase: the workspace is **not under version control** and has **no
`.gitignore`**. No secrets are present in the tree.

## 2. Inventory

| Component | Count | Location | Status |
|---|---:|---|---|
| Rules (`.mdc`) | 11 | `.cursor/rules/` | OK (verify requires ≥ 7) |
| Skills (`SKILL.md`) | 28 | `.cursor/skills/` | OK (verify requires ≥ 20) |
| Templates | 7 | `templates/` | OK |
| Checklists | 6 | `checklists/` | OK |
| Prompts | 8 | `prompts/` | OK |
| Scripts | 5 | `scripts/` | OK |
| Pine files | 4 | `pine/` | Present (not reviewed in this audit) |
| Governance docs | 12 | `docs/{governance,architecture,onboarding}/` | OK |

## 3. Verification results (exact)

- `bash scripts/verify.sh .` → `Skills: 28`, `Rules: 11`, `Verification passed.`
- `bash scripts/doctor.sh` → OK: bash, git, unzip, sha256sum, cursor CLI; **MISS: zip**.
- Script syntax (`bash -n`): all 5 scripts **OK** (`doctor`, `install`, `new-strategy`,
  `package-release`, `verify`). All use `#!/usr/bin/env bash`; all have the executable bit set.
- Governance relative-link check: 190 links across 15 files, **0 broken**.

## 4. Capability review (scripts)

- `verify.sh` — structural verification (required rules/skills present, counts, script syntax).
- `doctor.sh` — reports host tooling availability.
- `install.sh` — copies rules/skills/folders into a project or global skills dir (`cp -a`).
- `new-strategy.sh` — scaffolds `research/strategies/<date>-<slug>/` from templates and seeds
  `strategy.pine` from `pine/strategies/institutional_strategy_v6.pine`.
- `package-release.sh` — packages a strategy dir as `releases/<name>-<version>.tar.gz` and writes
  a `.sha256`. **Uses `tar` + `sha256sum`, not `zip`.**

## 5. Findings

| # | Severity | Finding | Recommendation |
|---|---|---|---|
| F1 | Major | Workspace is **not a Git repository**; no history/rollback. | Adopt Git via ADR (roadmap Phase 2). See ADR-001. |
| F2 | Major | **No `.gitignore`**; risk of committing secrets/outputs later. | Add `.gitignore` (`.env`, `releases/*.tar.gz`, `*.sha256`, tmp) as part of Git adoption. |
| F3 | Minor | `zip` not installed. | No action required for releases (packaging uses `tar`). `doctor.sh`'s `zip` check is informational only. |
| F4 | Info | Pine sources (4) not reviewed in this governance audit. | Defer to a dedicated Pine/temporal review before any promotion. |
| F5 | Info | `new-strategy.sh` seeds from `institutional_strategy_v6.pine`. | Confirm that seed is the intended default template. |

## 6. Environment

- OS: Linux 6.8.0-136-generic (Ubuntu), shell bash.
- Tooling present: bash, git, unzip, sha256sum, cursor CLI. Absent: zip.
- No `.env` and no secrets detected in the tree.

## 7. Conclusion

Repository is in good health for Phase 1. The blocking item before broader work is version
control (F1/F2), which is proposed for approval in ADR-001. No strategy optimization or
deployment should begin yet, per governance.
