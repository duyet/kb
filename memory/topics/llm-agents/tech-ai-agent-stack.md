---
name: tech-ai-agent-stack
title: AI agent building — tech stack
description: Frameworks/SDKs for building LLM agents (LangGraph, AI SDK, Claude/OpenAI Agents SDK, MCP) + what Duyet uses
type: tech
category: ai
tags: [tech, ai-agents, llm-agents, frameworks]
related: ["[[user-duyet-ai-stance]]", "[[user-duyet-stack]]"]
created: 2026-06-04
updated: 2026-06-04
timestamp: 2026-06-04T00:00:00Z
---

The 2026 stack for building LLM agents, by layer:

- **Orchestration (Python):** LangGraph (graph/state machines), LlamaIndex
  (RAG + agents), PydanticAI, CrewAI, AutoGen, OpenAI Agents SDK, Google ADK.
- **Orchestration (TS/JS):** Vercel **AI SDK** (streaming, tools, `ToolLoopAgent`),
  Mastra, LangGraph.js, Cloudflare Agents (Durable Objects), OpenAI Agents SDK,
  Claude Agent SDK.
- **Model gateways:** OpenRouter, AnyRouter, LiteLLM — swap providers without code churn.
- **Interop protocol:** **MCP** (Model Context Protocol) for tools/resources; A2A
  for agent-to-agent.
- **Memory / RAG:** vector stores (Qdrant, pgvector), LlamaIndex; explicit
  short/long-term + reflection memory for agentic loops.
- **Eval / observability:** LangSmith, Langfuse, Braintrust.
- **Runtime / deploy:** Cloudflare Workers + Durable Objects, Vercel.

**Duyet uses** (see [[user-duyet-ai-stance]]): Claude Code as driver; Claude Agent
SDK, OpenAI Agents SDK, Cloudflare Agents, Vercel AI SDK, LlamaIndex, LangChain;
OpenRouter/AnyRouter for routing; MCP (mcp.duyet.net). Core pattern: plan →
execute → test → reflect with persistent memory.
