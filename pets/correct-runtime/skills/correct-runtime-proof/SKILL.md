# Correct Runtime Proof Skill

Use this skill before runtime, browser, API, extension, or deploy proof.

## Goal

Attach the lane to the correct source, process, URL, port, identity, and platform.

## Steps

1. Record repo path, remote, branch, commit, and dirty-tree state.
2. Name the runtime target.
3. Record URL, route, port, process, command, or deployment source.
4. Confirm whether the app may be stale and whether reload/restart is required.
5. Confirm identity/auth state when writes or private data are involved.
6. Name platform constraints for Linux, Windows, WSL, or server.
7. Label unresolved runtime boundaries as `not_run` or `blocked`.

## Output

```text
Repo:
Branch/commit:
Dirty tree:
Runtime target:
URL/port/route:
Process/deploy source:
Freshness proof:
Identity/auth:
Platform constraints:
Not proven:
Stop condition:
```

