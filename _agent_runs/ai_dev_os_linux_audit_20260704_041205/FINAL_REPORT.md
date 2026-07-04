# AI Dev OS Linux Import Audit

Timestamp: 2026-07-04 04:12:05 Europe/Amsterdam

## 1. Repository State

- Path: `/home/fred/projects/ai-dev-os`
- Remote: `https://github.com/flowwebdesign/ai-dev-os`
- Branch: `bootstrap/portable-ai-dev-os`
- Commit: `a707c43217fd4bf6e11be9b30d2238dd56272896`
- Clean/dirty status before report write: clean (`rtk git status --short` returned `ok`)
- Remote branch proof: `rtk git ls-remote --heads origin bootstrap/portable-ai-dev-os` returned `a707c43217fd4bf6e11be9b30d2238dd56272896 refs/heads/bootstrap/portable-ai-dev-os`
- Local diff before report write: empty (`rtk git diff --stat`, `rtk git diff --name-only`)
- Local diff after report write: expected new `_agent_runs/ai_dev_os_linux_audit_20260704_041205/FINAL_REPORT.md`

## 2. Scaffold Map

The repo structure is sane for a first portable personal Codex/AI-dev control system. It is small, readable, and organized around current-truth checks, proof requirements, project state, and release traceability.

Main folders:

- `core/`: portable policy docs for proof standards, task classification, handoffs, escalation, failure patterns, and release traceability. This should remain project-agnostic and become the canonical source for durable concepts.
- `templates/project/.ai-dev/`: project-local state templates: context, active state, branch registry, deploy source map, proof requirements, run card, release ledger, RC gates, and project rules. This is the strongest part of the scaffold.
- `templates/codex/`: starter `AGENTS.md` and lane prompts. Good as importable working instructions, but currently overlaps with `core/` and `rules/`.
- `skills/`: starter repeatable workflows for truth gating, proof mapping, and handoff writing. These are useful but should eventually be packaged as real Codex skills with clear triggers and references.
- `agents/`: role TOMLs for explorer, worker, reviewer, proof checker, and scribe. These are readable, but no runtime consumes them yet.
- `rules/`: compact default rules. Useful as a small import layer, but overlaps with `AGENTS.md`, `core/CORE_RULES.md`, and `templates/codex/AGENTS.md`.
- `hooks/`: placeholder plan for future enforcement. Correctly non-active for now.
- `mcp/`: placeholder plan for future project-state MCP. Correctly read-only by default in the plan.
- `examples/minimal-project/`: minimal copied `.ai-dev` example. Useful, but it should eventually include one filled run card and one ledger event.
- `install.sh` and `install.ps1`: copy `.ai-dev` templates into a target project without overwriting existing files.

Unclear or duplicated:

- `AGENTS.md`, `core/CORE_RULES.md`, `rules/default.rules`, and `templates/codex/AGENTS.md` repeat the same truth-gate/proof concepts. That is acceptable in bootstrap, but implementation pass 2 should define which file is canonical and which files are generated/adapted excerpts.
- `skills/` and `templates/codex/prompts/` overlap. Skills should become workflows; prompts should become lane starters or examples.
- `agents/*.toml` role profiles are aspirational until there is a loader, schema, or documentation explaining how Codex should use them.
- The install scripts only copy project templates. They do not install skills, hooks, MCP config, agent profiles, or personal/global rules.

## 3. Portability Audit

Linux:

- `install.sh` uses POSIX `sh`, `set -eu`, safe copy-if-missing behavior, and relative `SCRIPT_DIR`; this is a good Linux baseline.
- `rtk sh -n install.sh` passed on this machine.
- Missing: dry-run mode, verbose plan mode, destination summary, template version marker, and post-install validation.
- Missing: detection/reporting for existing partial `.ai-dev` installs.

Windows native:

- `install.ps1` uses `Resolve-Path`, `Join-Path`, `Test-Path`, and `Copy-Item`, which is the right shape for native Windows.
- PowerShell validation was not run here because `pwsh` is unavailable.
- Missing: support for Windows PowerShell 5.1 vs PowerShell 7 behavior, execution policy guidance, path examples, and `-WhatIf`/dry-run behavior.
- Missing: explicit no-global-install default. The script currently targets a project path, which is good, but docs should warn against copying rules into user profiles too early.

WSL:

- The repo should work in WSL as Linux, but WSL-specific boundaries are not documented.
- Missing: guidance for Windows repo path vs WSL repo path, browser profile mismatch, extension folder identity, localhost bridging, and line-ending expectations.
- Missing: rule that WSL proof of browser/extension behavior must name whether the browser is Linux-side or Windows-side.

Server:

