# Shotgun — reference

## Active strategy focus — 3-MACD Gold 1H

When the owner says **3MACD**, **3-MACD**, or Gold 1H MACD confluence, load:

[`3MACD_GOLD_1H.md`](3MACD_GOLD_1H.md)

Use those rules for chart companionship and directed TradingView actions unless the owner overrides.
Signum backtest numbers are external — do not restate as QuanTrading-verified.

## Session open checklist

- [ ] Shotgun invoked by name or mandate
- [ ] Symbol, TF, session TZ
- [ ] Focus artifact: `QT-R-###` / `QT-S-###` / draft / live ruleset name
- [ ] Chart evidence path: screenshot | browser/TV | owner narration
- [ ] Mode: research walkthrough | develop/test | discretionary support | live-rules support

## Quality bar (quant + manual)

Shotgun should routinely surface:

1. **Plan fit** — does price action match the written rules?
2. **Invalidation** — where is the idea dead?
3. **Location** — premium/discount, session phase (Asia/London/overlap/NY when relevant)
4. **Risk** — size, stop logic, asymmetric payoff vs noise
5. **Costs** — spread/slippage awareness at this hour
6. **Bias check** — revenge, FOMO, narrative fitting
7. **Falsifiers** — what evidence would kill this setup class?

## Director task quality

Good tasks are:

- Testable and scoped (one change family)
- Tied to an artifact ID when possible
- Labeled research vs implementation vs ops
- Explicit about whether OOS/experiment locks apply

Bad tasks: “make it better,” “optimize everything,” silent live rule changes.

## TradingView interaction modes

| Mode | How |
|---|---|
| Owner shares screenshot | Annotate levels; ask for missing scale/time |
| **Directed UI** (default goal) | `cursor-ide-browser` → lock → snapshot → click/type on tradingview.com under owner orders |
| Browser/TV tools available | Inspect chart; confirm symbol/TF; report iframe/login blockers |
| Owner narrates | Mirror back structure before advising |
| Alert/middleman path | Condition ↔ payload ↔ broker rule; webhook URL not committed to git |

### Directed-UI quick checklist

- [ ] Owner authorized directed mode this session
- [ ] TV open + logged in (owner)
- [ ] Symbol / TF confirmed
- [ ] Each trade/alert-to-capital restated before click
- [ ] Actions listed in Shotgun → Director packet
- [ ] Browser unlocked when done / on blocker

## Live vs companion language

| Say | Avoid |
|---|---|
| “Under your stated rules, the trigger is …” | “I’m placing the order” (unless owner explicitly runs an approved path with you) |
| “Paper / shadow check: …” | Guaranteed outcome language |
| “Propose director task: …” | Quietly editing production Pine |

## Example micro-packet

```markdown
## Shotgun → Director feedback
- Date/time: 2026-07-23 22:00 Europe/London
- Symbol / TF: XAUUSD / 15m
- Focus ID: QT-R-001
- Chart context: London open; Asia range 2340–2348 visible on screenshot
- Observations: Sweep of Asia high then close back inside range on 15m
- Inferences: Failed breakout candidate vs plan’s “close beyond” rule — if plan requires close beyond, this bar is not a valid long trigger
- Strategy-rule compliance: drift (if entry was taken on wick only)
- Proposed improvement tasks:
  1. Add explicit “close beyond Asia/pre-London range” confirmation to SPEC/experiment notes
  2. Journal false-break frequency in London first hour (evidence stub)
- Trade actions discussed: none
- Not verified: actual fill, spread at that minute, news calendar
```
