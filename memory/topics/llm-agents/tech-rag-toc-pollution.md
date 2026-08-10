---
name: tech-rag-toc-pollution
title: "RAG: TOC docs pollute retrieval"
description: Table-of-contents pages rank well but answer poorly — filter or downweight
type: tech
category: rag
tags: [tech, llm-agents, rag]
related: ["[[tech-rag-citation-guards]]", "[[tech-rag-metadata-key-drift]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

TOC/index pages often dominate vector search without answering the question.

Mitigate: exclude TOCs, chunk body-only, or metadata filters. Related: [[tech-rag-citation-guards]], [[tech-rag-metadata-key-drift]].
