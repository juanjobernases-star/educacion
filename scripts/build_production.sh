#!/bin/bash
set -e
./scripts/audit_and_sanitize.sh || true
npm run build
ZIP="tgd-app-fase9-production-$(date +%Y%m%d-%H%M).zip"
zip -r "$ZIP" . -x "node_modules/*" ".git/*" "dist/*" "*.zip"
echo "ZIP producción creado: $ZIP"
