---
name: tech-codebase-maintenance-loop
title: Codebase maintenance loop
description: Improvement-cycle sweeps, safe dead-code removal, and test discipline used to keep duyet.net low-debt
type: tech
category: workflow
tags: [tech, refactor, quality, tests, workflow]
related: ["[[project-duyetbot]]", "[[feedback-working-style]]", "[[tech-cloudflare-pages-deploy]]", "[[project-duyet-net]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-04
---

How [[project-duyetbot]] keeps [[project-duyet-net]] low-debt — extends
[[feedback-working-style]] with concrete tooling.

**Improvement cycles:** periodic scoped sweeps, one debt category each (security,
dedup/shadcn, privacy/cache, data-sync, DB, design, tests). ~9 cycles / ~155
fixes by early 2026; cycle 9 added 104 tests + unified the design system. Run a
cycle: `git log --since=<date> --name-only` to scope → fix → test before/after →
one semantic commit per logical change.

**Safe dead-code removal:** before deleting a symbol, prove zero non-test refs:
`rg -n "<symbol>" apps packages --glob '!**/*.test.*' --glob '!**/*.spec.*'`.
Empty output = safe. `pnpm why <pkg>` to check dep overrides. Record durable
findings in the core-memory doc — do NOT create dated review files.

**Tests:** `pnpm run test` from root (also the pre-commit hook). A test must fail
when business logic changes (encode WHY, not just WHAT). Priority by risk:
security/credentials → data transforms (normalizers, slugs, markdown) → render
correctness → edge cases.
