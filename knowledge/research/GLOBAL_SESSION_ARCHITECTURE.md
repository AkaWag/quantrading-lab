# Global Session Architecture (Trading Day)

> **Title:** Global Session Architecture — Asia → London → Overlap → New York → Next Asia
> **Status:** reviewed
> **Owner:** Aka Wag
> **Created:** 2026-07-21
> **Last reviewed:** 2026-07-23
> **Source projects:** QT-R-001 (and subsequent session-aware projects)
> **Confidence:** structural (defines how QuanTrading models the trading day; **no empirical claim**
> that any session transition is predictive or profitable)
> **Evidence references:** none yet — session relationships remain research questions
> **Supersedes:** none
> **Superseded by:** none

## Purpose

QuanTrading researches markets across the **complete trading-day session sequence**. Named
sessions are **not** modeled in isolation. This document is a **structural convention** for
research design; it does **not** validate any session-transition edge.

**2026-07-23:** Accepted as structural for QT-R-001 research review. QT-R-001 primary Asia
anchor is project-specific (`A-TK` Tokyo) and does **not** invent a lab-wide default Asia clock.

## Fixed global-session architecture

```text
1. Asia                      — beginning of the trading day (contextual structure)
2. London                    — primary liquidity / expansion phase for many instruments
3. London–New York overlap   — dual participation / transition phase
4. New York                  — continuation, reversal, management, or close-out
5. Transition → next Asia    — handoff into the following trading day
```

Focal events (e.g. a London-open breakout) are studied **inside** this sequence: Asia and prior
session supply context; overlap and New York supply subsequent behaviour and management options;
the next-Asia transition closes the day cycle.

## What the architecture must support (candidate variables — unvalidated)

| Phase | Support |
|---|---|
| Asia | Range, high, low, direction, volatility |
| London | Expansion, continuation, reversal, failed breakout |
| Overlap | London–New York overlap behaviour |
| New York | Continuation or reversal of the London move |
| Cross-session | Previous-session context; liquidity and volatility transitions |
| Configuration | Configurable session windows |

## Time and timezone rules

- **Internal reference:** UTC (instant timestamps, storage, and comparison).
- **Named market calendars:** IANA time zones — at minimum `Europe/London` and
  `America/New_York`.
- **Do not hard-code permanent UTC offsets** for London or New York (daylight saving).
- Convert named local windows → UTC using the IANA zone for the relevant date.
- Exact **Asia market anchor** and Asia window remain **configurable research decisions**
  (Tokyo, Hong Kong/Singapore, Sydney, or a custom overnight block). Do **not** invent a default
  as if it were a lab fact.

## Configurable session definitions

Every project that uses this architecture must make session windows **explicit and
configurable**, including:

- Asia start/end (chosen anchor → IANA or documented UTC block)
- London start/end (`Europe/London`)
- London–New York **overlap** (derived or configured)
- New York start/end (`America/New_York`)
- Transition into the **next Asia** session
- Daylight-saving treatment (always via IANA zones, not fixed offsets)

**Distinguish:** fixed architecture (the sequence above) from **exact session-window values**
(project-specific, pre-registered open variables).

## Baseline implication

A session-aware model must be compared against **session-naive or London-only** baselines (and
other controls). See QT-R-001 for a concrete six-baseline set.

## Related documents

- [`MARKET_BEHAVIOURS.md`](../taxonomy/MARKET_BEHAVIOURS.md) (`SESSION`)
- [`RESEARCH_METHODS.md`](RESEARCH_METHODS.md)
- [`../../docs/research/RESEARCH_STREAMS.md`](../../docs/research/RESEARCH_STREAMS.md)
- [`../../docs/governance/RESEARCH_GOVERNANCE.md`](../../docs/governance/RESEARCH_GOVERNANCE.md)
- QT-R-001: [`../../research/strategies/20260721-xauusd-global-session-transition-london-breakout/`](../../research/strategies/20260721-xauusd-global-session-transition-london-breakout/README.md)
