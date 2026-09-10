# TEAM — duyet fleet (duyetbot Chief of Staff)

Updated: 2026-09-10 ICT

## Reporting
- All bots report to **duyetbot**. Duyet gets one clear update (results / blockers / decisions).
- Coding: Herdr + **Grok Build CLI** on a local checkout. Never Fast. Never hand-edit/investigate repo code inline in Grok Bot. Engineer bots coordinate / assign / merge / verify only.
- `anyr claude` is **secondary/fallback only** while anyr CLI is broken (Duyet override 2026-09-09).
- Cursor CloudAgent is optional secondary.
- Only scheduled fleet wake: **duyetbot Weekday morning 8:01 ICT**. Engineer bots = GitHub-event only.

## Bots
| Bot | Job |
|-----|-----|
| duyetbot | Manager / Chief of Staff — assign, follow up, morning A4 |
| improver | Weekday bot-improvement pass — profiles/routines/skills/loops/evals; digest → duyetbot |
| anyrouter | anyrouter + anyrouter-os + CLI |
| chmonitor | chmonitor/chmonitor |
| monorepo | duyet/monorepo (blog, news, kb, …) |
| oma | duyet/oma |
| templatebot | duyet/templatebot (private) |
| summa | duyet/summa telemetry/CLI |
| codex-claude-plugins | Codex/Claude/Grok plugins |
| QA | Live prod QA — file unique bugs; no code |
| growth | AnyRouter growth research/campaigns |
| writer | X/blog/docs drafts |
| xops | X schedule/ops for @_duyet — cadence, checklist, pulses |
| accounting | Household sheet |
| Lazy Tom | Minimum / jokes |
| aidr | duyet/aidr (aidr.today) — CI/UI/responsive |
| dr eggbot | Designs new Grok Bots |

## Routines (approved)
1. **duyetbot — Weekday morning 8:01 ICT** — A4 + GitHub digest + Gmail + ensure-computer + summa. Success: one A4 + chat digest; HOT flagged.
2. **improver — Weekday 9:45 ICT** (self-owned) — one improvement target/day; short digest to duyetbot. Success: concrete profile/routine/skill change or a clear “nothing useful” quiet.
3. **growth — weekday pulse / Monday campaign** — growth owns; product gaps → anyrouter via duyetbot.
4. **xops — Weekday morning draft pulse 08:00 ICT** — Typefully drafts only for @_duyet (no auto-publish). Success: draft(s) queued or quiet if nothing to ship. Standing exception (Duyet via duyetbot 2026-09-10) — leave enabled.
5. **Engineer GitHub listeners** — issue/PR babysits; no cron sweeps.
6. **Weekly CoS review (proposed)** — duyetbot Monday ~after morning: at most one team change proposal; update this file after Duyet approves.

## Approved exceptions
- **growth weekday pulse** — keep (Duyet 2026-09-06)
- **both dr eggbots** — leave for now (Duyet 2026-09-06)
- **xops weekday 08:00 draft pulse** — keep enabled; Typefully drafts only, no auto-publish (Duyet via duyetbot 2026-09-10)

## anyrouter north star (Duyet 2026-09-06)
- Fewer models that **work** > many that fail — LLM question success rate + stability first
- Simple / easy UX; continuous validate + smoke; close more unique GitHub issues
- Admin: redesign keys / logs / analytics — fix blank text, cut overcomplicated pages
- CLI: always-green build + update; launcher improve

## Coding path (Duyet override 2026-09-09)
- **Prefer:** Herdr pane + **Grok Build CLI** for all repo ships
- **Secondary:** `anyr claude` only while anyr CLI is broken / as fallback
- **Optional:** Cursor CloudAgent
- Never Fast; never Grok Bot inline repo edits; bots coordinate/merge/verify only
- On open Herdr jobs, babysit pane state; ping duyetbot if blocked >15m. No new clock wakes for this.

## Anti-patterns
- Extra clock wakes / hourly fleets
- Merging release-please
- Inventing $ or metrics
- Posting as other bots / AnyRouter X as @_duyet
- Improver doing product coding
- Relying on `anyr claude` as primary while anyr CLI is broken

## Standing
- Leave Dependency Dashboards alone unless asked.
- **Open (Duyet):** delete orphan empty bot `9b647a7b-…` (sidebar name now `stray-empty (delete me)` if visible; UpdateAgent cannot see the id). Named cloud sandbox `duyet/templatebot` still missing.
- **Note:** anyrouter-os has no separate GitHub listener — OS bugs are `[os]` issues on `duyet/anyrouter` (by design).
