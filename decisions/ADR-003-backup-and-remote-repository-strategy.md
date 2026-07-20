# ADR-003: Backup and remote repository strategy

- Status: proposed
- Date: 2026-07-20
- Owners: Aka Wag

This ADR **proposes** a strategy and requires human approval before any part is executed.
Selecting a remote or backup destination introduces credentials and an external trust boundary,
which ADR-001 explicitly deferred to a separate ADR
([`ADR-001-adopt-git-and-backup.md`](ADR-001-adopt-git-and-backup.md)) and which
[`../docs/governance/AI_OPERATING_PRINCIPLES.md`](../docs/governance/AI_OPERATING_PRINCIPLES.md)
gates behind explicit approval. Nothing here is configured yet.

## Context

- Current state (confirmed 2026-07-20): branch `main`, working tree clean, latest commit
  `07de88f2e290b883b0b1c448835b11a525d51121` ("feat: establish knowledge and research
  department"), **no Git remote configured** (`git remote -v` empty).
- The authoritative working copy resides only on the Ubuntu server; a recent power outage
  highlighted the lack of off-machine resilience.
- QuanTrading holds proprietary research and must default to **private** access
  ([`../docs/architecture/SYSTEM_BOUNDARIES.md`](../docs/architecture/SYSTEM_BOUNDARIES.md)).
- Prior audits flagged this: no off-machine backup and no remote (H1/G2 in
  [`../reports/repository-health-audit-2026-07-19.md`](../reports/repository-health-audit-2026-07-19.md)
  and the buildout follow-up
  [`../reports/knowledge-research-department-buildout-2026-07-19.md`](../reports/knowledge-research-department-buildout-2026-07-19.md)).
  This ADR references those findings and records a decision separately; it does not rewrite them.
- Roadmap Phase 2 calls for backup discipline
  ([`../docs/architecture/V2_5_TO_V3_ROADMAP.md`](../docs/architecture/V2_5_TO_V3_ROADMAP.md)).

Full option analysis is in the planning report
[`../reports/backup-and-remote-strategy-review-2026-07-20.md`](../reports/backup-and-remote-strategy-review-2026-07-20.md).

## Git remote replication is not a full backup

- A **Git remote** replicates the *committed history of tracked files*. It provides version
  history and off-machine replication of that history.
- A **full backup** captures everything a Git remote does **not**: untracked and gitignored files
  (including the non-committed `.env`), external market/reference data, secrets stores, databases,
  logs, and service configuration.
- Therefore a remote alone does **not** protect the whole workspace. Disaster recovery requires a
  full backup in addition to (not instead of) a remote.

## Decision (proposed)

Adopt a **hybrid** approach (Option 6) for V2.5, provider-agnostic and private by default:

1. **Private Git remote over SSH** — off-machine replication of committed history. Default
   visibility **private**. Authentication via **SSH keys** (or an approved credential manager);
   no tokens/passwords in the repository.
2. **Scheduled encrypted full-workspace backup** — encrypted archive of the entire workspace
   (including untracked files and, where present, the secrets store and any external data/logs/
   service config) to **separate storage** distinct from the server disk. Encryption keys/
   passphrases live in an approved credential manager, never in the repository.

Provider choice (private GitHub, private GitLab, or self-hosted remote) and backup destination
(separate local storage and/or encrypted cloud/remote storage) are **left for human selection**
at approval time; see the report's comparison and the recommendation below.

### Recommended minimum viable plan (V2.5)

- One **private** Git remote via SSH for `main` (choose GitHub/GitLab for lowest maintenance, or
  self-hosted for maximum IP privacy and V3 alignment).
- One **encrypted** full-workspace backup on a schedule to a **second physical location**
  (external disk and/or encrypted remote), covering untracked/gitignored content.
- Documented **recovery test** before relying on either mechanism.

### Recommended V3 backup architecture (future, each step its own ADR)

Per [`../docs/architecture/PLATFORM_VISION.md`](../docs/architecture/PLATFORM_VISION.md), the
server becomes the authoritative host with separated platform / workspaces / services / data /
logs / backups / archives. V3 should add: a self-hosted or private managed Git remote for all
workspaces; encrypted, versioned, offsite backups of workspaces, databases, and service config;
per-service backup policies; and infrastructure-as-code for reproducible recovery. No V3 service
exists today and each requires its own review and ADR.

## Alternatives considered

Summarized here; full matrix in the report.

- **Private GitHub / Private GitLab (Options 1–2).** Low maintenance, strong version history,
  off-machine replication. IP resides with a third party (mitigated by private access + SSH). Not
  a full backup by themselves.
- **Self-hosted Git remote (Option 3).** Maximum privacy/control, best V3 fit; higher maintenance
  and still not a full backup.
- **Encrypted backup to separate local storage (Option 4).** True disaster recovery for all
  files; no version history of the Git kind; vulnerable if co-located (same-site risks).
- **Encrypted backup to cloud/remote storage (Option 5).** Offsite disaster recovery; ongoing
  cost and credential/key management; no Git version history.
- **Hybrid (Option 6).** Chosen: combines version history + full disaster recovery. Higher setup
  effort; two mechanisms to maintain.
- **Status quo (no remote/backup).** Rejected: single point of failure; contradicts the charter's
  reproducibility and controlled-change principles and the outage lesson.

## Consequences

- Positive: version history off-machine, plus true disaster recovery covering non-Git content.
- Positive: private-by-default and SSH-key auth reduce IP and credential exposure.
- Negative/cost: two mechanisms to operate; credential/key custody; possible recurring storage
  cost; periodic recovery tests require discipline.

## Risks

- **Credential/key leakage** → mitigated: keys/passphrases in an approved credential manager,
  never in the repo; `.gitignore` already excludes `.env`, `*.key`, `*.pem`.
- **Third-party IP exposure** (hosted options) → mitigated: private visibility, SSH keys, and the
  option to self-host.
- **Silent backup failure** → mitigated: backup-verification and scheduled recovery tests below.
- **Co-located backup destroyed with the server** → mitigated: require a second physical location
  / offsite copy.

## Recovery testing expectations

- Perform a **restore test before** relying on the mechanism, and at least **quarterly**
  thereafter.
- Test both paths: clone from the remote into a scratch location, and restore the encrypted
  backup into a scratch location; confirm the workspace verifies (`scripts/verify.sh`).
- Record each test's date, result, and any gaps. Define target **RPO** (max acceptable data loss)
  and **RTO** (max acceptable recovery time) at approval.

## Retention and backup-verification expectations

- **Retention (proposed, to confirm):** grandfather-father-son, e.g. 7 daily, 4 weekly, 6–12
  monthly encrypted snapshots; never fewer than one verified offsite copy.
- **Verification:** every backup run produces an integrity check (e.g. checksums/repository
  integrity verify); a failed verification is treated as a failed backup and alerted.
- **Encryption:** at rest for all backup copies; keys rotated per the credential manager policy.

## Rollback plan

Documentation-only until approved, so this ADR is reversible by reverting the doc edits. If, after
approval, a remote or backup is later withdrawn:

- **Remove a remote:** `git remote remove <name>` (local history is unaffected). Revoke the
  associated deploy key / credential at the provider.
- **Retire a backup destination:** stop the schedule, securely destroy encrypted copies per
  retention policy, and revoke destination credentials/keys.
- Record the withdrawal as a superseding ADR; do not delete this record.

## Approval required (not yet granted)

This ADR remains `proposed`. Executing any step requires explicit human approval of: the remote
provider and visibility, the backup destination(s), the authentication method, retention, and the
recovery-test schedule. Until then, no remote, credential, or backup is configured.
