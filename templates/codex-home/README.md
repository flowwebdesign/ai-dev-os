# Codex Home Bootstrap

This folder contains a portable global `AGENTS.md` template for `~/.codex/AGENTS.md`.

Use it when you want every Codex session to start with the same truth gate, memory index rule, proof mapping, and reporting shape across all projects.

Install with:

```sh
./install.sh --install-codex-home
```

PowerShell:

```powershell
.\install.ps1 -InstallCodexHome
```

The installers do not overwrite an existing global `AGENTS.md` unless `--force` or `-Force` is supplied. Forced installs create a timestamped backup first.

Exact hook, skill, and MCP auto-load locations can vary by Codex version. This bootstrap is a readable instruction template, not a claim that every Codex surface auto-loads portable skills or hooks.
