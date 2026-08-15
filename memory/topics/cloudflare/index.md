# `topics/cloudflare/`

## Concepts

- [Access fails OPEN when the app is missing](tech-access-missing-app-fails-open.md) — Clients keep sending CF-Access-Client-* headers that nobody checks; the origin is public and looks healthy
- [AI Gateway is transparent on model ids](tech-cloudflare-ai-gateway-transparent.md) — Cloudflare AI Gateway does not validate model names; upstream does
- [Cache HIT skips Worker CPU](tech-workers-cache-hit-skips-cpu.md) — On HIT the Worker does not run — no CPU billing for that request
- [Cache-Control stale-while-revalidate](tech-workers-cache-swr.md) — SWR serves stale instantly while background refresh runs
- [Cache-Tag purge](tech-workers-cache-tags.md) — Tag responses for targeted purge instead of purge-everything
- [Cloudflare Pages deploy habit](tech-cloudflare-pages-deploy.md) — Semantic commit → push → deploy changed app; avoid parallel deploys that share env files
- [forwardAuth must preserve status](tech-forwardauth-preserve-status.md) — Error pages middleware can rewrite 302 challenges into 401/500 and break OAuth
- [Workers Cache enable flag](tech-workers-cache-enabled.md) — Enable per-worker cache with cache.enabled; only public Cache-Control is stored
- [Zone account transfer breaks Worker routes](tech-zone-account-transfer-breaks-worker-routes.md) — Moving a zone copies DNS but not routes, Custom Domains, rulesets or email rules — every hostname 403s with Error 1000
