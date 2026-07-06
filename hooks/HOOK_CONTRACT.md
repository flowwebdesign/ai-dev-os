# Hook Contract

Hooks must be safe standalone scripts.

## Principles

- Fail closed when an expected remote is supplied and the repo does not match.
- Print clear `PASS`, `WARN`, or `STOP` lines.
- Avoid destructive side effects.
- Avoid network calls.
- Avoid secrets.
- Write only to the requested evidence/run folder when capturing evidence.

## Hook Purposes

- `preflight` blocks unsafe work before edits.
- `stop_check` checks proof, final report, and run card before final claims.
- `evidence_capture` appends simple evidence to an agent run folder.

## Codex Integration

Exact Codex hook integration locations are not assumed here. Use these scripts manually or wire them into a project-specific hook system only after local Codex documentation or help output confirms the supported syntax.
