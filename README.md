# AI Dev OS

Reusable operating rules, templates, skills, agent roles, practical hook templates, and a minimal MCP starter for AI-assisted software development.

This repo is project-agnostic. It exists to make agents prove the basics before changing code, keep scope tight, map claims to evidence, and hand off work without turning stale summaries into truth.

## What This Contains

- `core/` - portable rules for truth, proof, release traceability, handoff quality, escalation, and known failure patterns.
- `templates/project/.ai-dev/` - files to copy into any product repo to describe the current project, active runtime state, token-light memory index, proof requirements, branches, deployments, and release ledger.
- `templates/codex/` and `templates/codex-home/` - reusable Codex project instructions, global bootstrap, and prompt starters for common lanes.
- `skills/` - portable skill package/templates for truth gates, proof mapping, scope control, release traceability, project memory, and handoff writing.
- `agents/` - role profiles for explorer, worker, reviewer, proof checker, and scribe agents.
- `mcp/` and `hooks/` - runnable starter scripts and documented integration points for enforcement and project-state tooling.
- `project-management/` - templates for active state, decisions, risks, progress, reviews, and run cards.
- `course/` and `learning-log/` - learning material that explains the system while it is built.
- `rules/` - compact default rules that can be imported into agent systems.
- `scripts/` - lightweight checks for installed project templates.

## First Use In A Project

1. Run `./install.sh /path/to/project` or `.\install.ps1 -TargetDir C:\path\to\project`.
2. Read `.ai-dev/AI_MEMORY_INDEX.md` first, then fill in `.ai-dev/PROJECT_CONTEXT.md` and `.ai-dev/ACTIVE_STATE.md`.
3. Add `.ai-dev/PROOF_REQUIREMENTS.md` entries for the app's real proof boundaries.
4. Add or adapt the Codex instructions from `templates/codex/AGENTS.md`.
5. Use `core/TASK_CLASSIFIER.md` before starting work and `core/PROOF_MATRIX.md` before claiming success.
6. Run `ai-dev-os check /path/to/project` after global install, or `scripts/ai-dev-os-check.sh /path/to/project` from this repo.

## CLI

After global install, use:

```sh
~/.ai-dev-os/bin/ai-dev-os init /path/to/project
~/.ai-dev-os/bin/ai-dev-os check /path/to/project
~/.ai-dev-os/bin/ai-dev-os doctor /path/to/project
```

`attach` is an alias for `init`.

`init` and `attach` also accept `--profile <name>` and `--detect`:

```sh
ai-dev-os init --profile serious --detect /path/to/project
```

## Codex Home Bootstrap

Install a short global Codex instruction file with:

```sh
./install.sh --install-codex-home
```

PowerShell:

```powershell
.\install.ps1 -InstallCodexHome
```

The installers create `~/.ai-dev-os` with the CLI and checkers, create `~/.codex` if missing, and copy `templates/codex-home/AGENTS.md` to `~/.codex/AGENTS.md`. Existing Codex AGENTS files are skipped unless `--force` or `-Force` is supplied; forced installs create a backup first.

## Non-Negotiable Pattern

Every lane starts by proving:

- correct repo, branch, worktree, and dirty-tree state
- correct target runtime: local, hosted, staging, or production
- correct identity/auth state for UI or API writes
- provider and cost mode for paid AI/search/TTS/embedding calls
- exact scope and stop condition

Every meaningful claim needs evidence across the relevant boundary: action, API or network, persisted state, reload or readback, and user-visible result.

## Status

This is now a working bootstrap. Hooks are safe standalone scripts that can be run manually while exact Codex hook integration remains version-dependent. The MCP project-state server is a minimal TypeScript starter that can be installed later. Skills are portable skill package/templates unless local Codex documentation proves an auto-load location for a specific environment.
