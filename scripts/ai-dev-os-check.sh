#!/usr/bin/env sh
set -eu

TARGET_DIR="${1:-.}"
AI_DEV_DIR="$TARGET_DIR/.ai-dev"
STOP=0
WARN=0

check_file() {
  file="$1"
  if [ -s "$AI_DEV_DIR/$file" ]; then
    echo "PASS .ai-dev/$file"
  else
    echo "STOP missing .ai-dev/$file"
    STOP=1
  fi
}

inside_work_tree="$(git -C "$TARGET_DIR" rev-parse --is-inside-work-tree 2>/dev/null || true)"
if [ "$inside_work_tree" != "true" ]; then
  echo "STOP git repo not found at $TARGET_DIR"
  STOP=1
else
  echo "PASS git repo found"
  remote="$(git -C "$TARGET_DIR" remote get-url origin 2>/dev/null || true)"
  branch="$(git -C "$TARGET_DIR" branch --show-current 2>/dev/null || true)"
  if [ -z "$remote" ]; then
    echo "WARN origin remote missing"
    remote="none"
    WARN=1
  fi
  if [ -z "$branch" ]; then
    echo "WARN branch is detached or unknown"
    branch="detached"
    WARN=1
  fi
  echo "INFO remote=$remote"
  echo "INFO branch=$branch"
  dirty="$(git -C "$TARGET_DIR" status --short 2>/dev/null || true)"
  if [ -n "$dirty" ]; then
    echo "WARN dirty tree"
    printf '%s\n' "$dirty"
    WARN=1
  else
    echo "PASS clean working tree"
  fi
fi

check_file "AI_MEMORY_INDEX.md"
check_file "PROJECT_CONTEXT.md"
check_file "ACTIVE_STATE.md"
check_file "PROOF_REQUIREMENTS.md"
check_file "RELEASE_LEDGER.jsonl"

if [ -s "$AI_DEV_DIR/PROOF_MATRIX.md" ]; then
  echo "PASS .ai-dev/PROOF_MATRIX.md"
else
  echo "WARN proof matrix missing"
  WARN=1
fi

if [ "$STOP" -eq 1 ]; then
  echo "SUMMARY STOP"
  exit 1
fi

if [ "$WARN" -eq 1 ]; then
  echo "SUMMARY WARN"
else
  echo "SUMMARY PASS"
fi
