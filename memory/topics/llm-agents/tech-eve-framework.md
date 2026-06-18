---
name: tech-eve-framework
title: eve framework (Vercel durable agents)
description: Filesystem-first durable-agent framework — file layout, extension model, and the Node-24 .ts-import gotcha
type: reference
category: llm-agents
tags: [eve, agents, vercel, mcp, typescript, framework]
aliases: [eve agent framework]
related: ["[[tech-ai-agent-stack]]", "[[project-anyrouter]]", "[[project-clickhouse-monitor]]"]
sources: ["node_modules/eve/docs/", "https://eve.dev/docs"]
created: 2026-06-18
updated: 2026-06-18
timestamp: 2026-06-18T00:00:00Z
---

**eve** = Vercel's filesystem-first framework for durable backend AI agents (npm `eve`,
Node 24+). An agent is a directory under `agent/`; eve compiles + runs it, persists every
session, serves it over HTTP. Docs ship in `node_modules/eve/docs/` — read these, they
match the installed version.

## File layout (everything is a file)
- `agent/agent.ts` — `defineAgent({ model, modelContextWindowTokens })`.
- `agent/instructions.md` — always-on system prompt (identity/rules).
- `agent/connections/<name>.ts` — `defineMcpClientConnection({url,description,auth?,tools?,approval?})`
  or `defineOpenAPIConnection`. Name = filename. Model calls `connection__<name>__<tool>`
  via `connection__search`; creds never reach the model.
- `agent/skills/<name>/SKILL.md` (or flat `.md`) — load-on-demand procedures (`load_skill`);
  `description` frontmatter is the routing hint. `defineSkill` for typed/packaged.
- `agent/tools/<snake_case>.ts` — `defineTool({description, inputSchema: zod, execute})`.
  Filename = tool name. Gate side effects with `needsApproval: always()/once()` (`eve/tools/approval`).
- `agent/channels/eve.ts` — `eveChannel({ auth: [...] })`. Auth is **fail-closed**;
  `placeholderAuth()` blocks browsers in prod — use `none()` (`eve/channels/auth`) as the
  last entry for a public web chat.
- State: `defineState(name, initial)` from `eve/context` — durable but **session-scoped**
  (get/update). Cross-session data → a connection or external store.
- HITL: built-in `ask_question` tool (model asks the user); approvals via `needsApproval`.

## Gotchas (learned building eved)
- **Imports between agent modules must use the real `.ts` extension** (`./model.ts`, not
  `./model.js`). eve runs raw TS via Node 24 native type-stripping, which does NOT rewrite
  `.js`→`.ts`; the docs' `.js` convention fails the dev runtime (`ERR_MODULE_NOT_FOUND`).
  Set `allowImportingTsExtensions: true` so tsgo accepts it. eve's generated
  `module-map.mjs` uses `.ts` — that's the tell.
- Commands: `eve dev|build|start|info`; typecheck via `tsgo`. `eve info` = quick compile check.
- **Frontend**: `eve/next` `withEve(nextConfig)` + `eve/react` `useEveAgent()`; same dir,
  `agent/` at root. assistant-ui bridges cleanly via `useExternalStoreRuntime`.
- `npx skills add <gh-repo>` vendors the WHOLE source repo (incl. its own CLAUDE.md/AGENTS.md
  → pollutes your agent's context). Prefer a self-contained `.claude/skills/<n>/SKILL.md`.

First used building **eved** (github.com/duyet/eved): a public Duyet-assistant agent on eve
+ AnyRouter, with duyet / firecrawl / clickhouse-monitor MCP connections.
