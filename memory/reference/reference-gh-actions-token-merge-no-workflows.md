---
name: reference-gh-actions-token-merge-no-workflows
title: GitHub Actions — default Actions token merges do not trigger further workflows
description: Squash-merge via github-actions bot with the default Actions token creates a push that skips CI and deploy workflows
type: reference
category: cicd
tags: [github-actions, automerge, actions-token, workflow-trigger]
aliases: [gh-actions-automerge-skips-push-ci, token-merge-no-workflow]
related: ["[[reference-gh-actions-concurrency-pending-cancel]]", "[[feedback-never-auto-merge-release-please]]"]
sources: ["https://docs.github.com/en/actions/security-guides/automatic-token-authentication#using-the-github_token-in-a-workflow"]
created: 2026-10-02
updated: 2026-10-02
timestamp: 2026-10-02T12:00:00Z
---

When a workflow merges a pull request with the default Actions token (`GITHUB_TOKEN`),
the resulting push to the default branch **does not start other workflows**. That is
intentional GitHub security: a bot credential cannot recursively fire Actions.
Observed 2026-10-02 on duyet/oma — automerge squash-merged #482 (and earlier #476/#479)
as `github-actions[bot]`; tip SHAs had PR CI green but **zero** `push` CI/deploy runs.

**Not the same as path filters.** Deploy workflows may correctly skip when only
`test/**` changed. CI on `push: branches: [main]` with no `paths:` key still never
starts after a default-token merge.

**How to apply:**

- After automerge, treat PR-head CI as the gate that already ran; do not assume tip
  push CI will confirm. Tip commit status may stay `pending` with only third-party
  checks (e.g. Socket Security).
- If tip push CI/deploy is required, merge with a PAT that is allowed to trigger
  workflows, re-run manually, or push an empty commit as a human/PAT.
- Do not invent a "test-only path filter skipped CI" explanation when `ci.yml` has
  no `paths:` filter — check `merged_by` first.
