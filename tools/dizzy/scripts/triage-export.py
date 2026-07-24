#!/usr/bin/env python3
"""Triage a Dizzy quarantine export and create inbox packets for new actionable messages."""

from __future__ import annotations

import argparse
import json
import re
from datetime import datetime, timezone
from pathlib import Path


OPS_HINTS = re.compile(
    r"\b(holiday|cancelled|boot camp|schedule changes|weekly video|live trading session)\b",
    re.I,
)


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def channel_export(export_dir: Path) -> tuple[Path, dict]:
    files = [
        p
        for p in export_dir.glob("*.json")
        if p.name != "CAPTURE_MANIFEST.json"
    ]
    if not files:
        raise SystemExit(f"No channel export JSON in {export_dir}")
    path = files[0]
    return path, load_json(path)


def message_text(message: dict) -> str:
    parts = [message.get("content") or ""]
    forwarded = message.get("forwardedMessage") or {}
    if forwarded.get("content"):
        parts.append(forwarded["content"])
    return "\n".join(p for p in parts if p).strip()


def attachments(message: dict) -> list[dict]:
    items = list(message.get("attachments") or [])
    forwarded = message.get("forwardedMessage") or {}
    items.extend(forwarded.get("attachments") or [])
    return items


def is_actionable(message: dict) -> tuple[bool, str]:
    text = message_text(message)
    atts = attachments(message)
    content = (message.get("content") or "").strip()

    if message.get("forwardedMessage") and (text or atts):
        if OPS_HINTS.search(text) and not atts:
            return False, "ops_notice"
        return True, "forwarded_idea"

    if atts:
        return True, "attachments"

    if not text:
        return False, "empty"

    if content.startswith("@") and len(text) < 40:
        return False, "mention_only"

    if OPS_HINTS.search(text) and not atts:
        return False, "ops_notice"

    if len(text) >= 40:
        return True, "text_idea"

    return False, "noise"


def slug(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value.strip().lower()).strip("-")
    return value[:48] or "item"


def inbox_exists_for_message(repo_root: Path, msg_id: str) -> Path | None:
    inbox = repo_root / "research" / "inbox"
    if not inbox.exists():
        return None
    for source in inbox.glob("*/SOURCE.md"):
        try:
            text = source.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue
        if msg_id in text:
            return source.parent
    return None


