# AI Memory Index

Load the index first. Load deeper files only when the task classifier, proof requirement, or active risk points to them.

## Read Order

1. This file.
2. `PROJECT_CONTEXT.md` for project identity and setup.
3. `ACTIVE_STATE.md` for current lane pointers.
4. `PROOF_REQUIREMENTS.md` for claim-specific proof.
5. Task-specific files listed below.

## Project Identity

- Project name:
- Canonical repo:
- Default branch:
- Product owner:

## Ownership Map

| Area | Owner | Escalation |
| --- | --- | --- |
| Product |  |  |
| Engineering |  |  |
| Operations |  |  |

## Runtime Map

| Target | Command or URL | Auth/Identity | Provider Mode |
| --- | --- | --- | --- |
| local |  |  |  |
| staging |  |  |  |
| production |  |  |  |

## Current Active State

- Active branch:
- Runtime target:
- Dirty-tree note:
- Current lane:
- Stop condition:

## Proof Boundaries

- Source:
- API/network:
- Persisted state:
- Reload/readback:
- User-visible state:

## Fast Stop Conditions

- Wrong repo, remote, branch, or worktree.
- Unknown runtime target.
- Unknown identity/auth state for writes.
- Unknown provider or cost mode for paid calls.
- Missing proof boundary for the requested claim.
- Release-relevant work without traceability.

## Deeper Files To Load By Task

| Task | Load |
| --- | --- |
| Coding or config change | `PROJECT_RULES.md`, `PROOF_REQUIREMENTS.md` |
| Runtime or deployment work | `DEPLOY_SOURCE_MAP.md`, `RELEASE_LEDGER.jsonl` |
| Release candidate work | `REQUIRED_FOR_RC.md`, `RUN_CARD.template.json` |
| Handoff or resume | `ACTIVE_STATE.md`, latest run folder |
| Planning | `PROJECT_CONTEXT.md`, `NEXT_ACTIONS.md` |
| Risk review | `RISKS.md`, `PROGRESS_LOG.md` |

## Last Updated

- Date:
- Updated by:
- Reason:
