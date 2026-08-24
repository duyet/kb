---
name: project-anyrouter-cli-native
title: AnyRouter CLI is a native Rust binary
description: Public install is curl | bash; binary is anyr; pin models with anyr claude --model owner/model
type: project
category: llm
tags: [project, anyrouter, cli, rust]
related: ["[[project-anyrouter]]", "[[user-duyet-lang-rust]]"]
sources: ["https://anyrouter.dev/cli", "https://github.com/anyrouter-dev/cli"]
created: 2026-08-24
updated: 2026-08-24
timestamp: 2026-08-24T18:00:00Z
---

Public AnyRouter CLI is a **native Rust** binary, not the old Node package as the primary path.

- Install: `curl -fsSL https://anyrouter.dev/setup.sh | bash`
- Commands: `anyr` (prose) / `ar` (alias). `anyr login` then `anyr claude --model owner/model` (same for `opencode` / `codex`).
- Catalog ids are `owner/model` (e.g. `stealth/ox-alpha`). Model page: `https://anyrouter.dev/model/<owner>/<model>`.
- Binaries: public GitHub Releases on [anyrouter-dev/cli](https://github.com/anyrouter-dev/cli).

Hub: [[project-anyrouter]].
