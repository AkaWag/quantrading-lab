#!/usr/bin/env bash
# Install DiscordChatExporter.Cli project-locally for Dizzy (no system packages).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENDOR_DIR="$ROOT/vendor"
VERSION_FILE="$VENDOR_DIR/VERSION"
VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"
ASSET="DiscordChatExporter.Cli.linux-x64.zip"
URL="https://github.com/Tyrrrz/DiscordChatExporter/releases/download/${VERSION}/${ASSET}"
EXPECTED_SHA_FILE="$VENDOR_DIR/${ASSET}.sha256"
DEST_DIR="$VENDOR_DIR/DiscordChatExporter.Cli.linux-x64"
TMP_ZIP="$(mktemp "/tmp/${ASSET}.XXXXXX")"

cleanup() { rm -f "$TMP_ZIP"; }
trap cleanup EXIT

mkdir -p "$VENDOR_DIR"
echo "Downloading DiscordChatExporter.Cli ${VERSION}..."
curl -fsSL -o "$TMP_ZIP" "$URL"

if [[ -f "$EXPECTED_SHA_FILE" ]]; then
  expected="$(awk '{print $1}' "$EXPECTED_SHA_FILE")"
  actual="$(sha256sum "$TMP_ZIP" | awk '{print $1}')"
  if [[ "$expected" != "$actual" ]]; then
    echo "ERROR: SHA-256 mismatch for ${ASSET}" >&2
    echo " expected: $expected" >&2
    echo " actual:   $actual" >&2
    exit 1
  fi
  echo "SHA-256 verified."
else
  sha256sum "$TMP_ZIP" | tee "$EXPECTED_SHA_FILE"
fi

rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"
unzip -o "$TMP_ZIP" -d "$DEST_DIR" >/dev/null
chmod +x "$DEST_DIR/DiscordChatExporter.Cli"

"$DEST_DIR/DiscordChatExporter.Cli" --version
echo "Installed: $DEST_DIR/DiscordChatExporter.Cli"
echo "Next: copy config/example.env → tools/dizzy/.env and config/channels.example.json → config/channels.json"
