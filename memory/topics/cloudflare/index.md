# `topics/cloudflare/`

## Concepts

- [AI Gateway is transparent on model ids](tech-cloudflare-ai-gateway-transparent.md) — Cloudflare AI Gateway does not validate model names; upstream does
- [Cache HIT skips Worker CPU](tech-workers-cache-hit-skips-cpu.md) — On HIT the Worker does not run — no CPU billing for that request
- [Cache-Control stale-while-revalidate](tech-workers-cache-swr.md) — SWR serves stale instantly while background refresh runs
- [Cache-Tag purge](tech-workers-cache-tags.md) — Tag responses for targeted purge instead of purge-everything
- [Cloudflare Access fails OPEN when the app is missing — clients keep sending headers nobody checks](tech-access-missing-app-fails-open.md) — A service-token-protected origin becomes publicly reachable if the Access application is absent; clients still send CF-Access-Client-* headers, so nothing errors and it looks healthy
- [Cloudflare Pages deploy habit](tech-cloudflare-pages-deploy.md) — Semantic commit → push → deploy changed app; avoid parallel deploys that share env files
- [forwardAuth must preserve status](tech-forwardauth-preserve-status.md) — Error pages middleware can rewrite 302 challenges into 401/500 and break OAuth
- [Moving a CF zone between accounts copies DNS but not Worker routes — Error 1000](tech-zone-account-transfer-breaks-worker-routes.md) — Cloudflare inter-account zone/registrar transfer carries DNS records but drops Worker routes and Custom Domains, so every proxied hostname 403s with Error 1000 until routes are recreated
- [Workers Cache enable flag](tech-workers-cache-enabled.md) — Enable per-worker cache with cache.enabled; only public Cache-Control is stored
