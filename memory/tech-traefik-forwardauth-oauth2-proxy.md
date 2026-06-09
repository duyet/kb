---
name: tech-traefik-forwardauth-oauth2-proxy
title: Traefik forwardAuth + OAuth2 Proxy + nginx redirector pattern
description: Traefik ErrorPages middleware preserves original status (won't pass 302 through), so forwardAuth with OAuth2 needs an nginx redirector to convert 401→302
type: tech
category: infra
tags: [tech, infra, traefik, oauth2, k8s, auth]
related: ["[[user-duyet-stack]]"]
created: 2026-06-09
updated: 2026-06-09
---

Pattern for protecting k8s services behind GitHub OAuth2 via Traefik forwardAuth.

## Architecture

```
Request → Traefik IngressRoute
  → forwardAuth middleware (points to auth-redirector:9190/auth)
    → auth-redirector (nginx) proxies to oauth2-proxy:4180/oauth2/auth
      → 200: pass through (authenticated)
      → 401: nginx intercepts → 302 to oauth2-proxy login
```

## Key insight: why nginx redirector is needed

Traefik's `ErrorPages` middleware replaces the response body but **keeps the original status code**. When oauth2-proxy returns 302 on unauthenticated requests, ErrorPages rewrites it — the redirect never reaches the browser. The nginx redirector intercepts the 401 from oauth2-proxy and returns its own 302 with the correct `Location` header. This is a known Traefik limitation, not a bug.

## OAuth2 Proxy callback URL

Must use the proxy prefix path `/oauth2/callback`, not `/callback`:

```
redirect-url: "https://auth.example.com/oauth2/callback"
login URL:     "https://auth.example.com/oauth2/start?rd=<original-url>"
```

## Traefik Middleware config

```yaml
apiVersion: traefik.io/v1alpha1
kind: Middleware
spec:
  forwardAuth:
    address: http://auth-redirector.<ns>.svc.cluster.local:9190/auth
    authResponseHeaders:
      - X-Auth-Request-Email
      - X-Auth-Request-User
    trustForwardHeader: true
```

Apply to IngressRoute via `middlewares` annotation or CRD middleware chain.
