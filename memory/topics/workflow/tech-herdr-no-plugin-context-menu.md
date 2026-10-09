---
name: tech-herdr-no-plugin-context-menu
title: Herdr cannot put plugin items in the sidebar right-click menu
description: Herdr 0.9.3 builds the workspace context menu from hardcoded variants; contexts=["workspace"] is parsed and never acted on
type: tech
category: workflow
tags: [workflow, herdr, plugins, ui]
aliases: []
related: ["[[tech-herdr-morning-issue-desk]]"]
sources: []
created: 2026-10-09
updated: 2026-10-09
timestamp: 2026-10-09T00:00:00Z
---

Verified against stable 0.9.3 source. A plugin cannot add an item to the
workspace / tab / pane right-click menu, and no manifest field is waiting to be
filled in:

- `src/client/shell/context_menu.rs` builds the menu as a `match` over the
  target kind returning hardcoded `ClientContextMenuAction` variants. There is
  no plugin branch.
- `PluginActionContext` — the enum behind `contexts = ["workspace"]` — is
  deserialized by the manifest loader, stored in `PluginActionInfo`, and has no
  consumer anywhere in `src/`. Declaring it is honest intent that Herdr parses
  and never acts on.
- The manifest accepts only `build`, `startup`, `actions`, `events`, `panes`
  and `link_handlers` entries. No menu or grouping key exists, and the plugins doc
  states native non-terminal plugin UI and runtime action registration are not
  part of plugin v1.

What a plugin *can* do for a workspace: an action with
`contexts = ["workspace"]` (listed under plugin actions, invoked by keybinding
or `herdr plugin action invoke`), a `panes` popup, and workspace display
tokens via `herdr workspace report-metadata --source <plugin> --token k=v`,
which Herdr renders beside the Space label. The invocation context arrives in
`HERDR_PLUGIN_CONTEXT_JSON` with `HERDR_WORKSPACE_ID` as fallback.

**Why:** "add this to the right-click menu" is not implementable, and time
spent looking for the manifest key is wasted.
**How to apply:** ship the workspace-scoped action plus a popup, and say plainly
in the docs that it is not in the right-click menu.
