# `reference/`

## Concepts

- [AI SDK UIMessage shape](reference-ai-sdk-uimessage.md) — UIMessage is id+role+parts; unknown part types render as null
- [Blog themes](reference-duyet-blog.md) — Recurring public blog themes on blog.duyet.net
- [Cloudflare acquired Astro (2026)](reference-cloudflare-acquires-astro.md) — Jan 2026: Astro team joined Cloudflare; Flue agent framework context
- [Dev machine duet-ubuntu and local repos](reference-machine-duet-ubuntu.md) — Primary Linux workstation (duet-ubuntu) — OS, Herdr workspaces, local repo checkout paths, and which credentials are stale
- [GitHub Actions — cancel-in-progress false still cancels the pending run, and a paths filter makes the replacement useless](reference-gh-actions-concurrency-pending-cancel.md)
- [GitHub Actions — default Actions token merges do not trigger further workflows](reference-gh-actions-token-merge-no-workflows.md) — Squash-merge via github-actions bot skips tip push CI/deploy — Back-to-back merges silently drop master builds; with per-path filtering the newer green run does not rebuild the earlier merge's images
- [Herdr child agents — a long prompt can fail to submit and look exactly like an idle child](reference-herdr-child-dispatch-verify.md) — herdr agent prompt with a long brief lands unsent in the opencode composer; verify the lifecycle moved instead of trusting the CLI's success response
- [Notable public GitHub repos](reference-duyet-github.md) — Catalog of notable public duyet/* and related OSS repos
