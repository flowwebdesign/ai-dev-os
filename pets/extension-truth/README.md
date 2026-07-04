# Extension Truth

## Purpose

Prevent "extension visible" from being treated as "extension connected and working."

## Problems It Prevents

- Testing the wrong extension folder or stale extension build.
- Using the wrong browser profile.
- Seeing extension UI but not proving app bridge connectivity.
- Missing bootstrap/session state.
- Missing payload-route proof between extension, app, and backend.

## When To Use It

Use this pet for browser extension lanes, content scripts, background/service workers, app bridge behavior, extension-to-app payloads, and extension-configured `appUrl` claims.

## Required Preflight Checks

- Prove extension folder and manifest/source identity.
- Prove active browser profile.
- Prove configured `appUrl`.
- Prove target page URL and route.
- Prove bootstrap/session state before private reads or writes.
- Prove payload route: extension action, bridge/API boundary, app/backend effect, persistence where relevant, and visible result.

## Required Evidence

- Extension folder path and manifest/source identity.
- Browser profile identity or explicit limitation.
- `appUrl` value and target route.
- Bootstrap/session proof.
- Extension action evidence.
- Bridge/API/payload evidence.
- Reload/readback or persisted-state evidence when relevant.
- Visible page effect when user-facing behavior is claimed.

## Required Verification

Verify the chain from extension action to app/backend effect. A visible extension popup alone is not enough. Label incomplete chains as `partial`, `smoke`, `not_run`, or `blocked`.

## Stop Conditions

- Active extension folder cannot be proven.
- Browser profile cannot be proven.
- `appUrl` or target route is unknown.
- Bootstrap/session state is missing for identity-sensitive behavior.
- Payload leaves the extension but no app/API/readback boundary can be checked.

## What It Must Never Claim

- Do not claim extension behavior from extension visibility alone.
- Do not claim app connection without `appUrl` and payload-route proof.
- Do not claim persistence without reload/readback.
- Do not claim private data behavior without session/identity proof.

## Future Hook Ideas

Hooks may later warn on extension claims without manifest, folder, browser profile, `appUrl`, route, and payload evidence. No active hooks are implemented in this pet.

