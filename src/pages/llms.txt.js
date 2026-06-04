import { getCollection } from 'astro:content';

export async function GET() {
  const notes = await getCollection('memory');
  const articles = await getCollection('articles');
  const base = import.meta.env.BASE_URL.replace(/\/$/, '');

  const allNotes = notes
    .sort((a, b) => a.data.name.localeCompare(b.data.name))
    .map(n => `- [${n.data.title || n.data.name}] ${base}/memory/${n.slug}.md — ${n.data.description}`)
    .join('\n');

  const allArticles = articles
    .sort((a, b) => a.data.title.localeCompare(b.data.title))
    .map(a => `- [${a.data.title}] ${base}/articles/${a.slug}.md — ${a.data.summary}`)
    .join('\n');

  const body = [
    `# kb.duyet.net`,
    `> Duyet Le — shared knowledge base`,
    ``,
    `## Memory (${notes.length})`,
    allNotes,
    ``,
    `## Articles (${articles.length})`,
    allArticles,
    ``,
    `## Links`,
    `- GitHub: https://github.com/duyet/kb`,
    `- Site: https://duyet.github.io${base}/`,
    `- RSS: https://duyet.github.io${base}/rss.xml`,
    `- LLM-friendly full: https://duyet.github.io${base}/llms-full.txt`,
  ].join('\n');

  return new Response(body, {
    headers: { 'Content-Type': 'text/plain; charset=utf-8' }
  });
}
