import { getCollection } from 'astro:content';

// Build-time knowledge-graph data: nodes (memory notes + articles) and edges
// (explicit frontmatter links = "strong", shared-tag links = "weak").
// Mirrors the data-loading shape of search-index.json.js.

const slugify = (s) =>
  String(s)
    .toLowerCase()
    .replace(/\[\[|\]\]/g, '')      // strip wikilink brackets
    .trim()
    .replace(/[^a-z0-9]+/g, '-')    // non-alnum -> hyphen
    .replace(/^-+|-+$/g, '');

export async function GET() {
  const notes = await getCollection('memory');
  const articles = await getCollection('articles');
  const base = import.meta.env.BASE_URL.replace(/\/$/, '');

  // 1. Build nodes (skip the memory _TEMPLATE scaffold).
  const nodes = [
    ...notes
      .filter((n) => !n.slug.startsWith('_'))
      .map((n) => ({
        id: n.slug,
        label: n.data.title || n.data.name,
        url: `${base}/memory/${n.slug}`,
        type: 'memory',
        tags: n.data.tags || [],
        _related: n.data.related || [],
        _aliases: [n.data.name, ...(n.data.aliases || [])],
      })),
    ...articles.map((a) => ({
      id: a.slug,
      label: a.data.title,
      url: `${base}/articles/${a.slug}`,
      type: 'article',
      tags: a.data.tags || [],
      _related: a.data.links || [],
      _aliases: [a.data.title],
    })),
  ];

  // 2. Resolution map: slug | name | title | aliases (slugified) -> node id.
  const resolve = new Map();
  for (const n of nodes) {
    resolve.set(n.id, n.id);
    resolve.set(slugify(n.id), n.id);
    resolve.set(slugify(n.label), n.id);
    for (const a of n._aliases) resolve.set(slugify(a), n.id);
  }

  // 3. Strong edges from explicit frontmatter links, deduped + undirected.
  const edgeKey = (a, b) => (a < b ? `${a}|${b}` : `${b}|${a}`);
  const edges = new Map(); // key -> { source, target, strong }

  for (const n of nodes) {
    for (const ref of n._related) {
      const target = resolve.get(slugify(ref));
      if (!target || target === n.id) continue;
      edges.set(edgeKey(n.id, target), { source: n.id, target, strong: true });
    }
  }

  // 4. Weak edges from shared tags — capped so the graph doesn't become a hairball.
  const TAG_NEIGHBOUR_CAP = 2;
  const byTag = new Map();
  for (const n of nodes) {
    for (const t of n.tags) {
      const key = String(t).toLowerCase();
      if (!byTag.has(key)) byTag.set(key, []);
      byTag.get(key).push(n.id);
    }
  }
  const weakCount = new Map(); // node id -> weak edges added
  for (const ids of byTag.values()) {
    for (let i = 0; i < ids.length; i++) {
      for (let j = i + 1; j < ids.length; j++) {
        const a = ids[i];
        const b = ids[j];
        const key = edgeKey(a, b);
        if (edges.has(key)) continue; // already strong-linked
        if ((weakCount.get(a) || 0) >= TAG_NEIGHBOUR_CAP) continue;
        if ((weakCount.get(b) || 0) >= TAG_NEIGHBOUR_CAP) continue;
        edges.set(key, { source: a, target: b, strong: false });
        weakCount.set(a, (weakCount.get(a) || 0) + 1);
        weakCount.set(b, (weakCount.get(b) || 0) + 1);
      }
    }
  }

  // 5. degree = strong-edge count -> drives node size.
  const degree = new Map();
  for (const e of edges.values()) {
    if (!e.strong) continue;
    degree.set(e.source, (degree.get(e.source) || 0) + 1);
    degree.set(e.target, (degree.get(e.target) || 0) + 1);
  }

  const outNodes = nodes.map((n) => ({
    id: n.id,
    label: n.label,
    url: n.url,
    type: n.type,
    tags: n.tags,
    degree: degree.get(n.id) || 0,
  }));

  return new Response(
    JSON.stringify({ nodes: outNodes, edges: [...edges.values()] }),
    { headers: { 'Content-Type': 'application/json; charset=utf-8' } }
  );
}
