# Correct Runtime

## Purpose

Prevent work and proof from attaching to the wrong repo, branch, process, port, stale app, or runtime.

## Problems It Prevents

- Editing one checkout while testing another.
- Testing a stale process after source changes.
- Confusing localhost, hosted, staging, and production.
- Using the wrong port or browser profile.
- Hardcoding personal paths that do not travel across machines.

## When To Use It

Use this pet before runtime claims, browser proof, API proof, extension proof, deployment checks, or any lane where the target environment matters.

## Required Preflight Checks

- Confirm repo path, remote, branch, commit, and dirty-tree state.
- Name runtime target: local, hosted, staging, production, WSL, server, or other.
- Prove the process or deployment source where possible.
- Prove the port, URL, route, or endpoint being tested.
- Prove identity/auth state before writes.
- Prefer repo-relative checks and avoid hardcoded personal paths.

## Required Evidence

- Repo evidence: path, branch, commit, dirty-tree state.
- Runtime evidence: process, command, URL, port, deployment revision, or source map.
- Freshness evidence: restart/reload/readback where stale runtime is possible.
- Identity evidence: active user, role, tenant, or explicit not-needed note.
- Platform evidence: Linux, Windows, WSL, or server constraints named.

## Required Verification

Verify that the tested runtime corresponds to the source and scope being claimed. If only a smoke check was possible, label it `smoke` or `partial`.

## Stop Conditions

- Repo or branch is wrong.
- Runtime target is not named.
- Port, URL, or route cannot be proven.
- The running app may be stale and cannot be refreshed safely.
- The lane would mutate production without explicit approval.

## What It Must Never Claim

- Do not claim hosted proof from localhost.
- Do not claim production proof from staging.
- Do not claim current-source proof from an unknown running process.
- Do not claim identity-sensitive behavior without identity proof.

## Cross-Platform Notes

- Linux: prefer repo-relative shell checks and explicit local URLs.
- Windows: use PowerShell-safe path wording and avoid POSIX assumptions unless proven.
- WSL: name whether the repo, process, browser, and extension are WSL-side or Windows-side.
- Server: label browser and extension proof as `not_run` or `blocked` unless a headless path is available.

## Future Hook Ideas

Hooks may later warn on localhost/hosted mismatches, production mutation wording, stale process risk, or missing runtime target. No active hooks are implemented in this pet.

