---
name: tech-squash-merge-hides-branch-cleanup
title: Squash merges break patch-id branch cleanup, so ask the forge
description: git cherry and patch-id report landed branches as unmerged in a squash-merging repo
type: tech
category: ci
tags: [tech, ci, git, release-please]
related: ["[[tech-release-please-pr-title]]", "[[tech-release-please-basics]]", "[[feedback-semantic-commits]]"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

Merged-branch cleanup based on `git cherry` or patch-id silently fails in a repo
that squash-merges, because a squash rewrites every patch-id. Landed branches
then look unmerged forever and are never cleaned up.

**Why:** release-please plus squash PR titles means the PR title is the release
commit, so squash is the norm rather than the exception. In `duyet/herdr-desk`
this left three dead branches looking live, and made `git log main..branch`
report six already-landed commits as pending.

**How to apply:** treat the forge as the authority, not patch-id. A branch is
spent only when it has at least one **merged** PR *and* no open PR. The "at
least one" clause is the load-bearing part: an empty PR list means *unknown*,
not *all merged*, and treating it as merged deletes in-flight work that was
pushed but not yet proposed — which in a shared working tree can be another
agent's branch. Keep `git cherry` only as a backstop for forge lag.

Skip the base branch, forge-managed release branches, and any branch pattern
created at runtime. Pair it with a scheduled workflow, dry-run by default.

A diff against the base is still the tie-breaker when a squash makes hashes
diverge: if moving from `main` to the branch is mostly deletions, the branch is
behind, not ahead.
