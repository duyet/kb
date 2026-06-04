---
name: tech-tanstack-start-ssg
title: TanStack Start SSG (Cloudflare)
description: Why + how to prerender a Vite app with TanStack Start SSG to survive Cloudflare Rocket Loader
type: tech
category: web
tags: [tech, tanstack, ssg, cloudflare, vite]
related: ["[[project-duyet-net]]", "[[tech-cloudflare-pages-deploy]]", "[[tech-rust-wasm-prerender]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-04
---

**Problem:** Cloudflare Rocket Loader rewrites `<script type="module">` to a
deferred non-module script → Vite SPA entry never bootstraps → blank page.
**Fix:** pre-render HTML so content exists before JS runs. (Also disable Rocket
Loader per domain in the CF dashboard as belt-and-suspenders.)

**Migrate Vite SPA → TanStack Start SSG** (~8 files/app):
- `vite.config.ts`: swap `TanStackRouterVite()` for `tanstackStart({ prerender:
  { enabled: true, crawlLinks: true, failOnError: false } })`; drop
  `@vitejs/plugin-react`; do NOT pass `autoCodeSplitting` (not in schema).
- Delete `index.html` + `main.tsx`; add `entry-client.tsx` (`hydrateRoot`),
  `entry-server.tsx` (`createStartHandler`).
- `router.tsx` must export a `getRouter()` factory, not a const.
- `__root.tsx` renders full `<html>` doc; move `<meta>`/`<link>` into route `head()`.
- Build output `dist` → `dist/client`; set `pages_build_output_dir` in `wrangler.toml`.

**Gotchas:** paths in config are relative to `srcDirectory` (`src`); local
`fetch('/data.json')` fails in SSR — use isomorphic loading (`fs.readFile` on
SSR, `fetch()` on client); absolute API URLs work in both. `failOnError:false`
hides prerender errors — see [[tech-rust-wasm-prerender]]. Deploy: [[tech-cloudflare-pages-deploy]].
