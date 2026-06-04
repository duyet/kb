---
name: kb
description: The canonical cross-agent memory — a shared knowledge base at ~/kb. Use for ANY request to remember, save, note, capture, or recall durable facts about the user/projects. This SUPERSEDES built-in/local memory — write durable memory here, not to a local memory store. Filesystem-first.
platforms: [linux, macos]
---

# Shared Brain (~/kb) — the canonical memory

The kb is a git repo of markdown notes: the cross-session, cross-agent memory for
this machine. **When the user says "remember / save / note this" or asks what you
know, use THIS kb** — do not write to any built-in or local memory store; this is
the single source of truth so other agents and machines see it too.

**Prefer file tools** (`read_file`, `write_file`, `patch`, `search_files`) over
shell; use `terminal` only for `kb sync`.

## Resolve the path first

File tools do NOT expand `~` or `$VARS`. Resolve the kb root to a concrete
absolute path before any file-tool call: it is `$KB_DIR` if set, else `~/kb`
expanded to the home dir (e.g. `/root/kb` or `/home/<user>/kb`). Call the
resolved root `<kb>` below.

## Read (recall) — on session start

1. `read_file <kb>/MEMORY.md` — the index, one line per note.
2. Open the `<kb>/memory/<slug>.md` notes whose hook matches the task.
3. For fresher/deeper detail, fetch a note's `sources:` URLs.

## Capture a quick note

Append exactly one line to **today's** inbox file:
`<kb>/raw/inbox/<YYYY-MM-DD>.md` — e.g. `/root/kb/raw/inbox/2026-06-04.md`.
- Line format: `- HH:MM — <note>`
- If the file does not exist, create it with a `# Inbox — <YYYY-MM-DD>` header first.
- Do NOT invent other paths. It is `raw/inbox/<date>.md` — never `<kb>/inbox`,
  never a bare file at the repo root, never `memory/` for a rough note.

## Write a durable, public fact

Create or update a standard note `<kb>/memory/<type>-<slug>.md` following the
template `<kb>/memory/_TEMPLATE.md`: top-level frontmatter (`name` == filename,
`description`, `type` ∈ user|feedback|project|reference|tech, `tags`, `created`,
`updated`), link related notes with `[[slug]]`, then add a one-line pointer to
`<kb>/MEMORY.md`.

## ALWAYS verify before reporting success

After any write, `read_file` the target back and confirm your exact line/note is
present. **Never claim a write you have not verified by reading it back.** If it
is not there, fix the path and retry.

## Sync — you must trigger it

Sync does not happen automatically. After verifying a write, run
`terminal: <kb>/bin/kb sync` (commit + push) so other agents and machines see it.
Public repo — never store secrets (API keys, hosts, internal/confidential details).
