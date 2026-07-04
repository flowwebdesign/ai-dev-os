# Pet Architecture

AI Dev OS uses pets to package repeatable failure-prevention behavior without installing global enforcement too early.

## Definitions

- Pet: a named module that prevents a specific class of failure.
- AGENTS fragment: durable instructions to import into a repo-level `AGENTS.md`.
- Skill: a repeatable workflow with a trigger, steps, required evidence, stop conditions, and output contract.
- Hook: future enforcement layer. Hooks are inactive until explicitly implemented and installed.
- MCP: future structured data/tool interface. MCP should be read-only by default and append-only where writes are needed.
- Config/profile: machine-specific behavior such as local ports, browser profiles, paths, provider modes, and command wrappers.

## Boundaries

Project-agnostic content belongs in `core/`, `pets/`, `skills/`, and `templates/`.

Project-specific truth belongs in a target repo's `.ai-dev/` files.

Machine-local truth belongs outside committed project docs unless it is a non-secret example. Browser profiles, local paths, credentials, provider keys, billing data, and workstation-specific ports must not become portable defaults.

## Recommended Pet Shape

Each pet should provide:

- `README.md` for the module contract.
- `AGENTS.fragment.md` for importable repo instructions.
- `skills/<skill-name>/SKILL.md` for repeatable workflow execution.
- `hooks/README.md` for future enforcement ideas only.

## Promotion Path

1. Start as documentation and workflow only.
2. Prove the pet in at least one project-local lane.
3. Add templates only when the required evidence shape is stable.
4. Add hooks only as warnings first.
5. Add MCP only when file-based project state is too slow or ambiguous.
6. Keep global installation out of scope until project-local behavior is boring and reversible.

