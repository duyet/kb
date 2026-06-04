---
name: feedback-working-style
description: How Duyet wants agents to work — concise English, semantic commits, simple solutions
metadata:
  type: feedback
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
