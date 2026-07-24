# QT-R-002 — Signum external evidence-expansion handover

- Research ID: QT-R-002
- Stream: EXISTING_STRATEGY
- Owner: Aka Wag
- Director: research-director
- Date: 2026-07-24
- Status: **READY FOR SIGNUM HANDOVER — owner start required**
- Authority: ADR-007 external Signum lab; no port into this repository
- Scope: evidence expansion and independent reproduction only

> **Agent Live** means Codex + Claude/Hermes running in the external Signum lab.
> It does not mean live money, broker access, TradingView session control, or order routing.

## Current gate

| Item | Result |
|---|---|
| Frozen long-only control | EV-002 PASS: 39 trades, 101.31% net, 7.98% MaxDD, PF 3.532 |
| Existing short-only control | EV-004: 17 trades, −10.63% net, 13.95% MaxDD, PF 0.529 |
| Short loss diagnosis | 6 momentum failures; 5 trend-exit givebacks |
| Pre-registered family | Short-specific EMA(300) slope qualification |
| Locked grid | 0.03%, 0.05%, 0.07%, 0.10%, 0.15% |
| OOS gate | 2 short trades; minimum 10 |
| Current verdict | `INSUFFICIENT_EVIDENCE`; no parameter selected |

Signum must preserve this verdict. Compute capacity does not create independent observations.

## Signum role

### Codex — implementer / evidence engineer

- verify the supplied ledgers and calculations;
- inventory lawful, locally available XAUUSD 4H data and feed metadata;
- build deterministic, non-mutating diagnostic tooling where useful;
- reproduce the frozen short-entry and exit semantics against an identified data feed;
- prepare evidence-expansion options and exact reproducibility instructions.

### Claude/Hermes — referee

- challenge feed equivalence, timestamp alignment, fill assumptions, and lookahead risk;
- audit all work against `EXPERIMENT_PLAN.md`;
- reject OOS leakage, parameter search, pooled transfer evidence, and unsupported claims;
- record disagreements and missing evidence rather than forcing agreement.

### Research Director — authority of record

- owns scope, experiment locks, repository wording, and evidence acceptance;
- accepts, rejects, or returns Signum artifacts;
- authorizes any later parameter run only after the declared evidence gate is met.

### Owner

- authorizes Signum startup and clearing any deliberate STOP;
- approves material scope changes, Git commits/pushes, and any future deployment gate.

## Authoritative inputs

Workspace of record:

`~/quantrading/workspaces/continuity-integration/research/strategies/20260723-gold-4h-macd4c-signal-squatter/`

Read in order:

1. [`README.md`](README.md)
2. [`BASELINE.md`](BASELINE.md)
3. [`pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine`](pins/GOLD_4H_macd4c_signal_squatter_v2_0.pine)
4. [`EXPERIMENT_PLAN.md`](EXPERIMENT_PLAN.md)
5. [`PRE_OPTIMIZATION_AUDIT.md`](PRE_OPTIMIZATION_AUDIT.md)
6. [`evidence/EV-002-tv-baseline-reproduce.md`](evidence/EV-002-tv-baseline-reproduce.md)
7. [`evidence/EV-004-short-only-diagnostic.md`](evidence/EV-004-short-only-diagnostic.md)
8. [`evidence/EV-004-short-only-trades.csv`](evidence/EV-004-short-only-trades.csv)
9. [`evidence/EV-004-short-trade-classification.csv`](evidence/EV-004-short-trade-classification.csv)
10. [`evidence/EV-006-short-failure-classification.md`](evidence/EV-006-short-failure-classification.md)
11. [`evidence/EV-007-short-validation-gate.md`](evidence/EV-007-short-validation-gate.md)

Upstream Signum JSON/Python/Pine artifacts are comparison sources only. QuanTrading pins and
evidence remain authoritative for this handover.

## Mission

### M1 — ledger reproduction

Independently recompute from `EV-004-short-only-trades.csv`:

- trade and winner counts;
- net P&L, gross profit/loss, profit factor, and commission totals;
- IS / validation / OOS partitions;
- 0.2% and 0.3% commission stresses;
- failure-class counts using the documented 1.50% MFE diagnostic separator.

Do not overwrite EV-004–007. Record any mismatch.

### M2 — data and semantic feasibility

Inventory available XAUUSD 4H data sources without reading or exposing credentials:

- provider and exact symbol/feed;
- timezone and bar timestamp convention;
- available start/end dates and missing bars;
- price precision and tick-size metadata;
- spread/commission availability;
- whether the feed can reproduce TradingView OANDA semantics.

If an allowed feed exists, run a diagnostic reproduction of the frozen short-only logic. This is
not a candidate search. Record entry/exit timestamps, exact EMA slope at entry, exit predicate,
MAE/MFE method, and all differences from TradingView.

### M3 — evidence-expansion proposal

Prepare two clearly separated options:

