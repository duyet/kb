# DREAM.md — memory consolidation

"Dreaming" is the maintenance pass that keeps the KB compact and retrievable —
the agent equivalent of sleep consolidating the day's memories. Run it manually,
on a `/loop`, or whenever the KB feels noisy (duplicates, sprawl, stale facts).

## When to dream

- The index `MEMORY.md` has grown large or has near-duplicate lines.
- Several notes restate the same fact, or one note has grown into many facts.
- A note contradicts newer knowledge.
- Links `[[slug]]` point at notes that don't exist (or should).
- On a schedule, e.g. `/loop 1d "run kb DREAM.md consolidation"`.

## The pass

1. **Load.** Read `MEMORY.md`, then every `memory/*.md`.
2. **Dedupe & merge.** Fold duplicate/overlapping notes into one. Keep the
   clearest, most recent phrasing. Preserve every distinct fact (lossless of
   meaning, not of words).
3. **Split.** If a note holds multiple facts, split into atomic notes.
4. **Re-file.** Ensure each note's `metadata.type` and `<type>-` filename prefix
   are correct. Rename if the type changed.
5. **Compact.** Trim verbose notes to the essential fact. Drop filler.
6. **Relink.** Fix `[[slug]]` references; add links between related notes; remove
   links to deleted notes.
7. **Prune.** Delete notes that are wrong, obsolete, or now-private. Delete their
   index lines.
8. **Rebuild index.** Regenerate `MEMORY.md` from the surviving notes — grouped by
   type, one line each: `[Title](file) — hook`.
9. **Verify scope.** Confirm no secrets/hosts/confidential facts slipped in
   (see `AGENTS.md` §3). Remove any that did.
10. **Commit.** `git add -A && git commit -m "dream: consolidate memory" && git push`.

## Principles

- **Lossless of meaning.** Compaction removes words, never distinct facts.
- **Atomic.** One fact per file after the pass.
- **Retrieval-first.** Every note's `description` must let a future agent judge
  relevance from the index alone.
- **Conservative deletes.** Only prune what is wrong, redundant, or out-of-scope —
  never delete a fact just because it's old.
- **Idempotent.** Running the pass twice in a row should change nothing the
  second time.
