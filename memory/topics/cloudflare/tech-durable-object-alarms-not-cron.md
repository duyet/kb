---
name: tech-durable-object-alarms-not-cron
title: Durable Object alarms are not Worker cron triggers
description: DO alarm() can schedule work without consuming the account-wide Worker cron cap
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, durable-objects, cron]
related: ["[[tech-cloudflare-cron-triggers-five-per-account]]", "[[tech-workflows-binding-schedules]]"]
sources: ["https://developers.cloudflare.com/durable-objects/api/alarms/"]
created: 2026-08-28
updated: 2026-08-28
timestamp: 2026-08-28T06:58:00Z
---

Cloudflare Durable Object `alarm()` wakes a DO at a chosen time. Alarms are **not** Worker `[triggers] crons` and do **not** count toward the account-wide 5-cron cap ([[tech-cloudflare-cron-triggers-five-per-account]]).

Workflow binding `schedules` are a different product and paid-only ([[tech-workflows-binding-schedules]]). On a Free plan, a DO alarm (or an external GitHub Actions POST) can start periodic work without a sixth Worker cron or a paid Workflow schedule.

Docs: [Durable Object Alarms](https://developers.cloudflare.com/durable-objects/api/alarms/).
