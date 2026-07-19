# Gated workflow

| Gate | Required artifact | Primary skill | Pass condition |
|---|---|---|---|
| Intake | INTAKE.md | update-intake-analyst | Scope and sources classified |
| Hypothesis | HYPOTHESIS.md | hypothesis-designer | Falsifiable and failure conditions defined |
| Specification | SPEC.md | strategy-architect | Deterministic behavior and costs specified |
| Risk pre-review | RISK.md | risk-architect | Sizing, exits, and account constraints defined |
| Implementation | strategy.pine | pine-v6-engineer | Traceable to specification |
| Compile | COMPILE.md | pine-compiler-triage | TradingView success evidence recorded |
| Temporal audit | REPAINT-AUDIT.md | repaint-lookahead-auditor | No unresolved critical future leak |
| Backtest audit | BACKTEST-AUDIT.md | backtest-auditor | Assumptions and limitations complete |
| Robustness | ROBUSTNESS.md | robustness-analyst | Stability evidence meets declared threshold |
| Release | RELEASE.md | release-gatekeeper | All mandatory gates pass |

A failed gate returns the work to the earliest affected stage. Optimization never repairs an invalid hypothesis or biased backtest.
