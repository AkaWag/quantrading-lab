# Knowledge Management

This governing standard defines how knowledge is captured, reviewed, promoted, and retired in
the QuanTrading Knowledge & Research Department. It supports
[`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md) and aligns with the `documentation-steward`
skill and `50-research-governance.mdc`.

## Three knowledge levels

Knowledge is classified by how much scrutiny it has received. The level is **not** a claim about
profitability or empirical truth; it is a claim about review status.

| Level | Meaning | Typical location | Status label |
|---|---|---|---|
| 1. Draft note | Raw, unreviewed capture. May be wrong or incomplete. | `research/inbox/`, project folders, `knowledge/**` with `status: draft` | `draft` |
| 2. Reviewed knowledge | Checked by a second party against evidence; internally consistent. | `knowledge/**` with `status: reviewed` | `reviewed` |
| 3. Governing standard | Adopted as a lab-wide rule or controlled vocabulary. | `docs/**`, `.cursor/rules/**`, taxonomies marked `governing` | `governing` |

### Who or what may promote content

- **Draft → Reviewed:** a human other than the sole author reviews the note against its cited
  evidence and records themselves as reviewer. AI assistants may *draft* and *propose* a
  promotion but cannot approve their own content.
- **Reviewed → Governing:** requires human approval and, when it changes repository structure,
  workflow, or governance, an **ADR** per
  [`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md). Controlled
  vocabularies (taxonomies) become governing when adopted by ADR.
- **Any demotion or retirement:** see "Contradictions and staleness" below.

## Distinguishing raw notes, reviewed knowledge, and governing standards

- **Raw notes** are provisional. Never cite a draft note as if it were established knowledge.
- **Reviewed knowledge** may be relied upon within its stated confidence and limitations.
- **Governing standards** are binding until superseded and must be followed.

Reusable knowledge (knowledge base) is always kept separate from project-specific evidence
(research operations). A finding stays in its project's evidence folder until a reviewer distills
a **reusable** lesson and promotes it into [`../../knowledge/`](../../knowledge/).

## Required metadata (every knowledge document)

Each file under `knowledge/` begins with a metadata block:

```md
> **Title:** <human title>
> **Status:** draft | reviewed | governing
> **Owner:** <human name>
> **Created:** YYYY-MM-DD
> **Last reviewed:** YYYY-MM-DD
> **Source projects:** <research IDs, or "none — structural">
> **Confidence:** structural | low | medium | high (+ one-line basis)
> **Evidence references:** <links, or "none yet">
> **Supersedes:** <doc/ID, or "none">
> **Superseded by:** <doc/ID, or "none">
```

`Confidence: structural` means the document defines structure or vocabulary only and makes **no
empirical claim**. Do not raise confidence above `structural` without linked evidence.

## Lessons promotion

At project closeout ([`../../research/templates/RESEARCH_CLOSEOUT.md`](../../research/templates/RESEARCH_CLOSEOUT.md)),
the owner records which lessons are reusable and promotes them into
[`../../knowledge/lessons/`](../../knowledge/lessons/) using
[`../../knowledge/lessons/LESSON_TEMPLATE.md`](../../knowledge/lessons/LESSON_TEMPLATE.md). A
lesson must cite the project(s) and evidence it came from. Failed and negative results are a
primary source of lessons and must not be discarded.

## Contradictions and staleness (no silent rewriting)

History is never silently rewritten. When new evidence contradicts existing knowledge:

1. **Mark, do not erase.** Set the old document's `Status` to `superseded` (or add a
   `> **Stale:** <date> — <reason>` line for time-based staleness) and fill `Superseded by`.
2. **Create a successor.** Write the corrected document with a fresh `Created` date and set its
   `Supersedes` field to the old document/ID.
3. **Record the decision.** If the change is significant or governance-affecting, add or
   reference an ADR.
4. **Preserve the trail.** The superseded document remains in the repository so the reasoning
   history stays visible, consistent with `60-repository-hygiene.mdc` ("never modify production
   releases in place; create a new version") and the append-only ADR discipline.

Contradicted lessons are annotated with the contradicting evidence link; they are not deleted.

## Guardrails

- Do not fabricate sources, compiler output, test results, or profitability.
- Do not claim a knowledge item is empirically validated unless linked evidence already exists.
- Prefer minimal, traceable changes; record rejected alternatives.

## Related documents

- [`RESEARCH_DEPARTMENT.md`](RESEARCH_DEPARTMENT.md) · [`RESEARCH_ARTIFACT_MODEL.md`](RESEARCH_ARTIFACT_MODEL.md)
- [`../governance/RESEARCH_GOVERNANCE.md`](../governance/RESEARCH_GOVERNANCE.md) · [`../governance/DECISION_GOVERNANCE.md`](../governance/DECISION_GOVERNANCE.md)
- [`../../knowledge/README.md`](../../knowledge/README.md)
