# Add Real Init Check Doctor CLI

## Verified

- Repo path: `/home/fred/projects/ai-dev-os`
- Remote: `https://github.com/flowwebdesign/ai-dev-os`
- Branch: `feature/day1-working-control-layer`
- Starting commit: `0606415 fix linux install smoke test issues`
- Global install path exists: `/home/fred/.ai-dev-os`
- Codex AGENTS path exists: `/home/fred/.codex/AGENTS.md`

## What Now Works

- `ai-dev-os init [path]` installs project `.ai-dev` files.
- `ai-dev-os attach [path]` aliases `init` and is idempotent.
- `ai-dev-os check [path]` runs the installed project checker.
- `ai-dev-os doctor [path]` checks global install state and project health.
- `ai-dev-os version` and `ai-dev-os help` work.

## Smoke Results

- Before init, `check` returned `SUMMARY STOP` because `.ai-dev` files were missing.
- After init, `check` returned `SUMMARY WARN` with expected warnings for untracked `.ai-dev/` and optional missing `PROOF_MATRIX.md`.
- `doctor` returned `SUMMARY WARN` consistently instead of mixing checker WARN with doctor PASS.
- `attach` skipped existing files safely.

## Not Run

- MCP runtime/build was not run.
- PowerShell CLI runtime check was not run because `pwsh` is not installed.

## Changed Files

- `bin/ai-dev-os`
- `bin/ai-dev-os.ps1`
- `install.sh`
- `install.ps1`
- `README.md`
- `templates/codex-home/README.md`
- `_agent_runs/add_real_init_check_doctor_cli_20260706_040104/`

## Risks

- `~/.ai-dev-os/bin` is not added to PATH by the installer.
- Installed VERSION will be updated to the final commit hash only after rerunning global install post-commit.

## Next Smallest Lane

Document optional PATH setup for `~/.ai-dev-os/bin`.
