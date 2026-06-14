#!/usr/bin/env python3
"""Regenerate OKF v0.1 derived artifacts for the kb bundle.

Walks `memory/` once and emits:
  - `memory/**/index.md`  — OKF progressive-disclosure directory listings
                            (root carries `okf_version: "0.1"`; others carry none)
  - `viz.html`            — self-contained graph viewer (cytoscape + marked via CDN)

Pure stdlib — no YAML dependency. Frontmatter is the flat key/value form this
repo uses (parseable with a line scan, like scripts/lint.sh).

Idempotent: re-running overwrites the same outputs. Run via `kb gen`.
"""
import json
import os
import re
import sys

PALETTE = {
    "user": "#8b5cf6",
    "feedback": "#ec4899",
    "project": "#3b82f6",
    "reference": "#10b981",
    "tech": "#f59e0b",
}
RESERVED = {"index.md", "log.md"}


def split_fm(text):
    m = re.match(r"\A---\r?\n(.*?)\r?\n---\r?\n?(.*)\Z", text, re.DOTALL)
    if not m:
        return {}, text
    fm = {}
    for line in m.group(1).splitlines():
        mm = re.match(r"^([A-Za-z_][\w-]*):\s*(.*)$", line)
        if mm:
            fm[mm.group(1)] = mm.group(2).strip()
    return fm, m.group(2)


def clean(v):
    return (v or "").strip().strip('"').strip("'").strip()


def parse_list(v):
    v = clean(v)
    if v.startswith("[") and v.endswith("]"):
        v = v[1:-1]
    if not v:
        return []
    return [x.strip().strip('"').strip("'") for x in re.split(r"[,\n]", v) if x.strip()]


def collect(mem_root):
    concepts = []
    for dp, dn, fn in os.walk(mem_root):
        dn.sort()
        for name in sorted(fn):
            if not name.endswith(".md"):
                continue
            if name in RESERVED or name.startswith("_"):
                continue
            path = os.path.join(dp, name)
            fm, body = split_fm(open(path, encoding="utf-8").read())
            slug = name[:-3]
            related = [r.replace("[[", "").replace("]]", "").strip()
                       for r in parse_list(fm.get("related", ""))]
            body_links = re.findall(r"\[\[([^\]]+)\]\]", body)
            concepts.append({
                "path": os.path.relpath(path, mem_root),
                "slug": slug,
                "title": clean(fm.get("title")) or slug,
                "description": clean(fm.get("description")),
                "type": clean(fm.get("type")) or "note",
                "tags": parse_list(fm.get("tags", "")),
                "related": related,
                "body_links": body_links,
                "sources": parse_list(fm.get("sources", "")),
                "body": body.strip(),
                "dirpath": dp,
            })
    return concepts


def write_indexes(mem_root, concepts):
    by_dir = {}
    for c in concepts:
        by_dir.setdefault(c["dirpath"], []).append(c)
    written = []
    # every dir under memory that has concepts OR subdirs gets an index
    dirs_to_index = set(by_dir.keys()) | {mem_root}
    for dp, dn, _fn in os.walk(mem_root):
        if dn:
            dirs_to_index.add(dp)
    for dirpath in sorted(dirs_to_index):
        rel = os.path.relpath(dirpath, mem_root)
        is_root = rel == "."
        subdirs = sorted(d for d in os.listdir(dirpath)
                         if os.path.isdir(os.path.join(dirpath, d)))
        here = sorted(by_dir.get(dirpath, []), key=lambda c: c["title"].lower())
        if not subdirs and not here:
            continue
        out = ["---", 'okf_version: "0.1"', "---", "",
               "# Knowledge Bundle — `memory/`", "",
               "Duyet's shared brain, a conformant "
               "[OKF v0.1](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md) "
               "bundle. Slugs are stable; cross-links are Obsidian wikilinks "
               "(resolved by `name:`).", "",
               "Agent-facing index: `MEMORY.md`. Graph viewer: `kb viz`.", ""]
        if not is_root:
            out = [f"# `{rel}/`", ""]
        if subdirs:
            out += ["## Groups", ""]
            out += [f"- [`{d}/`]({d}/)" for d in subdirs]
            out += [""]
        if here:
            out += ["## Concepts", ""]
            for c in here:
                tail = f" — {c['description']}" if c["description"] else ""
                out.append(f"- [{c['title']}]({os.path.basename(c['path'])}){tail}")
            out += [""]
        p = os.path.join(dirpath, "index.md")
        open(p, "w", encoding="utf-8").write("\n".join(out))
        written.append(p)
    return written


