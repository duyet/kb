---
name: tech-workers-cache-hit-skips-cpu
title: Cache HIT skips Worker CPU
description: On HIT the Worker does not run — no CPU billing for that request
type: tech
category: cloudflare
tags: [tech, cloudflare, cache, performance]
related: ["[[tech-workers-cache-enabled]]", "[[tech-tanstack-start-ssg]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

A cache HIT is served from the edge tier without invoking the Worker isolate.

Great for SSR-as-origin frameworks. Enable carefully with public CC only: [[tech-workers-cache-enabled]].
