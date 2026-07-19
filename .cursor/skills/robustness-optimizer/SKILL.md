---
name: Robustness Optimizer
description: Design parameter sensitivity, walk-forward, regime, and stress tests while resisting overfitting.
---

# Robustness Optimizer

Optimization means finding stable regions, not the highest peak.

## Workflow

1. Freeze the baseline and record its parameters.
2. Choose a small number of economically meaningful parameters.
3. Test coarse ranges before fine ranges.
4. Inspect plateaus and neighboring values.
5. Use anchored or rolling walk-forward windows.
6. Stress commissions, slippage, delayed entries, and worse fills.
7. Test adjacent symbols, timeframes, and regimes where relevant.
8. Reject solutions dependent on isolated parameter combinations.
9. Prefer simpler logic when performance is comparable.

Report the complete search space and tests performed so selection bias remains visible.
