# Project State MCP Server

Minimal TypeScript starter for exposing `.ai-dev/` project state to MCP clients.

## Tools

- `read_ai_memory_index`
- `read_active_state`
- `read_proof_requirements`
- `read_next_actions`
- `write_run_card`
- `append_progress_log`

## Rules

- No secrets.
- Only reads and writes inside the current project `.ai-dev/`.
- Refuses path traversal outside project root.
- Fails clearly when `.ai-dev/` is missing.

## Install Later

```sh
npm install
npm run build
```

Example client config is in `examples/mcp-config.example.json`.
