# Away mode status — 2026-07-24

Director left this while owner is away. Unattended work only.

## Done without you

| Item | Result |
|---|---|
| QT-R-002 pins | Present under `research/strategies/.../pins/` + SHA256SUMS |
| BASELINE freeze doc | Frozen for reproduce |
| REPRODUCE checklist | Added |
| EV-002 evidence stub | Ready to fill — no invented TV numbers |
| Improvement options (plan only) | `IMPROVEMENT_OPTIONS.md` — not executable yet |
| Registry / README / INTAKE / NEXT_ACTIONS | Synced to BASELINE_FROZEN |
| Away-mode operating doc | `docs/onboarding/AWAY_MODE.md` |
| `.cursor/cli.json` | Expanded allow for docs/dizzy/verify; deny commit/push/sudo/secrets |
| Dizzy cron | Active every 15m on `continuity-integration` → `#trader-j` |

## Blocked on you (cannot fake)

1. **H1/H2** — TradingView load pinned Pine → fill EV-002 metrics  
2. **H3** — After reproduce: pick first improvement family  
3. **H4** — Approve commit/merge of `continuity/full-repository` when ready  
4. Cursor UI: enable **Agent auto-run** for this workspace so prompts do not stall

## When you return

1. Open workspace: `/home/aka/quantrading/workspaces/continuity-integration`  
2. Do EV-002 per `REPRODUCE.md`  
3. Paste:

```text
Back from away mode. EV-002 is filled. Continue QT-R-002 from IMPROVEMENT_OPTIONS — one family only.
```

## Hard stops observed

No commit, push, optimize, live trade, or `.env` read during this away pass.
