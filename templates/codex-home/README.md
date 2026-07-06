# Codex Home Bootstrap

This folder contains a portable global `AGENTS.md` template for `~/.codex/AGENTS.md`.

Use it when you want every Codex session to start with the same truth gate, memory index rule, proof mapping, and reporting shape across all projects.

Install with:

```sh
./install.sh --install-codex-home
./install.sh --install-codex-home --force
```

PowerShell:

```powershell
.\install.ps1 -InstallCodexHome
.\install.ps1 -InstallCodexHome -Force
```

The installers do not overwrite an existing global `AGENTS.md` unless `--force` or `-Force` is supplied. Forced installs create a timestamped backup first.

The installers also create `~/.ai-dev-os/bin/ai-dev-os` and `~/.ai-dev-os/bin/ai-dev-os.ps1` for `init`, `attach`, `check`, `doctor`, `version`, and `help`.

Global install does not create project `.ai-dev` files. Use `./install.sh --project /path/to/project`, `.\install.ps1 -Project -TargetDir C:\path\to\project`, `ai-dev-os init --profile serious --detect /path/to/project`, or `cd C:\path\to\project` followed by `ai-dev-os.ps1 init -Profile serious -Detect` when you want project init.

Exact hook, skill, and MCP auto-load locations can vary by Codex version. This bootstrap is a readable instruction template, not a claim that every Codex surface auto-loads portable skills or hooks.
