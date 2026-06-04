# CLAUDE.md

This repo is the **shared brain** — the root source of truth for agent memory
across every tool and repo.

**The protocol lives in [`AGENTS.md`](./AGENTS.md). Read it.** It defines how to
read the index, write atomic notes, the frontmatter format, what must never be
stored, and the dream/consolidation pass.

Quick map:
- [`MEMORY.md`](./MEMORY.md) — master index, read first.
- [`memory/`](./memory/) — atomic notes, one fact per file.
- [`DREAM.md`](./DREAM.md) — memory-consolidation protocol.
- [`README.md`](./README.md) — human onboarding & new-device setup.

Claude-specific note: your per-project memory under
`~/.claude/projects/<project>/memory/` is a private scratchpad. When a fact
there is **general and public**, promote it into this repo's `memory/` so Codex,
Hermes, OpenClaw, and every device share it too. Then commit and push.
