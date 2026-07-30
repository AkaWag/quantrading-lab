# Knowledge Base

> **Title:** QuanTrading Knowledge Base
> **Status:** governing
> **Owner:** Aka Wag
> **Created:** 2026-07-19
> **Last reviewed:** 2026-07-19
> **Source projects:** none — structural
> **Confidence:** structural (defines organization only; no empirical claim)
> **Evidence references:** none yet
> **Supersedes:** none
> **Superseded by:** none

This is the **reusable knowledge** half of the Knowledge & Research Department. It holds
cross-project knowledge: controlled taxonomies, Pine/TradingView notes, research methods, and
promoted lessons. Project-specific evidence lives elsewhere, under
[`../research/`](../research/); only distilled, reviewed lessons are promoted here.

Governed by [`../docs/research/RESEARCH_DEPARTMENT.md`](../docs/research/RESEARCH_DEPARTMENT.md)
and [`../docs/research/KNOWLEDGE_MANAGEMENT.md`](../docs/research/KNOWLEDGE_MANAGEMENT.md).

## Structure

| Area | Path | Contents |
|---|---|---|
| Taxonomy | [`taxonomy/`](taxonomy/) | Controlled vocabularies for behaviors, strategy/indicator families, risk, evidence |
| Pine knowledge | [`pine/`](pine/) | TradingView/Pine patterns, execution notes, MTF/repainting, failures, performance |
| Research methods | [`research/`](research/) | Research methods, hypothesis design, baselines, robustness, anti-patterns, [global session architecture](research/GLOBAL_SESSION_ARCHITECTURE.md) |
| Lessons | [`lessons/`](lessons/) | Promoted lessons learned from closed projects |

## Knowledge levels and metadata

Every document here declares a metadata block and a level — **draft**, **reviewed**, or
**governing** — as defined in
[`../docs/research/KNOWLEDGE_MANAGEMENT.md`](../docs/research/KNOWLEDGE_MANAGEMENT.md). Do not
cite a `draft` document as established knowledge, and do not raise `Confidence` above
`structural` without linked evidence.

## How content enters

- **Draft notes** may be created directly here or captured in a project and copied in.
- **Reviewed knowledge** requires a second-party review against cited evidence.
- **Governing standards** require human approval and, when structural, an ADR.
- **Contradicted or stale** content is marked (`superseded` / `Stale:`), never silently rewritten.

## Important scope note

Nothing in this knowledge base asserts that any strategy, indicator, or behavior is profitable
or empirically validated. Taxonomies are definitional; notes are structural or draft until
evidence is linked. See
[`../docs/governance/QUANTRADING_CHARTER.md`](../docs/governance/QUANTRADING_CHARTER.md).
