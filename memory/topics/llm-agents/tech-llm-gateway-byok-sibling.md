---
name: tech-llm-gateway-byok-sibling
title: BYOK sibling before disabling backend
description: Disabling a platform backend can silently kill BYOK that injected through it
type: tech
category: gateway
tags: [tech, llm, gateway, byok]
related: ["[[project-anyrouter]]", "[[tech-llm-gateway-quota-as-retryable]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

If user keys ride a platform backend path, add an explicit `-byok` (or equivalent) route before disabling that backend.

Learned on multi-provider routers like [[project-anyrouter]]. Related: [[tech-llm-gateway-quota-as-retryable]].
