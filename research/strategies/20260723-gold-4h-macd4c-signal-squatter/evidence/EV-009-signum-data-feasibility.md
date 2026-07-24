# EV-009 — Signum data feasibility and evidence-expansion proposals (QT-R-002)

- Date: 2026-07-24
- Scope: M2 data/semantic inventory and M3 proposals
- Operation: local read-only diagnostics; no credential access, network fetch, transfer run, or
  parameter search
- M2 verdict: **PASS FOR PARTIAL DIAGNOSTIC PARITY; BLOCKED FOR FULL-WINDOW REPRODUCTION**
- M3 verdict: **PASS — PROPOSALS FILED, NOT EXECUTED**
- Research gate: **INSUFFICIENT_EVIDENCE — preserved**

## Facts: canonical frozen semantics

The pinned Pine SHA-256 independently matches `BASELINE.md`:
`2b770e44a82e0a79917db3adaf9f79557be6be77108d20c0e076f69b0e81b0cc`.

With short only enabled and all other defaults frozen:

- MACD = EMA(18) minus EMA(36); signal = SMA(12) of MACD;
- entry decision = bearish MACD cross, close below EMA(300), three-bar EMA slope <= -0.03%,
  and falling MACD;
- short exit decision = close above EMA(300), or a bullish MACD cross while MACD is positive;
- decisions occur at bar close and market orders fill at the next bar open under the captured
  one-tick delay;
- pyramiding is 1; TP/SL, cross-exit-any, and zero-line exit are off.

No Pine or input was changed.

## Lawful local inventory

Only already-local, non-secret files were inspected. `.env`, sessions, tokens, and broker
credentials were not read.

| Local source | Declared/provenance semantics | Coverage and basic integrity | Fitness |
|---|---|---|---|
| `incoming/Backtest_engine_v22.0.0/data/OANDA_XAUUSD, 240.csv` | Filename says OANDA; no embedded provider, timezone, session, tick-size, or spread metadata | 3,425 rows; 2023-12-17 23:00Z to 2026-05-11 11:00Z; no duplicate timestamps or null OHLC; mixed 3.5/4/5-hour spacing plus closures | **Unsuitable** for the frozen 2018 window and feed equivalence |
| `incoming/Backtest_engine_v22.0.0/data/OANDA_XAUUSD, 60.csv` | Vendored repository scripts/reports **claim** Dukascopy despite the filename; the CSV has no embedded provider proof | 70,992 rows; 2018-02-01 00:00Z to 2026-05-11 23:00Z; no duplicate timestamps or null OHLC; four large gaps of 25, 49, 721, and 745 hours | **Unsuitable** for OANDA/TradingView identity; possible future transfer source only |
| `incoming/Backtest_engine_v22.0.0/data/cache/tv_OANDA_XAUUSD_1h_2025-01-01_2026-05-18.csv` | Its local fetch script explicitly resolves `OANDA:XAUUSD`, interval 60, regular session, through TradingView without a credential | 8,117 rows; 2025-01-01 23:00Z to 2026-05-18 18:00Z; no duplicates/null OHLC; timestamp is explicit UTC; daily/session and weekend gaps exist | **Suitable only for partial diagnostic parity**, including the two known OOS trades |

The exact files and SHA-256 values inspected were:

- native 4H: `94c135ffa15cdc84f703317034c72c695483e0a2eccc433087f995bb84b04f55`;
- Dukascopy 1H: `c1c1e5e796f3ccf00d609c551bbc8b0d699ea2f03d88c826b7d68d2a72002b5e`;
- TradingView OANDA 1H cache:
  `00456ee2e8f6ebc5e53abb944dafc799d565ae1255b8770d20b9eb47a8cef819`.

Price precision is represented to three decimals in both 1H sources. None contains authoritative
`syminfo.mintick`, bid/ask spread, commission, or licensing metadata. Observed decimal precision
is not proof of tick size. The cache's source script disables TLS certificate verification;
that is a provenance/security limitation and the fetch was not rerun.

## Partial frozen-logic diagnostic

The exact-feed cache was aggregated without mutation into 4H OHLC groups starting at
UTC 01/05/09/13/17/21. This alignment is independently supported by all four known OOS fill
prices: each equals the exact 1H open at the ledger timestamp converted from chart UTC+2 to UTC.
Of 2,151 non-empty aggregate groups, 1,759 contain four hourly rows, 325 contain three, 39 contain
two, and 28 contain one; the shortened groups reflect feed/session gaps and are retained as a
semantic caveat.

EMA calculations used chronological closes, `adjust=False`, and the Pine lengths. More than a
year of warm-up precedes the reproduced April 2026 decisions. The recovered values are:

