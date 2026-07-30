# `topics/llm-agents/`

## Concepts

- [AI agent building — tech stack](tech-ai-agent-stack.md) — Frameworks/SDKs for building LLM agents (LangGraph, AI SDK, Claude/OpenAI Agents SDK, MCP) + what Duyet uses
- [eve framework (Vercel durable agents)](tech-eve-framework.md) — Filesystem-first durable-agent framework — file layout, extension model, and the Node-24 .ts-import gotcha
- [Flue — register model providers in the agent initializer, not module scope](tech-flue-provider-registration.md) — Flue custom providers (e.g. AnyRouter) must be registered inside defineAgent's initializer using ctx.env; secrets aren't in process.env at module load
- [Hermes agent custom LLM provider config](tech-hermes-agent-custom-provider.md) — Hermes (codingllm/hermes) uses custom_providers list + provider:custom to register non-built-in OpenAI-compatible endpoints
- [Hermes dashboard auth gate (nous OAuth plugin)](tech-hermes-dashboard-auth.md) — How the Hermes web dashboard auth gate + nous Portal OAuth plugin actually engage — insecure/loopback precedence, redirect-URI tiers, localhost-allowlist gotcha
- [RAG retrieval pollution — TOC docs, citation guards, metadata drift](tech-rag-retrieval-pollution.md) — Why vector search returns confidently-irrelevant pages — synthetic TOC/link-list docs, citation guards passing real-but-irrelevant URLs, dual metadata keys, wrong query embed model
