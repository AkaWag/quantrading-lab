#!/usr/bin/env bash
# Export one allowlisted Discord channel for Dizzy quarantine (bot token only).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$ROOT/../.." && pwd)"
ALLOWLIST="${DIZZY_CHANNELS_FILE:-$ROOT/config/channels.json}"
ENV_FILE="${DIZZY_ENV_FILE:-$ROOT/.env}"
DEFAULT_BIN="$ROOT/vendor/DiscordChatExporter.Cli.linux-x64/DiscordChatExporter.Cli"
BIN="${DIZZY_DCE_BIN:-$DEFAULT_BIN}"

usage() {
  cat <<EOF
Usage: $(basename "$0") <channelId|label> [--after <date|id>] [--before <date|id>] [--dry-run]

Exports one channel from the Dizzy allowlist into tools/dizzy/runtime/exports/.
Requires:
  - DiscordChatExporter.Cli installed via scripts/install-discordchatexporter.sh
  - tools/dizzy/.env with DISCORD_TOKEN (bot token)
  - tools/dizzy/config/channels.json with enabled=true for the target

Hard stops:
  - User-token automation is prohibited
  - Non-allowlisted channel IDs are rejected
  - This script does not write research/inbox/ (Director/human acceptance still required)
EOF
}

if [[ $# -lt 1 || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

TARGET="$1"
shift
AFTER=""
BEFORE=""
DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --after) AFTER="${2:-}"; shift 2 ;;
    --before) BEFORE="${2:-}"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    *) echo "Unknown option: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ ! -x "$BIN" ]]; then
  echo "ERROR: DiscordChatExporter.Cli not found at $BIN" >&2
  echo "Run: bash tools/dizzy/scripts/install-discordchatexporter.sh" >&2
  exit 1
fi

if [[ ! -f "$ALLOWLIST" ]]; then
  echo "ERROR: allowlist missing: $ALLOWLIST" >&2
  echo "Copy tools/dizzy/config/channels.example.json → tools/dizzy/config/channels.json" >&2
  exit 1
fi

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  set -a
  # Prefer bot-named var if present.
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

TOKEN="${DISCORD_BOT_TOKEN:-${DISCORD_TOKEN:-}}"
if [[ -z "$TOKEN" ]]; then
  echo "ERROR: DISCORD_BOT_TOKEN or DISCORD_TOKEN is not set." >&2
  echo "Put a Discord *bot* token in tools/dizzy/.env (never commit it)." >&2
  exit 1
fi

# Policy: use a Bot token from Developer Portal → Bot → Reset Token.
# Do not use a user account token, Client Secret, or OAuth2 secret.
# Modern bot tokens are often base64.dot.dot and do NOT start with digits, so we
# do not reject by shape heuristics (those false-positive on valid bot tokens).
if [[ -z "${DISCORD_BOT_TOKEN:-}" && -n "${DISCORD_TOKEN:-}" ]]; then
  echo "NOTE: Using DISCORD_TOKEN. Prefer DISCORD_BOT_TOKEN in tools/dizzy/.env." >&2
fi

CHANNEL_JSON="$(python3 - "$ALLOWLIST" "$TARGET" <<'PY'
import json, sys
from pathlib import Path
path, target = Path(sys.argv[1]), sys.argv[2]
data = json.loads(path.read_text(encoding="utf-8"))
channels = data.get("channels") or []
match = None
for ch in channels:
    if str(ch.get("channelId")) == target or str(ch.get("label")) == target:
        match = ch
        break
if match is None:
    print(f"ERROR: {target!r} is not in the Dizzy allowlist.", file=sys.stderr)
    sys.exit(1)
if not match.get("enabled", False):
    print(f"ERROR: channel {target!r} exists but enabled=false.", file=sys.stderr)
    sys.exit(1)
if str(match.get("channelId", "")).startswith("0000"):
    print("ERROR: placeholder channelId still present.", file=sys.stderr)
    sys.exit(1)
print(json.dumps(match))
PY
)"

CHANNEL_ID="$(python3 -c 'import json,sys; print(json.loads(sys.argv[1])["channelId"])' "$CHANNEL_JSON")"
LABEL="$(python3 -c 'import json,sys; print(json.loads(sys.argv[1]).get("label","channel"))' "$CHANNEL_JSON")"
THREADS="$(python3 -c 'import json,sys; print(json.loads(sys.argv[1]).get("includeThreads","Active"))' "$CHANNEL_JSON")"
MEDIA="$(python3 -c 'import json,sys; print("true" if json.loads(sys.argv[1]).get("media", True) else "false")' "$CHANNEL_JSON")"
FORMAT="${DIZZY_EXPORT_FORMAT:-Json}"
THREADS="${DIZZY_INCLUDE_THREADS:-$THREADS}"
UTC_FLAG="${DIZZY_UTC:-true}"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT_DIR="$ROOT/runtime/exports/${STAMP}_${LABEL}_${CHANNEL_ID}"
mkdir -p "$OUT_DIR"
MEDIA_DIR="$OUT_DIR/media"
mkdir -p "$MEDIA_DIR"

# Pass token only via environment (DISCORD_TOKEN). Never put it on argv so dry-run
# output and process listings do not expose the secret.
CMD=(
  "$BIN" export
  --channel "$CHANNEL_ID"
  --format "$FORMAT"
  --output "$OUT_DIR/"
  --include-threads "$THREADS"
  --respect-rate-limits true
)

if [[ "$MEDIA" == "true" || "${DIZZY_MEDIA:-true}" == "true" ]]; then
  CMD+=(--media --reuse-media --media-dir "$MEDIA_DIR/")
fi
if [[ "$UTC_FLAG" == "true" ]]; then
  CMD+=(--utc)
fi
if [[ -n "$AFTER" ]]; then
  CMD+=(--after "$AFTER")
fi
if [[ -n "$BEFORE" ]]; then
  CMD+=(--before "$BEFORE")
fi

MANIFEST="$OUT_DIR/CAPTURE_MANIFEST.json"
python3 - "$MANIFEST" "$CHANNEL_JSON" "$STAMP" "$FORMAT" "$REPO_ROOT" <<'PY'
import json, sys
from pathlib import Path
manifest_path = Path(sys.argv[1])
channel = json.loads(sys.argv[2])
stamp, fmt, repo = sys.argv[3], sys.argv[4], sys.argv[5]
manifest = {
    "schemaVersion": 1,
    "captureId": f"dizzy-{stamp}-{channel['channelId']}",
    "tool": "DiscordChatExporter.Cli",
    "toolVersionFile": "tools/dizzy/vendor/VERSION",
    "capturedAtUtc": stamp,
    "format": fmt,
    "channel": channel,
    "policy": {
        "tokenTypeRequired": "discord-bot",
        "userTokenProhibited": True,
        "writesResearchInbox": False,
        "liveTrading": False,
    },
    "repoRoot": repo,
    "notes": "Quarantine export only. Human/Director acceptance required before research/inbox landing.",
}
manifest_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
print(manifest_path)
PY

echo "Allowlisted channel: $LABEL ($CHANNEL_ID)"
echo "Output directory:    $OUT_DIR"
if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "Dry run — command prepared (token via env only, not shown):"
  printf ' DISCORD_TOKEN=[REDACTED]'
  printf ' %q' "${CMD[@]}"
  echo
  exit 0
fi

DISCORD_TOKEN="$TOKEN" "${CMD[@]}"
echo "Export complete."
echo "Manifest: $MANIFEST"
echo "Next: review quarantine → prepare SOURCE/OBSERVATION packet → Director acceptance before research/inbox."
