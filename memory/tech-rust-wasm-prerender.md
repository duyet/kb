---
name: tech-rust-wasm-prerender
title: Rust→WASM strategy + prerender CI trap
description: When WASM beats TS (>1ms compute only), and the silent-prerender CI trap when the gitignored WASM binary is missing
type: tech
category: web
tags: [tech, rust, wasm, performance, ci]
related: ["[[project-duyet-net]]", "[[tech-tanstack-start-ssg]]", "[[tech-cloudflare-pages-deploy]]", "[[user-duyet-stack]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-04
---

7 Rust crates compiled to WASM (`crate-type=["cdylib"]`) replace TS in
`@duyet/libs` ([[project-duyet-net]]). Apps import `@duyet/libs/*`, never WASM directly.

**Migration rule:** only migrate a TS function to WASM if its TS mean > ~1 ms.
JS↔WASM string marshaling costs ~30–40 µs/call, so sub-100 µs ops are parity or
slower. Only `markdown-to-html` cleared it: 6.3 ms → 0.08 ms (~79x). Slower
crates (normalizers, dedup, csv, exif, diff, string-utils) kept for consistency
+ future batch APIs that amortize marshal cost.

**CI trap:** `**/pkg/` is gitignored → WASM must be built in CI before the build
step. With `prerender.failOnError:false`, a missing binary makes `markdownToHtml`
throw, the route is silently skipped, no `index.html` written, and CF Pages
serves the homepage at every post URL (looks like a routing bug; deploy logs green).
**Fix:** CI runs rust-toolchain + wasm-pack + `wasm:build:release` before build,
gated on the blog app. **Diagnose:** healthy blog build = 700+ `index.html` in
`dist/client/`; grep build log for `markdownToHtml`/"Failed to convert".
See [[tech-tanstack-start-ssg]], [[tech-cloudflare-pages-deploy]].
