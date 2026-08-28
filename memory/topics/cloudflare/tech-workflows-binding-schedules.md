---
name: tech-workflows-binding-schedules
title: Workflows schedules need a paid Workers plan
description: Workflow binding schedules avoid Worker cron slots but wrangler deploy fails on Free because schedules are paid-only
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, workflows, cron]
related: ["[[tech-cloudflare-pages-deploy]]", "[[project-news]]", "[[tech-durable-object-alarms-not-cron]]", "[[tech-cron-as-code-install-script]]"]
sources: ["https://developers.cloudflare.com/workflows/build/trigger-workflows/"]
created: 2026-08-18
updated: 2026-08-28
timestamp: 2026-08-28T06:58:00Z
---

Cloudflare Workflows accept `schedules` on the binding. Each tick starts a Workflow instance. That does **not** use Worker `[triggers] crons` (Free accounts cap those).

`schedules` itself is paid-only. On a Free plan, `wrangler deploy` can upload the Worker then exit 1 attaching the schedule. The Worker may stay live; CI still goes red.

On Free: trigger the Workflow from a Durable Object alarm ([[tech-durable-object-alarms-not-cron]]), GitHub Actions, or another external cron — not from `workflows[].schedules` and not from Worker crons. Docs: [Trigger Workflows](https://developers.cloudflare.com/workflows/build/trigger-workflows/). Related: [[tech-cloudflare-pages-deploy]], [[project-news]].
