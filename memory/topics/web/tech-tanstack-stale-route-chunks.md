---
name: tech-tanstack-stale-route-chunks
title: TanStack Router stale lazy route chunks
description: After Vite hash rotation, missing lazy chunks surface as reading 'component' — reload guard + prerender marketing shells
type: tech
category: web
tags: [tanstack, vite, cloudflare, deploy, frontend]
aliases: [stale chunk reload, reading component error]
related: ["[[tech-tanstack-start-ssg]]", "[[project-anyrouter]]", "[[tech-cloudflare-pages-deploy]]"]
sources: []
created: 2026-06-14
updated: 2026-06-14
timestamp: 2026-06-14T16:35:00Z
---

Post-deploy, users on an old main bundle may 404 a lazy route chunk (`pricing-*.js`). TanStack Router then throws **`Cannot read properties of undefined (reading 'component')`** — not caught by import-only preload handlers.

## Fix pattern (AnyRouter 2026-06-14)

1. Inline pre-import script: match import failures **and** router render errors; `sessionStorage` debounce (30s); listen `unhandledrejection`, `error`, `vite:preloadError`
2. Root `errorComponent` calls same reload helper when patterns match
3. Prerender public marketing routes so ASSETS HTML is hash-locked with current build (`<slug>.html`, not `index.html` — CF trailing-slash 307 trap)

**Why:** Default TanStack error UI sticks; users blame the page, not their cached bundle.

**How to apply:** On any TanStack Start + Vite code-split app with frequent deploys, extend stale-chunk recovery beyond dynamic-import strings; prerender high-traffic static shells in the two-deploy capture pass.