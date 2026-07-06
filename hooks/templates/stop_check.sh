#!/usr/bin/env sh
set -eu

RUN_DIR="${1:-}"

if [ -z "$RUN_DIR" ]; then
  echo "STOP missing run folder"
  exit 1
fi

if [ ! -d "$RUN_DIR" ]; then
  echo "STOP run folder not found: $RUN_DIR"
  exit 1
fi

for file in FINAL_REPORT.md RUN_CARD.json VERIFICATION.txt; do
  if [ ! -s "$RUN_DIR/$file" ]; then
    echo "STOP missing or empty $RUN_DIR/$file"
    exit 1
  fi
done

echo "PASS final report, run card, and verification file exist"
