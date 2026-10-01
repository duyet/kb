---
name: reference-gh-actions-concurrency-pending-cancel
title: GitHub Actions — cancel-in-progress false still cancels the pending run, and a paths filter makes the replacement useless
description: Back-to-back merges silently drop master builds; with per-path filtering the newer green run does not rebuild the earlier merge's images
type: reference
category: cicd
tags: [github-actions, concurrency, paths-filter, publish-gap, silent-failure]
aliases: [gh-actions-pending-run-eviction, docker-images-publish-gap]
related: ["[[reference-herdr-child-dispatch-verify]]"]
sources: []
created: 2026-09-28
updated: 2026-09-28
timestamp: 2026-09-28T09:00:00Z
---

`cancel-in-progress: false` does **not** mean "no run is ever cancelled". GitHub
keeps one *running* plus one *pending* run per concurrency group, and **a third
arrival cancels the pending one**. Merge three PRs in a minute and the first two
`master` runs are dropped before they start.

The workflow comment usually only describes the half that is prevented ("a running
build is not killed mid-push") and calls the limit "at most one run + one pending
run per ref" without mentioning the eviction. It reads like a guarantee.

**Why it bites harder than it looks:** if the build matrix is filtered with
`dorny/paths-filter` and only push-to-main runs publish (`push:
${{ github.event_name != 'pull_request' }}`), then the surviving newer run does
**not** rebuild the earlier merge's images. The PR proved the image builds and
nothing ever pushed it. Published tags silently lag the branch, and every check
in the repo is green. Observed 2026-09-28 in duyet/docker-images: `minio_latest`
on master said alpine 3.24 while the registry still served 3.20.10, digest
unchanged from the day before.

**How to apply:**

- Never accept "the cancelled run has a newer green replacement" as a dismissal
  unless the replacement's path filter provably covers the same images.
- After a burst of merges, verify the **published** manifest, not the workflow
  status: read the digest, `created` timestamp, and inherited build history
  (`ADD alpine-minirootfs-<ver>-…` in the amd64 config blob names the actual base)
  for every image the merges touched.
- Remediate by re-running the cancelled run, but only once the group has a free
  pending slot — rerunning while a run is pending evicts that one and just moves
  the gap.
- Durable fixes: drop the concurrency limit for push events, make the push run
  cumulative, or assert the published base in CI. Cause fix plus a detection
  check; either alone leaves the other hole.
- Related: [[reference-herdr-child-dispatch-verify]].
