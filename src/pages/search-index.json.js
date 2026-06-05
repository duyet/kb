import { getCollection } from 'astro:content';

export async function GET() {
  const notes = await getCollection('memory');
  const articles = await getCollection('articles');
  const base = import.meta.env.BASE_URL.replace(/\/$/, '');

  const data = [
    ...notes.map(n => ({
      title: n.data.title || n.data.name,
      description: n.data.description,
      slug: n.slug,
      url: `${base}/memory/${n.slug}`,
      type: 'memory',
      category: n.data.category || 'Memory',
      tags: n.data.tags || [],
      body: n.body || ''
    })),
    ...articles.map(a => ({
      title: a.data.title,
      description: a.data.summary,
      slug: a.slug,
      url: `${base}/articles/${a.slug}`,
      type: 'article',
      category: a.data.category || a.data.tags?.[0] || 'Article',
      tags: a.data.tags || [],
      body: a.body || ''
    }))
  ];

  return new Response(JSON.stringify(data), {
    headers: {
      'Content-Type': 'application/json; charset=utf-8'
    }
  });
}
