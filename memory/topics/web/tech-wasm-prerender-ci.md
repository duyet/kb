---
name: tech-wasm-prerender-ci
title: WASM prerender CI trap
description: Missing wasm build step makes prerender succeed empty or fail late
type: tech
category: web
tags: [tech, web, wasm, ci]
related: ["[[tech-rust-wasm-when]]", "[[tech-tanstack-start-ssg]]", "[[tech-cloudflare-pages-deploy]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

SSG pipelines that import WASM must build release WASM in CI before prerender. Silent empty pages are worse than hard fail.

Related: [[tech-rust-wasm-when]], [[tech-tanstack-start-ssg]], [[tech-cloudflare-pages-deploy]].
