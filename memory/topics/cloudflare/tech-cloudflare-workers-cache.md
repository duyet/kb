---
name: tech-cloudflare-workers-cache
title: Cloudflare Workers Cache sits in front of your Worker
description: Per-worker tiered cache enabled by one wrangler line and driven by standard Cache-Control headers; a HIT skips the Worker (no CPU billing)
type: tech
category: infra
tags: [cloudflare, workers, cache, performance, ssr]
aliases: [workers-cache]
related: ["[[tech-cloudflare-pages-deploy]]", "[[tech-cloudflare-ai-gateway-proxy]]", "[[tech-tanstack-start-ssg]]", "[[project-anyrouter]]", "[[project-chmonitor-one-codebase-saas]]", "[[project-duyet-net]]"]
sources: ["https://blog.cloudflare.com/workers-cache/", "https://developers.cloudflare.com/workers/"]
created: 2026-07-06
updated: 2026-07-06
timestamp: 2026-07-06T00:00:00Z
---

**Workers Cache** (launched 2026-07-06) is a tiered cache that sits **in front of
a Worker**, belonging to the Worker (not the zone). On a cache HIT the Worker
never runs — no CPU billing, response served from the nearest tier. This is the
missing piece for SSR-on-Workers (TanStack Start / Astro / Next / Hono are *the
origin*, so every request used to re-render).

## Enable (one line, per worker)

```jsonc
// wrangler.jsonc            // wrangler.toml
"cache": { "enabled": true } // [cache]\nenabled = true
```

Enabling is **safe by default**: only responses with an explicit **public**
`Cache-Control` are stored; everything else is a MISS/BYPASS. Requests carrying
an `Authorization` header **auto-bypass** (great for authed APIs — inference /
`Bearer` / `ak_` keys never cache).

## Control with standard headers (no rules engine, no zone config)

```ts
return new Response(body, { headers: {
  "Cache-Control": "public, max-age=300, stale-while-revalidate=3600",
  "Cache-Tag": "products,product:123",     // tag-based purge
  "Vary": "Accept, Accept-Language",        // one URL → many cached variants
}})
```

- **`max-age`** = fresh window (served from cache, Worker idle).
- **`stale-while-revalidate`** = serve stale instantly (`Cf-Cache-Status:
  UPDATING`) while a background refresh runs — *no user ever waits*. This is what
  makes it "feel static".
- **`Vary: *`** disables caching. Normalize headers in a gateway before `Vary` to
  avoid variant fan-out.

## Purge / multi-tenant / per-entrypoint

- Purge from the **owning entrypoint**: `await ctx.cache.purge({ tags: [...] })`
  / `{ prefix: "/x" }` / `{ purgeEverything: true }` (scoped to that entrypoint
  only).
- **Per-user safety:** identity passed via `ctx.props` is part of the cache key,
  so an authed API caches per-user with no cross-tenant leaks. Pattern:
  gateway authenticates → strips `Authorization` → sets `ctx.props.userId` →
  calls a cached inner entrypoint.
- **Per-entrypoint control** in wrangler `exports`: disable cache on the
  gateway/router entrypoint (must always run), enable on the expensive inner one.
  The cache becomes a *layer inside one Worker*, between `ctx.exports` calls.

## How to apply (rules I use)

1. Enable `cache.enabled` on every public-facing Worker — it's a no-op until you
   add public `Cache-Control`.
2. Add `Cache-Control: public, …` **only** to genuinely public, non-user-specific
   GET responses: SSR marketing/docs/blog pages, static datasheets/catalogs,
   sitemaps/robots/llms.txt, public read-only list APIs, health.
3. **Never** public-cache authed / per-user / personalized / mutating routes —
   leave them uncacheable (Authorization auto-bypasses anyway).
4. TTL rule of thumb: content pages `max-age=300, swr=86400`; near-static
   (cv/photos/model datasheets) `max-age=3600, swr=604800`; volatile list APIs
   `max-age=60, swr=300`.
5. **Billing gotcha:** once cache is enabled, static-asset requests and
   worker-to-worker (service binding / `ctx.exports`) calls bill at the standard
   *request* rate (each consults the cache); HITs still cost 0 CPU.

Rolled out across duyet's CF fleet 2026-07: [[project-anyrouter]],
[[project-chmonitor-one-codebase-saas]], [[project-duyet-net]] monorepo, and
agentstate — see each repo's own `workers-cache` KB note for the endpoint map.
