# `topics/ci/`

## Concepts

- [A new CodexBar provider is a declarative spec plus one TypeScript plugin](tech-codexbar-new-provider-is-a-plugin.md) — CodexBar moved simple API-key providers to bundled QuickJS plugins; a new provider is ~25 lines of Swift plus a .ts file, not bespoke Swift
- [A per-package task gate is a no-op when no package defines the task](tech-automation-gate-vacuous.md) — turbo/CI gate that runs `run lint` lints nothing unless a package defines it; align the local hook and CI on one command
- [CLI report assemble from repo root](tech-cli-report-assemble-from-root.md) — Resolve --assemble/--report/--out from the repo root; do not cd into the crate first
- [Pin GitHub Actions](tech-pin-github-actions.md) — Pin actions to version or commit SHA; moving major tags can be force-pushed
- [Pre-1.0 feat may only bump patch](tech-release-please-pre1-minor.md) — With bump-patch-for-minor-pre-major, feat in 0.x needs breaking marker for minor
- [release-please basics](tech-release-please-basics.md) — Standing release PR + CHANGELOG; merge tags and publishes
- [Squash merges break patch-id branch cleanup, so ask the forge](tech-squash-merge-hides-branch-cleanup.md) — git cherry and patch-id report landed branches as unmerged in a squash-merging repo
- [Squash PR title is the release commit](tech-release-please-pr-title.md) — Under squash-merge, PR title becomes the commit release-please reads
- [Two-phase Trivy scan](tech-trivy-two-phase.md) — Report job always succeeds; separate fail-on-severity job gates the build
- [Vendor Helm deps; bare `charts/` in .gitignore hides them](tech-helm-vendored-deps-gitignore.md) — A bare `charts/` gitignore pattern silently strips vendored Helm dependency tarballs from git, breaking source installs
