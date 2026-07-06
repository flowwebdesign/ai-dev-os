# Hooks

This folder contains practical standalone hook templates.

They can be run manually today. Exact Codex hook wiring is version-dependent, so this repo does not invent unsupported hook configuration syntax.

Use:

- `hooks/templates/preflight.sh` or `.ps1` before edits.
- `hooks/templates/stop_check.sh` or `.ps1` before a final success claim.
- `hooks/templates/evidence_capture.sh` or `.ps1` to append evidence to a run folder.
- `hooks/install-hooks.sh` or `.ps1` to copy templates into a project-local `.ai-dev/hooks/` folder.

These hooks are support rails, not a replacement for human-readable rules and proof reports.
