# Full Strategy Review Prompt

Review the selected Pine script in this order:

1. `pine-code-reviewer`
2. `repaint-lookahead-auditor`
3. `risk-manager`
4. `backtest-auditor`
5. `performance-optimizer`
6. `release-reviewer`

Do not rewrite immediately. First return findings grouped as blocker, high, medium, and low severity. For each finding include the affected logic, consequence, and minimal correction. Then provide a revised script only for approved fixes or obvious correctness defects.
