---
name: tech-rag-retrieval-pollution
title: RAG retrieval pollution — TOC docs, citation guards, metadata drift
description: Why vector search returns confidently-irrelevant pages — synthetic TOC/link-list docs, citation guards passing real-but-irrelevant URLs, dual metadata keys, wrong query embed model
type: tech
category: llm-agents
tags: [tech, rag, vector-search, qdrant, retrieval, llm-agents]
aliases: []
related: []
sources: []
created: 2026-07-31
updated: 2026-07-31
timestamp: 2026-07-31T01:30:00Z
---

Failure signature: doc search links users to pages that don't exist or don't match the
question ("taxes" → "dashboard widgets"). Four independent causes seen together in prod:

- **Synthetic TOC/link-list documents poison retrieval.** A table-of-contents doc mentions
  every topic, so it scores ~0.75+ against *any* query on a narrow corpus, and the LLM lifts
  its links as if they were sources. Exclude at query time (`must_not is_toc`) AND ideally
  never index them into the searchable collection.
- **Citation guards that check "URL appears verbatim in a tool result" pass irrelevant real
  URLs.** They only block *invented* links — a TOC's link list is a guard bypass by design.
- **Metadata key drift between indexers** (`language` vs `lang`) silently hides half the
  corpus when filters match only one key; an empty filtered result must retry, not conclude
  "no documentation exists".
- **Query embeddings must come from the collection's own registry version**, never a global
  env default — a DB override switching collections otherwise queries a foreign vector
  space with zero errors, only garbage neighbours.

Related lesson: punt/fallback detection by substring matching backfires the moment the
system prompt mandates a boilerplate opener — every legitimate answer "contains the punt
marker". Strip mandated boilerplate first and test the residual.
