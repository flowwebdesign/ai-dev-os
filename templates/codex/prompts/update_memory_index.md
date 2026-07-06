# Update Memory Index Prompt

Update `.ai-dev/AI_MEMORY_INDEX.md` after proving the current project state.

Rules:

- Keep the index short.
- Preserve the exact required rule.
- Update only facts that changed.
- Route deeper context by task; do not copy full project docs into the index.
- Treat stale chats and handoffs as pointers, not truth.

Checklist:

1. Prove repo path, remote, branch, and dirty state.
2. Read the current index.
3. Read only the deeper files needed for the changed section.
4. Update project identity, runtime map, active state, proof boundaries, stop conditions, or routing rows as needed.
5. Record the date, updater, and reason.

Report changed sections, checks run, skipped checks, and residual risk.
