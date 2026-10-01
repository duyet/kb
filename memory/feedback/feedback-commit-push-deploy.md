---
name: feedback-commit-push-deploy
title: Commit and push to deploy
description: After shipping work, always commit, push, and deploy — do not wait to be asked
type: feedback
category: git
tags: [feedback, workflow, git, deploy]
related: ["[[feedback-working-style]]", "[[feedback-semantic-commits]]"]
created: 2026-09-14
updated: 2026-10-01
timestamp: 2026-10-01T08:45:00Z
---

When the work is done (tests pass, change is meant to go live), **commit, push, and deploy** in the same turn. The user says this as `cp and deploy`. Do not stop after the edit, and do not ask whether to ship.

**Why:** Deploy is the default end of the loop, not a follow-up question.

**How to apply:** conventional commit ([[feedback-semantic-commits]]), push, and land it on `main` so CI deploys. For this monorepo that is a PR merged to `main`, then the Cloudflare Pages workflow (`cf-deploy.yml`). Confirm the deploy run, or run `pnpm run cf:deploy -- <app> --prod` when CI will not pick it up. Ask only if the user forbade git, or the change is clearly a local experiment.
