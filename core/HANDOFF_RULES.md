# Handoff Rules

Handoffs should let the next agent restart from current truth, not from vibes.

## Include

- exact repo path
- branch and dirty-tree state at handoff time
- runtime target and identity/provider mode
- files changed
- commands/checks run
- verified claims
- partial/smoke-only claims
- not-run checks
- blockers with first failing boundary
- evidence paths, URLs, run cards, or logs
- next smallest lane

## Avoid

- saying "done" without naming the proof
- using old summaries as current status
- hiding blockers inside broad narrative
- asking the next agent to infer scope from chat history
- mixing wishlist items with verified work

## Template

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
