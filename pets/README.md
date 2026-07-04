# Pets

Pets are named failure-prevention modules.

A pet is not an agent, installer, hook, or MCP server by itself. It is a portable package of instructions and workflow scaffolding that can later be copied, installed, or enforced in a project-specific way.

## Model

- Pet = named failure-prevention module.
- `AGENTS.md` fragment = memory and instructions for agents working in a repo.
- Skill = repeatable workflow with triggers, steps, evidence, and output contract.
- Hook = future enforcement placeholder; inactive until explicitly implemented and installed.
- MCP = optional future structured tools or data access.
- Config/profile = future machine-specific behavior such as paths, ports, browser profiles, and provider defaults.

## Foundational Pets

- `done-means-verified/`: prevents claiming completion without relevant verification.
- `correct-runtime/`: prevents wrong repo, branch, process, port, stale app, or wrong runtime proof.
- `extension-truth/`: prevents treating visible extension UI as proof that the extension is connected and working.
- `fixture-vs-live/`: prevents fixture, demo, local mock, or cached success from being reported as live success.
- `release-ledger/`: prevents lost state across chats, branches, machines, and Codex lanes.

## Use Rules

- Keep pets project-local until they are proven in real repos.
- Do not store secrets in pet docs, run cards, reports, hook plans, or MCP plans.
- Do not activate hooks from this folder.
- Treat pet skills as workflows, not proof by themselves.
- Treat pasted summaries as last-known context only; reconcile them with Git, runtime, and current evidence.

