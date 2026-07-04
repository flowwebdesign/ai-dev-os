# Proof Matrix

Map every claim to the smallest evidence chain that can prove it.

| Claim Type | Minimum Useful Proof | Strong Proof |
| --- | --- | --- |
| Source change compiles | Targeted build or typecheck | Build plus focused runtime smoke |
| API behaviour works | Request/response with expected status and payload | API call, persisted state, reload/readback through user surface |
| UI behaviour works | Browser action and visible result | Browser action, network/API check, persisted state, reload/readback, visible result |
| Auth or identity works | Session state visible for expected user | Action under expected user, server-side identity confirmation, reload/readback |
| Extension works | Correct extension folder and active profile confirmed | Extension action, app bridge/API boundary, page effect, reload/readback |
| Provider integration works | Mode and budget confirmed, one successful call | Ledger entry, provider response, persisted output, quality check, replay/readback |
| Hosted deployment works | Public endpoint responds | Deployment identity, commit/image/source map, env mode, route proof, user-visible proof |
| Release candidate ready | Required checks listed and run | Traceable release ledger, run cards, blocker review, rollback/source map |

## Proof Labels

- `verified` - the relevant evidence chain was checked.
- `partial` - only part of the boundary was checked.
- `smoke` - a quick signal passed but does not prove the full claim.
- `not_run` - no current check was run.
- `blocked` - a specific boundary failed or could not be reached.

## Evidence Rule

When reporting proof, include the command, artifact path, URL, test name, or run card that produced the evidence. If the evidence cannot be rerun, say so.
