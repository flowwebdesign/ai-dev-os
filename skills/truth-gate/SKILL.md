# Truth Gate Skill

Portable skill package/template for starting a lane from current evidence.

## When To Use

Use before non-trivial coding, browser, provider, deployment, release, or project-state work.

## Inputs

- User request and stop condition.
- Repo path, remote, branch, and dirty-tree state.
- `.ai-dev/AI_MEMORY_INDEX.md` when present.
- Runtime, identity/auth, and provider/cost mode.

## Steps

1. Prove repo path, remote, branch, latest commit, and dirty-tree state.
2. Read `.ai-dev/AI_MEMORY_INDEX.md` first when present.
3. Load deeper files only when the task classifier, proof requirement, or active risk points to them.
4. Name target runtime: local, hosted, staging, or production.
5. Name identity/auth state when UI or API writes are involved.
6. Name provider/cost mode when paid services are involved.
7. Name exact scope and stop condition.

## Output Format

```text
Truth gate:
- repo:
- remote:
- branch:
- commit:
- dirty tree:
- runtime target:
- identity/auth:
- provider/cost:
- scope:
- stop condition:
- red flags:
```

## Stop Conditions

- Wrong repo, remote, branch, or worktree.
- Unexplained dirty changes that overlap the task.
- Unknown runtime, identity/auth, or provider/cost mode when relevant.
- Missing proof boundary for the requested claim.

## Example

```text
Truth gate:
- repo: /work/client-app
- remote: github.com/acme/client-app
- branch: feature/fix-login
- dirty tree: tracked files clean, unrelated notes untracked
- runtime target: local
- identity/auth: test admin
- provider/cost: mock email
- scope: fix login redirect
- stop condition: redirect verified after reload
- red flags: none
```
