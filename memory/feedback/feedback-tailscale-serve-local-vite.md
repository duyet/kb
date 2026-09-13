---
name: feedback-tailscale-serve-local-vite
title: Tailscale Serve for local Vite
description: When asked for Tailscale or remote access to a local Vite/TanStack app, bind Vite on every interface and add a tailnet-only Serve proxy. Never Funnel unless asked.
type: feedback
category: workflow
tags: [feedback, workflow, tooling, infra]
aliases: [tailscale-serve-dev]
related: ["[[feedback-working-style]]", "[[user-duyet-local-dev]]"]
sources: ["https://tailscale.com/kb/1247/funnel-serve-use-cases"]
created: 2026-09-14
updated: 2026-09-14
timestamp: 2026-09-14T00:00:00Z
---

When the user asks for Tailscale, tailnet, or remote access to a running local Vite/TanStack app, expose it with **Tailscale Serve** (tailnet only).

**Why:** Direct HTTP on the Vite port is often blocked; Serve terminates HTTPS on the MagicDNS name.

**How to apply:**
1. Vite `server.host` listens on every interface. `allowedHosts` includes the Tailscale MagicDNS suffix plus the node's name from `tailscale status`.
2. Do **not** `tailscale serve reset` (it wipes other proxies).
3. Do **not** enable Funnel unless the user asks for the public internet.
4. Add a mapping: `tailscale serve --bg --https=<httpsPort> --yes <vitePort>` on a free HTTPS port (check `tailscale serve status` first).
5. Reply with the `https://<magicdns>:<httpsPort>/` URL from `tailscale serve status`.
