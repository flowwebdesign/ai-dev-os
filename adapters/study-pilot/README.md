# Study Pilot Adapter Placeholder

This is a placeholder plan for a future project-specific pet pack. It does not touch Study Pilot code and must not be treated as active project truth.

## Future Proof Requirements

Three repo ownership:

- Backend repo: record canonical remote, branch, owner, dirty-tree state, and active lane.
- Dashboard repo: record canonical remote, branch, owner, dirty-tree state, and active lane.
- App bridge / extension repo: record canonical remote, branch, owner, dirty-tree state, and active lane.

Known local ports:

- Backend: `8000`
- Dashboard: `3011`
- App bridge: `3000`

Required proof:

- Extension `appUrl` proof: prove configured app URL, active extension folder, manifest/source identity, and active browser profile.
- Browser route proof for `/en/app`: prove route load, visible state, network/API boundary where relevant, persistence, reload/readback, and identity.
- Fixture/live/provider/cost proof: name fixture, live, auto, mock provider, real provider, cache policy, cost flags, budget, and ledger path.
- Run card / ledger proof: produce a run card and append or cite a ledger event for release/provider/runtime claims.
- Not proven section: every final report must list unproven route, extension, provider, cost, persistence, identity, release, or deployment boundaries.

## Boundaries

- Do not add Study Pilot repo-specific files to global AI Dev OS behavior.
- Do not hardcode personal paths.
- Do not store secrets, tokens, provider keys, browser session details, or account billing data.
- Do not treat pasted summaries as current truth; reconcile them with Git, runtime, and evidence.