def write_packet(
    repo_root: Path,
    export_dir: Path,
    export_json: Path,
    manifest: dict,
    message: dict,
    reason: str,
) -> Path:
    msg_id = str(message["id"])
    existing = inbox_exists_for_message(repo_root, msg_id)
    if existing is not None:
        return existing

    day = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    folder = repo_root / "research" / "inbox" / f"{day}-dizzy-msg-{msg_id}"
    if folder.exists():
        return folder

    folder.mkdir(parents=True, exist_ok=True)
    rel_export = Path("../../../") / export_dir.relative_to(repo_root)
    text = message_text(message)
    atts = attachments(message)
    reference = message.get("reference") or {}
    forwarded = message.get("forwardedMessage") or {}
    author = message.get("author") or {}
    channel = (manifest.get("channel") or {}) if manifest else {}

    source = f"""# SOURCE — Dizzy autopickup message {msg_id}

- Capture tool: DiscordChatExporter.Cli via mailbox autopickup
- Capture ID: `{manifest.get("captureId", "unknown")}`
- Mailbox label: `{channel.get("label", "unknown")}`
- Mailbox channel ID: `{channel.get("channelId", "unknown")}`
- Mailbox message ID: `{msg_id}`
- Mailbox timestamp: `{message.get("timestamp")}`
- Author: `{author.get("nickname") or author.get("name")}`
- Triage reason: `{reason}`
- Quarantine path: [`{rel_export.as_posix()}/`]({rel_export.as_posix()}/)
- Export JSON: `{export_json.name}`

## Origin / forward provenance

```json
{json.dumps(reference, indent=2)}
```

## Quoted source

> {text.replace(chr(10), chr(10) + "> ") if text else "_empty_"}

## Media

| File | Bytes |
|---|---|
"""
    if atts:
        for att in atts:
            source += f"| `{att.get('url') or att.get('fileName')}` | {att.get('fileSizeBytes', 'unknown')} |\n"
    else:
        source += "| _(none)_ | — |\n"

    source += """
## Rights note

Relayed/forwarded into owner mailbox. Untrusted external claim. No secrets stored here.
"""

    observation = f"""# Observation — Dizzy autopickup {msg_id}

- Research ID: unassigned (inbox candidate)
- Stream: unknown — Director to assign
- Owner: Aka Wag
- Date: {day}
- Related market / symbol / timeframe: unknown

## What was observed

Autopickup captured a new mailbox message classified as `{reason}`.
Exact levels/direction/invalidation remain unknown until chart/text transcription.

## Where and when

- Mailbox timestamp: {message.get("timestamp")}
- Forwarded origin timestamp: {forwarded.get("timestamp", "n/a")}

## Why it may matter

May contain a discretionary trade idea suitable for Shotgun chart review or research intake.

## Alternative explanations

Noise, incomplete forward, expired setup, or non-actionable commentary.

## Evidence currently available

- [`SOURCE.md`](SOURCE.md)
- Quarantine: [`{rel_export.as_posix()}/`]({rel_export.as_posix()}/)

## Confidence level

very low — automated mailbox intake; not validated.

## Next step

Director: ACCEPT_INBOX review → SHOTGUN_REVIEW / DEFER / REJECT / ATTACH QT-R-###.
No Pine, alerts, or live trades from this packet alone.
"""

    analysis = f"""# ANALYSIS — Dizzy autopickup {msg_id}

## Facts

- New mailbox message `{msg_id}` classified `{reason}`.
- Attachments: {len(atts)}
- Text length: {len(text)}

## Assumptions

- Owner mailbox `#trader-j` remains the authorized relay path.

## Inferences

- Requires human/Director routing before any chart or research promotion.

## Recommendation

`ACCEPT_INBOX` → await Director (`SHOTGUN_REVIEW` if charts present).

## Not verified

Chart levels, symbol/timeframe identity, setup validity, profitability.
"""

    (folder / "SOURCE.md").write_text(source, encoding="utf-8")
    (folder / "OBSERVATION.md").write_text(observation, encoding="utf-8")
    (folder / "ANALYSIS.md").write_text(analysis, encoding="utf-8")
    return folder


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("export_dir", type=Path)
    parser.add_argument("--repo-root", type=Path, required=True)
    parser.add_argument("--state-file", type=Path, required=True)
    parser.add_argument("--label", required=True)
    args = parser.parse_args()

    export_dir = args.export_dir.resolve()
    repo_root = args.repo_root.resolve()
    state_path = args.state_file.resolve()
    state_path.parent.mkdir(parents=True, exist_ok=True)

    state = {"label": args.label, "seenMessageIds": []}
    if state_path.exists():
        state.update(load_json(state_path))

    seen = set(str(x) for x in state.get("seenMessageIds", []))
    export_json, data = channel_export(export_dir)
    manifest_path = export_dir / "CAPTURE_MANIFEST.json"
    manifest = load_json(manifest_path) if manifest_path.exists() else {}

    created: list[str] = []
    skipped: list[str] = []
    for message in data.get("messages") or []:
        msg_id = str(message.get("id"))
        if msg_id in seen:
            skipped.append(f"{msg_id}:already_seen")
            continue
        ok, reason = is_actionable(message)
        seen.add(msg_id)
        if not ok:
            skipped.append(f"{msg_id}:{reason}")
            continue
        folder = write_packet(
            repo_root, export_dir, export_json, manifest, message, reason
        )
        created.append(f"{msg_id}:{folder.relative_to(repo_root)}")

    state["seenMessageIds"] = sorted(seen)
    state["lastExportDir"] = str(export_dir)
    state["lastRunAtUtc"] = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    state_path.write_text(json.dumps(state, indent=2) + "\n", encoding="utf-8")

    summary = {
        "label": args.label,
        "exportDir": str(export_dir),
        "createdInbox": created,
        "skipped": skipped,
        "messageCount": data.get("messageCount"),
    }
    print(json.dumps(summary, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
