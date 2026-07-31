#!/usr/bin/env sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
TARGET_DIR="."
INSTALL_GLOBAL=0
INSTALL_CODEX_HOME=0
PROJECT=0
FORCE=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --global)
      INSTALL_GLOBAL=1
      INSTALL_CODEX_HOME=1
      ;;
    --install-codex-home)
      INSTALL_GLOBAL=1
      INSTALL_CODEX_HOME=1
      ;;
    --project)
      PROJECT=1
      ;;
    --force)
      FORCE=1
      ;;
    --help|-h)
      echo "Usage: ./install.sh [target-dir] [--install-codex-home|--global] [--project] [--force]"
      echo "Default: install global CLI and Codex home bootstrap only."
      echo "  --install-codex-home  Install \$HOME/.ai-dev-os and install or preserve \$HOME/.codex/AGENTS.md."
      echo "  --global              Alias for global install and Codex home bootstrap."
      echo "  --project             Install .ai-dev project files into target-dir."
      echo "  --force               Backup and replace existing Codex AGENTS.md."
      echo "Examples:"
      echo "  ./install.sh --install-codex-home"
      echo "  ./install.sh --install-codex-home --force"
      echo "  ./install.sh --project /path/to/project"
      echo "  ai-dev-os init --profile serious --detect /path/to/project"
      exit 0
      ;;
    *)
      TARGET_DIR="$1"
      ;;
  esac
  shift
done

if [ "$INSTALL_GLOBAL" -eq 0 ] && [ "$INSTALL_CODEX_HOME" -eq 0 ] && [ "$PROJECT" -eq 0 ]; then
  INSTALL_GLOBAL=1
  INSTALL_CODEX_HOME=1
fi

if [ "$PROJECT" -eq 1 ] && [ ! -d "$TARGET_DIR" ]; then
  echo "Target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

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

copy_with_optional_force() {
  src="$1"
  dest="$2"
  if [ -e "$dest" ]; then
    if [ "$FORCE" -ne 1 ]; then
      echo "skip existing $dest"
      return
    fi
    backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
    cp "$dest" "$backup"
    echo "backup $backup"
  fi
  cp "$src" "$dest"
  echo "create $dest"
}

if [ "$INSTALL_GLOBAL" -eq 1 ]; then
  echo "GLOBAL INSTALL"
  AI_DEV_OS_HOME="${AI_DEV_OS_HOME:-$HOME/.ai-dev-os}"
  mkdir -p "$AI_DEV_OS_HOME/bin"
  cp "$SCRIPT_DIR/bin/ai-dev-os" "$AI_DEV_OS_HOME/bin/ai-dev-os"
  cp "$SCRIPT_DIR/bin/ai-dev-os.ps1" "$AI_DEV_OS_HOME/bin/ai-dev-os.ps1"
  cp "$SCRIPT_DIR/scripts/ai-dev-os-check.sh" "$AI_DEV_OS_HOME/bin/ai-dev-os-check.sh"
  cp "$SCRIPT_DIR/scripts/ai-dev-os-check.ps1" "$AI_DEV_OS_HOME/bin/ai-dev-os-check.ps1"
  if [ "$SCRIPT_DIR" != "$AI_DEV_OS_HOME" ]; then
    cp "$SCRIPT_DIR/install.sh" "$AI_DEV_OS_HOME/install.sh"
    cp "$SCRIPT_DIR/install.ps1" "$AI_DEV_OS_HOME/install.ps1"
    mkdir -p "$AI_DEV_OS_HOME/templates" "$AI_DEV_OS_HOME/project-management"
    cp -R "$SCRIPT_DIR/templates/." "$AI_DEV_OS_HOME/templates/"
    cp -R "$SCRIPT_DIR/project-management/." "$AI_DEV_OS_HOME/project-management/"
  fi
  chmod +x "$AI_DEV_OS_HOME/bin/ai-dev-os" "$AI_DEV_OS_HOME/bin/ai-dev-os-check.sh" "$AI_DEV_OS_HOME/install.sh"
  VERSION_VALUE="$(git -C "$SCRIPT_DIR" rev-parse --short HEAD 2>/dev/null || printf unknown)"
  printf '%s\n' "$VERSION_VALUE" > "$AI_DEV_OS_HOME/VERSION"
  printf '{\n  "name": "ai-dev-os",\n  "version": "%s",\n  "installed_from": "%s"\n}\n' "$VERSION_VALUE" "$SCRIPT_DIR" > "$AI_DEV_OS_HOME/manifest.json"
  echo "AI Dev OS global files installed in $AI_DEV_OS_HOME"
