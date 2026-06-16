#!/bin/bash
set -e
echo "Fase 12: PWA"
mkdir -p public scripts docs
npm install vite-plugin-pwa -D

cat << 'EOF' > vite.config.js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";
export default defineConfig({
  plugins: [react(), VitePWA({registerType:"autoUpdate",manifest:{name:"TGD App Educativa",short_name:"TGD",theme_color:"#0f172a",background_color:"#f8fafc",display:"standalone",start_url:"/",icons:[{src:"pwa-192.png",sizes:"192x192",type:"image/png"},{src:"pwa-512.png",sizes:"512x512",type:"image/png",purpose:"maskable"}]},workbox:{globPatterns:["**/*.{js,css,html,ico,png,svg}"]}})],
  server: { port: 3000, open: true }
});
EOF

cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
  <title>TGD - App Educativa Segura</title>
  <meta name="theme-color" content="#0f172a"/>
  <meta name="apple-mobile-web-app-capable" content="yes"/>
  <meta name="apple-mobile-web-app-title" content="TGD"/>
  <meta name="referrer" content="no-referrer"/>
</head>
<body><div id="root"></div><script type="module" src="/src/main.jsx"></script></body>
</html>
EOF

rm -f public/service-worker.js public/manifest.webmanifest 2>/dev/null || true
if [ -f src/App.jsx ]; then sed -i '/serviceWorker\.register/d' src/App.jsx; fi

cat << 'EOF' > scripts/build_pwa.sh
#!/bin/bash
set -e
npm run build
echo "PWA en dist/ - probar: npx vite preview"
EOF
chmod +x scripts/build_pwa.sh

cat << 'EOF' > scripts/build_tauri.sh
#!/bin/bash
set -e
echo "Tauri: necesitas Rust (rustup.rs)"
if ! npm list @tauri-apps/cli &>/dev/null; then npm install @tauri-apps/cli @tauri-apps/api -D; npx tauri init; fi
npx tauri build
EOF
chmod +x scripts/build_tauri.sh

cat << 'EOF' > scripts/build_capacitor.sh
#!/bin/bash
set -e
if ! npm list @capacitor/core &>/dev/null; then npm install @capacitor/core @capacitor/cli; npx cap init "TGD" "es.tgd.app" --web-dir=dist; fi
npm run build
if ! [ -d android ]; then npm install @capacitor/android; npx cap add android; fi
if ! [ -d ios ]; then npm install @capacitor/ios; npx cap add ios; fi
npx cap sync
echo "Android: npx cap open android"
echo "iOS: npx cap open ios"
EOF
chmod +x scripts/build_capacitor.sh
echo "DONE Fase 12 PWA"
