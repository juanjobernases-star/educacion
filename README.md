# TGD App - Pack Fases 10+11+12

## Orden de ejecucion:
```bash
cd ~/Escritorio/TGD

# 1. Modulos faltantes + rutinas + familia + informes + edad
chmod +x setup_tgd_fix_all.sh
./setup_tgd_fix_all.sh

# 2. Consentimiento + App.jsx completo
chmod +x fix_app_complete.sh
./fix_app_complete.sh

# 3. PWA
chmod +x setup_tgd_phase12.sh
./setup_tgd_phase12.sh

# 4. En navegador F12 Console: localStorage.clear()
# 5. npm run dev
```