- The current scaffold is safe on a server because active hooks/MCP are not installed and templates are local files.
- Missing: headless/server profile guidance, non-interactive install mode, CI validation mode, and secret-safe provider ledger conventions.
- Missing: explicit "no browser proof available" fallback labels for server lanes.

Machine-local state that must not be committed as generic truth:

- Absolute local repo paths.
- Browser profiles and extension install folders.
- Auth/session identity.
- Provider API keys, tokens, budgets tied to private accounts, and billing details.
- Local ports currently in use.
- Deployment credentials and cloud account identities.
- Personal Codex home, shell profiles, and machine-specific hook allowlists.

## 4. Safety Audit

Could break machines if installed blindly:

- Global AGENTS rules copied into unrelated repos could impose wrong command wrappers, block valid workflows, or create false confidence.
- Future hooks could block normal commands if they cannot distinguish generated files, broad searches, or destructive intent accurately.
- Future MCP write tools could corrupt ledgers or expose secrets if they are not read-only by default and append-only for ledgers.
- Installer expansion into shell profiles, global Codex config, browser profiles, or git hooks would be dangerous before project-local behavior is proven.
- Provider proof prompts could trigger paid calls unless budget/mode gates are enforced before execution.

Should never contain secrets:

- `.ai-dev/PROJECT_CONTEXT.md`
- `.ai-dev/ACTIVE_STATE.md`
- `.ai-dev/PROOF_REQUIREMENTS.md`
- `.ai-dev/RELEASE_LEDGER.jsonl`
- `.ai-dev/RUN_CARD*.json`
- `DEPLOY_SOURCE_MAP.md`
- Skills, prompts, agent TOMLs, MCP resources, hook config, examples, and audit reports.

Hooks should later block or warn on:

- Wrong repo, wrong branch, wrong worktree, or dirty-tree conflict before edits.
- Raw destructive commands: reset, clean, forced checkout, delete, rebase, force-push, deploy, production mutation.
- Unbounded recursive listings, broad logs without tail limits, and generated/lock/build output reads.
- Provider calls without explicit provider mode, budget, and ledger path.
- Release/deploy claims without source map and release ledger evidence.
- Extension proof without active extension folder, browser profile, app URL, and bridge target.
- Fixture/live confusion where a real-provider claim is made from fixture/mock evidence.

## 5. Pet Architecture Recommendation

Use this mental model consistently:

- Pet = named failure-prevention module.
- `AGENTS.md` = memory/instructions that tell agents how to behave in a repo.
- Skill = repeatable workflow with trigger, steps, required inputs, and output contract.
- Hook = enforcement or warning layer that catches unsafe actions before or after commands.
- MCP = structured external/project state interface with freshness metadata and guardrails.
- Config/profile = machine behavior such as paths, ports, command wrappers, browser profile, and provider defaults.

Recommended architecture:

- Keep `core/` project-agnostic and stable.
- Keep `.ai-dev/` project-specific and committed only when it describes non-secret project truth.
- Keep machine-local profiles outside repos, or in ignored files, for ports, browser profiles, provider keys, and local paths.
- Define each pet as a small folder with `README.md`, `AGENTS.fragment.md`, `SKILL.md`, optional `hooks/`, optional `mcp/`, optional `templates/`, and explicit "not secrets" rules.
- Avoid one mega-pet. The first pass should create five narrow pets that match recurring failures.

## 6. First 5 Recommended Pets

1. Done Means Verified

- Failure prevented: claiming success from weak evidence.
- AGENTS rules: final reports must separate verified, partial/smoke, not run, blocked, changed files, checks, risks, and next lane.
- Skill: map claim to proof chain and label evidence.
- Hook: warn when final response says done/success without checks or proof labels.
- MCP: optional read of project proof requirements.

2. Correct Runtime

- Failure prevented: testing local while asked for hosted, using wrong port, wrong browser profile, or wrong environment.
- AGENTS rules: name runtime target and identity before writes.
- Skill: prove route, port, environment, identity, and source map before runtime claims.
- Hook: warn on localhost/production mismatch and production mutation without approval.
- MCP: project runtime/deploy source map resource.

3. Extension Truth

- Failure prevented: proving the wrong extension folder, stale build, wrong app URL, or wrong browser profile.
- AGENTS rules: extension proof requires folder, manifest/source identity, active profile, app URL, bridge target, action, API/persistence/readback, and visible result.
- Skill: browser extension proof workflow.
- Hook: warn on extension claims without manifest/source/profile/app URL evidence.
- MCP: optional extension state/app bridge resource later.

4. Fixture vs Live

- Failure prevented: presenting fixture/mock/cached output as live provider proof.
- AGENTS rules: every provider claim names fixture/live mode, provider, budget, cache policy, and ledger path.
- Skill: provider cost proof workflow.
- Hook: block paid provider calls without budget/mode/ledger marker.
- MCP: provider mode and ledger append helper, read-only by default except append-only ledger writes.

