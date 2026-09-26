---
name: tech-daily-manager-leaves-worktrees
title: Daily coding-agent manager leaves worktrees open for review
description: Leave worktrees for human review, but never leave them dirty — commit the work first, and prove a branch landed before deleting it
type: tech
category: workflow
tags: [agents, worktree, review, git]
aliases: []
related: ["[[tech-agent-loop-cycle]]", "[[tech-eve-filesystem-agents]]", "[[tech-silent-scheduler-failure]]"]
sources: []
created: 2026-08-17
updated: 2026-09-27
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

## The two rules that keep "left open" from becoming "lost"

Leaving worktrees for review is only safe if a dirty worktree cannot lose work,
and only tidy if a merged one can actually be identified.

1. **Never leave a worktree dirty.** Commit to its own branch first — a local
   `wip(...)` commit is fine and needs no push. Observed cost of the
   alternative: 14 uncommitted files of real implementation parked in a worktree
   for a day, one `rm` from gone.
2. **Never trust `git branch --merged` after a squash merge.** Squash changes the
   sha, so a fully merged branch still reports "ahead 4, behind 9" and looks
   unmerged. Prove it by content instead:

   ```sh
   git diff <branch> origin/main -- $(git diff --name-only \
     $(git merge-base origin/main <branch>) <branch>)
   ```

   Empty output means every file it touched is byte-identical to `origin/main`.
   `git cherry` is the cheap complement: `-` means the patch is already upstream.

Corollary: `git status` reporting a branch as "ahead N" is not evidence of
unmerged work. Check the content. See [[tech-silent-scheduler-failure]].
