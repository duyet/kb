---
name: project-duyet-net
title: duyet.net monorepo
description: Bun + Turborepo monorepo behind duyet.net — ~9 web apps on TanStack Start SSG, deployed to Cloudflare Pages
type: project
category: web
tags: [project, duyet, web, monorepo, cloudflare]
aliases: [monorepo]
related: ["[[user-duyet-profile]]", "[[reference-duyet-github]]", "[[tech-tanstack-start-ssg]]", "[[tech-cloudflare-pages-deploy]]", "[[project-duyetbot]]"]
sources: ["https://kb.duyet.net/llms.txt", "https://github.com/duyet/monorepo"]
created: 2026-06-04
updated: 2026-06-04
---

`duyet/monorepo` — Bun + Turborepo hosting all of [[user-duyet-profile]]'s public
web apps + shared packages. Most apps are TanStack Start SSG on Cloudflare Pages
(see [[tech-tanstack-start-ssg]], [[tech-cloudflare-pages-deploy]]).

**Apps** (subdomains of duyet.net), with pre-rendered page counts:
- `blog` (393) — TanStack Start SSG, WASM markdown, isomorphic `readPublicJson`.
- `llm-timeline` (3700+) — see [[project-llm-timeline]].
- `insights` (22) — AI/Claude usage analytics from CCUsage data.
- `home` (4), `cv` (2), `photos` (2), `homelab` (1), `ai-percentage` (1).
- `agents` — the **only** Vite SPA left; D1 Pages Functions block SSG. See [[project-duyetbot]].

**Shared packages:** `components` (design system), `libs` (WASM bindings re-export),
`wasm` (compiled Rust crates), `data-sync`, `api`, `config`, `urls`.

**Design:** flat/hairline design system — see [[tech-flat-design-system]]. Palette
varies per app (blog white `#ffffff`, others warm cream `#fbf7f0`).
WASM strategy: [[tech-rust-wasm-prerender]]. Maintained autonomously by [[project-duyetbot]].
