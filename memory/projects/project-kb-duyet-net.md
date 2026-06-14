---
name: project-kb-duyet-net
title: kb.duyet.net knowledge base
description: kb.duyet.net — public KB site; migrating from the old monorepo app to this shared-brain repo, also serves bootstrap.sh
type: project
category: kb
tags: [project, duyet, kb, docs-driven]
aliases: [kb-duyet-net]
related: ["[[project-duyet-net]]", "[[feedback-docs-driven-development]]", "[[project-duyetbot]]", "[[user-duyet-web-presence]]"]
sources: ["https://kb.duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-05
timestamp: 2026-06-05T00:00:00Z
---

kb.duyet.net — Duyet's public knowledge base, the rendered front-end of this
shared brain.

- **Old form:** an `apps/kb` app inside [[project-duyet-net]] — markdown articles
  with frontmatter (category/tags/links/summary), graph view at `/graph`, machine
  index at `/llms.txt` + `/llms-full.txt`, raw article at `/k/<slug>.md`.
- **Now:** that monorepo app is being **replaced by THIS repo** (the shared brain).
  The site renders the kb (including client-side full-text search, RSS, and sitemap)
  and also serves `/scripts/bootstrap.sh` for new-device setup.

Embodies [[feedback-docs-driven-development]]: synthesized, graph-connected,
grep-able notes — the durable form of agent memory, distinct from point-in-time
session snapshots. Maintained by [[project-duyetbot]]. The 32 long-form source
articles seeding this brain came from the old monorepo `apps/kb`.
