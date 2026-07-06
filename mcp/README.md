# MCP

This folder contains a minimal project-state MCP starter.

The first server is `mcp/project-state-server/`. It is intentionally small and project-local:

- reads compact `.ai-dev/` project state
- writes run cards and progress logs inside `.ai-dev/`
- refuses paths outside the current project root
- stores no secrets

Do not make an MCP server the only source of truth. It should summarize files and current checks, not replace verification.
