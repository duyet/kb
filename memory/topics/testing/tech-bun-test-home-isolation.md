---
name: tech-bun-test-home-isolation
title: Bun writes .bun into a test fixture HOME — assert app state paths, not HOME emptiness
description: Bun creates ~/.bun (install/cache dirs) under whatever HOME is set when it runs, so hermetic tests must not assert an empty fixture HOME — assert the app-owned state dir is absent instead
type: reference
category: testing
tags: [reference, bun, testing, isolation, fixtures, gotcha, hermetic]
aliases: ["bun test fixture HOME polluted", "empty HOME assertion fails under bun"]
related: ["[[tech-bun-hoisting]]", "[[tech-e2e-db-external-sandbox]]"]
sources: []
created: 2026-09-17
updated: 2026-09-17
timestamp: 2026-09-17T00:00:00Z
---

When a test sets `HOME` to a fixture dir and spawns `bun` (e.g. `bun --eval`,
`bun run file.ts`, or importing modules in a child), Bun may create `<HOME>/.bun`
— its install/cache directory — inside the fixture, even when nothing installs.

**Consequence:** assertions like `readdirSync(fixtureHome)).toEqual([])` fail with
`[".bun"]`, and before/after HOME snapshot comparisons are order-dependent (they
pass only if an earlier test already created `.bun`).

**Fix the invariant, not the fixture:** the property under test is "the app wrote
no state", not "HOME stayed empty". Assert the application-owned paths instead:

- the app state dir under the fixture (`~/.local/state/<app>`) does **not** exist
- the fixture cwd contains only the files the test wrote
- pure-function paths: no draft/output JSON anywhere under the state dir

Never special-case `.bun` in an allowlist — that re-couples the test to Bun's
cache layout. Related: `bun test` does not typecheck; don't present it as a
typecheck gate.
