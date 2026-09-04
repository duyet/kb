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
<<<<<<< Updated upstream
updated: 2026-08-28
timestamp: 2026-08-28T08:06:00Z
=======
updated: 2026-09-05
timestamp: 2026-09-05T01:40:00Z
>>>>>>> Stashed changes
---

Public AnyRouter CLI is a **native Rust** binary, not the old Node package as the primary path.

- Install: `curl -fsSL https://anyrouter.dev/setup.sh | bash`
- First run: `anyr auth login` then `anyr claude`. Claude is the default agent; there is no post-login model/agent wizard.
- Commands: `anyr` (prose) / `ar` (alias). Pin a model with `anyr claude --model owner/model` (same for `opencode` / `codex`).
- Catalog ids are `owner/model` (e.g. `stealth/ox-alpha`). Model page: `https://anyrouter.dev/model/<owner>/<model>`.
- Source, issues, and binaries: [anyrouter-dev/cli](https://github.com/anyrouter-dev/cli). Product/catalog issues stay on [[project-anyrouter]] (`duyet/anyrouter`).
- Smoke: `anyr claude --model owner/model` (example: `stealth/ox-alpha[1m]`).
- `setup.sh` (stable) probes GitHub `/releases/latest/download/anyr-<os>-<arch>`, then falls back to the newest release that actually has binaries (often a prerelease). A bare `/releases/latest/download/...` URL can still 404 when the latest stable tag has no assets.
- `anyr update` must not call the GitHub Releases API unauthenticated (shared IPs get 403). Use a token or the public HTML listing.

Hub: [[project-anyrouter]].
