---
name: chmonitor-one-codebase-saas
title: chmonitor — one codebase for OSS + Cloud SaaS, single-source env
description: How chmonitor ships self-hosted (OSS) and hosted SaaS from one codebase; the single-source .env env pattern that keeps Wrangler/Docker/K8s in sync
type: project
category: architecture
tags: [chmonitor, clickhouse, saas, cloudflare-workers, env-config, astro]
aliases: [dash.chmonitor.dev]
related: []
sources: ["https://github.com/chmonitor/chmonitor"]
created: 2026-06-29
updated: 2026-06-29
timestamp: 2026-06-29T00:00:00Z
---

chmonitor (open-source ClickHouse monitoring dashboard, GPL-3.0) ships BOTH the
self-hosted (OSS) product and the hosted Cloud SaaS (dash.chmonitor.dev) from ONE
codebase. The difference is purely runtime config behind a fail-closed
**cloud-mode** flag — unset/junk resolves to self-hosted, so OSS is never degraded.

- **Cloud mode on:** env hosts become a public read-only demo; signed-in users
  get a clean per-user workspace (connect their own ClickHouse); zero hosts →
  welcome/setup page instead of the overview. Auth via Clerk with public read.
- **Self-hosted:** env hosts are the operator's real hosts, full access, no demo.
- **Connect-a-host errors** are classified into kinds (host-not-allowed/SSRF,
  invalid URL, auth failed, access denied, DNS, refused, TLS, timeout) → each
  renders title + cause + fix + a per-kind docs link.

**Reusable env pattern (the durable lesson):** centralize all non-secret config
to committed `.env` files as the SINGLE source of truth, consumed by BOTH the
client build and the server/worker runtime.

**Why:** dual build-time vs runtime var sources (e.g. a Vite-inlined client flag
vs a Worker runtime var) silently drift — a flag set only at build time but read
at runtime breaks features in prod with no error at build.
**How to apply:** one canonical name per setting; derive the client-inlined
`VITE_*` from the canonical server `CHM_*` in the bundler config (set it once);
generate the deploy target's vars from the same `.env` file; never keep a second
hand-maintained copy (e.g. wrangler `[vars]`). Same names work for Docker
(`env_file`) and Helm (values → ConfigMap), so switching deploy targets is a
config swap, not a re-learn. Secrets stay out of committed `.env` (CI secret store
/ K8s Secret only).
