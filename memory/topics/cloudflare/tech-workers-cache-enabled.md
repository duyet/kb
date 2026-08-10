---
name: tech-workers-cache-enabled
title: Workers Cache enable flag
description: Enable per-worker cache with cache.enabled; only public Cache-Control is stored
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, cache]
related: ["[[tech-workers-cache-swr]]", "[[tech-workers-cache-hit-skips-cpu]]", "[[user-duyet-infra-cloudflare]]"]
sources: ["https://blog.cloudflare.com/workers-cache/"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Workers Cache sits in front of a Worker. Enable: `cache: { enabled: true }` in wrangler.

Safe default: only responses with explicit public `Cache-Control` are stored. Auth headers auto-bypass.
See [[tech-workers-cache-swr]], [[tech-workers-cache-hit-skips-cpu]].