5. Release Ledger

- Failure prevented: release claims without source, deploy, proof, blockers, and rollback traceability.
- AGENTS rules: RC ready requires source identity, deploy source map, required checks, ledger entry, blockers, and rollback note.
- Skill: release handoff and ledger writer.
- Hook: warn on release/deploy wording without ledger/source map.
- MCP: append-only ledger and latest release summary.

## 7. Study Pilot Adapter Plan

Add a later Study Pilot adapter as a project-specific pet pack, not as global AI Dev OS behavior.

It should contain:

- Three repo ownership: record canonical paths/remotes/branches for backend, dashboard, and app-bridge or extension-related repo. Include branch owner, active lane, and do-not-touch flags.
- Port map: backend, dashboard, and app-bridge ports with local/hosted target rules. Include WSL/browser bridging notes.
- Extension appUrl proof: required evidence for manifest/source identity, active browser profile, extension folder, configured app URL, and the exact app bridge endpoint.
- Browser route proof for `/en/app`: browser action, URL, visible route state, network/API boundary where relevant, persistence, reload/readback, and identity.
- Fixture/live/provider/cost proof: explicit fixture vs live mode, provider name, budget approval, cache policy, ledger path, cost/usage when available, and quality/readback evidence.
- Run card and ledger proof: a Study Pilot run-card template with repo set, ports, browser profile, provider mode, checks, proof labels, and next lane; ledger events for release/provider/runtime proof.
- "Not proven" section: mandatory section in every Study Pilot final report listing route, extension, provider, cost, persistence, identity, release, or deployment boundaries not currently proven.

Adapter file shape:

- `adapters/study-pilot/README.md`
- `adapters/study-pilot/AGENTS.fragment.md`
- `adapters/study-pilot/SKILL.md`
- `adapters/study-pilot/templates/.ai-dev/STUDY_PILOT_STATE.md`
- `adapters/study-pilot/templates/.ai-dev/STUDY_PILOT_PORTS.md`
- `adapters/study-pilot/templates/.ai-dev/STUDY_PILOT_EXTENSION_PROOF.md`
- `adapters/study-pilot/templates/.ai-dev/STUDY_PILOT_PROVIDER_LEDGER.schema.json`

Do not add Study Pilot repo-specific files directly to unrelated repos or global Codex home. Keep the adapter opt-in and project-local.

## 8. Proposed Next Implementation Lane

Recommended next lane: create the five pet skeletons as docs-only modules and add a single project-local pet index.

Scope:

- Add `pets/README.md`.
- Add folders for `done-means-verified`, `correct-runtime`, `extension-truth`, `fixture-vs-live`, and `release-ledger`.
- In each pet, add only `README.md`, `AGENTS.fragment.md`, and `SKILL.md`.
- Do not add active hooks, MCP servers, installers, global config, or Study Pilot files yet.

Why this lane:

- It is small, safe, docs-only, and directly turns the current useful prose into reusable modules.
- It avoids premature global installation and avoids implementing enforcement before the wording and boundaries are stable.
- It creates a clean target for later installer logic and optional hook/MCP enforcement.

## Verification Performed

Checks run:

- `rtk git status --short`
- `rtk pwd`
- `rtk ls`
- `rtk git diff --stat`
- `rtk git diff --name-only`
- `rtk git branch --show-current`
- `rtk git rev-parse HEAD`
- `rtk git remote -v`
- `rtk git ls-remote --heads origin bootstrap/portable-ai-dev-os`
- `rtk jq -e . templates/project/.ai-dev/RUN_CARD.template.json`
- `rtk jq -e . templates/project/.ai-dev/BRANCH_REGISTRY.json`
- `rtk jq -e . templates/project/.ai-dev/RELEASE_LEDGER.jsonl`
- `rtk sh -n install.sh`
- `rtk command -v pwsh`
- `rtk python3 -c "import tomllib, pathlib; [tomllib.loads(p.read_text()) for p in pathlib.Path('agents').glob('*.toml')]; print('toml ok')"`

Results:

- Repo branch/commit matched the expected remote branch.
- Working tree was clean before writing this report.
- JSON templates validated with `jq`.
- JSONL placeholder validated with `jq`.
- Agent TOML files parsed with Python `tomllib`.
- `install.sh` passed POSIX shell syntax check.
- PowerShell syntax check was not run because `pwsh` is unavailable on this machine.

## Bottom Line

Status: PASS for import and audit; PARTIAL for cross-platform script validation because PowerShell validation could not run here.

The scaffold is ready for implementation pass 2 if pass 2 stays docs-only and project-local. It is not ready for global installation, active hooks, paid-provider automation, or MCP write tools.
