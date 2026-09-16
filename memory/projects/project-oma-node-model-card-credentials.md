---
name: project-oma-node-model-card-credentials
title: oma Node model-card credentials for session turns
description: Self-hosted Node resolves tenant Model Card creds before AnyRouter/deployment globals
type: project
category: agents
tags: [project, oma, node, model-cards]
aliases: [oma-node-model-card]
related: ["[[project-open-managed-agents]]", "[[tech-oma-bare-claude-gateway-rewrite]]"]
sources: ["https://github.com/duyet/oma/pull/470", "https://github.com/duyet/oma/issues/469"]
created: 2026-09-17
updated: 2026-09-17
timestamp: 2026-09-16T18:47:00Z
---

Self-hosted Node (`apps/main-node`) session turns resolve the tenant **Model Card** first: wire model, API key, base URL, provider, and custom headers. Shared across model construction, tools, and harness auth. OpenAI-compatible cards (e.g. DeepSeek gateways) work without a global `ANTHROPIC_API_KEY`. Deployment-wide / AnyRouter credentials remain the fallback.

**Why:** Without this, valid tenant cards still failed before the first model request on self-hosted Node with no global provider key.

**How to apply:** For Node self-host regressions on model routing, check Model Card resolution order before blaming env keys. Shipped in #470 (closes #469).
