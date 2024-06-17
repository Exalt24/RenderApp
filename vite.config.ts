import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import RubyPlugin from 'vite-plugin-ruby';

export default defineConfig({
  plugins: [
    vue(),
    RubyPlugin()
  ],
  build: {
    outDir: 'public/dist', // Output directory for built files
    manifest: true, // Generate manifest files
    rollupOptions: {
      input: {
        application: './app/javascript/entrypoints/application.js', // Entry point for your application
      },
    },
  },
});
