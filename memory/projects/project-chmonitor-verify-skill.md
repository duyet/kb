---
name: project-chmonitor-verify-skill
title: chmonitor verify skill
description: Project-local .cursor/skills/verify-chmonitor drives the Rust CLI; default doctor is identity-only
type: project
category: clickhouse
tags: [project, chmonitor, verification, cli]
aliases: [verify-chmonitor]
related: ["[[project-clickhouse-monitoring]]", "[[project-chmonitor-cli-local-connections]]", "[[feedback-pstack-verification]]"]
sources: ["https://github.com/chmonitor/chmonitor"]
created: 2026-09-02
updated: 2026-09-02
timestamp: 2026-09-01T18:37:00Z
---

chmonitor ships `.cursor/skills/verify-chmonitor` (CLI lever + Feature Map + one proven drive). Primary surface is the standalone `chm` / `chmonitor` binary from this checkout, not the hosted dashboard.

**Why:** Hosted dashboard `GET /api/healthz` is cluster-gated and can hang for minutes. That is not the identity prove.

**How to apply:**
- Launch this checkout's CLI, then `doctor.sh` (identity-only by default). Opt in to dashboard HTTP with `--http` / a short timeout.
- Canonical prove: `drive.sh local-connections` — `chm add` / `ls` / `use` / `rm` against isolated `--config` (no operator keyring).
- Later ships: `/poteto-mode` plus this skill. Refresh the skill when shipping, not on a weekday cron. Cloud agents only; no git worktrees.

Hub: [[project-clickhouse-monitoring]]. Generic loop: [[feedback-pstack-verification]]. Local store: [[project-chmonitor-cli-local-connections]].