def build_bundle(concepts):
    slugs = {c["slug"] for c in concepts}
    edge_set = set()
    for c in concepts:
        targets = set(c["related"]) | set(c["body_links"])
        for t in targets:
            t = t.split("|")[0].split("#")[0].strip()
            if t in slugs and t != c["slug"]:
                edge_set.add((c["slug"], t))
    degree = {s: 0 for s in slugs}
    for a, b in edge_set:
        degree[a] += 1
        degree[b] += 1
    types, nodes, bodies = [], [], {}
    for c in concepts:
        if c["type"] not in types:
            types.append(c["type"])
        nodes.append({"data": {
            "id": c["slug"], "label": c["title"], "type": c["type"],
            "description": c["description"], "tags": c["tags"],
            "resource": c["sources"][0] if c["sources"] else "",
            "color": PALETTE.get(c["type"], "#64748b"),
            "size": 24 + min(degree[c["slug"]], 6) * 4,
        }})
        bodies[c["slug"]] = c["body"]
    edges = [{"data": {"id": f"{a}__{b}", "source": a, "target": b}}
             for a, b in sorted(edge_set)]
    return {"nodes": nodes, "edges": edges, "bodies": bodies,
            "types": types, "palette": {t: PALETTE.get(t, "#64748b") for t in types}}


