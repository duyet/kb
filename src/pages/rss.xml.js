import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const notes = await getCollection('memory');
  const articles = await getCollection('articles');
  const all = [...notes.map(n => ({ ...n, type: 'note' })), ...articles.map(a => ({ ...a, type: 'article' }))]
    .sort((a, b) => new Date(b.data.updated).getTime() - new Date(a.data.updated).getTime());

  return rss({
    title: 'kb.duyet.net',
    site: context.site,
    description: 'Duyet Le — shared knowledge base',
    items: all.map(item => ({
      title: item.data.title || item.data.name,
      pubDate: new Date(item.data.updated),
      description: item.data.summary || item.data.description,
      link: item.type === 'note' ? `/memory/${item.slug}/` : `/articles/${item.slug}/`,
    })),
  });
}
