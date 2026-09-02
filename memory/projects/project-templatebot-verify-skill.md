---
name: project-templatebot-verify-skill
title: templatebot verify skill
description: Project-local .cursor/skills/verify-templatebot drives the Vite marketplace over CDP; Feature Map includes pay-to-install, MCP publish, and mobile/desktop viewport presets
type: project
category: agents
tags: [project, templatebot, verification, cli]
aliases: [verify-templatebot]
related: ["[[feedback-pstack-verification]]"]
sources: ["https://github.com/duyet/templatebot"]
created: 2026-09-02
updated: 2026-09-02
timestamp: 2026-09-02T13:36:00Z
---

templatebot ships `.cursor/skills/verify-templatebot` (CLI lever + Feature Map + one proven drive). Primary surface is the local Vite/Cloudflare marketplace driven over Chrome DevTools Protocol via `control-templatebot.mjs`.

**Why:** `main` had no Playwright/Cypress suite and no verify skill. Agents need a composable launch/doctor/drive loop before feature ships.

**How to apply:**
- Use `control-templatebot.mjs` (`launch` / `doctor` / `goto` / drive / `cleanup`; `--json`, `--dry-run` on launch/stop/cleanup).
- Feature map covers browse, preview (incl. `preview-scroll`), submit (incl. resubmit versions, Submit history, X post collect), leaderboard, dashboard, pay-to-install (Sale listings; local fixture `paid-demo.sql` / Night Counsel), and MCP publish (`features/mcp-publish.md`; Streamable HTTP `/mcp` + agent HTTP; Free-only over MCP). Viewport presets: `viewport --preset mobile` (375×812) and `--preset desktop` (1280×800); layout proof needs both sizes plus overflow eval.
- Proven drive: browse → Harvey search → Harvey Specter preview → `Close --exact`, then assert `scrollY` holds (no jump-to-top).
- `Close` needs `--exact` (Harvey card name includes `disclose`). Hero Browse is role button; clear search via `goto /templates`.
- Local vite skip HTTP→HTTPS redirect on loopback so doctor sees real HTML.
- Later ships: `/poteto-mode` plus this skill. Refresh with `/maintain-verification-skill` on ship. Cloud agents only; no git worktrees.

Generic loop: [[feedback-pstack-verification]].
