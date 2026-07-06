# Fix CLI Profile And Doctor Behavior

## Verified

- `ai-dev-os doctor` from `/home/fred` now reports global health and skips project checks with `SUMMARY WARN` instead of `SUMMARY STOP`.
- `ai-dev-os init --profile serious --detect` now succeeds.
- `.ai-dev/CLI_PROFILE.md` is written with profile, detect flag, branch, and remote.
- `ai-dev-os check` succeeds after init with expected warnings for untracked `.ai-dev/` and optional missing `PROOF_MATRIX.md`.

## Changed Files

- `bin/ai-dev-os`
- `bin/ai-dev-os.ps1`
- `README.md`
- `_agent_runs/fix_cli_profile_doctor_20260706_041248/`

## Tests And Checks Run

- `rtk bash -n bin/ai-dev-os`
- `rtk bash -n install.sh`
- `rtk ./bin/ai-dev-os help`
- `rtk ./install.sh /tmp/ai-dev-os-global-install-target --install-codex-home`
- `rtk /home/fred/.ai-dev-os/bin/ai-dev-os doctor`
- `rtk /home/fred/.ai-dev-os/bin/ai-dev-os init --profile serious --detect`
- `rtk /home/fred/.ai-dev-os/bin/ai-dev-os check`

## Not Run

- MCP runtime/build.
- PowerShell runtime/parse because `pwsh` is not installed.

## Risk

- `--detect` is intentionally lightweight in this fix. It records git branch and remote, but does not yet infer package manager or runtime commands.
