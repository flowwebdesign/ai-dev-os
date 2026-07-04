# Release Traceability

Release work must connect source, build, deploy, proof, and rollback.

## Required Release Anchors

- release name or candidate ID
- source repo and branch
- commit SHA or equivalent source identity
- build artifact, image ID, package version, or deploy revision
- target environment
- env/provider mode
- database or migration state
- required checks and proof status
- known blockers and limitations
- rollback or recovery note

## Release Ledger

Use `.ai-dev/RELEASE_LEDGER.jsonl` for append-only release events. Each entry should be one JSON object with:

- `timestamp`
- `actor`
- `event`
- `repo`
- `branch`
- `commit`
- `target`
- `proof`
- `blockers`
- `notes`

Do not rewrite past ledger entries to make a release look cleaner. Add corrections as new entries.

## Source Map

Use `.ai-dev/DEPLOY_SOURCE_MAP.md` to explain how hosted or packaged artifacts map back to source. Hosted green checks do not prove source identity unless the mapping is explicit.
