---
name: tech-automation-gate-vacuous
title: A per-package task gate is a no-op when no package defines the task
description: turbo/CI gate that runs `run lint` lints nothing unless a package defines it; align the local hook and CI on one command
type: tech
category: ci
tags: [tech, ci, gates, turbo, pnpm, husky]
related: ["[[tech-agent-loop-cycle]]", "[[feedback-main-ci-green-fast]]", "[[feedback-fail-loud]]"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

A CI job that runs a per-package orchestrator (`turbo run lint`,
`nx run-many -t lint`) lints **only the packages that define that script**. If
none do, the job passes on an empty task list and reports success over thousands
of files. It is green, fast, and worthless.

Paired failure: the local pre-push hook runs a *stricter* command than CI
(`biome check` = lint + format + assist, vs CI's `biome lint`, which never
reports `assist/source/organizeImports`). Drift then lands through any green PR
until the hook rejects **every** push, including unrelated ones — so everyone
starts using `--no-verify` and the gate is fully disarmed.

**Why:** the two gates are written independently and never compared, so the
stricter one becomes the thing everyone bypasses, and the looser one provides
false assurance. Neither is a bug in either command; the bug is the divergence.

**How to apply:**

- Audit every "green" gate by asking *what does it actually execute?* Check that
  the task exists in at least one package, or that it is not a per-package
  orchestrator.
- **Run the identical command locally and in CI.** One command, two places.
  When they must differ, make CI the superset and say why in a comment.
- The moment a hook needs `--no-verify` to be productive, the hook is wrong.
  Treat the first `--no-verify` as a defect report, not a convenience.
- Before "fixing" a newly-armed gate that flags a wall of unrelated files,
  autofix in a dedicated change — do not widen the ignore list.
- Check a stricter tool covers what CI runs before assuming CI is green: a
  formatter/import-order rule that only `check` reports is invisible to `lint`.

See also [[feedback-main-ci-green-fast]], [[feedback-fail-loud]].
