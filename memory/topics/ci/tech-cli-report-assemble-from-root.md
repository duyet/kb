---
name: tech-cli-report-assemble-from-root
title: CLI report assemble from repo root
description: Resolve --assemble/--report/--out from the repo root; do not cd into the crate first
type: tech
category: ci
tags: [tech, ci, cli, rust]
related: ["[[tech-pin-github-actions]]", "[[project-chmonitor-cli-local-connections]]"]
sources: ["https://github.com/chmonitor/chmonitor"]
created: 2026-08-28
updated: 2026-08-28
timestamp: 2026-08-27T18:32:00Z
---

`scripts/cli-build-report.sh --assemble` reads matrix JSON from the **workspace download dir** (CI: `cli-report-metrics` at the repo root).

- Resolve `--assemble` / `--report` / `--out` from the repo root
- Only `cd rust/` for the crate build path
- Relative `--assemble cli-report-metrics` (same as the workflow) must work from root
- `cd rust/` first makes the assemble step miss the artifacts (`no metrics json`) even when all matrix builds uploaded

Related: [[tech-pin-github-actions]], [[project-chmonitor-cli-local-connections]].
