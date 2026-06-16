#!/bin/bash
set -e
printf "Auditando proyecto TGD...\n"
FAIL=0
# Busca patrones peligrosos comunes en frontend.
if grep -R "dangerouslySetInnerHTML\|eval(\|new Function\|innerHTML\s*=" src --include='*.js' --include='*.jsx' 2>/dev/null; then
  echo "ALERTA: patrones peligrosos encontrados. Revisar antes de producción."
  FAIL=1
fi
if grep -R "API_KEY\|SECRET\|TOKEN\|PASSWORD" src public --include='*.js' --include='*.jsx' --include='*.json' 2>/dev/null; then
  echo "ALERTA: posible secreto en frontend. No debe haber claves en cliente."
  FAIL=1
fi
if [ -f package.json ]; then
  npm audit --audit-level=high || true
fi
if [ "$FAIL" = "1" ]; then
  echo "Auditoría con advertencias."
else
  echo "Auditoría básica OK."
fi
