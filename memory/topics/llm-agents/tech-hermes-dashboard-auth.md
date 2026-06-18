---
name: tech-hermes-dashboard-auth
title: Hermes dashboard auth gate (nous OAuth plugin)
description: How the Hermes web dashboard auth gate + nous Portal OAuth plugin actually engage — insecure/loopback precedence, redirect-URI tiers, localhost-allowlist gotcha
type: tech
category: reference
tags: [hermes, nous, oauth, dashboard, kubernetes, homelab]
aliases: [hermes-nous-plugin, hermes-dashboard-oauth]
related: ["[[tech-hermes-agent-custom-provider]]", "[[tech-traefik-forwardauth-oauth2-proxy]]", "[[project-self-driven-homelab]]"]
sources: []
created: 2026-06-18
updated: 2026-06-18
---

Hermes (`nousresearch/hermes-agent`) ships a bundled **`nous`** dashboard-auth
plugin (OAuth 2.0 auth-code + PKCE vs Nous Portal `portal.nousresearch.com`).
Source of truth when docs are scarce: read the bundled plugin at
`/opt/hermes/plugins/dashboard_auth/nous/` inside the running image.

- **Gate is independent of providers.** `web_server.should_require_auth(host, allow_public)`
  decides if the in-app auth gate engages: **loopback host → off**; **non-loopback
  + `insecure`/`--insecure` → off**; **non-loopback + not insecure → ON**. A
  registered provider (nous/OIDC/basic) is only *consulted* when the gate is ON.
  `allow_public` = `HERMES_DASHBOARD_INSECURE=1`.
- **nous activation:** registers only when a client_id is set — env
  `HERMES_DASHBOARD_OAUTH_CLIENT_ID` (chart `dashboard.auth.oauthClientId`) wins
  over config.yaml `dashboard.oauth.client_id`. client_id shape `agent:{instance_id}`.
  Empty client_id → plugin is a no-op. See [[tech-hermes-agent-custom-provider]].
- **Redirect-URI tiers** (`dashboard_auth/routes.py:_redirect_uri`):
  `dashboard.public_url`/`HERMES_DASHBOARD_PUBLIC_URL` → else `X-Forwarded-Host`+`Proto`
  → else request URL. The **Portal allowlist is authoritative** (plugin's local
  check allows any `http(s)://…/auth/callback`).
- **Homelab gotcha:** instance runs `insecure: true` behind Traefik forwardAuth
  (see [[tech-traefik-forwardauth-oauth2-proxy]]), so the gate never engages →
  registering nous is **dormant** (no effect). The default Portal allowlist is
  `http://localhost:<port>/auth/callback` only, so it can't authenticate an
  Ingress URL — to make nous the real dashboard auth you must: turn insecure OFF,
  set `dashboard.public_url`, and add the public callback to the Portal allowlist.
