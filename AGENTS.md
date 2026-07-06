# Global Agent Rules

Use these rules when working in this repository or when copying this control system into another project.

## Start Every Lane With Current Truth

Before editing code, running broad tests, touching deployments, or using paid providers, prove:

- current repo path and intended project
- current branch and compact dirty-tree status
- target runtime: local, hosted, staging, or production
- identity/auth state for UI or API writes
- provider/cost mode for AI, search, TTS, embeddings, scraping, or paid APIs
- exact scope and stop condition

If `.ai-dev/AI_MEMORY_INDEX.md` exists, read it before deeper project files.

Load the index first. Load deeper files only when the task classifier, proof requirement, or active risk points to them.

If any boundary is wrong or unclear, stop the lane and report the first failing boundary.

## Command Hygiene

- Prefer compact command wrappers such as RTK when available.
- Avoid unbounded logs, recursive listings, generated files, lockfiles, build output, `.next`, `dist`, and `node_modules`.
- Never run destructive commands such as reset, clean, delete, push, deploy, or production mutation without explicit approval.
- Inspect the smallest relevant files before editing.

## Scope Discipline

- Preserve existing repo content and user work.
- Make the smallest safe change that proves the current claim.
- Do not bundle adjacent fixes into the lane unless they are required to unblock the stated scope.
- Classify the task before editing and map proof before claiming success.
- Do not treat stale summaries, old handoffs, screenshots, or green tests as complete truth by themselves.

## Proof Standard

A claim is verified only when the relevant boundary has been checked:

- user or agent action
- API/network boundary
- persisted state
- reload/readback
- user-visible state

Record what passed, what failed, what was partial, and what was not run.

Stop on wrong repo, wrong branch, unknown runtime, unknown provider/cost mode, missing proof boundary, or missing release traceability when release-relevant.

## Reporting

Final reports must separate:

- verified
- partial or smoke only
- not run
- blocked
- changed files
- tests/checks run
- assumptions
- skipped checks
- risks
- next smallest lane
