---
name: feedback-pstack-verification
title: pstack verification is infra
description: Agents must close the loop themselves with a project-local verify skill, a CLI lever, a Feature Map, and cloud agents — not worktrees
type: feedback
category: working-style
tags: [feedback, pstack, verification, agents]
aliases: [pstack-verification, verification-is-infra]
related: ["[[feedback-working-style]]", "[[feedback-fail-loud]]", "[[user-duyet-ai-vibe-codes]]"]
sources: ["https://x.com/poteto/status/2094457600259842065", "https://github.com/poteto/verification-skill-example"]
created: 2026-09-01
updated: 2026-09-01
timestamp: 2026-09-01T16:50:00Z
---

Verification is the highest-leverage skill: the agent drives the real app, captures proof, and keeps going until the change is true. Treat it as infra, not optional markdown.

**Why:** Without a closed loop, a human is the bottleneck. Volume only helps if quality stays high.

**How to apply:**
- Generate `.cursor/skills/verify-<app>/` with `/create-verification-skill` (CLI lever + Feature Map + one proven drive).
- Prefer tools over prose ("Build the Lever"): composable CLI, `--dry-run` on destructive commands, JSON output, rich `--help`.
- Parallelize with Cursor cloud agents, not git worktrees.
- Ship prompts: `/poteto-mode` plus the repo's verify skill (screenshots, video, or transcripts as proof).
- Refresh the skill as the app changes (`/maintain-verification-skill` on ship, not a new clock wake unless asked).
