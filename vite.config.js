import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";
export default defineConfig({
  plugins: [react(), VitePWA({registerType:"autoUpdate",manifest:{name:"TGD App Educativa",short_name:"TGD",theme_color:"#0f172a",background_color:"#f8fafc",display:"standalone",start_url:"/",icons:[{src:"pwa-192.png",sizes:"192x192",type:"image/png"},{src:"pwa-512.png",sizes:"512x512",type:"image/png",purpose:"maskable"}]},workbox:{globPatterns:["**/*.{js,css,html,ico,png,svg}"]}})],
  server: { port: 3000, open: true }
});
