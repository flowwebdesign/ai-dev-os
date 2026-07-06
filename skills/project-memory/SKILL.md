# Project Memory Skill

Portable skill package/template for maintaining token-light project memory.

## When To Use

Use when project identity, runtime map, active state, proof boundaries, risks, or next actions change.

## Inputs

- `.ai-dev/AI_MEMORY_INDEX.md`.
- Relevant deeper `.ai-dev` file for the changed fact.
- Current repo and runtime proof.
- Reason for update.

## Steps

1. Read `.ai-dev/AI_MEMORY_INDEX.md` first.
2. Prove the fact being changed.
3. Load only the deeper file needed for that fact.
4. Update the shortest stable pointer in the index.
5. Update `Last Updated`.
6. Do not store secrets.

## Output Format

```text
Project memory:
- changed sections:
- evidence:
- deeper files read:
- skipped files:
- risk:
```

## Stop Conditions

- Current evidence contradicts the proposed memory update.
- The update would put secrets in project memory.
- The source of truth is unknown.

## Example

```text
Project memory:
- changed sections: Runtime Map, Last Updated
- evidence: local dev server moved to port 4080
- deeper files read: ACTIVE_STATE.md
- risk: staging URL not checked
```
