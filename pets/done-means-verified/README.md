# Done Means Verified

## Purpose

Prevent claiming completion without verification that matches the work performed.

## Problems It Prevents

- Reporting "done" after editing files but before running checks.
- Treating a unit test as full browser or runtime proof.
- Treating a build or typecheck as proof of user-visible behavior.
- Treating documentation-only review as implementation proof.
- Omitting a "not proven" section when verification is incomplete.

## When To Use It

Use this pet for every lane that changes source, docs, templates, prompts, config, runtime behavior, providers, browser flows, extensions, or release state.

## Required Preflight Checks

- Confirm repo path, branch, commit, and dirty-tree state.
- Classify the lane: documentation-only, unit-tested code, build/typecheck, browser proof, provider proof, extension proof, or release proof.
- Read project proof requirements if present.
- Name the exact claim that would be true when the lane is complete.
- Name the smallest relevant verification for that claim.

## Required Evidence

- Documentation-only: changed files read back, links/paths recorded, and no runtime claim made.
- Unit tests: exact test command and result, with scope tied to changed behavior.
- Build/typecheck: exact command and result, with limits stated.
- Browser proof: browser action, route/visible state, relevant network or persistence boundary, and reload/readback when needed.
- Provider proof: provider mode, budget/cost flags, call evidence, persisted output, and readback or quality check.
- Release proof: source identity, deploy/source map, required checks, ledger/run-card evidence, blockers, and rollback note.

## Required Verification

Label each claim as `verified`, `partial`, `smoke`, `not_run`, or `blocked`.

Every final report must include:

- Changed files.
- Checks run.
- Verified claims.
- Partial or smoke-only claims.
- Not proven claims.
- Blocked claims.
- Risks.
- Next smallest lane.

## Stop Conditions

- The required proof boundary is unclear.
- The repo, branch, runtime, identity, or provider mode is not proven.
- A requested verification would require destructive action or unapproved external mutation.
- The only available evidence is stale, pasted, or unrelated.

## What It Must Never Claim

- Do not claim implementation success from documentation-only edits.
- Do not claim browser behavior from unit tests alone.
- Do not claim provider/live success from mocked or cached output.
- Do not claim release readiness without ledger/source/proof traceability.
- Do not hide incomplete verification; use a `not proven` section.

## Future Hook Ideas

Hooks may later warn when a final report uses completion language without checks, proof labels, or a `not proven` section. No active hooks are implemented in this pet.

