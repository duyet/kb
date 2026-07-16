---
name: project-chmonitor-one-codebase-saas
title: chmonitor — one codebase for OSS + Cloud SaaS, single-source env
description: How chmonitor ships self-hosted (OSS) and hosted SaaS from one codebase; deployment-mode flag fail-closed to OSS; the single-source .env pattern that keeps Wrangler/Docker/K8s in sync
type: project
category: architecture
tags: [chmonitor, clickhouse, saas, cloudflare-workers, env-config]
aliases: [dash.chmonitor.dev, chmonitor-one-codebase-saas]
related: ["[[project-clickhouse-monitor]]"]
sources: ["https://github.com/chmonitor/chmonitor"]
created: 2026-06-29
updated: 2026-07-16
timestamp: 2026-07-16T15:10:00Z
---

chmonitor (open-source ClickHouse monitoring dashboard) ships BOTH the
self-hosted (OSS) product and the hosted Cloud SaaS (dash.chmonitor.dev) from ONE
codebase. The difference is purely runtime config behind a fail-closed flag chain:
`CHM_DEPLOYMENT_MODE=oss|cloud` is the single high-level switch that resolves
defaults for cloud mode, auth provider (Clerk), public read, and per-user D1
storage — unset/junk resolves to self-hosted, so OSS is never degraded.

- **Cloud mode on:** env hosts become a public read-only demo; signed-in users
  get a clean per-user workspace (connect their own ClickHouse); zero hosts →
  welcome/setup page. Billing via Polar (webhook → D1 → plan resolution, fails
  open to Free for OSS).
- **Self-hosted:** env hosts are the operator's real hosts, full access, no demo.
  Invariant: never gate a core monitoring feature behind cloud mode.
- **Connect-a-host errors** are classified into kinds (SSRF/host-not-allowed,
  invalid URL, auth failed, DNS, refused, TLS, timeout) → title + cause + fix +
  per-kind docs link.

**Reusable env pattern (the durable lesson):** centralize all non-secret config
to committed `.env` files as the SINGLE source of truth, consumed by BOTH the
client build and the server/worker runtime.

**Why:** dual build-time vs runtime var sources (a Vite-inlined client flag vs a
Worker runtime var) silently drift — a flag set only at build time but read at
runtime breaks features in prod with no error at build.
**How to apply:** one canonical name per setting; derive the client-inlined
`VITE_*` from the canonical server `CHM_*` in the bundler config; generate the
deploy target's vars from the same `.env` file; never keep a second
hand-maintained copy (e.g. wrangler `[vars]`). Same names work for Docker
(`env_file`) and Helm (values → ConfigMap). Secrets stay out of committed `.env`.
