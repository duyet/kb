---
name: tech-cloudflare-pages-deploy
title: Cloudflare Pages deploy workflow
description: Commit→push→background-deploy convention for duyet.net apps on Cloudflare Pages, plus the parallel-deploy hazard
type: tech
category: infra
tags: [tech, cloudflare, deploy, ci, workflow]
related: ["[[project-duyet-net]]", "[[project-duyetbot]]", "[[tech-tanstack-start-ssg]]", "[[tech-rust-wasm-prerender]]", "[[feedback-working-style]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-04
timestamp: 2026-06-04T00:00:00Z
---

Each [[project-duyet-net]] app deploys to Cloudflare Pages
(`scripts/cf-deploy-prod.sh`, per-app `pnpm run cf:deploy:prod`,
`pages_build_output_dir = "dist/client"`).

**Per-task convention:** semantic commit → push to `master` → background-deploy
the changed app, then continue; verify production (`curl` → 200) after the
completion notification.

**Hazard:** never run two background deploys in parallel — the script renames
`.env.local` → `.env.local.deploy-bak` mid-run, so parallel runs collide and lose
the CF API token.

**CI (`cf-deploy.yml`):** matrix over apps on push to `master`; the blog entry
adds rust-toolchain + wasm-pack + `wasm:build:release` before build (see
[[tech-rust-wasm-prerender]]); other apps skip it.

**commitlint:** `subject-case` lowercase, `body-max-line-length` 100. Pre-commit
hook runs `pnpm run test`. Root checks before completing a multi-file task:
`pnpm run lint` (Biome) + `pnpm run check-types` + `pnpm run test`. Aligns with
[[feedback-working-style]]; run autonomously by [[project-duyetbot]].
