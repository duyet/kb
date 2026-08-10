---
name: tech-rust-wasm-when
title: When Rust WASM is worth it
description: "WASM usually wins only when the TS path is >~1ms hot work"
type: tech
category: web
tags: [tech, web, rust, wasm]
related: ["[[tech-wasm-prerender-ci]]", "[[user-duyet-lang-rust]]", "[[project-monorepo]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z---

Prefer TypeScript for most UI/data shaping. Use Rust→WASM when profiling shows >~1ms hot paths.

CI trap: [[tech-wasm-prerender-ci]]. Language context: [[user-duyet-lang-rust]].
