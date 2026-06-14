---
name: feedback-working-style
title: Working style preferences
description: How Duyet wants agents to work — concise English, semantic commits, simple solutions
type: feedback
category: workflow
tags: [feedback, duyet, workflow]
related: ["[[user-duyet-profile]]", "[[tech-codebase-maintenance-loop]]"]
created: 2026-06-04
updated: 2026-06-04
timestamp: 2026-06-04T00:00:00Z
---

Working preferences for agents collaborating with [[user-duyet-profile]].

- **Language:** respond in English. (Vietnamese is native, but English is the
  default for work.)
- **Communication:** concise, evidence over assumption, no filler words like
  "comprehensive/extensive". Surface tradeoffs and uncertainty; don't hide confusion.
- **Code:** simplest solution that works. No speculative abstractions, no
  features beyond what was asked. Surgical changes — touch only what's needed.
- **Commits:** semantic format, consistent scope, simple English.
- **Autonomy:** comfortable with `/loop` for recurring maintenance; values
  non-disruptive operations (never destructive actions without explicit ask).

**Why:** Duyet is a senior engineer who optimizes for maintainability and low
noise; over-engineering and verbosity waste his time.

**How to apply:** default to less code and fewer words; ask before big or
irreversible moves; match the existing codebase's conventions.
