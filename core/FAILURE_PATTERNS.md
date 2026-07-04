# Failure Patterns

Use this list as a preflight checklist and a forensic checklist after repeated failures.

## Location And State Drift

- working in the wrong repo, folder, branch, or worktree
- assuming the current checkout matches a stale handoff
- editing a shared dirty checkout when the lane needed isolation
- reading generated output instead of source files

## Runtime Drift

- testing a local page while the requested target is hosted
- calling hosted services from a local-only lane
- calling localhost from a hosted proof lane
- using the wrong route, port, extension folder, or app bridge
- treating a successful page load as proof of the requested workflow

## Identity Drift

- wrong browser profile
- logged-out or expired session
- mismatched user or tenant
- admin-only control tested as a normal user, or the reverse
- write proof without readback under the same identity

## Provider Drift

- mock mode presented as real provider proof
- real paid provider called without budget, ledger, or explicit mode
- generated content accepted without quality/readback checks
- cached provider output mistaken for a fresh run

## Scope Drift

- adjacent refactors bundled into a narrow fix
- release blockers hidden behind broad summaries
- old handoff used as truth instead of a lead
- claims made without exact evidence paths, commands, or artifacts

## Proof Drift

- unit/API/jsdom test treated as full user-facing proof
- screenshot without action/API/persistence/readback chain
- log line without verifying visible state
- reload skipped after save
- database write not checked from the app surface
