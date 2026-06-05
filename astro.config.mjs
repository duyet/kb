import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://duyet.github.io',
  base: '/kb',
  build: { assets: '_assets' },
  integrations: [sitemap()]
});
