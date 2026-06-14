---
name: project-clickhouse-monitor
title: ClickHouse Monitor (chmonitor)
description: Open-source ClickHouse monitoring dashboard — monorepo topology, domains, marketing/docs apps, design system
type: project
category: projects
tags: [project, clickhouse, chmonitor, cloudflare, astro, tanstack]
aliases: [chmonitor, clickhouse-monitoring]
related: ["[[reference-duyet-github]]", "[[user-duyet-stack]]", "[[tech-cloudflare-pages-deploy]]"]
sources: ["https://github.com/duyet/clickhouse-monitoring", "https://chmonitor.dev", "https://docs.chmonitor.dev"]
created: 2026-06-14
updated: 2026-06-14
timestamp: 2026-06-14T23:55:00Z
---

github.com/duyet/clickhouse-monitoring — flagship ClickHouse ops UI (~240★, GPL-3.0).

## Domains (Cloudflare Workers)

| Worker | App | URL |
|--------|-----|-----|
| `chmonitor-landing` | `apps/landing` (Astro static) | chmonitor.dev |
| `chmonitor-dash` | `apps/dashboard` (TanStack Start) | dash.chmonitor.dev |
| `chmonitor-docs` | `apps/docs` (Astro custom theme) | docs.chmonitor.dev |
| `chmonitor-mcp` | `apps/mcp` | dash.chmonitor.dev/api/mcp* |

PR previews: `preview.chmonitor.dev`, `preview.docs.chmonitor.dev`, `preview.dash.chmonitor.dev`.

`apps/landing` and `apps/docs` are **outside** the root bun workspace (isolated installs).

## Marketing design system (2026-06-14)

Shared landing + docs vibe:
- **Display:** Bricolage Grotesque · **Body:** Source Sans 3 · **Mono:** JetBrains Mono
- **Palette:** zinc fg (`#09090b`), amber `#f59e0b` → orange `#f97316` accent
- **CTA copy:** nav/buttons say **Dashboard** / **Open dashboard** (not "Open Cloud")
- Landing hero: browser-frame dashboard carousel + stats strip + lazy-loaded gallery marquee

Docs: custom Astro theme (not Starlight); Pagefind search; versioned via `scripts/sync-docs.mjs`.

## CI gotcha

`component-test` (Cypress) fails on main when no `src/**/*.cy.{ts,tsx}` specs exist — needs `supportFile: false` in `cypress.config.ts` component block or actual component specs.

**Why:** Agents editing marketing/docs need the right app paths and shared tokens — not the dashboard TanStack app.

**How to apply:** Landing/docs changes → `apps/landing` + `apps/docs` only; build with `bun run build:landing` and `cd apps/docs && bun run build`; deploy via `landing.yml` / `docs.yml` / `cloudflare.yml`.