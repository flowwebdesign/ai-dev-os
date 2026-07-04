# Proof Mapper Skill

Use this skill when a claim needs to be turned into concrete evidence requirements.

## Goal

Prevent weak proof from being reported as full success.

## Steps

1. Write the exact claim.
2. Classify the claim: source, API, UI, auth, extension, provider, hosted, or release.
3. Read `.ai-dev/PROOF_REQUIREMENTS.md` if present.
4. Map the claim to required evidence:
   - action
   - API/network boundary
   - persisted state
   - reload/readback
   - user-visible state
5. Label the current evidence as `verified`, `partial`, `smoke`, `not_run`, or `blocked`.

## Output

```text
Claim:
Required proof:
Evidence collected:
Label:
Gap:
Next smallest proof:
```
