import { defineCollection, z } from 'astro:content';

const memory = defineCollection({
  type: 'content',
  schema: z.object({
    name: z.string(),
    title: z.string().optional(),
    description: z.string(),
    type: z.enum(['user', 'feedback', 'project', 'reference', 'tech']).optional(),
    category: z.string().optional(),
    tags: z.array(z.string()).optional(),
    aliases: z.array(z.string()).optional(),
    related: z.array(z.string()).optional(),
    sources: z.array(z.string()).optional(),
    created: z.coerce.string().optional(),
    updated: z.coerce.string(),
  }),
});

const articles = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    category: z.string(),
    tags: z.array(z.string()).optional(),
    links: z.array(z.string()).optional(),
    summary: z.string(),
    updated: z.coerce.string(),
  }),
});

export const collections = { memory, articles };
