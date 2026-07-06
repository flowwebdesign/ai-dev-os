# Scope Guard Skill

Portable skill package/template for keeping a lane narrow.

## When To Use

Use when a task could expand into adjacent fixes, refactors, cleanup, or release work.

## Inputs

- User request.
- Current task classifier.
- Dirty-tree state.
- Files expected to change.
- Stop condition.

## Steps

1. Restate the exact requested outcome.
2. Name files or systems likely in scope.
3. Name adjacent work that is explicitly out of scope.
4. Stop before editing if unrelated dirty changes overlap target files.
5. After edits, compare changed files to the expected scope.

## Output Format

```text
Scope:
In:
Out:
Expected changed files:
Actual changed files:
Scope drift:
Next action:
```

## Stop Conditions

- Requested result requires destructive action without approval.
- Required change crosses an ownership boundary not covered by the request.
- Actual changed files include unexplained unrelated work.

## Example

```text
Scope: add memory index template.
In: core contract, project template, docs mention.
Out: changing agent TOML roles.
Scope drift: none.
```
