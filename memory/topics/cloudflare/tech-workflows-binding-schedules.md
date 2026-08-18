---
name: tech-workflows-binding-schedules
title: Workflows schedules skip Worker cron slots
description: Attach cron schedules on a Cloudflare Workflow binding so ingest runs without a Worker Cron Trigger
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, workflows, cron]
related: ["[[tech-cloudflare-pages-deploy]]", "[[project-news]]", "[[tech-cron-as-code-install-script]]"]
sources: ["https://developers.cloudflare.com/workflows/build/trigger-workflows/"]
created: 2026-08-18
updated: 2026-08-18
timestamp: 2026-08-18T14:30:00Z
---

Cloudflare Workflows can take `schedules` on the binding (`workflows` binding / `workflows[].schedules`). Each tick creates a Workflow instance. No Worker `scheduled()` handler and no `[triggers] crons` required.

Worker Cron Triggers are a separate quota (Free accounts are capped). A Workflow binding schedule does not spend that quota.

Use this when a Worker already owns a Workflow (ingest, notify, digest) and adding `[triggers] crons` would fail deploy. Docs: [Trigger Workflows](https://developers.cloudflare.com/workflows/build/trigger-workflows/). Related: [[tech-cloudflare-pages-deploy]], [[project-news]].
