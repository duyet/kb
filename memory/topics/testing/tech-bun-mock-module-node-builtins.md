---
name: tech-bun-mock-module-node-builtins
title: "Bun mock.module does not intercept node: builtins (1.4.2)"
description: bun:test mock.module cannot replace node:child_process in importers; use PATH shims or spyOn before import
type: reference
category: testing
tags: [bun, testing, mocks, subprocess]
aliases: []
related: ["[[tech-cli-report-assemble-from-root]]"]
sources: ["https://bun.com/docs/test/mock-module"]
created: 2026-09-17
updated: 2026-09-17
timestamp: 2026-09-17T00:00:00Z
---

On Bun 1.4.2, `mock.module("node:child_process", …)` does not change what `import { spawnSync } from "node:child_process"` returns in later importers — builtin modules bypass the module mock registry. Verified empirically; docs describe mock.module for user modules.

Proven substitutes:

- **PATH shim**: create a fixture-local executable script (shebang `#!/path/to/bun`), set `mode: 0o755`, and prepend its directory to `PATH`. Capture argv/stdout to a JSON file; assert on the file. Works for real `spawnSync` and any child that resolves commands via PATH. Combine with `PATH=<shim-dir>` alone (no system dirs) to prove no other executable can run.
- **`spyOn` before import**: for `process.*`/`globalThis` seams (`process.kill`, `fetch`, `Bun.serve`), `spyOn(...).mockImplementation(...)` placed before dynamically importing the module under test works.

**Why:** teams burn time on the documented-looking `mock.module` path for builtins and silently get the real implementation (worse: real subprocesses).
**How to apply:** in Bun CLI tests that must fake subprocesses, default to a PATH shim recorder; keep module mocks confined to a fresh child process so spy state never leaks across cases.
