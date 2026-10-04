---
name: feedback-herdr-children-merge-clean
title: Herdr children — offload, merge, then remove
description: Offload implementation to parallel Herdr child worktrees, squash-merge finished PRs, then remove the worktree
type: feedback
category: workflow
tags: [feedback, workflow, tooling]
related: ["[[feedback-working-style]]", "[[feedback-never-auto-merge-release-please]]", "[[project-anyrouter]]"]
created: 2026-10-04
updated: 2026-10-04
timestamp: 2026-10-04T12:00:00Z
---

Standing rule for a manager session on a repo that uses [Herdr](https://herdr.dev) worktrees:

- Offload implementation to child worktrees. Resume dead sessions in small batches so the host stays usable. Do not implement features in the manager checkout.
- Heavy Node work runs once, in the manager session: `local-ci`, typecheck, vitest, `assets:build`, and app builds. Children do not run those in parallel.
- Group edits that touch the same files into one child. Split only independent work.
- When a child PR is ready, squash-merge it onto the repo's default branch, then remove that worktree.
- Leave a lane whose agent is still working, and any tree with uncommitted work that is not already on the default branch.
- Do not merge release-please or dependency-bump PRs ([[feedback-never-auto-merge-release-please]]).

**Why:** The user repeats this as the manager loop: children build, the manager integrates, finished checkouts go away.

**How to apply:** On each manager turn, list child worktrees, resume or spawn the unfinished ones, merge only gated PRs, and reclaim only landed trees.
