# Backup and Remote Repository Strategy Review

- Date: 2026-07-20
- Scope: QuanTrading Lab V2.5 workspace (`VERSION` = `2.5.0`)
- Type: planning / architecture decision (non-destructive; no remote or backup configured)
- Decision record: [`../decisions/ADR-003-backup-and-remote-repository-strategy.md`](../decisions/ADR-003-backup-and-remote-repository-strategy.md)
- References (not rewritten): [`repository-health-audit-2026-07-19.md`](repository-health-audit-2026-07-19.md)
  (H1/G2), [`knowledge-research-department-buildout-2026-07-19.md`](knowledge-research-department-buildout-2026-07-19.md)

## 1. Current-state confirmation

| Item | Value |
|---|---|
| Branch | `main` |
| Working tree | clean |
| Latest commit | `07de88f2e290b883b0b1c448835b11a525d51121` — feat: establish knowledge and research department |
| Configured remotes | **none** (`git remote -v` empty) |
| Authoritative copy | Ubuntu server working copy only |
| Access requirement | proprietary research — **private by default** |
| Trigger | recent power outage exposed lack of off-machine resilience |

## 2. Git remote replication vs full backup (core distinction)

- A **Git remote** replicates the **committed history of tracked files**. It gives version history
  and an off-machine copy of that history.
- A **full backup** captures what a remote does not: **untracked and gitignored files** (including
  the non-committed `.env`), **external market/reference data**, **secrets stores**, **databases**,
  **logs**, and **service configuration**.
- Consequence: **a remote alone is not disaster recovery.** Anything uncommitted or intentionally
  gitignored is invisible to a remote. Full protection needs both.

## 3. Options compared

Ratings: ●●● strong · ●● moderate · ● weak · — none.

| Dimension | 1. Private GitHub | 2. Private GitLab | 3. Self-hosted Git | 4. Enc. local backup | 5. Enc. cloud/remote backup | 6. Hybrid (remote + backups) |
|---|---|---|---|---|---|---|
| Protects vs disk failure | ●● (tracked only) | ●● (tracked only) | ●● (tracked, if separate host) | ●●● (all files) | ●●● (all files) | ●●● |
| Protects vs accidental deletion | ●● (history of tracked) | ●● | ●● | ●● (point-in-time) | ●● (point-in-time) | ●●● |
| Recovery complexity | ●●● simple `clone` | ●●● simple `clone` | ●● (needs host up) | ●● (restore + decrypt) | ●● (fetch + decrypt) | ●● (two paths) |
| Operational maintenance | ●●● low | ●●● low | ● higher (patch/host) | ●● (schedule/media) | ●● (schedule/keys) | ● (two systems) |
| Privacy / IP risk | ●● third party | ●● third party | ●●● full control | ●●● local | ●● depends on provider | ●●● (self-host + enc.) |
| Credential requirements | SSH key/deploy key | SSH key/deploy key | SSH key + host access | disk access + enc. key | remote creds + enc. key | SSH + enc. key |
| Ongoing cost | free–low (private) | free–low (private) | hardware/time | media cost | recurring storage | media + storage |
| V3 suitability | ●● | ●● | ●●● (aligns with self-hosted platform) | ● | ●● | ●●● |
| Provides history / DR | history | history | history | DR | DR | **both** |

### Notes per option

1. **Private GitHub** — lowest friction, excellent version history and off-machine replication;
   IP sits with a third party (mitigate: private + SSH). Not a full backup.
2. **Private GitLab** — equivalent to GitHub for our needs; self-managed GitLab would shift it
   toward Option 3.
3. **Self-hosted Git remote (separate machine)** — best privacy/control and best V3 fit; requires
   a second always-available host and its upkeep; still tracked-files-only.
4. **Encrypted backup to separate local storage** — true DR for all files; no Git-style history;
   same-site risk if the media never leaves the building.
5. **Encrypted backup to cloud/remote storage** — offsite DR; recurring cost; credential and
   encryption-key custody required; no Git history.
6. **Hybrid** — remote for history + encrypted full backups for DR; the only option that delivers
   **both**; costs two mechanisms to maintain.

