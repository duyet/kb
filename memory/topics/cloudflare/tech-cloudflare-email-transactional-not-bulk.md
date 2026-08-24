---
name: tech-cloudflare-email-transactional-not-bulk
title: Cloudflare Email Sending is transactional, not marketing bulk
description: Cloudflare Email Sending is for transactional mail; bulk/marketing campaigns belong on a dedicated ESP
type: tech
category: cloudflare
tags: [tech, cloudflare, email]
related: ["[[tech-cloudflare-workflows-reset-on-code-update]]", "[[user-duyet-infra-cloudflare]]"]
sources: ["https://developers.cloudflare.com/email-service/"]
created: 2026-08-24
updated: 2026-08-24
timestamp: 2026-08-24T18:00:00Z
---

Cloudflare Email Sending (Workers `send_email` binding or REST) is **transactional** — receipts, password resets, one-off lifecycle mail. Marketing and multi-thousand blasts are out of scope.

Bulk sends hit `E_RATE_LIMIT_EXCEEDED` / `E_DAILY_LIMIT_EXCEEDED` (or silent rejects) after a small successful prefix. Check `GET /accounts/{id}/email/sending/limits` before a large send. Use a dedicated ESP for campaigns.

Docs: [Email Service](https://developers.cloudflare.com/email-service/). Related: [[tech-cloudflare-workflows-reset-on-code-update]].
