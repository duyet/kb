import { getCollection } from 'astro:content';

export async function getStaticPaths() {
  const articles = await getCollection('articles');
  return articles.map(article => ({ params: { slug: article.slug }, props: { article } }));
}

export async function GET({ props }) {
  const { article } = props;
  const body = article.body;

  // Reconstruct frontmatter as YAML
  const frontmatter = Object.entries(article.data)
    .filter(([, v]) => v !== undefined)
    .map(([k, v]) => {
      if (Array.isArray(v)) return `${k}:\n${v.map(i => `  - ${i}`).join('\n')}`;
      if (typeof v === 'string') return `${k}: "${v.replace(/"/g, '\\"')}"`;
      return `${k}: ${v}`;
    })
    .join('\n');

  const markdown = `---\n${frontmatter}\n---\n\n${body}`;

  return new Response(markdown, {
    headers: { 'Content-Type': 'text/markdown; charset=utf-8' }
  });
}
