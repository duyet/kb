---
name: tech-cloudflare-workflows-reset-on-code-update
title: Updating a Worker resets in-flight Cloudflare Workflows
description: Deploying a Worker that hosts a running Workflow resets the Durable Object and fails the instance
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, workflows]
related: ["[[tech-workflows-binding-schedules]]", "[[tech-cloudflare-cron-triggers-five-per-account]]"]
sources: ["https://developers.cloudflare.com/workflows/"]
created: 2026-08-24
updated: 2026-08-24
timestamp: 2026-08-24T18:00:00Z
---

A Cloudflare Workflow instance is a Durable Object. Deploying new code for the **host Worker** resets that DO. The instance fails with `Durable Object reset because its code was updated`.

List or wait for instances (`wrangler workflows instances list`) before deploying the host. Do not treat a new instance as a clean retry of side effects already written by the old run.

Related: [[tech-workflows-binding-schedules]], [[tech-cloudflare-cron-triggers-five-per-account]].
