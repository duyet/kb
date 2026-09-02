---
name: project-templatebot-pay-to-install
title: templatebot pay-to-install Sale listings
description: Sale templates require checkout before install; owners see 5% platform fee plus processor estimate and net
type: project
category: product
tags: [project, templatebot, payments, marketplace]
aliases: [templatebot-pay-to-install]
related: ["[[project-templatebot-verify-skill]]"]
sources: ["https://github.com/duyet/templatebot"]
created: 2026-09-02
updated: 2026-09-02
timestamp: 2026-09-02T08:52:59Z
---

On templatebot, **Sale** listings gate install behind checkout. Free listings stay one-click. Platform fee is **5%** of list price (`PLATFORM_FEE_BPS = 500`); Dodo processor estimate is separate; seller net = price − Dodo − platform.

**Why:** Unpaid buyers must not get `Open in Grok` / `Add to Grok Bot` or x.ai / grokbot URLs. Owners need the fee split visible on submit, dashboard, earnings, and pricing.

**How to apply:**
- Omit install/share URLs from HTML, preview, list payloads, `getTemplate`, `clickAndRedirect`, and `/llms.txt` unless the viewer is the owner or has a completed purchase.
- Buyers start Dodo checkout (`createBuyCheckout`); demo/unsigned users get a visible alert instead of an install control.
- Show shared owner fee breakdown (buyer pays / Dodo / platform 5% / you keep) on submit, dashboard, earnings, and pricing.
- Keep `/terms`, `/pricing`, FAQ, and `/llms.txt` aligned with pay-to-unlock and the 5% split.
- Prove with `.cursor/skills/verify-templatebot` feature `pay-to-install.md` and local D1 fixture `features/fixtures/paid-demo.sql` (Night Counsel). Leave Renovate Dependency Dashboard #6 alone.
