# Linux Install Smoke Test

## Verified

- Repo path: `/home/fred/projects/ai-dev-os`
- Remote: `https://github.com/flowwebdesign/ai-dev-os`
- Branch: `feature/day1-working-control-layer`
- Starting commit: `408e506 make ai dev os working control layer`
- Global install command used: `./install.sh /tmp/ai-dev-os-global-install-target --install-codex-home`
- Installed package path after fix: `/home/fred/.ai-dev-os`
- Codex AGENTS path: `/home/fred/.codex/AGENTS.md`
- Temp project path: `/tmp/ai-dev-os-smoke-project`
- Installed checker path: `/home/fred/.ai-dev-os/bin/ai-dev-os-check.sh`

## Checker Results

- Before project install: `SUMMARY STOP`, expected because `.ai-dev` files were missing.
- Attach/init: no separate command was installed or documented; used `install.sh /tmp/ai-dev-os-smoke-project`.
- After project install: `SUMMARY WARN`, exit 0. Warnings were expected for untracked `.ai-dev/` files and missing optional `.ai-dev/PROOF_MATRIX.md`.

## Hook Smoke

- `preflight.sh`: passed repo/branch/remote checks with dirty-tree warning.
- `stop_check.sh`: passed against temp smoke run folder.
- `evidence_capture.sh`: appended evidence log in the temp smoke run folder.

## Source Fix

One small Linux installer fix was needed. Before the fix, `--install-codex-home` did not create `~/.ai-dev-os`, a manifest, VERSION file, or installed checker binary. The fix adds those files during global install.

## Not Run

- MCP build was not run because dependencies were not already installed and the task said not to build MCP in that case.

## Preserved

- Existing untracked snapshot artifacts in the repo were not deleted or staged.
