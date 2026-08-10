# `topics/ci/`

## Concepts

- [Pin GitHub Actions](tech-pin-github-actions.md) — Pin actions to version or commit SHA; moving major tags can be force-pushed
- [Pre-1.0 feat may only bump patch](tech-release-please-pre1-minor.md) — With bump-patch-for-minor-pre-major, feat in 0.x needs breaking marker for minor
- [release-please basics](tech-release-please-basics.md) — Standing release PR + CHANGELOG; merge tags and publishes
- [Squash PR title is the release commit](tech-release-please-pr-title.md) — Under squash-merge, PR title becomes the commit release-please reads
- [Two-phase Trivy scan](tech-trivy-two-phase.md) — Report job always succeeds; separate fail-on-severity job gates the build
