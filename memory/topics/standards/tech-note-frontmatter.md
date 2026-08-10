---
name: tech-note-frontmatter
title: Note frontmatter standard
description: Required top-level fields for every concept note
type: tech
category: standards
tags: [tech, standards, kb]
related: ["[[tech-note-atomic]]", "[[project-kb]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Required: `name` (== filename), `description`, `type`, `tags`, `created`, `updated`, `timestamp` (ISO 8601).

Optional: `title`, `category`, `aliases`, `related`, `sources`. No nested `metadata:`.
Lint: `kb lint`. Template: memory/_TEMPLATE.md. See [[tech-note-atomic]].
