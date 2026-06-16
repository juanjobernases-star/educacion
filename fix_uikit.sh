#!/bin/bash
# ============================================================
# fix_uikit.sh — Crea ui-kit.jsx y arregla imports + HTML roto
# Ejecutar desde: ~/Escritorio/TGD/
# ============================================================
set -e

echo ""
echo "🔧 Arreglando ui-kit y HTML escapado..."
echo ""

mkdir -p src/ui

# 1) Si ya existe como .jsx, perfecto
if [ -f src/ui/ui-kit.jsx ]; then
  echo "✅ src/ui/ui-kit.jsx ya existe"

# 2) Si existe como .js, renombrar
elif [ -f src/ui/ui-kit.js ]; then
  mv src/ui/ui-kit.js src/ui/ui-kit.jsx
  echo "✅ Renombrado ui-kit.js → ui-kit.jsx"

# 3) Si no existe ninguno, crearlo
else
  echo "📝 Creando src/ui/ui-kit.jsx desde cero..."

  cat << 'UIEOF' > src/ui/ui-kit.jsx
import React from "react";

export const UI = {
  card: "tgd-card",
  panel: "tgd-panel",
  button: "tgd-button",
  buttonPrimary: "tgd-button tgd-button-primary",
  buttonSoft: "tgd-button tgd-button-soft",
  input: "tgd-input",
  badge: "tgd-badge"
};

export function AppCard({ title, subtitle, children, actions }) {
  return (
    <section className="tgd-card">
      {(title || subtitle) && (
        <header className="tgd-card-header">
          {title && <h2>{title}</h2>}
          {subtitle && <p>{subtitle}</p>}
        </header>
      )}
      <div className="tgd-card-body">{children}</div>
      {actions && <footer className="tgd-card-actions">{actions}</footer>}
    </section>
  );
}

export function BigAction({ icon, title, text, onClick, active }) {
  return (
    <button type="button" onClick={onClick} className={active ? "tgd-big-action active" : "tgd-big-action"}>
      <span className="tgd-big-action-icon">{icon}</span>
      <span className="tgd-big-action-title">{title}</span>
      {text && <span className="tgd-big-action-text">{text}</span>}
    </button>
  );
}

export function ProgressBar({ value = 0 }) {
  const safe = Math.max(0, Math.min(100, Number(value) || 0));
  return (
    <div className="tgd-progress">
      <span style={{ width: safe + "%" }} />
    </div>
  );
}
UIEOF

  echo "✅ src/ui/ui-kit.jsx creado"
fi

# 4) Arreglar TODOS los imports que apunten a ui-kit.js
echo ""
echo "🔧 Arreglando imports..."

find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec grep -l "ui-kit\.js" {} \; | while read file; do
  sed -i 's/ui-kit\.js/ui-kit.jsx/g' "$file"
  echo "  ✅ $file → import corregido"
done

# 5) Arreglar HTML escapado en TODO el proyecto
echo ""
echo "🔧 Arreglando HTML escapado..."

find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec grep -l "&lt;\|&gt;\|&amp;" {} \; 2>/dev/null | while read file; do
  sed -i 's/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g' "$file"
  echo "  ✅ $file → HTML corregido"
done

# 6) Verificación final
echo ""
echo "============================================================"
echo "  VERIFICACIÓN"
echo "============================================================"

echo ""
echo "Archivo ui-kit:"
ls -la src/ui/ui-kit.* 2>/dev/null || echo "  ⚠️ No encontrado"

echo ""
echo "Imports a ui-kit en src/:"
grep -r "ui-kit" src/ --include="*.js" --include="*.jsx" || echo "  Sin referencias"

echo ""
echo "HTML escapado restante:"
ESCAPED=$(grep -r "&lt;\|&gt;\|&amp;" src/ --include="*.js" --include="*.jsx" 2>/dev/null | wc -l)
if [ "$ESCAPED" = "0" ]; then
  echo "  ✅ Ninguno — todo limpio"
else
  echo "  ⚠️ Quedan $ESCAPED líneas con HTML escapado"
  grep -r "&lt;\|&gt;\|&amp;" src/ --include="*.js" --include="*.jsx" 2>/dev/null | head -5
fi

echo ""
echo "🚀 Listo. Ejecuta: npm run dev"
echo ""
