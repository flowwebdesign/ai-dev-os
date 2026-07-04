# Core Rules

These rules apply to any project using AI Dev OS.

## 1. Prove The Basics First

Start every non-trivial lane by proving the current repo, branch, dirty-tree state, runtime target, identity/auth state, provider/cost mode, scope, and stop condition.

Do not edit until the lane is attached to the correct project and target.

## 2. Current Truth Beats Memory

Use previous notes and handoffs as pointers, not facts. Verify claims against the current repo, runtime, API, database, browser, or deployment before acting on them.

## 3. One Change, One Proof

Make the smallest safe change, then run the smallest relevant check that proves or falsifies it. Keep the lane narrow until the boundary is proven or blocked.

## 4. Real Behaviour Needs Real Proof

Unit tests, API tests, jsdom tests, screenshots, logs, and page loads are useful signals. They are not complete proof unless they cover the relevant user-facing or persisted boundary.

## 5. Provider And Runtime Modes Must Not Drift

Never mix local and hosted targets, mock and real providers, or staging and production writes by accident. Name the active mode before making calls.

## 6. Preserve User Work

Do not overwrite, revert, reset, delete, or reformat unrelated user changes. If unrelated dirty files exist, route around them.

## 7. Escalate On First Unsafe Boundary

Stop and report when a lane hits a wrong repo, wrong browser profile, mismatched session, hidden disabled control, unexpected provider call, missing deployment identity, or production mutation risk.

## 8. Reports Must Be Claim-Aware

Separate verified, partial, not run, blocked, changed files, checks run, and next smallest lane. Do not report broad success from narrow evidence.
