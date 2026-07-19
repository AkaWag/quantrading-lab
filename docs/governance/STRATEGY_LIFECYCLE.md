# Strategy Lifecycle

This document defines the status model for strategies in QuanTrading Lab and the criteria for
moving between statuses. It aligns with the gated workflow in [`../WORKFLOW.md`](../WORKFLOW.md)
and the evidence tiers in [`QUANTRADING_CHARTER.md`](QUANTRADING_CHARTER.md). A status describes
demonstrated maturity and control, not expected profitability.

## Statuses

```text
IDEA → RESEARCH → PROTOTYPE → VERIFIED → VALIDATION → CANDIDATE → APPROVED → RETIRED
```

## Required metadata (all statuses)

Every strategy record must carry:

- **Strategy ID** (stable, unique) and **owner**;
- **version** (semantic, see [`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md));
- **hypothesis** reference;
- **change log**;
- **test record** (see [`../../templates/test-plan.md`](../../templates/test-plan.md));
- **known limitations** and untested conditions.

## Entry and exit criteria

### IDEA
- **Entry:** a trading concept has been captured.
- **Exit:** a candidate hypothesis and target market/timeframe are stated.

### RESEARCH
- **Entry:** market-behavior framing and initial evidence gathering begin.
- **Exit:** a falsifiable hypothesis with failure conditions is recorded
  ([`../../templates/hypothesis.md`](../../templates/hypothesis.md)).

### PROTOTYPE
- **Entry:** a specification and risk pre-review exist; implementation begins.
- **Exit:** Pine implementation is traceable to the specification and compiles on TradingView
  (compiler evidence recorded).

### VERIFIED
- **Entry:** code compiles; temporal-integrity audit is performed.
- **Exit:** no unresolved critical repaint/lookahead finding; behavior matches the spec on
  confirmed bars.

### VALIDATION
- **Entry:** backtest and robustness testing are conducted with documented assumptions.
- **Exit:** backtest assumptions/limitations complete, in-sample vs out-of-sample separation
  honored, baseline comparison done, and sensitivity evidence meets the declared threshold.

### CANDIDATE
- **Entry:** an evidence package (see [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md)) is
  assembled and submitted for review.
- **Exit:** required reviews pass with no unresolved critical findings; a release decision is
  requested.

### APPROVED
- **Entry:** all mandatory gates pass and a human records a governance approval
  ([`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md)).
- **Note:** APPROVED is a governance state. It is not a profitability guarantee and does not by
  itself authorize live capital or order routing.
- **Exit:** superseded by a new version, or retired.

### RETIRED
- **Entry:** the strategy is deprecated, superseded, or failed in forward use.
- **Record:** reason for retirement and lessons learned; artifacts are preserved, not deleted.

## Returning to an earlier stage

A strategy must return to an earlier stage when any of the following occur:

- a critical repaint, lookahead, or execution-realism defect is found (→ PROTOTYPE/VERIFIED);
- the hypothesis is contradicted by out-of-sample or forward evidence (→ RESEARCH);
- results prove unstable under sensitivity testing (→ VALIDATION);
- assumptions (symbol, costs, session, fill model) change materially (→ VALIDATION);
- a review raises an unresolved critical finding (→ the earliest affected stage).

## Related documents

- [`QUANTRADING_CHARTER.md`](QUANTRADING_CHARTER.md)
- [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md)
- [`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md)
- [`../WORKFLOW.md`](../WORKFLOW.md)
