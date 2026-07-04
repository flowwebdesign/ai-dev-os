# Fixture vs Live

## Purpose

Prevent fixture, demo, local mock, or cached success from being reported as live success.

## Problems It Prevents

- Reporting mock provider output as real provider behavior.
- Reporting fixture data as live runtime data.
- Confusing `auto` mode with a known mode.
- Calling paid providers without cost flags, budget, and ledger path.
- Reusing cached output as fresh proof.

## When To Use It

Use this pet for AI, search, TTS, embeddings, scraping, email, payment, live APIs, fixture-backed tests, provider toggles, demo modes, and any lane with paid or external provider risk.

## Required Preflight Checks

- Name mode: fixture, live, auto, mock provider, real provider, or unknown.
- Name provider.
- Name cost flags and budget requirement.
- Name cache policy.
- Name ledger or run-card location.
- Confirm target runtime.

## Required Evidence

- Configuration or runtime evidence for mode.
- Provider identity.
- Cost/budget approval or explicit no-cost proof.
- Ledger/run-card path.
- Call evidence without secrets.
- Persisted output and readback when behavior is claimed.
- Quality check when generated output is user-facing.

## Required Verification

Verify mode before provider calls. If mode is `auto`, prove what it resolved to before claiming fixture or live behavior.

## Stop Conditions

- Mode is unknown.
- Provider is unknown.
- Cost flags or budget are missing for paid calls.
- Ledger/run-card location is missing for real provider proof.
- The lane would expose secrets in logs, reports, or artifacts.

## What It Must Never Claim

- Do not claim live success from fixture, demo, mock, or cached output.
- Do not claim real provider proof when mode is `auto` but unresolved.
- Do not claim provider success without cost/budget/ledger context.
- Do not include secrets in evidence.

## Future Hook Ideas

Hooks may later block or warn on provider calls without mode, budget, and ledger markers. No active hooks are implemented in this pet.