## 4. Recommended minimum viable plan (V2.5)

Adopt Option 6 in minimal form (details in the ADR):

1. One **private** Git remote over **SSH** for `main` (GitHub/GitLab for low maintenance, or
   self-hosted for maximum IP privacy / V3 alignment).
2. One **encrypted full-workspace backup** on a schedule to a **second physical location**
   (external disk and/or encrypted remote), including untracked/gitignored content.
3. A documented **recovery test** before relying on either, then quarterly.

Rationale: gives version history *and* disaster recovery, keeps research private, and uses
protected authentication with credentials/keys outside source control.

## 5. Recommended V3 plan (future)

Per [`../docs/architecture/PLATFORM_VISION.md`](../docs/architecture/PLATFORM_VISION.md) and the
roadmap:

- Self-hosted or private managed Git remote for **all** workspaces on the authoritative host.
- Encrypted, versioned, **offsite** backups covering workspaces, **databases**, **logs**, and
  **service configuration** — not just Git history.
- Per-service backup policies; infrastructure-as-code for reproducible recovery.
- Separation of platform / workspaces / services / data / logs / backups / archives.
- Each new service or destination requires its own review and ADR.

## 6. Credential, privacy, and integrity rules (apply to any option)

- All hosted repositories **private** by default.
- Authentication via **SSH keys** or an approved credential manager; **no** tokens/passwords in
  the repo.
- **Never** commit private keys, access tokens, recovery codes, or passwords. `.gitignore` already
  excludes `.env`, `.env.*`, `*.key`, `*.pem`
  ([`../.gitignore`](../.gitignore)); secrets stay in a non-committed `.env`
  ([`../docs/architecture/SYSTEM_BOUNDARIES.md`](../docs/architecture/SYSTEM_BOUNDARIES.md)).
- Backup **encryption keys/passphrases** live in an approved credential manager, never in the
  repository or backup filenames.

## 7. Recovery, retention, and verification expectations

- **Recovery testing:** restore-before-reliance, then quarterly; test both clone-from-remote and
  restore-from-backup into scratch locations; confirm with `scripts/verify.sh`. Define RPO/RTO at
  approval.
- **Retention (proposed):** GFS — e.g. 7 daily / 4 weekly / 6–12 monthly encrypted snapshots;
  always ≥1 verified offsite copy.
- **Verification:** each run produces an integrity check; a failed check is a failed backup and is
  alerted.

## 8. Exact proposed implementation steps (NOT executed — require approval)

> None of the following has been run. They are recorded for review only.

1. **Approve** in ADR-003: remote provider + visibility, backup destination(s), auth method,
   retention, RPO/RTO, and recovery-test cadence.
2. **Generate an SSH key** for the server identity and register the **public** key with the chosen
   provider (private key never leaves the server; never committed).
3. **Create the private remote** at the provider (or provision the self-hosted remote host).
4. `git remote add origin <ssh-url>` then `git push -u origin main` (first push only after
   approval).
5. **Choose a backup tool** (e.g. an encrypted snapshot tool) and configure an **encrypted**
   full-workspace backup to the second location; store its passphrase in the credential manager.
6. **Schedule** the backup (user-level scheduler; no `sudo`, no system-wide changes) and enable
   integrity verification.
7. **Run a recovery test**: clone the remote and restore the backup into scratch dirs; run
   `scripts/verify.sh`; record RPO/RTO actuals.
8. **Record results** and flip ADR-003 to `accepted`; update `PROJECT_STATUS.md`/`NEXT_ACTIONS.md`
   to reflect *implemented* status only after verification succeeds.

## 9. Decisions requiring human approval

- Remote provider (GitHub / GitLab / self-hosted) and confirmation of **private** visibility.
- Backup destination(s): separate local storage, encrypted cloud/remote, or both.
- Authentication method and credential-manager choice.
- Retention policy and RPO/RTO targets.
- Recovery-test cadence and owner.

## 10. What was not done

No remote configured, no push, no software installed, no `sudo`, no system configuration changed,
and no historical audit finding rewritten. Changes are documentation-only and left uncommitted for
human review.
