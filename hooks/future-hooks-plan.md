# Future Hooks Plan

## Phase 1: Command Warnings

- warn on unbounded recursive listings
- warn on raw generated-file reads
- warn on full logs without tail/limit
- warn on raw git diff/log commands

## Phase 2: Lane Gates

- require repo, branch, dirty-tree, runtime, identity, provider mode, scope, and stop condition before edits
- require proof label in final report for non-trivial work
- require release ledger entry for release lanes

## Phase 3: Project-Aware Enforcement

- read `.ai-dev/PROJECT_RULES.md`
- check `.ai-dev/BRANCH_REGISTRY.json`
- check `.ai-dev/DEPLOY_SOURCE_MAP.md`
- block production mutation without explicit approval marker

## Non-Goals

- hiding output that is needed for debugging
- replacing code review
- silently rewriting destructive commands
