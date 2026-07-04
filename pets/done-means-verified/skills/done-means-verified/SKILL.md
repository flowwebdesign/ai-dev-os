# Done Means Verified Skill

Use this skill before producing a final report or claiming completion.

## Goal

Ensure every completion claim is backed by evidence that matches the claim boundary.

## Steps

1. State the exact claim.
2. Classify the claim as documentation-only, unit-tested source, build/typecheck, browser, extension, provider, hosted runtime, or release.
3. Read project proof requirements if present.
4. List evidence collected.
5. Label the evidence as `verified`, `partial`, `smoke`, `not_run`, or `blocked`.
6. List what is not proven.
7. Name the next smallest verification if proof is incomplete.

## Output

```text
Claim:
Claim class:
Evidence collected:
Proof label:
Not proven:
Risk:
Next smallest verification:
```

Stop if the required proof would need unapproved destructive action, production mutation, provider cost, or global configuration changes.

