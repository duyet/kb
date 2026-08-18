---
name: project-kb-site
title: KB site front-end
description: kb.duyet.net renders the shared-brain notes; apps/kb/kb mounts ~/kb
type: project
category: kb
tags: [project, kb, web]
related: ["[[project-kb]]", "[[user-duyet-site-kb]]", "[[project-monorepo]]", "[[feedback-docs-driven-development]]"]
created: 2026-08-10
updated: 2026-08-18
timestamp: 2026-08-18T13:36:00Z
---

Public site for [[project-kb]]. Graph + llms.txt endpoints for agents. Pattern: [[feedback-docs-driven-development]]. Link: [[user-duyet-site-kb]].

Content lives in the [[project-kb]] git repo (`~/kb`). The renderer is `apps/kb` in [[project-monorepo]]. Locally `apps/kb/kb` is a symlink to `~/kb`. CI uses the `apps/kb/kb` git submodule (`git@github.com:duyet/kb.git`, branch `main`).
