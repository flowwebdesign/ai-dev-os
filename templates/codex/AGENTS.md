# Codex Project Instructions

Use this file as a project-level `AGENTS.md` starter.

## Lane Start

Before code changes, run compact checks for:

- current path
- git status
- branch
- remote
- target runtime
- identity/auth state for writes
- provider/cost mode for paid calls
- exact scope and stop condition

When `.ai-dev/AI_MEMORY_INDEX.md` exists, read it first.

Load the index first. Load deeper files only when the task classifier, proof requirement, or active risk points to them.

Read `.ai-dev/PROJECT_CONTEXT.md`, `.ai-dev/PROJECT_RULES.md`, `.ai-dev/ACTIVE_STATE.md`, and `.ai-dev/PROOF_REQUIREMENTS.md` only when the index or task points to them.

## Work Protocol

- Preserve user work.
- Classify the task before editing.
- Inspect the smallest relevant files.
- Make one safe change.
- Map proof before claiming success.
- Run the smallest relevant proof.
- Record verified, partial, not run, and blocked.
- Treat stale chats and handoffs as pointers, not truth when current evidence disagrees.

Stop on wrong repo, wrong branch, unknown runtime, unknown provider/cost mode, missing proof boundary, or missing release traceability when release-relevant.

## Final Response

Include proven facts, assumptions, skipped checks, risks, changed files, tests/checks run, and next smallest lane. Do not claim success beyond current proof.
