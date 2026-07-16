---
name: project-anyrouter
title: AnyRouter
description: Universal LLM API gateway at anyrouter.dev — TanStack Start on CF Workers, shadcn/ui, hub-and-spoke multi-worker, prerendered marketing shells
type: project
category: projects
tags: [project, anyrouter, cloudflare, tanstack, shadcn, llm-gateway]
aliases: [anyrouter.dev]
related: ["[[reference-duyet-github]]", "[[tech-cloudflare-ai-gateway-proxy]]", "[[tech-tanstack-stale-route-chunks]]", "[[tech-kumo-ui-nextjs-integration]]"]
sources: ["https://github.com/duyet/anyrouter", "https://anyrouter.dev", "https://anyrouter.dev/docs"]
created: 2026-06-14
updated: 2026-07-17
timestamp: 2026-07-17T03:15:00Z
---

github.com/duyet/anyrouter — OpenAI-compatible LLM router: one API, many providers, BYOK, presets, failover.

## Stack & deploy

| Layer | Choice |
|-------|--------|
| App | TanStack Start + React, SSR on Cloudflare Workers |
| UI | shadcn/ui (Tailwind v4, semantic tokens) + Phosphor icons — Kumo fully removed 2026-07 |
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

## Gateway-ops lessons (2026-07-16 autonomous issue sweep)

- **CF AI Gateway unified billing can hard-zero**: error `{"code":2021,"httpCode":402,"message":"Insufficient balance; add money to your gateway or use BYOK"}` takes down every model whose only platform route is the unified `cloudflare` backend. No code fix — top up or wire a fallback platform upstream per popular model.
- **LiteLLM-style resellers bury quota exhaustion in HTTP 400** (`{"type":"budget_exceeded","message":"ExceededBudget: ..."}`). Routers must classify those 400s like 402/429 (fall through to next candidate), not as terminal client errors.
- **Disabling a platform backend silently kills BYOK through it** — if user keys inject via the platform backend, add a `-byok` sibling BEFORE disabling (anyrouter's z-ai precedent; the openai/deepinfra disable missed this and broke OpenAI-key BYOK for a day).
- **Every new backend has a registration checklist** (logo alias, byok provider map, schema-registry dialect row, intentional-free allowlist, regen). Drift tests that enumerate the registry are what catch skipped steps — worth building in any config-driven router.
- **A full network timeout (zero bytes) is terminal per backend per request** — retrying the same origin just burns another 60s.
