---
name: project-clickhouse-monitor
title: ClickHouse Monitor (chmonitor)
description: Open-source ClickHouse monitoring dashboard — monorepo topology (7 apps on Cloudflare Workers), OSS + Cloud SaaS split, AI agent, alerting, design system
type: project
category: projects
tags: [project, clickhouse, chmonitor, cloudflare, tanstack, pnpm, ai-agent]
aliases: [chmonitor, clickhouse-monitoring]
related: ["[[project-chmonitor-one-codebase-saas]]", "[[lessons-chmonitor-homelab-deploy]]", "[[reference-duyet-github]]", "[[user-duyet-stack]]", "[[tech-tanstack-start-ssg]]"]
sources: ["https://github.com/chmonitor/chmonitor", "https://chmonitor.dev", "https://docs.chmonitor.dev"]
created: 2026-06-14
updated: 2026-08-10
timestamp: 2026-08-10T10:11:57Z
---

github.com/chmonitor/chmonitor (moved from duyet/clickhouse-monitoring) — flagship ClickHouse ops UI. Monorepo on **pnpm 10** with isolated per-app workspaces (root workspace covers only `apps/mcp` + `packages/*`); **bun is the test runner only**, never the package manager.

## Apps (Cloudflare Workers)

| App | Role | URL |
|-----|------|-----|
| `apps/dashboard` | TanStack Start dashboard (the product) | dash.chmonitor.dev |
| `apps/landing` | marketing site | chmonitor.dev |
| `apps/docs` | **Fumadocs** on TanStack Start (content synced from `docs/content/`) | docs.chmonitor.dev |
| `apps/blog` | blog | blog.chmonitor.dev |
| `apps/mcp` | MCP server | dash.chmonitor.dev/api/mcp |
| `apps/bug-handler` | Email Worker: Sentry alert emails → GitHub issues | bug@chmonitor.dev |
| `apps/cloud-hooks` | Cloud ops Worker: Polar webhook + Telegram notifications + crons | hooks.chmonitor.dev |

## Current state (2026-08)

- **Cloud SaaS live**: Clerk auth, per-user D1 connections, Polar billing, `CHM_DEPLOYMENT_MODE=oss|cloud` (fail-closed to OSS) — see [[project-chmonitor-one-codebase-saas]].
- **Published image:** `ghcr.io/chmonitor/chmonitor` (not the old `ghcr.io/duyet/chmonitor` path). Helm chart: `https://charts.chmonitor.dev`.
- **Public dash vs self-host:** `dash.chmonitor.dev` is Cloud/demo (limited); private homelab k3s runs a full-cluster instance — see [[lessons-chmonitor-homelab-deploy]].
- **AI agent**: Vercel AI SDK (not LangGraph), ~29 lean tools + skill recipes; AI Insights engine (collect→enrich→persist, stable-key dismissal).
- **Health alerting**: dual dispatch worlds (client polling + server cron sweep), adapters (webhook/Slack/PagerDuty/Opsgenie/email), D1 routing/maintenance/ack/history; expansion epic chmonitor#2669 (Telegram/ntfy/Teams/quiet-hours/digest/smart rule suggestions).
- **Design system**: OKLCH tokens + shadcn (Base UI), `product-design` project skill is the source of truth; smart-detection "section-returns-null" pattern for conditional dashboard sections.
- Dev knowledge lives in-repo at `docs/knowledge/` (linked knowledge graph, ~25 notes) — read that first when working in the repo.

**Why:** agents touching chmonitor need the right app paths, package manager, and the OSS/Cloud invariant before editing.
**How to apply:** dashboard work → `apps/dashboard` (see its CLAUDE.md); `pnpm` for everything except `bun test`; never gate core monitoring features behind cloud mode; verify with `pnpm run build` + `pnpm run lint`.