fi

if [ "$INSTALL_CODEX_HOME" -eq 1 ]; then
  echo "CODEX HOME INSTALL"
  CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
  mkdir -p "$CODEX_HOME_DIR"
  copy_with_optional_force "$SCRIPT_DIR/templates/codex-home/AGENTS.md" "$CODEX_HOME_DIR/AGENTS.md"
  echo "Codex Home Bootstrap installed in $CODEX_HOME_DIR"
fi

if [ "$PROJECT" -eq 1 ]; then
  echo "PROJECT INIT"
  AI_DEV_DIR="$TARGET_DIR/.ai-dev"
  mkdir -p "$AI_DEV_DIR"

  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/AI_MEMORY_INDEX.md" "$AI_DEV_DIR/AI_MEMORY_INDEX.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROJECT_CONTEXT.md" "$AI_DEV_DIR/PROJECT_CONTEXT.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROJECT_RULES.md" "$AI_DEV_DIR/PROJECT_RULES.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/ACTIVE_STATE.md" "$AI_DEV_DIR/ACTIVE_STATE.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROOF_REQUIREMENTS.md" "$AI_DEV_DIR/PROOF_REQUIREMENTS.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/PROOF_MATRIX.md" "$AI_DEV_DIR/PROOF_MATRIX.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/RELEASE_LEDGER.jsonl" "$AI_DEV_DIR/RELEASE_LEDGER.jsonl"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/RUN_CARD.template.json" "$AI_DEV_DIR/RUN_CARD.template.json"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/BRANCH_REGISTRY.json" "$AI_DEV_DIR/BRANCH_REGISTRY.json"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/DEPLOY_SOURCE_MAP.md" "$AI_DEV_DIR/DEPLOY_SOURCE_MAP.md"
  copy_if_missing "$SCRIPT_DIR/templates/project/.ai-dev/REQUIRED_FOR_RC.md" "$AI_DEV_DIR/REQUIRED_FOR_RC.md"
  copy_if_missing "$SCRIPT_DIR/project-management/templates/NEXT_ACTIONS.md" "$AI_DEV_DIR/NEXT_ACTIONS.md"
  copy_if_missing "$SCRIPT_DIR/project-management/templates/DECISIONS.md" "$AI_DEV_DIR/DECISIONS.md"
  copy_if_missing "$SCRIPT_DIR/project-management/templates/RISKS.md" "$AI_DEV_DIR/RISKS.md"
  copy_if_missing "$SCRIPT_DIR/project-management/templates/PROGRESS_LOG.md" "$AI_DEV_DIR/PROGRESS_LOG.md"
  copy_if_missing "$SCRIPT_DIR/project-management/templates/WEEKLY_REVIEW.md" "$AI_DEV_DIR/WEEKLY_REVIEW.md"
  copy_if_missing "$SCRIPT_DIR/project-management/templates/RUN_CARD.schema.json" "$AI_DEV_DIR/RUN_CARD.schema.json"

  echo "AI Dev OS project files installed in $AI_DEV_DIR"
  echo "Run scripts/ai-dev-os-check.sh $TARGET_DIR to verify required project files."
else
  echo "PROJECT INIT skipped. Pass --project to create .ai-dev files."
fi

echo "Next steps:"
echo 'export PATH="$HOME/.ai-dev-os/bin:$PATH"'
echo 'ai-dev-os doctor'
echo 'cd /path/to/project'
echo 'ai-dev-os check .'
echo 'ai-dev-os init --profile serious --detect'
