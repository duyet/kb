---
name: tech-oma-cf-two-segment-invoke-package
title: CF two-segment package mounts need invokePackage
description: Cloudflare Hono wrappers for /v1/<group>/<name>/* must dispatch via invokePackage, not nested fetch on c.req.path
type: tech
category: agents
tags: [tech, agents, cloudflare, hono]
related: ["[[project-open-managed-agents]]", "[[tech-oma-credentials-out-of-sandbox]]"]
sources: ["https://github.com/duyet/oma"]
created: 2026-09-03
updated: 2026-09-03
timestamp: 2026-09-03T17:30:00Z
---

On Cloudflare, a Hono mount under `/v1/<group>/<name>` (two segments after `/v1`) must route through `invokePackage` with the two-segment prefix. Nesting `inner.fetch` on `c.req.path` leaves the mount prefix on the URL, so handlers for `/status` or `/connect` never match and return 404 even when the outer auth middleware ran.

Same class of bug for Telegram integrations and AnyRouter provider routes. Flat rewrite that drops only one segment also mis-routes.

Hub: [[project-open-managed-agents]].
