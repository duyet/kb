# `topics/cloudflare/`

## Concepts

- [Cloudflare AI Gateway is a transparent proxy for model names](tech-cloudflare-ai-gateway-proxy.md) — AI Gateway does not validate model ids; it forwards them to the upstream — "invalid model ID" comes from the provider, not CF
- [Cloudflare Pages deploy workflow](tech-cloudflare-pages-deploy.md) — Commit→push→background-deploy convention for duyet.net apps on Cloudflare Pages, plus the parallel-deploy hazard
- [Traefik forwardAuth + OAuth2 Proxy + nginx redirector pattern](tech-traefik-forwardauth-oauth2-proxy.md) — Traefik ErrorPages middleware preserves original status (won't pass 302 through), so forwardAuth with OAuth2 needs an nginx redirector to convert 401→302
