---
name: project-templatebot-verify-skill
title: templatebot verify skill
description: Project-local .cursor/skills/verify-templatebot drives the Vite marketplace over CDP; proven browse + Harvey Specter preview
type: project
category: agents
tags: [project, templatebot, verification, cli]
aliases: [verify-templatebot]
related: ["[[feedback-pstack-verification]]"]
sources: ["https://github.com/duyet/templatebot"]
created: 2026-09-02
updated: 2026-09-02
timestamp: 2026-09-02T04:03:00Z
---

templatebot ships `.cursor/skills/verify-templatebot` (CLI lever + Feature Map + one proven drive). Primary surface is the local Vite/Cloudflare marketplace driven over Chrome DevTools Protocol via `control-templatebot.mjs`.

**Why:** `main` had no Playwright/Cypress suite and no verify skill. Agents need a composable launch/doctor/drive loop before feature ships.

**How to apply:**
- Use `control-templatebot.mjs` (`launch` / `doctor` / `goto` / drive / `cleanup`; `--json`, `--dry-run` on launch/stop/cleanup).
- Feature map covers browse, preview, submit, leaderboard, dashboard.
- Proven drive: browse templates → search Harvey → open Harvey Specter preview dialog.
- Local vite skip HTTP→HTTPS redirect on loopback so doctor sees real HTML.
- Later ships: `/poteto-mode` plus this skill. Refresh with `/maintain-verification-skill` on ship. Cloud agents only; no git worktrees.

Generic loop: [[feedback-pstack-verification]].
