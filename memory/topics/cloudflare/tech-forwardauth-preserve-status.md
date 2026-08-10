---
name: tech-forwardauth-preserve-status
title: forwardAuth must preserve status
description: Error pages middleware can rewrite 302 challenges into 401/500 and break OAuth
type: tech
category: cloudflare
tags: [tech, traefik, oauth, ingress]
related: ["[[user-duyet-infra-kubernetes]]", "[[tech-cloudflare-pages-deploy]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

When Traefik forwardAuth + OAuth2 Proxy sit behind error middleware, ensure 302 challenges are not replaced by generic error pages.

Pattern: explicit redirect path for auth challenges. Generic edge auth lesson — no private hostnames.
