# raw/ — ground-truth sources (read-only for agents)

Drop immutable source material here: PDFs, articles, exported notes, transcripts,
`llms.txt` snapshots, anything an agent should summarize **from** but never edit.

Rules:
- Agents have **read-only** access to this folder. They never modify these files.
- Agents synthesize facts from here into atomic notes under `../memory/`, then
  link them in `../MEMORY.md`.
- `.agent/state.json` tracks which raw files have been ingested, so re-runs only
  process what's new.

This mirrors the Karpathy LLM-Wiki layering — see the model in `../README.md`.
Keep only **public** sources here (this repo is public).
