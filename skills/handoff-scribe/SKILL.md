# Handoff Scribe Skill

Portable skill package/template for creating a truthful handoff.

## When To Use

Use when another agent, another chat, or a later lane must continue from the current work.

## Inputs

- Repo path, remote, branch, commit, and dirty-tree state.
- Runtime target, identity/auth state, and provider/cost mode.
- Changed files and reason for each change.
- Checks run and evidence locations.
- Open risks, blockers, and next action.

## Steps

1. Gather current repo evidence.
2. Gather runtime, identity/auth, and provider/cost state.
3. List changed files and why they changed.
4. List checks run with exact commands and results.
5. Separate verified, partial/smoke only, not run, and blocked.
6. Name evidence paths, URLs, run cards, or logs.
7. Name the next smallest lane.

## Output Format

```text
Repo:
Branch:
Commit:
Dirty tree:
Runtime target:
Identity/provider mode:
Scope:

Changed files:
Checks run:

Verified:
Partial/smoke only:
Not run:
Blocked:

Evidence:
Next smallest lane:
```

## Stop Conditions

- Current repo or branch cannot be proven.
- Dirty changes would make ownership ambiguous.
- Evidence location is missing for a release-relevant claim.

## Example

```text
Repo: /work/client-app
Branch: feature/fix-login
Changed files: src/login.ts - redirect target fixed.
Checks run: npm test -- login passed.
Verified: unit-level redirect behavior.
Not run: browser login flow.
Next smallest lane: verify hosted login in staging.
```
