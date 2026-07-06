# Proof Mapper Skill

Portable skill package/template for turning claims into evidence.

## When To Use

Use whenever a result, fix, deploy, release, or user-visible behavior needs to be claimed.

## Inputs

- Exact claim.
- Task class.
- `.ai-dev/PROOF_REQUIREMENTS.md` when present.
- Current checks, logs, screenshots, API results, persisted state, and readbacks.

## Steps

1. Write the exact claim.
2. Classify the claim: source, API, UI, auth, extension, provider, hosted, release, or documentation.
3. Read proof requirements when present.
4. Map required evidence across action, API/network, persisted state, reload/readback, and user-visible state.
5. Label evidence as `verified`, `partial`, `smoke`, `not_run`, or `blocked`.
6. Name the next smallest proof for every gap.

## Output Format

```text
Claim:
Required proof:
Evidence collected:
Label:
Gap:
Next smallest proof:
```

## Stop Conditions

- Claim is broader than the available evidence.
- Release-relevant work has no run card or release traceability.
- Provider or runtime mode is unknown.

## Example

```text
Claim: Password reset email sends.
Required proof: form submit, API 200, email provider accepted message, user sees confirmation.
Evidence collected: form submit and API 200 only.
Label: partial
Gap: provider acceptance not checked.
Next smallest proof: inspect provider event for test address.
```
