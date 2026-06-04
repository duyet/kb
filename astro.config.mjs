import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://duyet.github.io',
  base: '/kb',
  build: { assets: '_assets' }
});
