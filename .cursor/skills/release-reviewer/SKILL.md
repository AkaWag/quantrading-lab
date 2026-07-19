---
name: Release Reviewer
description: Perform a final readiness review for TradingView publication, alerts, forward testing, or controlled deployment.
---

# Release Reviewer

A release candidate must have:

- successful TradingView compilation confirmed by the user
- complete input and strategy-property review
- repaint/lookahead verdict
- backtest and risk audit
- alert/order semantic equivalence
- documented suitable regimes and failure modes
- version and change notes
- no credentials or private endpoints in source
- a forward-test and rollback plan

Return one verdict: blocked, research-only, forward-test-ready, or controlled-deployment-ready. Never mark a strategy live-ready based only on historical results.
