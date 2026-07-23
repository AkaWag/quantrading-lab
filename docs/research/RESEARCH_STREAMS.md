# Research Streams

This governing standard defines how QuanTrading coordinates research across **streams**. It
supports [`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md) and was adopted via
[`../../decisions/ADR-005-establish-research-streams.md`](../../decisions/ADR-005-establish-research-streams.md).

**New-strategy and existing-strategy development are not the same process.** Mixing them
silently (e.g. “improving” an existing script without a frozen baseline) is a research-integrity
failure.

## Identifiers (unchanged)

- **Research ID:** `QT-R-###` — one sequential series for all streams.
- **Strategy ID:** `QT-S-###` — assigned only when an implementation candidate exists.
- A **strategy ID is stable across revisions**; versions use **semantic versioning**
  (`MAJOR.MINOR.PATCH`). Do **not** create a new strategy ID for each revision.

## Streams

| Stream code | Name | Purpose | Typical path |
|---|---|---|---|
| `NEW_STRATEGY` | New strategy | New market hypothesis or strategy concept | Observation → question → hypothesis → specification → prototype → validation |
| `EXISTING_STRATEGY` | Existing strategy | Existing Pine strategy, indicator, manual method, or prior QuanTrading strategy | Preserve baseline → reproduce → diagnose → controlled change → compare to frozen baseline |
| `BLACK_BOX_STRATEGY` | Black-box strategy | Locked or source-unavailable TradingView strategy | Capture inputs/screenshots/exports → observable baseline → approximation → compare → declare uncertainty |
| `VALIDATION` | Validation | Independent verification of spec, code behaviour, repaint, execution, backtests, robustness, claimed improvements | Review/audit chain; prefer independence from the implementation decision |

Every research-registry row **must** declare a `Stream`.

## NEW_STRATEGY

- Starts from observation / research question; no implementation before a falsifiable hypothesis
  and reviewed specification options (or accepted specification).
- Acquires a strategy ID only at implementation candidacy.
- Must not skip to optimization or claim validation without linked evidence.

## EXISTING_STRATEGY (mandatory controls)

Before any controlled change, record:

- preserved **original version** (file/commit/export)
- **frozen baseline** (behaviour + metrics under declared assumptions)
- original **parameters**
- **market and timeframe**
- **execution assumptions** (costs, fills, session)
- **existing evidence** (linked)
- **known limitations**

Then:

- change **one thing at a time**
- compare each change to the frozen baseline
- run a **regression review** before accepting the revision

Do not treat an existing strategy as a blank new hypothesis.

## BLACK_BOX_STRATEGY (mandatory controls)

- Capture **observable inputs**, **screenshots**, and **exported results**
- Establish an **observable baseline** (what can be seen without source)
- Build an **approximation** only with uncertainty declared
- **Prohibit** claiming exact replication without evidence
- Document gaps (hidden logic, unknown fills, unavailable internals)

## VALIDATION

- Prefer reviewers **independent** of the implementation decision where practical
- Scope: specification fidelity, code behaviour, repainting/lookahead, execution assumptions,
  backtest integrity, robustness, and claimed improvements
- Validation does not invent performance; it checks evidence already supplied

## Work-in-progress guideline (starting limit)

As a starting governance limit (not an immutable technical limit), prefer at most:

- **one** active `NEW_STRATEGY` project
- **one** active `EXISTING_STRATEGY` project
- **one** active `VALIDATION` assignment

`BLACK_BOX_STRATEGY` work counts toward capacity similarly; park excess projects rather than
running many in parallel without owners.

## Related documents

- [`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md) · [`RESEARCH_ARTIFACT_MODEL.md`](RESEARCH_ARTIFACT_MODEL.md)
- [`GLOBAL_SESSION_ARCHITECTURE.md`](../../knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md)
- [`../governance/STRATEGY_LIFECYCLE.md`](../governance/STRATEGY_LIFECYCLE.md)
- [`../../research/registry/RESEARCH_REGISTRY.md`](../../research/registry/RESEARCH_REGISTRY.md)
