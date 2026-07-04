# MCP

This folder is reserved for future MCP servers that expose project state to agents.

The first planned server is a project-state server that reads `.ai-dev/` files and returns compact, current context:

- project identity
- active runtime target
- branch registry
- proof requirements
- release ledger summary
- deploy source map
- known blockers

Do not make an MCP server the only source of truth. It should summarize files and current checks, not replace verification.