1. **forward evidence collection** on frozen XAUUSD OANDA 4H logic;
2. **transfer study proposal** using adjacent feeds/symbols/timeframes.

Transfer evidence must remain separate and must not be pooled into QT-R-002 OOS. Do not execute a
transfer study without a Director-approved amendment.

## Required outputs

Add new files only:

1. `evidence/EV-008-signum-ledger-reproduction.md`
2. `evidence/EV-009-signum-data-feasibility.md`
3. `evidence/EV-010-signum-evidence-referee.md`
4. `SIGNUM_PROGRESS.md`

`SIGNUM_PROGRESS.md` may state `GOAL ACHIEVED` only when M1–M3 are filed and the referee records
PASS, FAIL, or BLOCKED for each. It must not state that a strategy edge or candidate was validated.

## Prohibited

- Do not execute or rank the slope grid.
- Do not change Pine, MACD periods, entries, exits, sizing, dates, costs, or fills.
- Do not assign `QT-S-###`.
- Do not move or inspect OOS for parameter selection.
- Do not pool transfer data with QT-R-002 OOS.
- Do not write Signum live Reflex state or enable live trading.
- Do not read `.env`, broker credentials, TradingView sessions, or API secrets.
- Do not overwrite existing QuanTrading evidence or governance files.
- Do not commit or push without explicit human approval.

## Hard stops

Stop and report `BLOCKED` when:

- no lawful local data source can reproduce the required feed;
- feed/timezone/fill semantics cannot be reconciled;
- the task would require credentials, a Pine adapter, or a scope amendment;
- a proposed action would expose or tune against the locked OOS;
- fewer observations remain than the experiment acceptance gate requires.

## BRIDGE_KICKOFF

```text
QuanTrading QT-R-002 Signum handover — evidence expansion only, lab agents, no live money.

Workspace of record:
  ~/quantrading/workspaces/continuity-integration/research/strategies/20260723-gold-4h-macd4c-signal-squatter/

Read first:
  PILOT_SIGNUM_EXTERNAL.md, README.md, BASELINE.md, EXPERIMENT_PLAN.md,
  PRE_OPTIMIZATION_AUDIT.md, the canonical Pine pin, and EV-002/004/006/007.

Current gate:
  EV-002 PASS. D0-S has 17 trades and negative expectancy. Locked OOS has only 2 trades.
  Verdict is INSUFFICIENT_EVIDENCE. Preserve it. Do not search the slope grid.

Mission:
  M1) Independently reproduce the EV-004 ledger, chronological partitions, cost stress, and
      failure counts.
  M2) Inventory lawful local XAUUSD 4H data/feed semantics and, only if suitable, reproduce the
      frozen short-only logic diagnostically to recover exact slopes and exit predicates.
  M3) Draft separate forward-evidence and transfer-study proposals. Do not execute or pool a
      transfer study without Director approval.
  M4) Add only evidence/EV-008-signum-ledger-reproduction.md,
      evidence/EV-009-signum-data-feasibility.md, evidence/EV-010-signum-evidence-referee.md,
      and SIGNUM_PROGRESS.md under the QT-R-002 folder.

Codex = evidence implementer. Claude/Hermes = adversarial referee.
No Pine mutation, parameter search, QT-S assignment, OOS tuning, credentials, live trading,
existing-file overwrite, commit, or push.
Set GOAL ACHIEVED only when M1-M3 outputs are filed with explicit PASS/FAIL/BLOCKED referee
verdicts. Otherwise stop with the exact blocker.
```

## Start command

Owner-authorized start from the external Signum tree:

```bash
cd ~/signum-ai-strategy
systemctl --user status signum-bridge-panel.service
BRIDGE_KICKOFF="$(sed -n '/^```text$/,/^```$/p' \
  ~/quantrading/workspaces/continuity-integration/research/strategies/20260723-gold-4h-macd4c-signal-squatter/PILOT_SIGNUM_EXTERNAL.md \
  | sed '1d;$d')" bash bridge/start.sh
```

Halt with `bash bridge/stop.sh` or `touch STOP`.

### Operational readiness check

Checked 2026-07-24:

- Control Centre panel: **active and enabled**.
- `codex` and `claude` commands: present in the owner shell.
- Existing bridge state: tmux session alive but daemon down with a stale PID.
- Prior daemon log records a historical `claude` command-resolution failure.

The owner-authorized `bridge/start.sh` performs a clean stop/start. After launch, confirm
`bash bridge/status.sh` reports both tmux and daemon healthy before accepting any output. Do not
run Codex solo for this handover; the independent referee is mandatory.

## Return path

1. Owner reviews the Control Centre, Signum bus, and `SIGNUM_PROGRESS.md`.
2. Director reviews EV-008/009 and the referee report.
3. Accepted files remain in the QT-R-002 tree; rejected work receives a dated failure record.
4. Commit and GitHub push require separate human approval.
