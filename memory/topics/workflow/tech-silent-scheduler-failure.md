---
name: tech-silent-scheduler-failure
title: A failing scheduled job looks exactly like one with nothing to do
description: Count consecutive failures per job, not last status; a stale path can kill every future fire permanently
type: tech
category: workflow
tags: [tech, workflow, cron, observability, agents]
related: ["[[tech-agent-loop-cycle]]", "[[tech-improvement-loop]]", "[[tech-daily-manager-leaves-worktrees]]"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

A cron/agent job that throws before it does its work produces **the same
observable state as a job with no work**: no output, no artifacts, no diff. The
only difference lives in a log nobody reads.

Observed cost: 24 consecutive daily fires died on one `EISDIR` (a *directory*
sitting where a `writeFileSync` expected to write a file). 35 of 40 run
directories were empty. It recovered by accident, when an unrelated config edit
plus a reinstall happened to clear the path. See [[tech-daily-manager-leaves-worktrees]].

**Why:** `writeFileSync` on an existing directory throws — and because it
happens *before* the work starts, the failure is permanent rather than
transient, and self-inflicted rather than environmental.

**How to apply:**

- **Never** let a scheduled job's success be "no error was raised". Write a
  heartbeat artifact (a `changes.md`, a state row with a real value) so "did
  nothing" and "could not start" are distinguishable.
- **Report consecutive failures, not the last status.** `Last: fail` is one red
  word in a wide table; `Fails: 24 from <date>` is the number that gets read.
  Replayed against a real ledger, that one column would have named the outage
  on day two instead of day twenty-four.
- **Make writes self-healing.** Clear the path before writing
  (`rm -rf <pointer>` then write) so a stale file, dir, or symlink is a non-event.
- **Make the health check the first finding** of any self-improvement loop — if
  the scheduler is broken, every other automated job is silently a no-op too.
- An **empty run directory** is the cheapest smell there is. Alert on the
  directory existing with no files in it.
