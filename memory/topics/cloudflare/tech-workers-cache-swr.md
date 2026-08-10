---
name: tech-workers-cache-swr
title: Cache-Control stale-while-revalidate
description: SWR serves stale instantly while background refresh runs
type: tech
category: cloudflare
tags: [tech, cloudflare, cache, web]
related: ["[[tech-workers-cache-enabled]]", "[[tech-workers-cache-tags]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Use `Cache-Control: public, max-age=…, stale-while-revalidate=…` so users rarely wait on origin re-render.

Pair with [[tech-workers-cache-enabled]], [[tech-workers-cache-tags]].
