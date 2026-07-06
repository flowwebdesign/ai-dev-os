import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";
import { mkdir, readFile, writeFile, appendFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import path from "node:path";

const projectRoot = process.cwd();
const aiDevDir = path.resolve(projectRoot, ".ai-dev");

function ensureAiDevDir(): void {
  if (!existsSync(aiDevDir)) {
    throw new Error(`Missing .ai-dev directory at ${aiDevDir}`);
  }
}

function resolveAiDevFile(name: string): string {
  ensureAiDevDir();
  const target = path.resolve(aiDevDir, name);
  if (!target.startsWith(aiDevDir + path.sep)) {
    throw new Error("Refusing path outside .ai-dev");
  }
  return target;
}

async function readAiDevFile(name: string): Promise<string> {
  return readFile(resolveAiDevFile(name), "utf8");
}

const server = new McpServer({
  name: "ai-dev-os-project-state",
  version: "0.1.0"
});

server.tool("read_ai_memory_index", {}, async () => ({
  content: [{ type: "text", text: await readAiDevFile("AI_MEMORY_INDEX.md") }]
}));

server.tool("read_active_state", {}, async () => ({
  content: [{ type: "text", text: await readAiDevFile("ACTIVE_STATE.md") }]
}));

server.tool("read_proof_requirements", {}, async () => ({
  content: [{ type: "text", text: await readAiDevFile("PROOF_REQUIREMENTS.md") }]
}));

server.tool("read_next_actions", {}, async () => ({
  content: [{ type: "text", text: await readAiDevFile("NEXT_ACTIONS.md") }]
}));

server.tool(
  "write_run_card",
  { runId: z.string().min(1), json: z.string().min(2) },
  async ({ runId, json }) => {
    ensureAiDevDir();
    const safeRunId = runId.replace(/[^a-zA-Z0-9_.-]/g, "_");
    const runDir = path.resolve(aiDevDir, "runs");
    if (!runDir.startsWith(aiDevDir + path.sep)) {
      throw new Error("Refusing path outside .ai-dev");
    }
    JSON.parse(json);
    await mkdir(runDir, { recursive: true });
    const target = path.resolve(runDir, `${safeRunId}.json`);
    await writeFile(target, json + "\n", "utf8");
    return { content: [{ type: "text", text: `wrote ${target}` }] };
  }
);

server.tool(
  "append_progress_log",
  { message: z.string().min(1) },
  async ({ message }) => {
    const target = resolveAiDevFile("PROGRESS_LOG.md");
    const stamp = new Date().toISOString();
    await appendFile(target, `\n| ${stamp} | mcp | ${message.replace(/\|/g, "/")} |  |  |\n`, "utf8");
    return { content: [{ type: "text", text: `appended ${target}` }] };
  }
);

const transport = new StdioServerTransport();
await server.connect(transport);
