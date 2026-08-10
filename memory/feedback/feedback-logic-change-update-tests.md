---
name: feedback-logic-change-update-tests
title: Logic change → update related tests
description: Co-update tests in the same change; never wait for CI
type: feedback
category: testing
tags: [feedback, testing, workflow, ci]
related: ["[[feedback-fail-loud]]", "[[tech-codebase-maintenance-loop]]", "[[feedback-working-style]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

If you rename contracts or change behavior tests lock, grep tests and update expected values in the same PR.

**Why:** green "new code only" still breaks CI.
**How to apply:** run related suite before claiming done. See [[feedback-fail-loud]], [[tech-codebase-maintenance-loop]].
