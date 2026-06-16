#!/bin/bash
set -e
echo ""
echo "Adding consent gate..."
echo ""
mkdir -p src/modules/consent

cat << 'EOF' > src/modules/consent/consent-gate.jsx
import React, { useState } from "react";

const CONSENT_KEY = "tgd_consent_accepted";
const BLOCKED_KEY = "tgd_consent_blocked";

function isBlocked() {
  try {
    const raw = localStorage.getItem(BLOCKED_KEY);
    if (!raw) return false;
    const data = JSON.parse(raw);
    const blockedAt = new Date(data.blockedAt).getTime();
    const now = Date.now();
    if (now - blockedAt < 24 * 60 * 60 * 1000) return true;
    localStorage.removeItem(BLOCKED_KEY);
    return false;
  } catch { return false; }
}

function hasConsented() {
  try {
    const raw = localStorage.getItem(CONSENT_KEY);
    if (!raw) return false;
    return JSON.parse(raw).accepted === true;
  } catch { return false; }
}

function BlockedScreen() {
  return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center p-6">
      <div className="max-w-lg w-full text-center space-y-6">
        <div className="text-5xl">🔒</div>
        <h1 className="text-2xl font-bold">Aplicacion bloqueada</h1>
        <p className="text-slate-600">El consentimiento no fue aceptado. Podras volver a intentarlo en 24 horas.</p>
      </div>
    </div>
  );
}

export default function ConsentGate({ children }) {
  const [accepted, setAccepted] = useState(hasConsented());
  const [blocked, setBlocked] = useState(isBlocked());
  const [guardianName, setGuardianName] = useState("");
  const [showDetail, setShowDetail] = useState(false);

  if (blocked) return <BlockedScreen />;
  if (accepted) return children;

  function accept() {
    localStorage.setItem(CONSENT_KEY, JSON.stringify({
      accepted: true,
      guardianName: guardianName.trim() || "No especificado",
      acceptedAt: new Date().toISOString()
    }));
    setAccepted(true);
  }

  function reject() {
    localStorage.setItem(BLOCKED_KEY, JSON.stringify({
      accepted: false,
      blockedAt: new Date().toISOString()
    }));
    setBlocked(true);
  }

  return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center p-6">
      <div className="max-w-2xl w-full space-y-6">
        <div className="text-center space-y-3">
          <div className="text-4xl">📋</div>
          <h1 className="text-2xl font-bold">Consentimiento de uso</h1>
          <p className="text-slate-600">El padre, madre o tutor legal debe leer y aceptar antes de usar la app.</p>
        </div>

        <div className="rounded-2xl border bg-white p-6 space-y-4">
          <h2 className="font-bold text-lg">Informacion sobre la aplicacion</h2>
          <div className="space-y-3 text-sm text-slate-700">
            <div className="rounded-xl border bg-slate-50 p-4">
              <p className="font-semibold">Que es esta aplicacion</p>
              <p>TGD es una app educativa para alumnos con TEA, TGD y Asperger. Incluye contenido LOMLOE, rutinas visuales, apoyo emocional y herramientas para familias.</p>
            </div>
            <div className="rounded-xl border bg-slate-50 p-4">
              <p className="font-semibold">Datos personales</p>
              <p>NO recoge ni envia datos personales a ningun servidor. Todo se almacena cifrado en el dispositivo.</p>
            </div>
            <div className="rounded-xl border bg-slate-50 p-4">
              <p className="font-semibold">Privacidad</p>
              <p>Sin telemetria. Sin publicidad. Sin rastreo. Sin cookies de terceros. Cumplimiento RGPD y LOPDGDD.</p>
            </div>
            <div className="rounded-xl border bg-slate-50 p-4">
              <p className="font-semibold">Menores de 14 anios</p>
              <p>Segun la LOPDGDD, el uso por menores de 14 requiere consentimiento del tutor legal.</p>
            </div>
          </div>
          <button onClick={() => setShowDetail(!showDetail)} className="text-sm text-slate-500 underline">
            {showDetail ? "Ocultar detalle" : "Ver detalle completo"}
          </button>
          {showDetail && (
            <div className="rounded-xl border bg-slate-50 p-4 text-xs text-slate-600 space-y-2">
              <p>1. Funciona local-first: los datos no salen del dispositivo.</p>
              <p>2. Cifrado AES-256-GCM con PBKDF2-SHA256.</p>
              <p>3. No se recopilan: email, telefono, IP, ni geolocalizacion.</p>
              <p>4. El alumno usa alias, no nombre completo.</p>
              <p>5. El adulto puede revocar y borrar datos desde Ajustes.</p>
              <p>6. Sin IA conectada a internet. Tutor emocional reglado y local.</p>
              <p>7. Sin publicidad, compras integradas ni suscripciones.</p>
              <p>8. No sustituye intervencion de profesionales sanitarios ni educativos.</p>
            </div>
          )}
        </div>

        <div className="rounded-2xl border bg-white p-6 space-y-4">
          <h2 className="font-bold">Datos del tutor legal</h2>
          <p className="text-sm text-slate-600">Obligatorio para menores de 14. Recomendado para cualquier edad.</p>
          <input type="text" value={guardianName} onChange={(e) => setGuardianName(e.target.value)}
            placeholder="Nombre del padre, madre o tutor legal"
            className="w-full rounded-xl border px-4 py-3 outline-none" />
        </div>

        <div className="flex flex-col sm:flex-row gap-4">
          <button onClick={accept} disabled={!guardianName.trim()}
            className="flex-1 rounded-2xl border-2 px-6 py-4 bg-emerald-600 text-white font-bold text-lg disabled:opacity-40">
            ACEPTO
          </button>
          <button onClick={reject}
            className="flex-1 rounded-2xl border-2 px-6 py-4 bg-rose-600 text-white font-bold text-lg">
            NO ACEPTO
          </button>
        </div>

        <p className="text-center text-xs text-slate-500">
          Si pulsa NO ACEPTO, la app se bloquea 24 horas.
        </p>
      </div>
    </div>
  );
}
EOF

echo "OK src/modules/consent/consent-gate.jsx"

# Patch App.jsx
if [ -f src/App.jsx ]; then
  if ! grep -q "ConsentGate" src/App.jsx; then
    sed -i '1i import ConsentGate from "./modules/consent/consent-gate.jsx";' src/App.jsx
    sed -i 's|if (!selection) return <StageSelectorView|if (!selection) return <ConsentGate><StageSelectorView|' src/App.jsx
    sed -i 's|onSelect={sel => setSelection(sel)} />;|onSelect={sel => setSelection(sel)} /></ConsentGate>;|' src/App.jsx
    echo "OK App.jsx parcheado"
  else
    echo "ConsentGate ya presente"
  fi
fi

echo ""
echo "CONSENT GATE INSTALADO"
echo "Ejecuta: npm run dev"
echo ""
