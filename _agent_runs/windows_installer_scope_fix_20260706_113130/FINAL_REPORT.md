# Windows Installer Scope Fix

## Verified

- Repo path: `C:\Users\floww\Documents\ai-dev-os`.
- Remote: `https://github.com/flowwebdesign/ai-dev-os`.
- Branch at start: `feature/day1-working-control-layer`.
- Start commit: `479060c capture profile matrix learning proof`.
- Bug found: `install.ps1` and `install.sh` copied project `.ai-dev` templates before global install, so `-InstallCodexHome` / `--install-codex-home` also dirtied the current repo.
- Source repo cleanup: untracked `C:\Users\floww\Documents\ai-dev-os\.ai-dev` was confirmed untracked and removed. Final check: `SOURCE_AI_DEV_FINAL=False`.
- Global install: `.\install.ps1 -InstallCodexHome` printed separate `GLOBAL INSTALL`, `CODEX HOME INSTALL`, and `PROJECT INIT skipped` sections.
- Global CLI exists: `C:\Users\floww\.ai-dev-os\bin\ai-dev-os.ps1`.
- Codex home AGENTS exists: `C:\Users\floww\.codex\AGENTS.md`.
- Installed CLI version during smoke: `479060c`.
- Installed `doctor` from the source repo returns `SUMMARY WARN` because `.ai-dev` is intentionally absent, rather than creating or requiring project files.
- Git Bash syntax check passed for `install.sh`.

## Partial Or Smoke Only

- Linux installer runtime was not executed on Linux. Only Windows-hosted Git Bash syntax was checked.
- PowerShell CLI init was smoke-tested in a temp folder using the intended Windows flow: `cd <target>`, then `ai-dev-os.ps1 init -Profile serious -Detect`.

## Study_master Dry Run

- `C:\Users\floww\Documents\Scripts\Study_master` exists.
- `Study_master` `.ai-dev` was absent before and after dry checks.
- `doctor .` result: `SUMMARY WARN`, project check skipped because `.ai-dev` is absent.
- `check .` result: `SUMMARY STOP`, with `remote=none`, branch `lane/chrome-store-beta-extension-package`, existing dirty tree, and missing `.ai-dev` required files.
- No Study_master init was run.

## Changed Files

- `install.ps1`
- `install.sh`
- `bin/ai-dev-os.ps1`
- `bin/ai-dev-os`
- `scripts/ai-dev-os-check.ps1`
- `README.md`
- `templates/codex-home/README.md`
- `templates/codex/prompts/install_codex_home_bootstrap.md`
- `course/12-windows-install-scope.md`
- `learning-log/2026-07-06.md`

## Remaining Risks

- Installed `VERSION` remains the pre-commit hash until the installer is run again after the final commit.
- Bash runtime behavior was not fully exercised on a Linux host in this Windows-only run.
- Study_master already has unrelated dirty work; this run did not inspect or modify it beyond dry `doctor` and `check`.

## Next Study_master Init Command

```powershell
cd C:\Users\floww\Documents\Scripts\Study_master
& "$HOME\.ai-dev-os\bin\ai-dev-os.ps1" init -Profile serious -Detect
```
