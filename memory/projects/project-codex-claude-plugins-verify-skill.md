---
name: project-codex-claude-plugins-verify-skill
title: codex-claude-plugins verify skill
description: Project-local .cursor/skills/verify-marketplace; CLI lever on catalogs/manifests, not a hosted UI
type: project
category: agents
tags: [project, marketplace, verification, cli]
aliases: [verify-marketplace]
related: ["[[feedback-pstack-verification]]"]
sources: ["https://github.com/duyet/codex-claude-plugins"]
created: 2026-09-03
updated: 2026-09-03
timestamp: 2026-09-03T02:11:00+07:00
---

duyet/codex-claude-plugins ships `.cursor/skills/verify-marketplace` (CLI lever + Feature Map + one proven drive). Surface is marketplace JSON and plugin manifests, not a hosted web app.

**Why:** Agents need a closed loop before Grok/logo/harness ships. `main` had no `.cursor/skills/verify-*` until PR 86.

**How to apply:**
- Use `control-marketplace.mjs` (`doctor`, `info`, `list`, `check-install`, `validate`; `--json`; `--dry-run` on `install-antigravity` and `cleanup`). Controller v1.1.0 after #88.
- Proven drives: `marketplace-catalog` (Claude), `codex-install` (Codex), `grok-build-and-bot` (Grok; skip fails).
- Grok Build / Grok Bot are first-class after #87 (harnesses) and squash-merged #88 (verify treats those slots as real; prove pass on master `a2c28a3`).
- Later ships: `/poteto-mode` plus this skill. Refresh on ship, not weekday cron. Cloud agents only; no git worktrees.

Generic loop: [[feedback-pstack-verification]].
