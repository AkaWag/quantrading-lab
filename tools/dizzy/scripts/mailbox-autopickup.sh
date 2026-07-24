#!/usr/bin/env bash
# Export an allowlisted Dizzy mailbox channel and triage new messages into research/inbox.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$ROOT/../.." && pwd)"
LABEL="${1:-trader-j}"
LOG_DIR="$ROOT/runtime/logs"
STATE_DIR="$ROOT/runtime/state"
STATE_FILE="$STATE_DIR/${LABEL}.json"
LOCK_FILE="$STATE_DIR/${LABEL}.lock"
mkdir -p "$LOG_DIR" "$STATE_DIR"

usage() {
  cat <<EOF
Usage: $(basename "$0") [channel-label]

Default label: trader-j

1) Exports the allowlisted mailbox channel
2) Triages new messages into research/inbox/<date>-dizzy-msg-<id>/
3) Updates runtime state so repeats are skipped

Does not trade, alert, or open TradingView.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ -e "$LOCK_FILE" ]]; then
  # stale lock older than 30 minutes is ignored
  if find "$LOCK_FILE" -mmin +30 | grep -q .; then
    rm -f "$LOCK_FILE"
  else
    echo "Autopickup already running (lock: $LOCK_FILE)" >&2
    exit 0
  fi
fi
trap 'rm -f "$LOCK_FILE"' EXIT
echo "$$" >"$LOCK_FILE"

echo "[dizzy-autopickup] $(date -u +%Y-%m-%dT%H:%M:%SZ) start label=$LABEL"

AFTER_ARGS=()
if [[ -f "$STATE_FILE" ]]; then
  LAST_ID="$(python3 - "$STATE_FILE" <<'PY'
import json, sys
from pathlib import Path
state=json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
ids=sorted(str(x) for x in state.get("seenMessageIds") or [])
print(ids[-1] if ids else "")
PY
)"
  if [[ -n "$LAST_ID" ]]; then
    AFTER_ARGS=(--after "$LAST_ID")
    echo "[dizzy-autopickup] incremental --after $LAST_ID"
  fi
fi

# Capture export directory from dry-run first? Live export prints Output directory.
EXPORT_LOG="$(mktemp)"
set +e
bash "$ROOT/scripts/export-channel.sh" "$LABEL" "${AFTER_ARGS[@]}" | tee "$EXPORT_LOG"
EXPORT_RC=${PIPESTATUS[0]}
set -e
if [[ "$EXPORT_RC" -ne 0 ]]; then
  echo "[dizzy-autopickup] export failed rc=$EXPORT_RC" >&2
  exit "$EXPORT_RC"
fi

EXPORT_DIR="$(awk -F'Output directory:[[:space:]]*' '/Output directory:/{print $2}' "$EXPORT_LOG" | tail -n1)"
rm -f "$EXPORT_LOG"
if [[ -z "$EXPORT_DIR" || ! -d "$EXPORT_DIR" ]]; then
  # Fallback: newest export folder for this label
  EXPORT_DIR="$(ls -1dt "$ROOT/runtime/exports/"*"_${LABEL}_"* 2>/dev/null | head -n1 || true)"
fi
if [[ -z "${EXPORT_DIR:-}" || ! -d "$EXPORT_DIR" ]]; then
  echo "[dizzy-autopickup] could not locate export directory" >&2
  exit 1
fi

echo "[dizzy-autopickup] triage $EXPORT_DIR"
python3 "$ROOT/scripts/triage-export.py" \
  "$EXPORT_DIR" \
  --repo-root "$REPO_ROOT" \
  --state-file "$STATE_FILE" \
  --label "$LABEL"

echo "[dizzy-autopickup] $(date -u +%Y-%m-%dT%H:%M:%SZ) done"
