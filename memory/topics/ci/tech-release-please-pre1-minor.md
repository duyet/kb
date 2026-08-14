---
name: tech-release-please-pre1-minor
title: Pre-1.0 feat may only bump patch
description: With bump-patch-for-minor-pre-major, feat in 0.x needs breaking marker for minor
type: tech
category: ci
tags: [tech, ci, release]
related: ["[[tech-release-please-basics]]", "[[tech-release-please-pr-title]]"]
created: 2026-08-10
updated: 2026-08-14
timestamp: 2026-08-14T12:00:00Z
---

In 0.x, `bump-patch-for-minor-pre-major: true` makes plain `feat` → patch (`feat!:` or BREAKING CHANGE for minor). Set it **false** (keep `bump-minor-pre-major: true`) if 0.x should move `0.1` → `0.2` on each feature release.

Related: [[tech-release-please-basics]], [[tech-release-please-pr-title]].
