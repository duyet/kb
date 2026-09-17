---
name: tech-helm-vendored-deps-gitignore
title: Vendor Helm deps; bare `charts/` in .gitignore hides them
description: A bare `charts/` gitignore pattern silently strips vendored Helm dependency tarballs from git, breaking source installs
type: tech
category: ci
tags: [tech, helm, charts, gitignore, kubernetes]
related: ["[[project-charts]]", "[[feedback-fail-loud]]"]
sources: ["https://github.com/duyet/charts/issues/237"]
created: 2026-09-17
updated: 2026-09-17
timestamp: 2026-09-17T00:00:00Z
---

Helm repos that vendor dependencies must commit `charts/*.tgz` per chart. A
bare `charts/` line in `.gitignore` matches **every** chart's dependency dir
(chart repos rarely have a top-level `charts/` dir), so `helm dependency
build` works locally but tarballs are silently never committed. Committed
`Chart.lock` + missing `charts/` is the tell. Published packages look fine
when CI builds deps before packaging — only source clones break.

**Why:** `helm template`/`lint`/`install` fail out of the box ("found in
Chart.yaml, but missing in charts/ directory") with no visible cause.

**How to apply:** anchor the ignore (e.g. `/charts/`) or delete it; commit
vendored tarballs via `helm dependency build` and verify with a fresh-clone
`helm template`. Vendor rather than drop declarations when templates
reference default endpoints like `{{ .Release.Name }}-<dep>`. Related:
[[project-charts]], [[feedback-fail-loud]].
