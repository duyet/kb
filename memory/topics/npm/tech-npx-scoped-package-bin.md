---
name: tech-npx-scoped-package-bin
title: npx looks up a scoped package's last path segment as the executable
description: npx @scope/name runs a bin named `name`. Multiple bins without that name fail with "not found" / could not determine executable.
type: tech
category: npm
tags: [npm, npx, cli, bin]
aliases: []
related: []
sources: ["https://docs.npmjs.com/cli/v11/commands/npx"]
created: 2026-08-13
updated: 2026-08-13
timestamp: 2026-08-13T07:20:00Z
---

`npx @scope/name` (and `npx --package @scope/name name`) looks up an executable named **`name`** — the unscoped last path segment. It does not automatically pick `anyr` just because that is the documented command.

If the package ships several bins (`anyr`, `anyrouter`, `ar`) and none is named `name`, some npx versions fail with `name: not found` (exit 127) or "could not determine executable to run". Newer npx may pick the first bin, so the bug can look machine-specific.

**How to apply:** add a bin key that matches the last path segment, pointing at the same file as the documented command. Keep the documented aliases. Prove it with `npx --yes --package <tarball> <last-segment> --help`, not by reading `package.json` alone.
