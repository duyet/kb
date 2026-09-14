---
name: feedback-commit-push-deploy
title: Commit and push to deploy
description: After shipping work, commit and push so CI deploys — do not wait to be asked
type: feedback
category: git
tags: [feedback, workflow, git, deploy]
related: ["[[feedback-working-style]]", "[[feedback-semantic-commits]]"]
created: 2026-09-14
updated: 2026-09-14
timestamp: 2026-09-14T09:20:00Z
---

When the work is done (tests pass, change is meant to go live), **commit and push** in the same turn. Do not leave a finished change sitting uncommitted or unpushed.

**Why:** Deploy is the default end of the loop, not a follow-up question.

**How to apply:** conventional commit ([[feedback-semantic-commits]]), push the current branch. Ask only if the user forbade git, or the change is clearly a local experiment.
