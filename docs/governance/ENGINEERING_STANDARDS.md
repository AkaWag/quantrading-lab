# Engineering Standards

These standards govern how code, primarily TradingView Pine Script, is written in QuanTrading
Lab. They summarize and cross-reference the enforced rules in
[`.cursor/rules/`](../../.cursor/rules/): `10-pine-v6-standards.mdc`,
`10-pine-v6-engineering.mdc`, `20-non-repainting.mdc`, and `30-backtest-integrity.mdc`.
Those rule files take precedence where more specific.

## Language and version

- **Pine Script v6 by default.** Begin scripts with `//@version=6`. Use another version only
  when the user explicitly requires it, and document why.
- Use `indicator()`, `strategy()`, or `library()` correctly and exactly once per script.

## Temporal integrity

- **No repainting or lookahead** unless explicitly documented and justified for research.
  When accepted for research, classify the repaint source and record the reason.
- Prefer confirmed-bar decisions for historical/live consistency.
- **Confirm higher-timeframe data correctly.** Treat HTF and lower-timeframe requests as a
  special review area; review timing, gaps, and lookahead. Do not use `barmerge.lookahead_on`
  unless the requested series is correctly offset and the reason is documented. See
  [`../../.cursor/rules/20-non-repainting.mdc`](../../.cursor/rules/20-non-repainting.mdc).

## Backtest realism (strategies)

- Model **commission, slippage, position sizing, and execution assumptions** explicitly. Make
  initial capital, currency, pyramiding, and quantity behavior explicit.
- State the fill model and note `calc_on_every_tick`, `calc_on_order_fills`, and bar-magnifier
  implications when used. See [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md) and
  [`../../checklists/backtest-audit.md`](../../checklists/backtest-audit.md).

## Structure and readability

- Prefer **readable, modular code** over unnecessary complexity.
- **Separate sections**: signal generation, filters, risk, orders/exits, visualization,
  alerts, and diagnostics.
- Use **meaningful camelCase names** and small pure helper functions where practical.
- Use **bounded inputs** with clear titles, tooltips, and sensible defaults.
- Add **comments for non-obvious logic** and execution assumptions, not for obvious syntax.
- Include a **version header** identifying the strategy/indicator, version, and intent.

## Change discipline

- **Preserve backward compatibility** where reasonable; list any intentional semantic changes.
- Preserve user code unless a change is necessary, and explain material behavioral changes.
- Alert conditions must align with actual logic and state whether they trigger intrabar or at
  bar close. See [`../../checklists/alert-deployment.md`](../../checklists/alert-deployment.md).

## Verification before completion

- **Do not claim completion without verification.** TradingView is the compilation authority;
  paste exact compiler messages (with line numbers) rather than assuming success.
- Run available non-destructive checks (for example
  [`../../scripts/verify.sh`](../../scripts/verify.sh)) and report exact results.
- State clearly what was verified, what was not, and what a human must confirm.

## Related documents

- [`QUANTRADING_CHARTER.md`](QUANTRADING_CHARTER.md)
- [`RESEARCH_GOVERNANCE.md`](RESEARCH_GOVERNANCE.md)
- [`REVIEW_AND_RELEASE.md`](REVIEW_AND_RELEASE.md)
- [`../IMPLEMENTATION.md`](../IMPLEMENTATION.md)
- [`../WORKFLOW.md`](../WORKFLOW.md)
