import { getCollection } from 'astro:content';

export async function GET() {
  const notes = await getCollection('memory');
  const articles = await getCollection('articles');
  const base = import.meta.env.BASE_URL;

  const sections = [];

  sections.push('# kb.duyet.net — Full Content');
  sections.push('> Duyet Le — shared knowledge base');
  sections.push('');

  sections.push(`## Memory (${notes.length})`);
  sections.push('');
  for (const note of notes.sort((a, b) => a.data.name.localeCompare(b.data.name))) {
    const { body } = await note.render();
    sections.push(`### ${note.data.title || note.data.name}`);
    sections.push(`> ${note.data.description}`);
    sections.push(`> Updated: ${note.data.updated}`);
    sections.push('');
    sections.push(body);
    sections.push('');
    sections.push('---');
    sections.push('');
  }

  sections.push(`## Articles (${articles.length})`);
  sections.push('');
  for (const article of articles.sort((a, b) => a.data.title.localeCompare(b.data.title))) {
    const { body } = await article.render();
    sections.push(`### ${article.data.title}`);
    sections.push(`> ${article.data.summary}`);
    sections.push(`> Updated: ${article.data.updated}`);
    sections.push('');
    sections.push(body);
    sections.push('');
    sections.push('---');
    sections.push('');
  }

  sections.push('## Index');
  sections.push(`- Site: https://duyet.github.io${base}`);
  sections.push(`- LLM index: https://duyet.github.io${base}llms.txt`);
  sections.push('- GitHub: https://github.com/duyet/kb');

  const body = sections.join('\n');

  return new Response(body, {
    headers: { 'Content-Type': 'text/plain; charset=utf-8' }
  });
}
