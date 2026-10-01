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
timestamp: 2026-10-01T12:10:00Z
---

When the work is done (tests pass, change is meant to go live), **commit, push, and deploy** in the same turn. The user says this as `cp and deploy`. Do not stop after the edit, and do not ask whether to ship.

**Why:** Deploy is the default end of the loop, not a follow-up question.

**How to apply:** conventional commit ([[feedback-semantic-commits]]), push, and land it on GitHub `main` so CI deploys. For this monorepo that is a PR merged to `main`, then the Cloudflare Pages workflow (`cf-deploy.yml`). Confirm the deploy run. Run `pnpm run cf:deploy -- <app> --prod` only when CI will not pick the change up, and only from a commit already on `origin/main` with a clean `apps/` and `packages/`. The script refuses otherwise.

Before that merge, run `git log origin/main..HEAD -- apps packages`. If it lists commits, those edits are only on the local checkout. Merging an unrelated PR still rebuilds production from GitHub `main` and rolls the live site back to the older copy. Put the missing files on the PR first. This is what reverted the long "I don't read code anymore" post.
