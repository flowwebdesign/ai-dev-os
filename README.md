# AI Dev OS

Reusable operating rules, templates, skills, agent roles, and future hook/MCP plans for AI-assisted software development.

This repo is project-agnostic. It exists to make agents prove the basics before changing code, keep scope tight, map claims to evidence, and hand off work without turning stale summaries into truth.

## What This Contains

- `core/` - portable rules for truth, proof, release traceability, handoff quality, escalation, and known failure patterns.
- `templates/project/.ai-dev/` - files to copy into any product repo to describe the current project, active runtime state, proof requirements, branches, deployments, and release ledger.
- `templates/codex/` - reusable Codex instructions and prompt starters for common lanes.
- `skills/` - starter skill definitions for truth gates, proof mapping, and handoff writing.
- `agents/` - role profiles for explorer, worker, reviewer, proof checker, and scribe agents.
- `mcp/` and `hooks/` - placeholders for later enforcement and project-state tooling.
- `rules/` - compact default rules that can be imported into agent systems.

## First Use In A Project

1. Copy `templates/project/.ai-dev/` into the target repo.
2. Fill in `.ai-dev/PROJECT_CONTEXT.md` and `.ai-dev/ACTIVE_STATE.md`.
3. Add `.ai-dev/PROOF_REQUIREMENTS.md` entries for the app's real proof boundaries.
4. Add or adapt the Codex instructions from `templates/codex/AGENTS.md`.
5. Use `core/TASK_CLASSIFIER.md` before starting work and `core/PROOF_MATRIX.md` before claiming success.

## Non-Negotiable Pattern

Every lane starts by proving:

- correct repo, branch, worktree, and dirty-tree state
- correct target runtime: local, hosted, staging, or production
- correct identity/auth state for UI or API writes
- provider and cost mode for paid AI/search/TTS/embedding calls
- exact scope and stop condition

Every meaningful claim needs evidence across the relevant boundary: action, API or network, persisted state, reload or readback, and user-visible result.

## Status

This is a first usable bootstrap. The hooks and MCP server are planned as future enforcement layers; today's value is the portable structure, templates, rules, and proof language.
