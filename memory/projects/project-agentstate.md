---
name: project-agentstate
title: duyet/agentstate
description: State and coordination layer for AI agent fleets (public OSS)
type: project
category: agents
tags: [project, agentstate, llm-agents, oss]
aliases: [agentstate]
related: ["[[user-duyet-active-projects]]", "[[tech-ai-agent-stack]]", "[[project-anyworker]]", "[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/agentstate", "https://agentstate.app"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T18:00:00Z
---

github.com/duyet/agentstate · https://agentstate.app

Open-source **state/coordination layer for agent fleets** — not another agent framework. Primitives:

| Primitive | Role |
|-----------|------|
| States | Versioned KV + append-only event log |
| Leases | Distributed locks (exactly-one-writer) |
| Claims | Assertions + evidence for audit |
| Capability tokens | Scoped, revocable sub-agent delegation |
| Conversations | Message history, search, tags, export |

SDKs: npm `@agentstate/sdk`, PyPI `agentstate`. MCP server available. MIT, self-hostable.
Portfolio: [[user-duyet-active-projects]]. Stack: [[tech-ai-agent-stack]]. Related runtime: [[project-anyworker]], [[project-open-managed-agents]].
