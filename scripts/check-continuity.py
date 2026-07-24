#!/usr/bin/env python3
"""Validate repository-local Markdown links and required continuity artifacts."""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote


MARKDOWN_LINK = re.compile(r"(?<!!)\[[^\]]+\]\(([^)]+)\)")
SKIP_PREFIXES = ("http://", "https://", "mailto:", "#")
REQUIRED_PATHS = (
    "decisions/ADR-005-establish-research-streams.md",
    "decisions/ADR-006-establish-chatgpt-cursor-orchestration-bridge.md",
    "decisions/ADR-007-external-signum-agent-lab-archive-adr-006.md",
    "decisions/ADR-008-intake-signum-gold-tv-strategies.md",
    "decisions/ADR-009-establish-dizzy-discord-intake-agent.md",
    "docs/onboarding/DIZZY_AGENT.md",
    "docs/onboarding/DIRECTOR_OPERATING_MODEL.md",
    "docs/onboarding/SHOTGUN_AGENT.md",
    ".cursor/skills/dizzy/SKILL.md",
    ".cursor/skills/dizzy/reference.md",
    "docs/research/RESEARCH_STREAMS.md",
    "knowledge/research/GLOBAL_SESSION_ARCHITECTURE.md",
    "reports/repository-continuity-restoration-2026-07-24.md",
    "research/strategies/20260721-xauusd-global-session-transition-london-breakout/README.md",
    "tools/dizzy/README.md",
    "tools/dizzy/OWNER_SETUP.md",
    "tools/dizzy/docs/DISCORDDATAMIRROR_COMPARISON.md",
    "tools/dizzy/docs/MAILBOX_AUTOPICKUP.md",
    "tools/dizzy/scripts/export-channel.sh",
    "tools/dizzy/scripts/mailbox-autopickup.sh",
    "tools/dizzy/scripts/triage-export.py",
    "tools/dizzy/scripts/install-discordchatexporter.sh",
    "tools/dizzy/vendor/VERSION",
)
SKIP_DIRECTORIES = {".git", "node_modules", "dist", "coverage", "runtime"}


def markdown_files(root: Path) -> list[Path]:
    return sorted(
        path
        for path in root.rglob("*.md")
        if not any(part in SKIP_DIRECTORIES for part in path.relative_to(root).parts)
    )


def local_target(raw_target: str) -> str | None:
    target = raw_target.strip()
    if target.startswith("<") and target.endswith(">"):
        target = target[1:-1]
    if not target or target.lower().startswith(SKIP_PREFIXES):
        return None

    target = target.split("#", 1)[0].strip()
    if not target:
        return None
    return unquote(target)


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    failures: list[str] = []

    for relative in REQUIRED_PATHS:
        if not (root / relative).exists():
            failures.append(f"MISSING CONTINUITY ARTIFACT: {relative}")

    for document in markdown_files(root):
        text = document.read_text(encoding="utf-8")
        for line_number, line in enumerate(text.splitlines(), start=1):
            for match in MARKDOWN_LINK.finditer(line):
                target = local_target(match.group(1))
                if target is None:
                    continue

                resolved = (
                    (root / target.lstrip("/"))
                    if target.startswith("/")
                    else (document.parent / target)
                ).resolve()
                try:
                    resolved.relative_to(root)
                except ValueError:
                    # Links to intentionally external local trees are not repository continuity.
                    continue

                if not resolved.exists():
                    failures.append(
                        f"BROKEN LINK: {document.relative_to(root)}:{line_number}: {target}"
                    )

    if failures:
        print("\n".join(failures))
        print(f"Continuity check failed: {len(failures)} issue(s).")
        return 1

    print(
        f"Continuity check passed: {len(REQUIRED_PATHS)} required artifacts and "
        f"{len(markdown_files(root))} Markdown files checked."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
