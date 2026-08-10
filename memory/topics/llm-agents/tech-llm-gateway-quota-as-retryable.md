---
name: tech-llm-gateway-quota-as-retryable
title: Quota errors may arrive as HTTP 400
description: Reseller budget errors buried in 400 should failover like 402/429
type: tech
category: gateway
tags: [tech, llm, gateway, architecture]
related: ["[[project-anyrouter]]", "[[tech-llm-gateway-byok-sibling]]", "[[tech-cloudflare-ai-gateway-transparent]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Some upstreams return `budget_exceeded` as HTTP 400. Classify as retryable/failover, not terminal client error.

Also: zero-byte full timeouts are terminal per backend per request — don't burn identical retries. See [[project-anyrouter]].
