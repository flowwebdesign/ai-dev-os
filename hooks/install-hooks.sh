#!/usr/bin/env sh
set -eu

TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
DEST="$TARGET_DIR/.ai-dev/hooks"

if [ ! -d "$TARGET_DIR" ]; then
  echo "STOP target directory not found: $TARGET_DIR" >&2
  exit 1
fi

mkdir -p "$DEST"
cp "$SCRIPT_DIR/templates/preflight.sh" "$DEST/preflight.sh"
cp "$SCRIPT_DIR/templates/stop_check.sh" "$DEST/stop_check.sh"
cp "$SCRIPT_DIR/templates/evidence_capture.sh" "$DEST/evidence_capture.sh"
echo "PASS installed hook templates in $DEST"
