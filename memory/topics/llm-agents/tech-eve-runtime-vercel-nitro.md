---
name: tech-eve-runtime-vercel-nitro
title: Eve durable runtime is Vercel or Nitro
description: Eve sessions need Vercel Workflow or a self-hosted Nitro Node server
type: tech
category: agents
tags: [tech, llm-agents, eve, deploy]
related: ["[[tech-eve-filesystem-agents]]", "[[user-duyet-infra-cloudflare]]"]
sources: ["https://eve.dev/docs/guides/deployment/overview"]
created: 2026-08-15
updated: 2026-08-15
timestamp: 2026-08-15T00:00:00Z
---

Eve's durable loop (sessions, pause/resume, sandbox) deploys to **Vercel Workflow** or a **self-hosted Nitro Node** server (`eve build` → `.output/`).

It does not run inside a thin Cloudflare Worker that only serves static assets plus one `POST /api/chat`. `withEve()` for Next.js expects that Eve service (local eve-dev, Vercel service, or `EVE_NEXT_PRODUCTION_ORIGIN`).

Authoring files can still follow [[tech-eve-filesystem-agents]] on another host; the durable Eve runtime is a separate deploy choice.
