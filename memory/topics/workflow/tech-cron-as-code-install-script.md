---
name: tech-cron-as-code-install-script
title: Host cron lives in-repo behind an install script
description: Reproducible host jobs are committed crontab snippets plus an idempotent installer, not hand-edited crontab
type: tech
category: workflow
tags: [cron, ops, reproducibility]
aliases: []
related: ["[[tech-eve-filesystem-agents]]"]
sources: []
created: 2026-08-17
updated: 2026-08-17
timestamp: 2026-08-17T00:00:00Z
---

Durable host jobs belong in the repo: a `cron.lines` (or equivalent) file plus
an installer that wraps the block in `BEGIN`/`END` markers, replaces any prior
block, and can `--remove`. Hand-editing `crontab -e` is not reproducible on the
next machine.

**How to apply:** new machine runs the installer; do not copy crontab lines from
chat. When substituting command strings into crontab, do not use `sed` `s|||`
if the replacement contains `&` (`2>&1`) — `sed` treats `&` as the match.

**Why:** a missing or corrupted redirect silently drops job logs.
