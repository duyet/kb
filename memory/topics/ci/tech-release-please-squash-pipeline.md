---
name: tech-release-please-squash-pipeline
title: release-please + squash-merge release pipeline
description: Conventional-commit release automation where squash-merge PR titles drive versioning; pre-1.0 bump rules and the PR-title guard that keeps it honest
type: reference
category: tech
tags: [release, release-please, ci, changelog, semver, github-actions]
aliases: []
related: ["[[tech-tanstack-start-ssg]]", "[[tech-cloudflare-pages-deploy]]"]
sources: ["https://github.com/duyet/clickhouse-monitoring/blob/main/.github/workflows/release-please.yml"]
created: 2026-06-13
updated: 2026-06-13
timestamp: 2026-06-13T00:00:00Z
---

Pattern used in chmonitor (clickhouse-monitoring) to fully automate releases.

- **release-please** watches `main`, keeps a standing `chore(main): release X.Y.Z`
  PR + tracked `CHANGELOG.md`. Merging it tags + publishes a GitHub Release,
  which fires a separate `release.yml` (on `release: published`, NOT tag push —
  avoids duplicate runs) to build Docker/assets and generate AI release notes.
- Config/manifest can live anywhere — pass `config-file` / `manifest-file` to
  the action. Moving them out of repo root into `.github/` keeps root clean.

**Pre-1.0 bump trap:** with `bump-patch-for-minor-pre-major: true`, in `0.x`
a plain `feat` only bumps the **patch**. To cut a new **minor** (e.g. 0.2→0.3)
the commit MUST be a breaking change (`feat!:` or `BREAKING CHANGE:` footer).

**The key guard:** squash-merge makes the **PR title** the commit release-please
reads. An invalid title is silently dropped from the bump + changelog. So add a
`pr-title` workflow that validates the title against the SAME
`commitlint.config.js` the husky hook uses (`echo "$PR_TITLE" | bunx commitlint`)
— one source of truth, no third-party action.

**CHANGELOG ownership:** release-please owns versioned blocks; keep a human
`## [Unreleased]` section on top for a curated preview — it's left untouched and
the generated block is inserted above it on release.

**AI migration prompt:** ship a paste-able env-migration prompt
(`.github/release-migration-prompt.md`) auto-appended to breaking releases and
mirrored in README + docs — lets users hand their `.env`/compose/k8s to any LLM
to upgrade.
