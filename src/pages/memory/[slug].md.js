import { getCollection } from 'astro:content';

export async function getStaticPaths() {
  const notes = await getCollection('memory');
  return notes.map(note => ({ params: { slug: note.slug }, props: { note } }));
}

export async function GET({ props }) {
  const { note } = props;
  const { body } = await note.render();

  // Reconstruct frontmatter as YAML
  const frontmatter = Object.entries(note.data)
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
