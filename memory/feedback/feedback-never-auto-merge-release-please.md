---
name: feedback-never-auto-merge-release-please
title: Never auto-merge release-please PRs
description: Leave release-please and changeset version PRs for human merge
type: feedback
category: release
tags: [feedback, release, ci, github]
related: ["[[tech-release-please-basics]]", "[[feedback-working-style]]"]
created: 2026-08-10
updated: 2026-09-04
timestamp: 2026-09-04T02:00:00+07:00
---

Do not auto-merge release PRs. Skip:

- release-please: branch starts with `release-please--`, or title starts with `chore(release)` / `chore(<scope>): release` / `chore: release`
- changeset Version Packages: branch starts with `changeset-release/`, or title is `Version Packages` / `chore: version packages`

Ordinary `feat` / `fix` / `ci` PRs may still automerge.

**How to apply:** fix/CI babysit only; human merges releases. Generic automerge should skip those branch/title patterns from the default branch so a PR cannot rewrite the skip table. See [[tech-release-please-basics]], [[project-open-managed-agents]].
