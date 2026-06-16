# DEPLOYMENT_PHASE9

Objetivo multiplataforma:
- Web/PWA: `npm run build` y publicar `dist/`.
- Desktop Linux/macOS/Windows: empaquetar posteriormente con Tauri o Electron.
- Android/iOS: empaquetar posteriormente con Capacitor usando el build PWA.

Recomendado:
- HTTPS obligatorio.
- Sin secretos en frontend.
- Sin telemetría por defecto.
- Consentimiento explícito y revocable.
