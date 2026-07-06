# Profile Matrix And Learning Capture

## Verified

- Repo: `/home/fred/projects/ai-dev-os`
- Remote: `https://github.com/flowwebdesign/ai-dev-os`
- Branch: `feature/day1-working-control-layer`
- Starting commit: `6363215 fix ai dev os cli profile doctor behavior`
- Installed CLI version: `6363215`
- Installed CLI path: `/home/fred/.ai-dev-os/bin/ai-dev-os`
- Installed Codex AGENTS path: `/home/fred/.codex/AGENTS.md`

## Profile Matrix

| Profile | Temp Repo | Detect | Init | Check | Doctor | Readback |
| --- | --- | --- | --- | --- | --- | --- |
| minimal | `/tmp/ai-dev-os-profile-matrix-20260706_055420/minimal` | no | pass | `SUMMARY WARN` | `SUMMARY WARN` | profile minimal, detect 0 |
| standard | `/tmp/ai-dev-os-profile-matrix-20260706_055420/standard` | no | pass | `SUMMARY WARN` | `SUMMARY WARN` | profile standard, detect 0 |
| serious | `/tmp/ai-dev-os-profile-matrix-20260706_055420/serious` | no | pass | `SUMMARY WARN` | `SUMMARY WARN` | profile serious, detect 0 |
| serious detect | `/tmp/ai-dev-os-profile-matrix-20260706_055420/serious-detect` | yes | pass | `SUMMARY WARN` | `SUMMARY WARN` | profile serious, detect 1 |

The WARN result is expected: `.ai-dev/` is untracked in temporary repos and optional `.ai-dev/PROOF_MATRIX.md` is missing.

## Learning Capture

- Added `course/11-profile-matrix-proof.md`.
- Updated `course/00-course-map.md`.
- Updated `learning-log/2026-07-06.md`.

## Not Run

- MCP runtime/build.
- PowerShell runtime check because `pwsh` is not installed.

## Risk

Profiles currently record requested mode and detect flag. They do not yet change which templates are installed or infer project runtime beyond the lightweight CLI profile readback.
