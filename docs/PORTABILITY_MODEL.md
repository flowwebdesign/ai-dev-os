# Portability Model

AI Dev OS should travel across Linux, Windows, WSL, and servers without carrying machine-local state as truth.

## Portable

- Pet docs and skills.
- Project-local `.ai-dev/` templates.
- Proof labels and report formats.
- Run-card schema.
- Release ledger event shape.
- Hook plans that are inactive by default.
- MCP plans that are read-only by default.

## Machine-Local

- Absolute repo paths.
- Browser profiles.
- Extension install folders.
- Local process IDs and currently occupied ports.
- Auth sessions and tenant identity.
- Provider keys, budgets tied to private accounts, billing details, and tokens.
- Shell profiles, Codex home, MCP server state, and app-level settings.

## Linux

Prefer POSIX-compatible shell where possible. Use repo-relative checks, explicit commands, and local `.ai-dev/` state. Do not assume a desktop browser exists on a server.

## Windows Native

Use PowerShell-friendly paths and avoid assuming POSIX tools unless the lane has proven they exist. Keep execution-policy guidance separate from project templates. Do not hardcode user profile paths.

## WSL

Name which side owns the repo, browser, runtime, and extension. A WSL process can prove source and server state, but browser proof may depend on a Windows browser profile and localhost bridging.

## Server

Expect no interactive browser, no desktop extension, and no personal auth session. Server lanes should label browser/extension proof as `not_run` or `blocked` unless a headless proof path is explicitly available.

