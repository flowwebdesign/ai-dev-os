#!/usr/bin/env sh
set -eu

RUN_DIR="${1:-}"
MESSAGE="${2:-}"

if [ -z "$RUN_DIR" ] || [ -z "$MESSAGE" ]; then
  echo "STOP usage: evidence_capture.sh RUN_DIR MESSAGE"
  exit 1
fi

mkdir -p "$RUN_DIR"
LOG="$RUN_DIR/EVIDENCE.log"
STAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
printf '%s %s\n' "$STAMP" "$MESSAGE" >> "$LOG"
echo "PASS appended $LOG"
