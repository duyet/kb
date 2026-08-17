---
name: tech-herdr-morning-issue-desk
title: Morning Herdr issue-desk cron
description: Daily cron starts a Grok manager on main; children get isolated git worktrees; dated run folder stays on disk for review
type: tech
category: workflow
tags: [workflow, herdr, cron, agents, github]
aliases: []
related: ["[[tech-agent-loop-cycle]]", "[[feedback-never-auto-merge-release-please]]"]
sources: []
created: 2026-08-17
updated: 2026-08-17
timestamp: 2026-08-17T00:00:00Z
---

Unattended daily issue pass: a user-session terminal multiplexer (Herdr) is already running. Cron only talks to that socket.

- Morning: start or nudge a **manager** agent on the `main` checkout. Manager does not implement on `main`.
- Manager writes a **dated run folder** (queue, workers, summary) on disk; leave tabs/workspaces **open** for human review.
- Children: one isolated git worktree + one agent each. Cap concurrency (default 3).
- Nightly: if the manager is still live, ask it for a wrap file. Do not spawn a second evening manager.
- Timers are **code in the repo** (crontab snippet + systemd user units + install script). Re-run install on a new machine.
- If the multiplexer socket is missing, the cron job exits 0 and logs a skip.
- Never auto-merge release-please PRs.

**Why:** overnight GitHub triage without mixing work onto `main`.
**How to apply:** install the repo's issue-desk script; review the latest run folder and open workspaces in the morning.