VIZ = r"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>__NAME__ — OKF Bundle Viewer</title>
<script src="https://cdn.jsdelivr.net/npm/cytoscape@3.28.1/dist/cytoscape.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/marked@12.0.0/marked.min.js"></script>
<style>
*{box-sizing:border-box}
body{margin:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",system-ui,sans-serif;font-size:14px;color:#0f172a;background:#f8fafc;display:flex;flex-direction:column;height:100vh}
header{display:flex;align-items:center;justify-content:space-between;padding:10px 16px;background:#fff;border-bottom:1px solid #e2e8f0;flex-shrink:0}
.title strong{font-size:16px;margin-right:8px}
.muted{color:#64748b;font-size:12px}
.legend{display:flex;gap:12px;font-size:12px;flex-wrap:wrap}
.legend i{display:inline-block;width:10px;height:10px;border-radius:50%;margin-right:4px;vertical-align:middle}
main{display:flex;flex:1;min-height:0}
#graph{flex:1 1 60%;background:#fff;border-right:1px solid #e2e8f0;min-width:0;position:relative}
#detail{flex:0 0 40%;overflow-y:auto;padding:18px 22px;background:#fff}
#detail h1{font-size:18px;margin:0 0 6px}
.badge{display:inline-block;font-size:11px;padding:2px 8px;border-radius:999px;color:#fff}
#detail .desc{color:#475569;margin:8px 0 12px}
#detail .tags{margin-bottom:12px}
#detail .tags span{font-size:11px;background:#f1f5f9;border:1px solid #e2e8f0;border-radius:4px;padding:2px 6px;margin:0 4px 4px 0;display:inline-block}
#detail .body{line-height:1.55}
#detail .body pre{background:#0f172a;color:#e2e8f0;padding:10px;border-radius:6px;overflow:auto}
#detail .body code{background:#f1f5f9;padding:1px 4px;border-radius:3px;font-size:13px}
#detail .body pre code{background:none;padding:0}
#detail .body table{border-collapse:collapse;margin:8px 0}
#detail .body th,#detail .body td{border:1px solid #e2e8f0;padding:4px 8px}
#detail .body a{color:#2563eb}
#detail h2{font-size:13px;margin-top:18px;color:#64748b;text-transform:uppercase;letter-spacing:.04em}
#backlinks ul{padding-left:18px;margin:4px 0}
#backlinks a{color:#2563eb;cursor:pointer}
.hint{position:absolute;bottom:10px;left:12px;color:#94a3b8;font-size:12px}
</style>
</head>
<body>
<header>
  <div class="title"><strong>__NAME__</strong><span class="muted">OKF v0.1 bundle viewer</span></div>
  <div class="legend" id="legend"></div>
</header>
<main>
  <div id="graph"><div class="hint">scroll = zoom · drag = pan · click a node</div></div>
  <section id="detail"><p class="muted">Select a node to read it.</p></section>
</main>
<script>
window.BUNDLE=__BUNDLE__;
(function(){
  const b=window.BUNDLE, byId={}; b.nodes.forEach(n=>byId[n.data.id]=n.data);
  const back={}; b.edges.forEach(e=>{(back[e.data.target]=back[e.data.target]||[]).push(e.data.source)});
  const leg=document.getElementById("legend");
  b.types.forEach(t=>{const s=document.createElement("span");s.innerHTML='<i style="background:'+b.palette[t]+'"></i>'+t;leg.appendChild(s)});
  const cy=cytoscape({container:document.getElementById("graph"),elements:[...b.nodes,...b.edges],style:[
    {selector:"node",style:{"label":"data(label)","background-color":"data(color)","width":"data(size)","height":"data(size)","color":"#334155","font-size":10,"text-valign":"bottom","text-margin-y":4,"text-wrap":"wrap","text-max-width":80}},
    {selector:"node:selected",style:{"border-width":3,"border-color":"#0f172a"}},
    {selector:"edge",style:{"width":1,"line-color":"#cbd5e1","curve-style":"bezier","opacity":.55}}
  ],layout:{name:"cose",animate:false,idealEdgeLength:90,nodeRepulsion:9000,padding:20}});
  function select(id){
    cy.nodes().unselect(); const el=cy.getElementById(id); if(el&&el.length)el.select();
    const n=byId[id]; if(!n) return;
    const bodyMd=b.bodies[id]||"";
    const tags=(n.tags||[]).map(t=>'<span>'+t+'</span>').join("");
    const bl=(back[id]||[]).map(s=>'<li><a data-id="'+s+'">'+((byId[s]||{}).label||s)+'</a></li>').join("");
    document.getElementById("detail").innerHTML=
      '<h1>'+n.label+'</h1>'+
      '<span class="badge" style="background:'+(b.palette[n.type]||'#64748b')+'">'+n.type+'</span>'+
      (n.resource?' <a class="muted" href="'+n.resource+'" target="_blank" rel="noopener">source ↗</a>':'')+
      '<p class="desc">'+(n.description||'')+'</p>'+
      (tags?'<div class="tags">'+tags+'</div>':'')+
      '<div class="body">'+marked.parse(bodyMd)+'</div>'+
      (bl?'<div id="backlinks"><h2>Linked from</h2><ul>'+bl+'</ul></div>':'');
    document.querySelectorAll('#backlinks a').forEach(a=>a.onclick=()=>select(a.dataset.id));
  }
  cy.on("tap","node",e=>select(e.target.id()));
  if(b.nodes.length) select(b.nodes[0].data.id);
})();
</script>
</body>
</html>
"""


def write_viz(repo_root, bundle):
    html = VIZ.replace("__NAME__", "duyet-kb").replace("__BUNDLE__", json.dumps(bundle))
    open(os.path.join(repo_root, "viz.html"), "w", encoding="utf-8").write(html)


def main():
    repo = os.path.abspath(sys.argv[1]) if len(sys.argv) > 1 else os.getcwd()
    mem = os.path.join(repo, "memory")
    if not os.path.isdir(mem):
        print(f"error: no memory/ bundle at {mem}", file=sys.stderr)
        return 1
    concepts = collect(mem)
    idx = write_indexes(mem, concepts)
    bundle = build_bundle(concepts)
    write_viz(repo, bundle)
    print(f"generated {len(idx)} index.md + viz.html "
          f"({len(bundle['nodes'])} nodes, {len(bundle['edges'])} edges)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
