---
name: tech-cloudflare-pages-deploy
title: Cloudflare Pages deploy habit
description: Semantic commit → push → deploy changed app; avoid parallel deploys that share env files
type: tech
category: cloudflare
tags: [tech, cloudflare, deploy, ci]
related: ["[[tech-tanstack-start-ssg]]", "[[project-monorepo]]", "[[feedback-semantic-commits]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Habit: commit → push → deploy the changed Pages app → verify HTTP 200.

Hazard: scripts that rename local env files mid-deploy must not run in parallel.
Related: [[tech-tanstack-start-ssg]], [[project-monorepo]], [[feedback-semantic-commits]].
