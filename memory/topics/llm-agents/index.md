# `topics/llm-agents/`

## Concepts

- [AgentState five primitives](tech-agentstate-five-primitives.md) — States, leases, claims, capability tokens, conversations — fleet coordination API
- [AgentState is not an agent framework](tech-agentstate-not-a-framework.md) — Coordination/state API for fleets — bring your own agent loop
- [AI agent stack map](tech-ai-agent-stack.md) — Map of common agent frameworks and what they are for
- [AI SDK native tool parts](tech-ai-sdk-uimessage-native-tools.md) — Persist or convert to dynamic-tool / tool-name parts for history reload
- [BYOK sibling before disabling backend](tech-llm-gateway-byok-sibling.md) — Disabling a platform backend can silently kill BYOK that injected through it
- [Convert history DTO → UIMessage](tech-ai-sdk-history-dto-convert.md) — Keep API neutral; translate tool-call DTOs to AI SDK parts per client
- [Credentials never enter the sandbox](tech-oma-credentials-out-of-sandbox.md) — Managed-agent platforms should inject secrets via outbound proxy, not into the sandbox FS
- [Dashboard auth gate precedence](tech-hermes-dashboard-auth-gate.md) — Insecure/loopback allowlists can bypass OAuth if ordered wrong
- [Filesystem-first durable agents](tech-eve-filesystem-agents.md) — Some frameworks store agent state/layout as files for durability and review
- [Flue: register providers in initializer](tech-flue-register-in-initializer.md) — Custom gateways must register from agent init with ctx.env; module load has empty env
- [Hermes custom_providers](tech-hermes-custom-provider.md) — Register custom OpenAI-compatible providers by name, base_url, model
- [Hermes steer mode](tech-hermes-steer-mode.md) — While busy, new user messages can adjust the current task instead of being ignored
- [Prompt cache is byte-sensitive](tech-prompt-cache-byte-sensitive.md) — Any prefix byte change can bust LLM prompt cache
- [Quota errors may arrive as HTTP 400](tech-llm-gateway-quota-as-retryable.md) — Reseller budget errors buried in 400 should failover like 402/429
- [RAG citation guards](tech-rag-citation-guards.md) — URL-shaped citations can be real yet irrelevant — require passage support
- [RAG metadata key drift](tech-rag-metadata-key-drift.md) — Inconsistent metadata keys break filters between ingest and query
- [RAG: TOC docs pollute retrieval](tech-rag-toc-pollution.md) — Table-of-contents pages rank well but answer poorly — filter or downweight
