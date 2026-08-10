---
name: tech-prompt-cache-byte-sensitive
title: Prompt cache is byte-sensitive
description: Any prefix byte change can bust LLM prompt cache
type: tech
category: agents
tags: [tech, llm, performance]
related: ["[[project-open-managed-agents]]", "[[tech-ai-agent-stack]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Prompt caching keys on exact prefix bytes. Unstable timestamps, random IDs, or reordered system text kill hit rates.

Related: [[project-open-managed-agents]], [[tech-ai-agent-stack]].
