# Hooks

This folder is reserved for future active enforcement.

Hooks should help agents fail fast before unsafe actions:

- wrong repo or branch
- dirty-tree conflict
- recursive/noisy command
- raw generated-file read
- production mutation without approval
- provider call without budget/mode
- deploy without source map

Hooks are support rails, not a replacement for human-readable rules and proof reports.
