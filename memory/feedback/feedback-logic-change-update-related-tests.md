---
name: feedback-logic-change-update-related-tests
title: Logic change → update related tests same change
description: When changing production logic/names/contracts, agents must find and update related tests in the same change — never wait for CI
type: feedback
category: workflow
tags: [feedback, testing, agents, workflow, ci]
related: ["[[feedback-working-style]]", "[[tech-codebase-maintenance-loop]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T09:01:42Z
---

Agents must co-update related tests whenever they change production logic.

**Rule:** If you rename titles, enums, API fields, registry entries, template keys, or change behavior a test locks — **grep for the old literals under tests**, update expected values, run the related suite, and ship tests with the logic change. Do not declare done on green “new code only.”

**Why:** Exact-set / title / inventory asserts fail only after renames. Leaving tests for CI produces misleading failures (“missing chart X”) when the real bug is a stale expected name. Bisect also lands on a red intermediate commit.

**How to apply:**
1. After any non-test edit, `rg` the **old** strings/symbols in `**/tests/**`, `test_*`, `*.test.ts(x)`.
2. Update asserts to the new contract; keep the invariant (do not weaken).
3. Run the related test file(s); then commit.
4. Prefer co-located tests and exact-set inventory tests so drift is loud.

Project-specific detail for dp-llm-assistant lives in-repo
(`docs/internal-docs/development/42-logic-change-update-related-tests.md` + CLAUDE.md Testing).
