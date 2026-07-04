# Truth Gate Skill

Use this skill before non-trivial coding, browser, provider, deployment, or release work.

## Goal

Attach the lane to current truth before changing anything.

## Steps

1. Prove repo path, remote, branch, and dirty-tree state.
2. Read project context files if present:
   - `.ai-dev/PROJECT_CONTEXT.md`
   - `.ai-dev/PROJECT_RULES.md`
   - `.ai-dev/ACTIVE_STATE.md`
   - `.ai-dev/PROOF_REQUIREMENTS.md`
3. Name target runtime: local, hosted, staging, or production.
4. Name identity/auth state when UI or API writes are involved.
5. Name provider/cost mode when paid services are involved.
6. Name exact scope and stop condition.

## Output

```text
Truth gate:
- repo:
- remote:
- branch:
- dirty tree:
- runtime target:
- identity/auth:
- provider/cost:
- scope:
- stop condition:
- red flags:
```

If a required boundary cannot be proven, stop and report the first failing boundary.
