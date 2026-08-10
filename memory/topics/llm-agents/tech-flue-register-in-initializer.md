---
name: tech-flue-register-in-initializer
title: Flue: register providers in initializer
description: Custom gateways must register from agent init with ctx.env; module load has empty env
type: tech
category: agents
tags: [tech, llm-agents, cloudflare]
related: ["[[reference-cloudflare-acquires-astro]]", "[[project-anyrouter]]", "[[tech-cloudflare-ai-gateway-transparent]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Flue addresses models as `provider/model`. Register custom providers inside `defineAgent` initializer using `ctx.env`.

`process.env` is empty at module load on workerd. Debug with Node target when errors hide. Related: [[reference-cloudflare-acquires-astro]], [[project-anyrouter]].
