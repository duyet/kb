---
name: feedback-issue-research-pr
title: Issue → research → PR: require the verify path before implementation
description: An issue is addressable only when it names where the change starts, what the behaviour becomes, and which check proves it
type: feedback
category: workflow
tags: [feedback, workflow, issues, agents, review]
related: ["[[feedback-docs-driven-development]]", "[[feedback-surgical-changes]]", "[[tech-improvement-loop]]", "[[feedback-logic-change-update-tests]]"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

The contract that makes agent-written PRs reviewable, stated once and enforced
everywhere (human, desk, and sub-agent alike):

1. **Issue** — one problem, with an observable symptom and its evidence (a log
   line, an `rg` hit, a failing check). No "improve X" without a symptom.
2. **Research** — before any code, the issue answers: **where** (exact files and
   the line you start at), **what** (the behaviour after, in one sentence a
   reviewer could disagree with), **verify** (the test name, CI check, or command
   with expected output), and **not already done** (issues, PRs, `git log`).
3. **PR** — one concern, no drive-by renames or dependency bumps, description
   states the issue, the verify path, and the blast radius.

**Why:** "there is no verify path" is itself the finding — an agent that cannot
name the check will ship a plausible diff that nothing proves, and the reviewer
pays for it. Naming *where* is what keeps parallel agents from colliding on the
same file, and naming *what* is what turns a review from "is this right?" into
"is this what we asked for?".

**How to apply:**

- **Research-only is a valid outcome.** A vague issue, a product decision, or a
  finding whose right output is knowledge gets a note, and the cycle stops. Do
  not open a weak PR to look productive, and do not guess a product decision on
  a timer.
- **`needs-design` is a hard stop** for every agent, unattended ones included. It
  means a human owes a decision.
- Skip a step if you must — just never skip it *silently*, and record why in the
  issue.

See [[tech-improvement-loop]], [[feedback-docs-driven-development]].
