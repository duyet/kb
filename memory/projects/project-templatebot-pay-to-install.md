---
name: project-templatebot-pay-to-install
title: templatebot pay-to-install Sale listings
description: Sale templates require checkout before install; delivery is email plus secret unlock URL; owners see 5% platform fee plus processor estimate and net
type: project
category: product
tags: [project, templatebot, payments, marketplace]
aliases: [templatebot-pay-to-install]
related: ["[[project-templatebot-verify-skill]]"]
sources: ["https://github.com/duyet/templatebot"]
created: 2026-09-02
updated: 2026-09-03
timestamp: 2026-09-03T05:40:00Z
---

On templatebot, **Sale** listings gate install behind checkout. Free listings stay one-click. Platform fee is **5%** of list price (`PLATFORM_FEE_BPS = 500`); Dodo processor estimate is separate; seller net = price − Dodo − platform.

After pay, fulfilment mints an unguessable `unlock_token`, emails the install link (Resend when configured), and `/unlock/{token}` shows install to that buyer. Unpaid Sale must not expose Add to Grok Bot, Open in Grok, View/Copy x.ai, or x.ai/grokbot URLs in HTML/JSON; marketplace share (`?bot=` / `/bot/{id}`) stays public. Buy is the only primary CTA until unlock.

**Why:** Unpaid buyers must not get install paths. Paid buyers need a durable delivery path without relying on a signed-in session alone. Owners need the fee split visible on submit, dashboard, earnings, and pricing.

**How to apply:**
- Omit install URLs from HTML, preview, list payloads, `getTemplate`, `clickAndRedirect`, and `/llms.txt` unless the viewer is the owner, has a completed purchase, or holds a valid unlock token.
- Buyers start Dodo checkout (`createBuyCheckout`); demo/unsigned users get a visible alert instead of an install control.
- Product page: left card is the bot (no install until paid); right panel is Unlock this bot (Buy). After unlock, Add is on the left card and Buy is gone.
- Show shared owner fee breakdown (buyer pays / Dodo / platform 5% / you keep) on submit, dashboard, earnings, and pricing.
- Keep `/terms`, `/pricing`, FAQ, and `/llms.txt` aligned with pay-to-unlock, email + unlock URL delivery, and the 5% split.
- Prove with `.cursor/skills/verify-templatebot` feature `pay-to-install.md` and local D1 fixture `features/fixtures/paid-demo.sql` (Night Counsel). Leave Renovate Dependency Dashboard #6 alone.
