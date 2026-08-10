---
name: tech-tanstack-stale-chunks
title: Stale route chunks after deploy
description: Missing lazy chunks throw reading 'component'; add reload guard + prerender shells
type: tech
category: web
tags: [tech, web, tanstack, deploy]
related: ["[[tech-tanstack-start-ssg]]", "[[project-anyrouter]]", "[[tech-cloudflare-pages-deploy]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

After deploy, old tabs may request deleted lazy chunks → runtime error on `component`.

Mitigations: soft reload on chunk load failure; keep critical shells prerendered. See [[tech-tanstack-start-ssg]], [[project-anyrouter]].
