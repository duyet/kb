---
name: tech-og-images-static-prerender
title: Per-page OG images in a static-prerendered app
description: Build-time Open Graph cards from one registry feeding both the generator and the route head; meta must be in prerendered HTML for crawlers
type: tech
category: web
tags: [tech, og, social, seo, satori, tanstack, prerender]
related: ["[[tech-tanstack-start-ssg]]", "[[project-clickhouse-monitor]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-15
updated: 2026-06-15
timestamp: 2026-06-15T00:00:00Z
---

**Goal:** unique 1200×630 social-share images per page on a static site, without
adding a runtime image renderer.

**Two flavours of "dynamic":**
- *Build-time* — generate one committed `og-<slug>.png` per page; regenerate on
  every deploy. No worker bundle cost. **Default choice** for static-first apps.
- *Request-time* — a `/og?title=…` worker route rendering live (Satori + resvg
  WASM). Truly dynamic but adds WASM weight to the worker bundle; avoid unless
  needed.

**Pipeline (build-time):** [Satori](https://github.com/vercel/satori) (HTML/CSS
object tree → SVG) + `@resvg/resvg-js` (SVG → PNG). Make it **hermetic**: vendor
the TTF fonts in-repo so no network access — safe inside CI deploy jobs. It's
deterministic (no timestamps/random), so regenerating unchanged cards yields
**byte-identical** PNGs — git diff = objective proof a refactor changed nothing.

**Single registry = no drift.** One map `slug → {eyebrow, title, description}`
feeds *both* consumers: (1) the generator loops it to emit `og-<slug>.png`, and
(2) a `pageOgHead(slug)` helper builds the route `<head>` meta. A standalone bun
script can import the app's TS registry directly — keep that file free of React /
path-alias imports.

**Crawler correctness — the check that matters:** social crawlers (Slack, X,
Facebook) don't run JS. The OG meta MUST be in the *prerendered* HTML, not
injected client-side. With TanStack Start SSG the route `head()` runs at build
and bakes tags into `dist/client/<route>/index.html`. Verify by grepping the
built HTML, and on prod check the image returns `200 image/png` with
`cf-cache-status: MISS` right after deploy (proves fresh, not edge-cached).

Root layout holds the shared defaults (`og:type`, `og:image:width/height`,
`twitter:card=summary_large_image`); per-route `head()` overrides title + image.
Pages without a registry entry fall back to the site-wide default image.

Shipped in chmonitor [[project-clickhouse-monitor]] (PRs #1614/#1615 base,
#1617 extended to per-page query pages).
