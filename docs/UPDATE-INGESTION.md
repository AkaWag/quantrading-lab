# Update ingestion protocol

1. Place original material in `research/inbox/<date-topic>/`.
2. Add `SOURCE.md` with origin, date, author if known, and intended purpose.
3. Run the `update-intake-analyst` skill.
4. Write `ANALYSIS.md` containing claims, evidence quality, conflicts, dependencies, and recommendation.
5. Accepted platform changes require an ADR copied from `templates/ADR.md`.
6. Strategy-specific material stays with that strategy and must not silently alter global rules.
7. Update `CHANGELOG.md` only after implementation and verification.
