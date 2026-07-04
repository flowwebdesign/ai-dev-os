# Handoff Scribe Skill

Use this skill when producing a handoff for another agent, another chat, or a later lane.

## Goal

Make the next start fast, truthful, and bounded.

## Steps

1. Gather repo path, remote, branch, commit if available, and dirty-tree state.
2. Gather runtime target, identity/auth state, and provider/cost mode.
3. List changed files and why they changed.
4. List checks run with exact commands and results.
5. Separate verified, partial/smoke only, not run, and blocked.
6. Name evidence paths, URLs, run cards, or logs.
7. Name the next smallest lane.

## Output

```text
Repo:
Branch:
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
