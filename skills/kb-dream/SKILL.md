---
name: kb-dream
description: Consolidate the shared-brain knowledge base (~/kb) — the "dream" pass. Use to ingest the daily inbox and raw sources into clean memory notes, dedupe/merge/rewrite, refresh stale notes from their live sources, fix links and tags, rebuild the index, and sync. Run manually, on a schedule, or whenever the kb feels noisy.
---

# kb-dream

Run the memory-consolidation pass. Location is configurable: use `$KB_DIR` or
`kb root` (default `~/kb`).

## Procedure

Read `$KB_DIR/DREAM.md` and execute it end to end. In summary:

1. Load `MEMORY.md`, all `memory/**/*.md` (recursive — **excluding** reserved
   `index.md`, `log.md`, `_TEMPLATE.md`), `raw/inbox/*`, `raw/` source docs, and
   `.agent/state.json`.
2. **Ingest & rewrite:** promote durable/general/public facts from the inbox and
   un-processed `raw/` docs into `memory/` — create new notes or rewrite/merge
   existing ones. Then **delete** consumed inbox files; **keep** source docs and
   record them in `state.json.processed`.
3. Dedupe & merge; split multi-fact notes; validate frontmatter against the
   standard (`kb lint`); compact to ≤~25 lines.
4. **Refresh:** for notes with `sources:` whose `timestamp`/`updated:` is stale
   (>~30 days), fetch the source (prefer `llms.txt`) and update the note +
   `updated:` + `timestamp`.
5. Relink (no orphans), merge tag sprawl, prune wrong/obsolete/now-private notes.
6. Rebuild `MEMORY.md`; run **`kb gen`** to regenerate every `memory/**/index.md`
   (OKF listings) + `viz.html`; append a dated entry to `memory/log.md`; verify
   scope (no secrets).
7. Set `state.json.last_dream` to today; run `kb sync`.

## Principles

Lossless of meaning, atomic, retrieval-first, conservative deletes, idempotent.
Pair with `kb-memory` for the read/write protocol.
