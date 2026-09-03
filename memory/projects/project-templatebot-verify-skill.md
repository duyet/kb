---
name: project-templatebot-verify-skill
title: templatebot verify skill
description: Project-local .cursor/skills/verify-templatebot drives the Vite marketplace over CDP; Feature Map includes browse card coat blend, unlisted /data analytics, PostHog funnel, marquee, pay-to-install, MCP publish, live X embeds, multi-bot collect progress/skip/claim + master-detail publish, viewport presets
type: project
category: agents
tags: [project, templatebot, verification, cli]
aliases: [verify-templatebot]
related: ["[[feedback-pstack-verification]]"]
sources: ["https://github.com/duyet/templatebot"]
created: 2026-09-02
updated: 2026-09-03
timestamp: 2026-09-03T11:20:50Z
---

templatebot ships `.cursor/skills/verify-templatebot` (CLI lever + Feature Map + one proven drive). Primary surface is the local Vite/Cloudflare marketplace driven over Chrome DevTools Protocol via `control-templatebot.mjs`.

**Why:** `main` had no Playwright/Cypress suite and no verify skill. Agents need a composable launch/doctor/drive loop before feature ships.

**How to apply:**
- Use `control-templatebot.mjs` (`launch` / `doctor` / `goto` / drive / `cleanup`; `--json`, `--dry-run` on launch/stop/cleanup).
- Feature map covers browse (incl. `browse-marquee` on `/` only; coat-blend card surfaces via `surface-bot-card` / `botCardTint` in light+dark), preview (incl. `preview-scroll`), submit (incl. resubmit / history / X collect; post-submit Leaderboard vs Paid Template equal choices), leaderboard, dashboard, unlisted `/data` analytics (`features/data.md`), PostHog official JS funnel (`VITE_POSTHOG_PROJECT_TOKEN` env-only), pay-to-install (Sale; email + `/unlock/{token}`; `paid-demo.sql` / Night Counsel), and MCP publish (`features/mcp-publish.md`). Viewport presets: mobile 375×812 / desktop 1280×800.
- Proven drive: browse → Harvey search → Harvey Specter preview → `Close --exact`, then assert `scrollY` holds (no jump-to-top).
- `Close` needs `--exact` (Harvey card name includes `disclose`). Hero Browse is role button; clear search via `goto /templates`.
- Live paywall copy is `Checkout unlocks the install link` (not `unlock the install link`); `/unlock/{token}` sets `tb_unlock` so unpaid recipes must run first; `/privacy` shares terms email+unlock copy (`docs-terms`).
- Local vite skip HTTP→HTTPS redirect on loopback so doctor sees real HTML.
- Later ships: `/poteto-mode` plus this skill. Refresh with `/maintain-verification-skill` on ship. Cloud agents only; no git worktrees.

Generic loop: [[feedback-pstack-verification]].

**2026-09-03:** Squash-merged [#65](https://github.com/duyet/templatebot/pull/65) (`fd72151`) after [#45](https://github.com/duyet/templatebot/pull/45) `/data` ship — Feature Map now covers unlisted `/data`, PostHog funnel, multi-bot X collect on main.
**2026-09-03:** Squash-merged [#83](https://github.com/duyet/templatebot/pull/83) (`827735a`, closes #79) — Collecting N of M / skip-or-claim already-listed; then [#80](https://github.com/duyet/templatebot/pull/80) (`4bed5db`, closes #73) master-detail picker; [#85](https://github.com/duyet/templatebot/pull/85)/[#86](https://github.com/duyet/templatebot/pull/86) folded verify map (Publish N bots, Skip rows, marquee above FOOTER not H1).
**2026-09-03:** Squash-merged [#76](https://github.com/duyet/templatebot/pull/76) (`4aeac0a`, closes #70) — `/on-x` and homepage On X use official live X/Twitter embeds (`widgets.js`), not homemade URL cards.
