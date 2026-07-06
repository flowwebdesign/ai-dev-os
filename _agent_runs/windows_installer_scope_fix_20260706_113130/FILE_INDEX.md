# File Index

## Proof Files

- `FINAL_REPORT.md` - human-readable final proof report.
- `RUN_CARD.json` - structured run scope, checks, and boundaries.
- `VERIFICATION.txt` - compact command/result evidence.
- `FILE_INDEX.md` - this index.

## Source Files Changed

- `install.ps1` - added explicit global/Codex/project sections and `-Project` scope separation.
- `install.sh` - mirrored `--project` scope separation and help text.
- `bin/ai-dev-os.ps1` - passes `-Project` for init, supports Windows profile flags, propagates check exit status, and makes doctor skip missing project `.ai-dev`.
- `bin/ai-dev-os` - passes `--project` for init and mirrors doctor skip behavior.
- `scripts/ai-dev-os-check.ps1` - tolerates missing git remote/branch and reports `none` or `unknown`.
- `README.md` - documents global install vs project init and Windows/Bash flag forms.
- `templates/codex-home/README.md` - documents global install as non-project-mutating.
- `templates/codex/prompts/install_codex_home_bootstrap.md` - adds project-init separation to bootstrap prompt.
- `course/12-windows-install-scope.md` - captures the installer scope lesson.
- `learning-log/2026-07-06.md` - records the Windows installer scope fix.
