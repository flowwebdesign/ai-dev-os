# Install Codex Home Bootstrap Prompt

Install the portable Codex home bootstrap only after proving the current repo and user intent.

Steps:

1. Confirm the AI Dev OS repo path and branch.
2. Inspect `templates/codex-home/README.md` and `templates/codex-home/AGENTS.md`.
3. Run `./install.sh --install-codex-home` or `.\install.ps1 -InstallCodexHome`.
4. Use `--force` or `-Force` only when the user explicitly wants to replace an existing `~/.codex/AGENTS.md`.
5. If forced, confirm a backup was created before overwrite.

Report:

- installed path
- whether an existing file was skipped or backed up
- checks run
- remaining uncertainty about Codex hook, skill, or MCP auto-load behavior
