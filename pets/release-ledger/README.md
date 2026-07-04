# Release Ledger

## Purpose

Prevent lost state across chats, branches, machines, and Codex lanes.

## Problems It Prevents

- Treating pasted summaries as current truth.
- Losing source identity, branch ownership, or runtime proof between lanes.
- Calling a release ready without a run card or final report.
- Forgetting branch registry, manifest, source map, or ledger context.
- Hiding not-run or blocked checks in broad summaries.

## When To Use It

Use this pet for release candidates, deployments, provider runs, multi-machine handoffs, multi-branch work, and any lane expected to survive chat or machine changes.

## Required Preflight Checks

- Read existing ledger, manifest, branch registry, source map, and run-card templates when present.
- Confirm repo path, remote, branch, commit, and dirty-tree state.
- Confirm runtime target, provider mode, and identity where relevant.
- Reconcile pasted summaries with Git, runtime, and current evidence.
- Name release candidate or run ID if applicable.

## Required Evidence

- Existing ledger or explicit note that none exists.
- Manifest/branch registry/source map when present.
- Run card output.
- Final report output.
- Source identity and runtime identity.
- Checks run and proof labels.
- Not proven, blockers, risks, and next smallest lane.

## Required Verification

Every release or handoff claim must have a run card and final report, or explicitly state why those artifacts were not produced. Ledger entries should be append-only when implemented.

## Stop Conditions

- Existing ledger/source map/branch registry cannot be reconciled.
- Pasted context conflicts with Git or runtime evidence.
- Release source identity is unknown.
- Required checks are not run and no waiver/blocker is recorded.

## What It Must Never Claim

- Do not treat pasted summaries as truth; they are last-known context only.
- Do not rewrite history to make a release look cleaner.
- Do not call an RC ready without run-card/final-report proof and known gaps.
- Do not store secrets in ledgers, run cards, or final reports.

## Future Hook Ideas

Hooks may later warn on release/deploy wording without a run card, source map, ledger event, final report, blockers, and rollback note. No active hooks are implemented in this pet.

