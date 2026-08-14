---
name: tech-eve-filesystem-agents
title: Filesystem-first durable agents
description: Eve authors an agent as agent/ files — instructions, tools, connections
type: tech
category: agents
tags: [tech, llm-agents, eve, architecture]
related: ["[[feedback-docs-driven-development]]", "[[tech-ai-agent-stack]]", "[[tech-eve-runtime-vercel-nitro]]"]
sources: ["https://eve.dev/docs", "https://github.com/vercel/eve"]
created: 2026-08-10
updated: 2026-08-15
timestamp: 2026-08-15T00:00:00Z
---

Vercel [Eve](https://eve.dev/) authors an agent as files under `agent/`:

| Path | Role |
|------|------|
| `instructions.md` | always-on system prompt |
| `tools/<name>.ts` | tool name = filename |
| `connections/<name>.ts` | MCP / OpenAPI |
| `skills/`, `schedules/`, `subagents/` | optional slots |

Identity comes from the path, not a `name` field. Aligns with [[feedback-docs-driven-development]]. Runtime host: [[tech-eve-runtime-vercel-nitro]].
