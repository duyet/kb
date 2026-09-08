# TEAM — duyet fleet (duyetbot Chief of Staff)

Updated: 2026-09-05 ICT

## Reporting
- All bots report to **duyetbot**. Duyet gets one clear update (results / blockers / decisions).
- Coding: Cursor cloud on grok-4.6, Fast off. Never Fast, never Grok Build. No inline repo code on manager/engineer bots.
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
| xops | X schedule/ops for @duyetbot — cadence, checklist, templatebot + anyrouter pulses |
| accounting | Household sheet |
| Lazy Tom | Minimum / jokes |
| aidr | duyet/aidr (aidr.today) — CI/UI/responsive |
| dr eggbot | Designs new Grok Bots |

## Routines (approved)
1. **duyetbot — Weekday morning 8:01 ICT** — A4 + GitHub digest + Gmail + ensure-computer + summa. Success: one A4 + chat digest; HOT flagged.
2. **improver — Weekday 9:45 ICT** (self-owned) — one improvement target/day; short digest to duyetbot. Success: concrete profile/routine/skill change or a clear “nothing useful” quiet.
3. **growth — weekday pulse / Monday campaign** — growth owns; product gaps → anyrouter via duyetbot.
4. **Engineer GitHub listeners** — issue/PR babysits; no cron sweeps.
5. **Weekly CoS review (proposed)** — duyetbot Monday ~after morning: at most one team change proposal; update this file after Duyet approves.

## Approved exceptions
- **growth weekday pulse** — keep (Duyet 2026-09-06)
- **both dr eggbots** — leave for now (Duyet 2026-09-06)

## anyrouter north star (Duyet 2026-09-06)
- Fewer models that **work** > many that fail — LLM question success rate + stability first
- Simple / easy UX; continuous validate + smoke; close more unique GitHub issues
- Admin: redesign keys / logs / analytics — fix blank text, cut overcomplicated pages
- CLI: always-green build + update; launcher improve (Herdr / `anyr claude` OK while cloud exhausted)

## Coding fallback (Duyet 2026-09-06)
- Cursor CloudAgent usage-blocked → Herdr + `anyr claude`
- Prefer `poolside/laguna-s-2.1` and `minimax/m3`; avoid `stealth/ox-alpha[1m]`

## Anti-patterns
- Extra clock wakes / hourly fleets
- Merging release-please
- Inventing $ or metrics
- Posting as other bots / AnyRouter X as @_duyet
- Improver doing product coding

## Standing
- **Code path (2026-09-07):** Engineer bots ship **only** via Herdr + `anyr claude` (laguna-s-2.1 → minimax/m3). Never Grok Bot inline repo edits — even small UI. Coordinate/merge only. Leave Dependency Dashboards alone.


- **Herdr/anyr babysit (2026-09-07):** On every open Herdr job, engineer bots monitor pane state and restart/retry stuck or slow anyr (`poolside/laguna-s-2.1` → `minimax/m3`). Ping duyetbot if blocked >15m. No new clock wakes for this.
