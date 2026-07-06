# MCP Project State

MCP can expose project state to agents through tools.

The starter server reads `.ai-dev/` files and writes run cards or progress logs inside the project. It should summarize truth, not replace verification.

Mistakes prevented:

- agents searching the whole repo for basic project facts
- hidden project state in chats only
- run evidence stored outside the project

Exercise: inspect `mcp/project-state-server/src/index.ts` and identify the path-safety checks.

Client offer angle: build small project-state MCP servers for teams with many repos.