| Trade | Decision / fill | Reproduction |
|---|---|---|
| 16 entry | decision 2026-04-05 21:00Z; fill 2026-04-06 01:00Z | fill **4622.630 exact**; EMA(300) **4805.4548597**; three-bar slope **-0.0641466272%**; bearish cross + below EMA + falling MACD |
| 16 exit | decision 2026-04-07 21:00Z; fill 2026-04-08 01:00Z | fill **4817.730 exact**; close **4817.715** > EMA **4795.9222961**: **EMA reclaim** |
| 17 entry | decision 2026-04-27 13:00Z; fill 2026-04-27 17:00Z | fill **4676.915 exact**; EMA(300) **4781.0030007**; three-bar slope **-0.0366187514%**; bearish cross + below EMA + falling MACD |
| 17 exit | decision 2026-05-07 09:00Z; fill 2026-05-07 13:00Z | fill **4750.235 exact**; close **4750.195** > EMA **4735.6194888**: **EMA reclaim** |

A further qualifying short signal occurs during trade 17. It does not add a position under
pyramiding 1 and is not a new trade.

The ledger's MAE/MFE values were **not** exactly reproduced from aggregated OHLC extremes. The
CSV displays rounded quantities, while TradingView's broker emulator uses internal quantity and
bar-path state. The diagnostic method tested was short favorable excursion from entry to the
minimum aggregate low and adverse excursion to the maximum aggregate high before exit. Because
the values differ, EV-004 remains authoritative and no equivalence claim is made for MAE/MFE.

### M2 limits

- The exact-feed cache does not cover 2018-2024, so the first 15 trades and full ledger cannot be
  reproduced.
- Direct native TradingView 4H bars were not locally available. The aggregation alignment is
  strongly corroborated by exact fills but is not provider metadata.
- EMA initialization is a deterministic local reconstruction, not exported TradingView state.
- Spread, tick-size metadata, and unrounded order quantity are absent.

Therefore M2 passes only as a two-trade semantic diagnostic and is blocked as a full-window feed
reproduction. It does not increase the locked OOS count beyond two.

## M3-A — forward-evidence proposal (not executed)

Purpose: acquire genuinely later observations for the frozen `OANDA:XAUUSD` 4H logic.

1. Freeze the existing Pine hash, inputs, direction state, UTC/session convention, on-close
   decisions, next-bar-open fills, 0.1% commission, zero slippage baseline, and evidence schema.
2. Begin strictly after the current cutoff, **2026-05-19**. Append signals and fills
   chronologically; never revise the prior partitions or inspect the locked slope grid.
3. For every event retain source bar timestamps/OHLC, signal predicates, EMA/MACD values, order
   time/fill time, unrounded quantity when exportable, exit-predicate flags, MAE/MFE, data-fault
   checks, and strategy/inputs hashes.
4. Reconcile every collected event against TradingView: signal parity target 100% for this
   evidence study, timestamp/fill discrepancies explicitly failed, and zero unresolved data
   faults.
5. For this forward protocol, require at least **20 independent OOS shorts**, where independent
   means sequential, non-pyramided, and non-overlapping. This is stricter than the locked
   experiment's absolute minimum of 10 and adopts the referee's power safeguard. No interim
   parameter testing or performance peeking.
6. Predeclare **0.2% commission per side as a mandatory hurdle**; passing only the 0.1% baseline
   is a failure. At the gate, also apply the remaining pre-registered fill and concentration
   checks. A sparse or negative result remains `INSUFFICIENT_EVIDENCE` or `NO CANDIDATE`.

This proposal requires Director acceptance of the collection protocol before operation. It is
shadow/research evidence only and contains no live routing.

## M3-B — transfer-study proposal (not executed)

Purpose: test whether the frozen hypothesis generalizes; never manufacture more QT-R-002 OOS.

1. Require a Director-approved experiment amendment naming each adjacent feed, symbol, and/or
   timeframe, its rationale, and its feed/session mapping before any run.
2. Freeze the current logic and 0.03% control. Do **not** execute or rank the slope grid in the
   transfer study.
3. Pre-register per-domain chronological partitions, minimum trades, cost/fill assumptions,
   missing-bar policy, and failure criteria. Use direct provider-native bars where possible.
4. Report each domain separately, including feed-basis differences and event parity. Do not pool
   transfer trades with XAUUSD OANDA OOS, and do not use transfer results to tune OOS boundaries.
5. Interpret the result only as hypothesis transportability or implementation feasibility.
   Promotion still requires the original evidence gate and a separately authorized candidate
   study.

No transfer source was selected, executed, pooled, or scored in this work.

## Result

M2: **PASS FOR PARTIAL DIAGNOSTIC PARITY; BLOCKED FOR FULL-WINDOW REPRODUCTION**.

M3: **PASS — both proposals are filed and remain unexecuted**.

The performance scorecard remains dormant. No candidate was evaluated, and
`INSUFFICIENT_EVIDENCE` remains the controlling verdict.
