import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import { tanstackRouter } from '@tanstack/router-plugin/vite'
import { resolve } from 'node:path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [tanstackRouter({ 
    autoCodeSplitting: true,
    quoteStyle: "double",
    routesDirectory: "./src/app",
  }), 
  react()],
  resolve: {
    alias: {
      '@': resolve('./src'),
    },
  },
})
