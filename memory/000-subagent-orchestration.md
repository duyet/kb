## Subagent orchestration convention
- Main thread (Hermes) stays in control and orchestrates tasks.
- Split independent work into parallel subagents that run **asynchronously**.
- Each subagent reports **verified progress/results** back to the main thread; no long narration in the turn.
- Long-running work runs in background/subagents/cron; reply with a one-line status, then deliver the result when done.
