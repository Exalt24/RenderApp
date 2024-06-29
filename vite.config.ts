import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import RubyPlugin from 'vite-plugin-ruby';
import path from 'path';

export default defineConfig({
  plugins: [
    vue(),
    RubyPlugin(),
  ],
  resolve: {
    alias: {
      jquery: path.resolve(__dirname, 'node_modules/jquery/dist/jquery.min.js'),
      popper: path.resolve(__dirname, 'node_modules/popper.js/dist/umd/popper.min.js')
    }
  },
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
