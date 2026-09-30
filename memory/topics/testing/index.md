# `topics/testing/`

## Concepts

- [Bun mock.module does not intercept node: builtins (1.4.2)](tech-bun-mock-module-node-builtins.md) — bun:test mock.module cannot replace node:child_process in importers; use PATH shims or spyOn before import
- [Bun writes .bun into a test fixture HOME — assert app state paths, not HOME emptiness](tech-bun-test-home-isolation.md) — Bun creates ~/.bun (install/cache dirs) under whatever HOME is set when it runs, so hermetic tests must not assert an empty fixture HOME — assert the app-owned state dir is absent instead
