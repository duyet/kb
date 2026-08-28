---
name: tech-cloudflare-cron-triggers-five-per-account
title: Cloudflare Worker cron triggers cap at five per account
description: Cron triggers are capped at 5 per Cloudflare account, not per Worker
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, cron]
related: ["[[tech-workflows-binding-schedules]]", "[[tech-durable-object-alarms-not-cron]]", "[[tech-cron-as-code-install-script]]"]
sources: ["https://developers.cloudflare.com/workers/configuration/cron-triggers/"]
created: 2026-08-24
updated: 2026-08-28
timestamp: 2026-08-28T06:58:00Z
---

Cloudflare caps Worker `[triggers] crons` at **5 per account**, not per Worker. Shared accounts fill the slots fast. Deploy error is `10072 — You have exceeded the limit of 5 cron triggers`.

Omitting the `triggers` block does **not** clear an existing cron. Emit `"triggers": { "crons": [] }` (or PUT `[]` to the schedules API) to release a slot. Workflow binding `schedules` are a different product and paid-only ([[tech-workflows-binding-schedules]]). Durable Object `alarm()` is another Free-safe scheduler and does not use a cron slot ([[tech-durable-object-alarms-not-cron]]).
