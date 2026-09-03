---
name: project-oma-verify-skill
title: oma verify skill
description: Project-local .cursor/skills/verify-oma with control-oma.mjs CLI lever and Feature Map for web + Console
type: project
category: agents
tags: [project, oma, verification, cli]
aliases: [verify-oma]
related: ["[[project-open-managed-agents]]", "[[feedback-pstack-verification]]"]
sources: ["https://github.com/duyet/oma"]
created: 2026-09-03
updated: 2026-09-03
timestamp: 2026-09-03T06:00:00Z
---

duyet/oma ships `.cursor/skills/verify-oma` (CLI lever `control-oma.mjs` + Feature Map under `features/`). Added in #430 with the marketing/Console `cn` migrate.

**Why:** Later ships should drive landing + Console as a user, with screenshots/JSON proof, not only typecheck.

**How to apply:**
- First prove path already landed with the skill: `control-oma launch web` → `doctor` → `drive landing-home` → `landing-check`; Console login drive for `#auth-email` / Sign in.
- Later ships: `/poteto-mode` plus this skill. Refresh on ship, not a weekday cron. Cloud agents only; no git worktrees. No invented env or secrets.

Hub: [[project-open-managed-agents]]. Generic loop: [[feedback-pstack-verification]].
