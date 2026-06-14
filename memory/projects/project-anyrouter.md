---
name: project-anyrouter
title: AnyRouter
description: Universal LLM API gateway at anyrouter.dev — TanStack Start on CF Workers, Kumo UI, split web/API workers, prerendered marketing shells
type: project
category: projects
tags: [project, anyrouter, cloudflare, tanstack, kumo, llm-gateway]
aliases: [anyrouter.dev]
related: ["[[reference-duyet-github]]", "[[tech-cloudflare-ai-gateway-proxy]]", "[[tech-tanstack-stale-route-chunks]]", "[[tech-kumo-ui-nextjs-integration]]"]
sources: ["https://github.com/duyet/anyrouter", "https://anyrouter.dev", "https://anyrouter.dev/docs"]
created: 2026-06-14
updated: 2026-06-14
timestamp: 2026-06-14T16:35:00Z
---

github.com/duyet/anyrouter — OpenAI-compatible LLM router: one API, many providers, BYOK, presets, failover.

## Stack & deploy

| Layer | Choice |
|-------|--------|
| App | TanStack Start + React, SSR on Cloudflare Workers |
| UI | Kumo (`@cloudflare/kumo`) + Phosphor icons |
| API | Separate `anyrouter-api` worker via service binding (3 MiB budget split) |
| Deploy | `pnpm cf:deploy` → `pnpm ops deploy` (secrets, D1 migrate, build, deploy, prerender, purge) |
| Docs | Customer docs in `src/content/docs/`; maintainer kb in `docs/kb/` |

## Public routes (2026-06-14)

- `/pricing` — Free / Pro / Team tiers (Kumo cards)
- Homepage **LLM API Gateway** diagram: `src/components/home-sections/gateway-section.tsx` (clients → AnyRouter hub → providers)
- Subdomain shortcuts: `pricing.anyrouter.dev` → `/pricing`, etc. (`src/worker.ts`)

## Ops habits

- Post-task: deploy + commit only touched paths (`git add` specific files, never `-A`)
- Smoke: `pnpm e2e:test:prod` after deploy
- Internal kb auto-updated under `docs/kb/` for non-trivial fixes

**Why:** Agents working across repos need the deploy split, file locations, and stale-chunk trap without re-discovering from scratch.

**How to apply:** Read `docs/kb/` + `AGENTS.md` in repo before coding; use Kumo docs-first; route all upstreams through CF AI Gateway.