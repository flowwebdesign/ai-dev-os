# AI Dev OS Pass 2 First Pets Report

Status: PASS

## 1. Repository State

- Repo path: `/home/fred/projects/ai-dev-os`
- Branch: `bootstrap/portable-ai-dev-os`
- Commit: `a707c43217fd4bf6e11be9b30d2238dd56272896`
- Initial dirty state: only prior `_agent_runs/` audit report files were present.
- Current dirty state: expected new docs-only pass 2 files plus prior `_agent_runs/`.

## 2. Files Created

- `pets/README.md`
- `pets/done-means-verified/README.md`
- `pets/done-means-verified/AGENTS.fragment.md`
- `pets/done-means-verified/skills/done-means-verified/SKILL.md`
- `pets/done-means-verified/hooks/README.md`
- `pets/correct-runtime/README.md`
- `pets/correct-runtime/AGENTS.fragment.md`
- `pets/correct-runtime/skills/correct-runtime-proof/SKILL.md`
- `pets/correct-runtime/hooks/README.md`
- `pets/extension-truth/README.md`
- `pets/extension-truth/AGENTS.fragment.md`
- `pets/extension-truth/skills/extension-truth-proof/SKILL.md`
- `pets/extension-truth/hooks/README.md`
- `pets/fixture-vs-live/README.md`
- `pets/fixture-vs-live/AGENTS.fragment.md`
- `pets/fixture-vs-live/skills/fixture-vs-live-proof/SKILL.md`
- `pets/fixture-vs-live/hooks/README.md`
- `pets/release-ledger/README.md`
- `pets/release-ledger/AGENTS.fragment.md`
- `pets/release-ledger/skills/release-ledger-proof/SKILL.md`
- `pets/release-ledger/hooks/README.md`
- `templates/run-cards/RUN_CARD.template.json`
- `templates/reports/FINAL_REPORT.template.md`
- `docs/PET_ARCHITECTURE.md`
- `docs/PORTABILITY_MODEL.md`
- `adapters/study-pilot/README.md`
- `_agent_runs/ai_dev_os_pass_2_first_pets_20260704_041800/FINAL_REPORT.md`

## 3. What Each Pet Contains

Done Means Verified:

- Purpose: prevent completion claims without relevant verification.
- Covers documentation-only readback, unit tests, build/typecheck, browser proof, provider proof, and release proof.
- Requires `Not Proven` when verification is incomplete.
- Includes AGENTS fragment, skill workflow, and inactive hook ideas.

Correct Runtime:

- Purpose: prevent wrong repo, branch, process, port, stale app, or wrong runtime proof.
- Includes Linux, Windows, WSL, and server notes.
- Prefers repo-relative checks and rejects hardcoded personal paths.
- Includes AGENTS fragment, skill workflow, and inactive hook ideas.

Extension Truth:

- Purpose: prevent treating visible extension UI as proof of connected extension behavior.
- Requires extension folder, browser profile, `appUrl`, bootstrap/session, and payload-route proof.
- Includes AGENTS fragment, skill workflow, and inactive hook ideas.

Fixture vs Live:

- Purpose: prevent fixture/demo/local mock/cached success from being reported as live success.
- Requires explicit mode proof for fixture, live, auto, mock provider, real provider, and cost flags.
- Includes AGENTS fragment, skill workflow, and inactive hook ideas.

Release Ledger:

- Purpose: prevent lost state across chats, branches, machines, and Codex lanes.
- Requires reading existing ledger, manifest, branch registry, and source map when present.
- Requires run-card and final-report output for release or handoff lanes.
- States pasted summaries are last-known context only and must be reconciled with Git, runtime, and evidence.
- Includes AGENTS fragment, skill workflow, and inactive hook ideas.

## 4. Validation Run

- `rtk git status --short`
- `rtk pwd`
- `rtk git branch --show-current`
- `rtk git rev-parse HEAD`
- `rtk sed -n '1,260p' _agent_runs/ai_dev_os_linux_audit_20260704_041205/FINAL_REPORT.md`
- `rtk jq -e . templates/run-cards/RUN_CARD.template.json`
- `rtk rg "^## Purpose" pets -n`
- `rtk rg "^## Future Hook Ideas" pets -n`
- `rtk rg "Not Proven|not proven" pets templates/reports adapters/study-pilot -n`
- `rtk rg "^## Problems It Prevents" pets -n`
- `rtk rg "^## When To Use It" pets -n`
- `rtk rg "^## Required Preflight Checks" pets -n`
- `rtk rg "^## Required Evidence" pets -n`
- `rtk rg "^## Required Verification" pets -n`
- `rtk rg "^## Stop Conditions|^## What It Must Never Claim" pets -n`
- `rtk git diff --stat`
- `rtk git diff --name-only`

Results:

- Branch and commit matched the expected bootstrap branch.
- Prior audit report was found and read.
- No conflicting existing pet, docs, or adapter structure existed.
- Run-card JSON template validated with `jq`.
- Required pet README sections were found for all five pets.
- Inactive hook placeholders were documented; no hook scripts were created or executed.

## 5. Risks

- `git diff --stat` and `git diff --name-only` do not show untracked file contents; `rtk git status --short` was used to prove the expected new directories.
- The pet structure is docs-only and not yet wired into installers, root README, or project templates.
- Skills are workflow docs, not installed Codex skills.
- Hook folders are placeholders only and provide no enforcement.
- Study Pilot adapter is only a placeholder plan and contains no repo-specific verified truth.

## 6. Intentionally Not Done

- No global install.
- No edits to `~/.codex`, shell profiles, machine config, Codex app config, or MCP server state.
- No hook activation.
- No MCP implementation.
- No installer changes.
- No Study Pilot repo edits.
- No commits or pushes.
- No TOML changes.

## 7. Recommended Pass 3

Recommended pass 3: add an opt-in project-local pet index/import workflow.

Scope:

- Update root `README.md` to mention `pets/`, `docs/PET_ARCHITECTURE.md`, and `docs/PORTABILITY_MODEL.md`.
- Add a docs-only guide showing how to copy selected pet `AGENTS.fragment.md` content into a project `AGENTS.md`.
- Add a docs-only guide showing how to copy selected pet skill folders into a project-local skills area.
- Do not modify installers, activate hooks, implement MCP, or install anything globally.

