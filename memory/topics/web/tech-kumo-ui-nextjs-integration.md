---
name: tech-kumo-ui-nextjs-integration
title: Cloudflare Kumo UI + Next.js integration gotchas
description: Kumo (base-ui) + Phosphor crash RSC pre-render via createContext — every importer must be "use client"; plus Button/Tabs/Chart/Sidebar API differences
type: reference
category: web
tags: [kumo, cloudflare, nextjs, react, ui-library, phosphor]
aliases: ["kumo-ui", "cloudflare-kumo"]
related: ["[[tech-flat-design-system]]", "[[tech-tanstack-start-ssg]]"]
sources: ["https://kumo-ui.com/installation.md"]
created: 2026-06-14
updated: 2026-06-14
timestamp: 2026-06-14T00:00:00Z
---

Hard-won facts from migrating the AgentState dashboard (Next 16 + Turbopack + `output:"export"`) to `@cloudflare/kumo@2.5` from shadcn/ui. See [[project-agentstate-kumo-rebuild]].

**`createContext is not a function` is THE blocker.** Kumo (base-ui) AND `@phosphor-icons/react` (`IconContext`) call `React.createContext` at module top-level. RSC pre-render has no `createContext`, so **every file importing either must start with `"use client"`** — not just the obvious ones. `transpilePackages: ["@cloudflare/kumo","@base-ui/react","@phosphor-icons/react","echarts"]` is necessary but NOT sufficient.

**Tailwind v4 wiring** (`globals.css`): `@source "../../node_modules/@cloudflare/kumo/dist/**/*.{js,jsx,ts,tsx}";` then `@import "@cloudflare/kumo/styles/tailwind";` BEFORE `@import "tailwindcss";`. Without `@source`, Kumo utility classes silently vanish (e.g. dialogs not centered).

**API differences vs shadcn:**
- `Button` has **no `render`/`asChild`** → link buttons are `<Link href><Button>…</Button></Link>`. Default `variant` is `secondary` (map shadcn `default`→`primary`).
- `Tabs` is **array-based** (`tabs={[{value,label}]}` + controlled `value`/`onValueChange`), no `Tabs.Content`.
- **No `Chart`** → use `echarts` directly (it's a peer dep).
- `Sidebar`: use named `SidebarProvider` (not `Sidebar.Provider`); `SidebarMenuButton` has `href`+`active`+`tooltip` but **no `render`**.
- `Text` is a discriminated union: `heading1/2/3` REQUIRE matching `as="h1/2/3"`; **`className` is not accepted** on `Text` at all.

**Tokens:** Kumo ships `--color-kumo-*` (base, hairline, fill, danger, brand…) AND the standard names (`muted`, `foreground`, `border`…) resolve from your own `globals.css :root`. Don't invent `kumo-line`/`kumo-tint`/`kumo-subtle`/`kumo-strong` — they don't exist; only `kumo-base` does among the common ones.

**Phosphor:** `Activity` does NOT exist (use `Pulse`/`ChartLine`); both bare (`House`) and `*Icon` (`HouseIcon`) forms export. `lucide→phosphor`: Home→House, Settings→Gear, MessageSquare→ChatCircle, ChevronsUpDown→CaretUpDown, Building2→Buildings.

**Dark mode:** Kumo uses `data-mode="dark"` attr; shadcn uses `.dark` class. During migration set BOTH. Local docs via `bunx kumo doc <Name>` / `kumo ls` (web docs often rate-limited).

**Install:** `bun add @cloudflare/kumo @phosphor-icons/react echarts zod` (project uses Bun, not pnpm).
