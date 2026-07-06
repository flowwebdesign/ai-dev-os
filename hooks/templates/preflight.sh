#!/usr/bin/env sh
set -eu

EXPECTED_REMOTE="${1:-}"

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  echo "STOP no git repo"
  exit 1
fi

ROOT="$(git rev-parse --show-toplevel)"
BRANCH="$(git branch --show-current 2>/dev/null || true)"
REMOTE="$(git remote get-url origin 2>/dev/null || true)"
DIRTY="$(git status --short)"

if [ -n "$EXPECTED_REMOTE" ] && [ "$REMOTE" != "$EXPECTED_REMOTE" ]; then
  echo "STOP wrong remote: $REMOTE"
  exit 1
fi

if [ -z "$BRANCH" ]; then
  echo "STOP unknown branch"
  exit 1
fi

if [ -n "$DIRTY" ]; then
  echo "WARN dirty tree"
  printf '%s\n' "$DIRTY"
else
  echo "PASS clean tracked tree"
fi

echo "PASS repo=$ROOT"
echo "PASS branch=$BRANCH"
echo "PASS remote=$REMOTE"
