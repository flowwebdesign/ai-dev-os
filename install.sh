#!/usr/bin/env sh
set -eu

TARGET_DIR="${1:-.}"
AI_DEV_DIR="$TARGET_DIR/.ai-dev"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

mkdir -p "$AI_DEV_DIR"

copy_if_missing() {
  src="$1"
  dest="$2"
  if [ -e "$dest" ]; then
    echo "skip existing $dest"
  else
    cp "$src" "$dest"
    echo "create $dest"
  fi
}

copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROJECT_CONTEXT.md" "$AI_DEV_DIR/PROJECT_CONTEXT.md"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROJECT_RULES.md" "$AI_DEV_DIR/PROJECT_RULES.md"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/ACTIVE_STATE.md" "$AI_DEV_DIR/ACTIVE_STATE.md"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROOF_REQUIREMENTS.md" "$AI_DEV_DIR/PROOF_REQUIREMENTS.md"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/RELEASE_LEDGER.jsonl" "$AI_DEV_DIR/RELEASE_LEDGER.jsonl"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/RUN_CARD.template.json" "$AI_DEV_DIR/RUN_CARD.template.json"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/BRANCH_REGISTRY.json" "$AI_DEV_DIR/BRANCH_REGISTRY.json"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/DEPLOY_SOURCE_MAP.md" "$AI_DEV_DIR/DEPLOY_SOURCE_MAP.md"
copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/REQUIRED_FOR_RC.md" "$AI_DEV_DIR/REQUIRED_FOR_RC.md"

echo "AI Dev OS project files installed in $AI_DEV_DIR"
