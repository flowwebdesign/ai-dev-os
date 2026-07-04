# Release Handoff Prompt

Create a release-ready handoff with traceability.

Include:

- repo path, remote, branch, commit, dirty-tree state
- target environment and deployment source identity
- provider/env mode
- release candidate ID
- changed files
- checks run and results
- verified claims
- partial/smoke-only claims
- not-run checks
- blockers
- rollback/recovery note
- release ledger entry or exact reason it was not written
- next smallest lane

Do not call an RC ready unless every required gate is either verified or explicitly waived by a human.
