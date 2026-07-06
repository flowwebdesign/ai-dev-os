# Release Ledger Skill

Portable skill package/template for release traceability.

## When To Use

Use when work affects a release candidate, deployment, production behavior, or rollback decision.

## Inputs

- Release candidate ID.
- Branch, commit, and source remote.
- Target environment.
- Required proof.
- Run card or evidence folder.

## Steps

1. Prove repo, branch, commit, remote, and dirty state.
2. Identify target environment and deploy source.
3. Read release requirements and proof requirements.
4. Write or validate a run card.
5. Append a release ledger entry only when the project policy says this run belongs in the project ledger.
6. If not appending, create an example or explain why.

## Output Format

```text
Release ledger:
- rc id:
- source:
- target:
- proof:
- ledger action:
- evidence:
- risk:
```

## Stop Conditions

- Missing RC ID for release-relevant work.
- Deploy source cannot be traced to a commit.
- Required proof is not verified or explicitly waived.

## Example

```text
Release ledger:
- rc id: rc-2026-07-06-1
- source: feature/fix-login@abc123
- target: staging
- proof: build and browser smoke verified
- ledger action: appended
```
