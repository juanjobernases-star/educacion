import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  base: "/educacion/",

  plugins: [
    react(),

    VitePWA({
      registerType: "autoUpdate",

      includeAssets: [
        "favicon.ico",
        "pwa-192.png",
        "pwa-512.png"
      ],

      manifest: {
        name: "TGD App Educativa Segura",
        short_name: "TGD",
        description:
          "App educativa TEA/TGD/Asperger. Local-first, cifrada, sin telemetría.",
        theme_color: "#0f172a",
        background_color: "#f8fafc",
        display: "standalone",
        orientation: "portrait",
        scope: "/educacion/",
        start_url: "/educacion/",
        icons: [
          {
            src: "pwa-192.png",
            sizes: "192x192",
            type: "image/png"
          },
          {
            src: "pwa-512.png",
            sizes: "512x512",
            type: "image/png"
          },
          {
            src: "pwa-512.png",
            sizes: "512x512",
            type: "image/png",
            purpose: "maskable"
          }
        ]
      },

      workbox: {
        globPatterns: ["**/*.{js,css,html,ico,png,svg,woff,woff2}"]
      }
    })
  ],

  server: {
    port: 3000,
    open: true
  }
});
