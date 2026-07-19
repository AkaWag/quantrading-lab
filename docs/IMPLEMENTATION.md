# Implementation Guide

## 1. Repository layout

Use one Git repository per strategy family or research programme. Keep Pine source in `pine/`, research notes in `docs/`, and exported test results in a clearly named folder such as `research/results/`.

## 2. Install into a project

```bash
./scripts/install.sh --project "$HOME/projects/my-trading-lab"
cd "$HOME/projects/my-trading-lab"
git init
cursor .
```

If the `cursor` shell command is unavailable, open Cursor from the Ubuntu desktop and choose **File → Open Folder**.

## 3. Start each strategy with a specification

Create `docs/<strategy-name>-spec.md` using the strategy specification prompt. Do not begin optimization before the specification defines:

- market and timeframe
- hypothesis and expected regime
- exact entry and exit rules
- sizing and risk budget
- costs and fill assumptions
- invalidation criteria
- in-sample and out-of-sample windows

## 4. Development loop

Use this sequence:

```text
Specification → baseline code → TradingView compile → semantic audit
→ backtest integrity review → risk review → robustness tests → release review
```

TradingView is the compilation authority. Paste exact compiler messages into Cursor, including line numbers and the relevant code section.

## 5. Testing discipline

Maintain a test journal for every material change. At minimum record:

- script version or Git commit
- symbol, exchange, timeframe, session, and date range
- strategy properties
- parameter values
- net profit, drawdown, trade count, profit factor, expectancy, exposure
- out-of-sample result
- observations and next decision

## 6. MCP and automation

An MCP server may provide documentation lookup or browser/TradingView automation, but it is not required for this package. Before adding one:

1. Inspect its repository and maintenance history.
2. Pin a version or commit.
3. Review commands and network access.
4. Run it as an unprivileged Linux user.
5. Grant only the directories it needs.
6. Never expose browser cookies, broker tokens, or webhook secrets.

A documentation-only integration is lower risk than one controlling a browser or desktop session.

## 7. Remote server recommendations

- Keep the project under `$HOME`, not `/root`.
- Use SSH keys and Git for backups.
- Use `tmux` for long terminal sessions, though Cursor work itself remains interactive.
- Avoid opening the same repository simultaneously through incompatible network mounts.
- Set an automatic screen lock because Remmina exposes the full desktop session.
