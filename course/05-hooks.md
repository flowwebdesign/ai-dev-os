# Hooks

Hooks are executable guardrails.

In this repo they are standalone scripts first. Codex-specific wiring should be added only after local documentation confirms the supported hook syntax.

Mistakes prevented:

- final reports without run cards
- edits in the wrong repo
- missing evidence capture

Exercise: run `hooks/templates/preflight.sh` in a repo and note every PASS, WARN, and STOP line.

Client offer angle: add lightweight guardrails without forcing a platform migration.
