# Strategy Registry

Authoritative index of candidate strategies. Each candidate receives a stable **strategy ID**
(`QT-S-###`) and references the research ID that produced it. Lifecycle states follow
[`../../docs/governance/STRATEGY_LIFECYCLE.md`](../../docs/governance/STRATEGY_LIFECYCLE.md).

Governed by [`../../docs/research/RESEARCH_DEPARTMENT.md`](../../docs/research/RESEARCH_DEPARTMENT.md)
and [`../../docs/governance/REVIEW_AND_RELEASE.md`](../../docs/governance/REVIEW_AND_RELEASE.md).

## Conventions

- **Strategy ID:** `QT-S-###`, assigned sequentially; never reused.
- **Lifecycle state:** `IDEA`, `RESEARCH`, `PROTOTYPE`, `VERIFIED`, `VALIDATION`, `CANDIDATE`,
  `APPROVED`, `RETIRED` (see [`../../docs/governance/STRATEGY_LIFECYCLE.md`](../../docs/governance/STRATEGY_LIFECYCLE.md)).
- **Validation status:** short phrase (e.g. `no evidence`, `compiled`, `temporal-audited`,
  `backtested-IS`, `OOS`, `robustness`) — never claim beyond supplied evidence.
- **Release status:** `blocked` / `research` / `paper-test` / `approved`
  (see [`../../templates/release-record.md`](../../templates/release-record.md)). Default is
  `blocked`; live trading is never enabled from research.

## Register (columns are mandatory)

| Strategy ID | Title | Version | Lifecycle state | Related research ID | Pine file | Validation status | Known limitations | Release status |
|---|---|---|---|---|---|---|---|---|
| _none yet_ | | | | | | | | |

<!--
Row example (do not treat as a real strategy):
| QT-S-001 | <title> | 0.1.0 | PROTOTYPE | QT-R-001 | ../strategies/<folder>/strategy.pine | no evidence | untested | blocked |
-->

## Adding a strategy

1. A strategy is registered only when a research project reaches an implementation phase.
2. Claim the next `QT-S-###`, set version (semantic, see
   [`../../docs/governance/REVIEW_AND_RELEASE.md`](../../docs/governance/REVIEW_AND_RELEASE.md)),
   and link the Pine file and related research ID.
3. Update lifecycle/validation/release status only with linked evidence.
4. Retire rather than delete superseded strategies; record the reason.

## Related documents

- [`RESEARCH_REGISTRY.md`](RESEARCH_REGISTRY.md) · [`../../docs/governance/STRATEGY_LIFECYCLE.md`](../../docs/governance/STRATEGY_LIFECYCLE.md)
