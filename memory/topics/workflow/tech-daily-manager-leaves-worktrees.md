---
name: tech-daily-manager-leaves-worktrees
title: Daily coding-agent manager leaves worktrees open for review
description: Overnight issue-fanout should persist worktrees and a dated summary folder instead of tearing down panes
type: tech
category: workflow
tags: [agents, worktree, review]
aliases: []
related: ["[[tech-agent-loop-cycle]]", "[[tech-eve-filesystem-agents]]"]
sources: []
created: 2026-08-17
updated: 2026-08-17
timestamp: 2026-08-17T00:00:00Z
---

A morning manager that fans GitHub issues into isolated git worktrees should
**not** close those worktrees when a child finishes. Persist a dated folder
(`SUMMARY.md`, issue picks, per-child status) in the repo so the next morning
is a review, not an archaeology pass.

**How to apply:** cron starts the manager; nightly cron only refreshes the
summary; humans close or merge after reading the summary.

**Why:** transcripts disappear; filesystem state plus open panes are the review
surface.
