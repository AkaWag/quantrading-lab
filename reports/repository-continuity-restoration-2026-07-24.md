# Repository Continuity Restoration — 2026-07-24

- Status: integration verified; owner review and promotion approval pending
- Owner: Aka Wag
- Integration branch: `continuity/full-repository`
- Base: `main` at `c3cad29`

## Incident statement

Accepted governance and research work was preserved in Git but split across parallel feature
branches. `PROJECT_STATUS.md` and `NEXT_ACTIONS.md` on the gold-intake branch referenced files
that existed only on other branches. This created an incomplete checkout and a continuity defect;
it was not evidence of deleted or unrecoverable artifacts.

## Source branches

| Branch | Integrated scope |
|---|---|
| `pr/research-streams-foundation` | ADR-005, research streams, global session architecture |
| `pr/qt-r-001-london-breakout` | QT-R-001 artifact chain through the EV-001 gate |
| `pr/signum-ops-adr007` | ADR-006/007, Director model, threat model, Signum pilot |
| `pr/shotgun-companion` | Shotgun mandate, skill, and reference |
| `pr/gold-existing-intake-adr008` | ADR-008, gold intakes, current status and priorities |

The source branches remain intact locally and on `origin`. Their accepted changes were applied in
the dependency order above onto an isolated worktree. No source branch, `main`, or remote was
modified by assembling this integration state.

## Orchestration-bridge disposition

The uncommitted `services/orchestration-bridge/`, `integrations/`, bridge hooks, verification
script, and `.gitignore` additions remain preserved in the original working tree. They are
excluded from this integration baseline.

Rationale:

- ADR-007 supersedes ADR-006 as the operating path.
- ADR-007 explicitly permits the prototype to remain as historical R&D but prohibits resuming
  Custom GPT Action, Cloudflare, or HTTPS operations.
- Integrating active service and ingress scaffolding would blur the archived/active boundary and
  create an unsupported dependency and security surface.
- ADR-006, its architecture, and its threat model remain in this baseline as historical decision
  evidence and rollback context.

Future choices are limited to retaining the prototype on a clearly archival branch, packaging it
as explicitly non-operational historical source under a separately approved change, or removing
it through a reviewed rollback. None revives it as an ops path without a new ADR.

The preserved prototype is not archive-labelled consistently enough to merge as-is:

- its service README, OpenAPI contract, example configuration, and smoke script describe setup
  and operation without a sufficiently prominent ADR-007 archive warning;
- the ChatGPT and Cloudflare integration material conflicts with the decision not to pursue
  Action or tunnel stages;
- root Cursor hooks would affect active sessions and therefore do not belong in the active
  baseline; and
- the bridge-specific verification script and ignore rules are justified only beside an
  explicitly archived source package.

The audit also identified unresolved security limitations: no complete durable audit/retention
model, duplicate-side-effect risk during restart recovery, idempotency keys not bound to request
content, regex/environment-dependent hook enforcement, incomplete cancellation confirmation, and
no verified external authentication, replay protection, session isolation, credential lifecycle,
or incident-response evidence. These findings reinforce exclusion; they are not a remediation
backlog for the active ADR-007 operating path.

## Preventive control

`scripts/check-continuity.py` verifies:

- the presence of accepted continuity-critical artifacts; and
- repository-local Markdown links across the workspace.

`scripts/verify.sh` invokes this check so status documents cannot again reference absent accepted
artifacts without failing verification.

## Dizzy sequencing

Dizzy is specified only after the Director, Shotgun, Signum, stream, and intake artifacts exist
on the same baseline. ADR-009 and `docs/onboarding/DIZZY_AGENT.md` are proposals; they do not
authorize Discord access, automation, alerts, chart actions, or trade execution.

## Verification evidence

Executed from the isolated integration worktree on 2026-07-24:

- `bash scripts/verify.sh .` — **passed**: 29 skills, 12 rules, 12 required continuity artifacts,
  and 148 Markdown files checked.
- `bash scripts/doctor.sh` — completed: bash, Git, unzip, sha256sum, and Cursor CLI found; `zip`
  missing. This is a known non-blocker because release packaging uses `tar` and `sha256sum`.
- `PYTHONDONTWRITEBYTECODE=1 python3 -m py_compile scripts/check-continuity.py` — passed.
- `git diff --cached --check` and `git diff --check` — passed with no whitespace errors.
- Targeted likely-secret scan — no matching files. Lockfiles, historical threat/decision records,
  reports, and source-intake prose were excluded to avoid treating documented placeholder terms
  as credentials; no secret-bearing environment file was read.

TradingView compilation, backtesting, Discord API behavior, Signum operation, chart automation,
paper trading, and live execution were not tested and are not claimed.

## Promotion boundary

This integration remains uncommitted. Commit, merge to `main`, and push each require explicit
human approval after the complete diff and verification evidence are reviewed.
