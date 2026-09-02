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
timestamp: 2026-09-03T02:08:00+07:00
---

duyet/codex-claude-plugins ships `.cursor/skills/verify-marketplace` (CLI lever + Feature Map + one proven drive). Surface is marketplace JSON and plugin manifests, not a hosted web app.

**Why:** Agents need a closed loop before Grok/logo/harness ships. `main` had no `.cursor/skills/verify-*` until PR 86.

**How to apply:**
- Use `control-marketplace.mjs` (`doctor`, `info`, `list`, `check-install`, `validate`; `--json`; `--dry-run` on `install-antigravity` and `cleanup`).
- Proven drive: `marketplace-catalog` (Claude catalog/install paths). Codex may report a pre-existing `command-code` catalog gap.
- Grok Build / Grok Bot are first-class after #87 (harnesses) and #88 (verify skill no longer skips those slots). `command-code` is indexed in Codex.
- Later ships: `/poteto-mode` plus this skill. Refresh on ship, not weekday cron. Cloud agents only; no git worktrees.

Generic loop: [[feedback-pstack-verification]].
