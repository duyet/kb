---
name: tech-gh-squash-uses-head-commit-title
title: gh pr merge --squash titles the commit from the head commit, not the PR title
description: Editing the PR title does not change the squash commit message unless --subject is passed; release-please then reads the wrong type
type: tech
category: ci
tags: [tech, ci, github, release]
aliases: []
related: ["[[tech-release-please-pr-title]]"]
sources: []
created: 2026-10-09
updated: 2026-10-09
timestamp: 2026-10-09T00:00:00Z
---

`gh pr merge --squash` without `--subject` takes the squash commit's subject
from the **head commit's title**, not from the (edited) PR title. Editing the PR
title to fix a bad conventional-commit prefix therefore has no effect on the
commit that lands, and release-please — which reads the squash commit — parses
the typo (`feat(here)` stays `feat(here)`).

**Why:** the kb rule "squash PR title is the release commit" assumes the title
and the commit agree; when the head commit carries a typo, only `--subject`
fixes what lands.
**How to apply:** pass `--subject 'feat(scope): …'` explicitly when merging, or
fix the head commit on the branch before merging. Fixing it afterwards means
rewriting `main`.
