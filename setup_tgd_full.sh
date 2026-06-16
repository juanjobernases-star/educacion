#!/bin/bash
# ============================================================
# setup_tgd_full.sh
# Inicializa el proyecto TGD completo desde cero
# Vite + React + Tailwind + Cifrado local + Diario TEA
#
# Uso:
#   cd ~/Escritorio/TGD
#   chmod +x setup_tgd_full.sh
#   ./setup_tgd_full.sh
# ============================================================

set -e

echo ""
echo "🔧 Inicializando proyecto TGD completo..."
echo ""

# ============================================================
# 1. package.json
# ============================================================
cat << 'PKG_EOF' > package.json
{
  "name": "tgd-app",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "description": "App educativa segura local-first con soporte TEA/TGD",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.3.4",
    "autoprefixer": "^10.4.20",
    "postcss": "^8.4.49",
    "tailwindcss": "^3.4.17",
    "vite": "^6.0.5"
  }
}
PKG_EOF

echo "✅ package.json"

# ============================================================
# 2. vite.config.js
# ============================================================
cat << 'VITE_EOF' > vite.config.js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    open: true
  }
});
VITE_EOF

echo "✅ vite.config.js"

# ============================================================
# 3. tailwind.config.js
# ============================================================
cat << 'TW_EOF' > tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx}"
  ],
  theme: {
    extend: {}
  },
  plugins: []
};
TW_EOF

echo "✅ tailwind.config.js"

# ============================================================
# 4. postcss.config.js
# ============================================================
cat << 'POSTCSS_EOF' > postcss.config.js
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};
POSTCSS_EOF

echo "✅ postcss.config.js"

# ============================================================
# 5. index.html
# ============================================================
cat << 'HTML_EOF' > index.html
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TGD - App Educativa Segura</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
HTML_EOF

echo "✅ index.html"

# ============================================================
# 6. Crear directorios
# ============================================================
mkdir -p src/core
mkdir -p src/modules/journal

# ============================================================
# 7. src/index.css
# ============================================================
cat << 'CSS_EOF' > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;

html, body, #root {
  margin: 0;
  padding: 0;
  min-height: 100%;
}
CSS_EOF

echo "✅ src/index.css"

# ============================================================
# 8. src/main.jsx
# ============================================================
cat << 'MAIN_EOF' > src/main.jsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
MAIN_EOF

echo "✅ src/main.jsx"

# ============================================================
# 9. src/App.jsx
# ============================================================
cat << 'APP_EOF' > src/App.jsx
import React, { useState } from "react";
import JournalView from "./modules/journal/journal-view";

export default function App() {
  const [parentPin, setParentPin] = useState("");

  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <div className="max-w-5xl mx-auto p-6 space-y-6">
        <header className="space-y-2">
          <h1 className="text-3xl font-bold tracking-tight">
            TGD · App educativa segura
          </h1>
          <p className="text-slate-600">
            Prototipo local-first con diario cifrado y soporte TEA/TGD.
            Sin telemetría · Sin servidores · Sin rastreo.
          </p>
        </header>

        <section className="rounded-2xl border bg-white p-4 space-y-3">
          <label className="block text-sm font-medium">
            PIN del adulto (local)
          </label>

          <input
            type="password"
            value={parentPin}
            onChange={(e) => setParentPin(e.target.value)}
            placeholder="Introduce un PIN de 4+ caracteres"
            className="w-full max-w-sm border rounded-xl px-3 py-2 outline-none focus:ring-2 focus:ring-slate-300"
          />

          <p className="text-sm text-slate-500">
            Este PIN no se envía a ningún servidor. Solo se usa en tu dispositivo
            para cifrar y descifrar la información del diario.
          </p>
        </section>

        <JournalView
          parentPin={parentPin}
          teaMode={true}
          lowStim={true}
        />
      </div>
    </div>
  );
}
APP_EOF

echo "✅ src/App.jsx"

# ============================================================
# 10. src/core/secure-store.js
# ============================================================
cat << 'STORE_EOF' > src/core/secure-store.js
const DEFAULT_NAMESPACE = "tgd_secure";
const PBKDF2_ITERATIONS = 150000;
const AES_LENGTH = 256;
const SALT_LENGTH = 16;
const IV_LENGTH = 12;

function ensureBrowserCrypto() {
  if (typeof window === "undefined" || !window.crypto?.subtle) {
    throw new Error("Web Crypto API no disponible en este entorno.");
  }
}

function textEncoder() {
  return new TextEncoder();
}

function textDecoder() {
  return new TextDecoder();
}

function toBase64(buffer) {
  const bytes = new Uint8Array(buffer);
  let binary = "";
  for (let i = 0; i < bytes.byteLength; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}

function fromBase64(base64) {
  const binary = atob(base64);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i);
  }
  return bytes.buffer;
}

function scopedKey(namespace, key) {
  return `${namespace}:${key}`;
}

async function deriveKeyFromPin(pin, salt) {
  ensureBrowserCrypto();

  if (!pin || String(pin).length < 4) {
    throw new Error("Se necesita un PIN local de al menos 4 caracteres.");
  }

  const rawKey = await crypto.subtle.importKey(
    "raw",
    textEncoder().encode(String(pin)),
    { name: "PBKDF2" },
    false,
    ["deriveKey"]
  );

  return crypto.subtle.deriveKey(
    {
      name: "PBKDF2",
      salt,
      iterations: PBKDF2_ITERATIONS,
      hash: "SHA-256"
    },
    rawKey,
    { name: "AES-GCM", length: AES_LENGTH },
    false,
    ["encrypt", "decrypt"]
  );
}

export async function encryptJson(pin, data) {
  ensureBrowserCrypto();

  const salt = crypto.getRandomValues(new Uint8Array(SALT_LENGTH));
  const iv = crypto.getRandomValues(new Uint8Array(IV_LENGTH));
  const key = await deriveKeyFromPin(pin, salt);
  const payload = textEncoder().encode(JSON.stringify(data));

  const cipher = await crypto.subtle.encrypt(
    { name: "AES-GCM", iv },
    key,
    payload
  );

  return {
    version: 1,
    salt: toBase64(salt.buffer),
    iv: toBase64(iv.buffer),
    cipher: toBase64(cipher),
    createdAt: new Date().toISOString()
  };
}

export async function decryptJson(pin, packet) {
  ensureBrowserCrypto();

  if (!packet?.salt || !packet?.iv || !packet?.cipher) {
    throw new Error("Paquete cifrado no válido.");
  }

  const salt = new Uint8Array(fromBase64(packet.salt));
  const iv = new Uint8Array(fromBase64(packet.iv));
  const cipher = fromBase64(packet.cipher);

  const key = await deriveKeyFromPin(pin, salt);

  const plain = await crypto.subtle.decrypt(
    { name: "AES-GCM", iv },
    key,
    cipher
  );

  return JSON.parse(textDecoder().decode(plain));
}

export async function saveEncryptedJSON(key, data, pin, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const packet = await encryptJson(pin, data);
  localStorage.setItem(scopedKey(namespace, key), JSON.stringify(packet));
  return true;
}

export async function loadEncryptedJSON(key, pin, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const raw = localStorage.getItem(scopedKey(namespace, key));
  if (!raw) return null;

  const packet = JSON.parse(raw);
  return decryptJson(pin, packet);
}

export function removeEncryptedJSON(key, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  localStorage.removeItem(scopedKey(namespace, key));
}

export function hasEncryptedJSON(key, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  return localStorage.getItem(scopedKey(namespace, key)) !== null;
}

export function listNamespaceKeys(options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const prefix = `${namespace}:`;

  return Object.keys(localStorage)
    .filter((k) => k.startsWith(prefix))
    .map((k) => k.slice(prefix.length))
    .sort();
}

export async function exportNamespace(pin, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const keys = listNamespaceKeys({ namespace });
  const values = {};

  for (const k of keys) {
    values[k] = await loadEncryptedJSON(k, pin, { namespace });
  }

  return {
    namespace,
    exportedAt: new Date().toISOString(),
    values
  };
}

export async function importNamespace(bundle, pin, options = {}) {
  const namespace = options.namespace || bundle?.namespace || DEFAULT_NAMESPACE;
  const values = bundle?.values || {};

  for (const [k, v] of Object.entries(values)) {
    await saveEncryptedJSON(k, v, pin, { namespace });
  }

  return true;
}

/* ==========================
   Helpers específicos diario
   ========================== */

export async function saveJournalEntry(pin, entry, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  const fecha = entry?.fecha || new Date().toISOString().slice(0, 10);
  const key = `entry:${fecha}`;

  const normalized = {
    fecha,
    estado: entry?.estado || "tranquilo",
    dia: entry?.dia || "",
    gusto: entry?.gusto || "",
    costo: entry?.costo || "",
    manana: entry?.manana || "",
    ruido: entry?.ruido || "bajo",
    ayuda: entry?.ayuda || "no",
    energia: entry?.energia || "media",
    rutina: Array.isArray(entry?.rutina) ? entry.rutina : [],
    apoyos: Array.isArray(entry?.apoyos) ? entry.apoyos : [],
    updatedAt: new Date().toISOString()
  };

  await saveEncryptedJSON(key, normalized, pin, { namespace });
  return normalized;
}

export async function loadJournalEntry(pin, fecha, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  return loadEncryptedJSON(`entry:${fecha}`, pin, { namespace });
}

export function listJournalDates(options = {}) {
  const namespace = options.namespace || "tgd_journal";

  return listNamespaceKeys({ namespace })
    .filter((k) => k.startsWith("entry:"))
    .map((k) => k.replace("entry:", ""))
    .sort((a, b) => b.localeCompare(a));
}

export async function loadAllJournalEntries(pin, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  const fechas = listJournalDates({ namespace });
  const entries = [];

  for (const fecha of fechas) {
    const entry = await loadJournalEntry(pin, fecha, { namespace });
    if (entry) {
      entries.push(entry);
    }
  }

  return entries;
}

export function deleteJournalEntry(fecha, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  removeEncryptedJSON(`entry:${fecha}`, { namespace });
}
STORE_EOF

echo "✅ src/core/secure-store.js"

# ============================================================
# 11. src/modules/journal/journal-view.js
# ============================================================
cat << 'JOURNAL_EOF' > src/modules/journal/journal-view.js
import React, { useMemo, useState } from "react";
import {
  saveJournalEntry,
  loadJournalEntry,
  loadAllJournalEntries,
  deleteJournalEntry
} from "../../core/secure-store";

const MOODS = [
  { key: "feliz", emoji: "😊", label: "Feliz" },
  { key: "tranquilo", emoji: "😌", label: "Tranquilo" },
  { key: "cansado", emoji: "😴", label: "Cansado" },
  { key: "nervioso", emoji: "😟", label: "Nervioso" },
  { key: "enfadado", emoji: "😠", label: "Enfadado" }
];

const TEA_ROUTINES = [
  { key: "levantarse", icon: "🛏️", label: "Me he levantado" },
  { key: "cole", icon: "🏫", label: "He ido al cole" },
  { key: "comer", icon: "🍽️", label: "He comido" },
  { key: "jugar", icon: "🎮", label: "He jugado" },
  { key: "descanso", icon: "🛋️", label: "He descansado" },
  { key: "familia", icon: "👨‍👩‍👧‍👦", label: "He estado con mi familia" }
];

const SUPPORTS = [
  { key: "pictos", label: "Pictogramas" },
  { key: "pasos", label: "Pasos cortos" },
  { key: "descanso", label: "Descanso extra" },
  { key: "audio", label: "Audio suave" }
];

function TeaButton({ active, onClick, children }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={[
        "rounded-2xl border px-4 py-3 text-left transition w-full",
        active
          ? "bg-slate-900 text-white border-slate-900"
          : "bg-white hover:bg-slate-50 border-slate-200"
      ].join(" ")}
    >
      {children}
    </button>
  );
}

function SectionTitle({ children }) {
  return <h3 className="text-base font-semibold tracking-tight">{children}</h3>;
}

function getDefaultJournal() {
  return {
    fecha: new Date().toISOString().slice(0, 10),
    estado: "tranquilo",
    dia: "",
    gusto: "",
    costo: "",
    manana: "",
    ruido: "bajo",
    ayuda: "no",
    energia: "media",
    rutina: [],
    apoyos: []
  };
}

export default function JournalView({
  parentPin,
  teaMode = true,
  lowStim = true,
  namespace = "tgd_journal",
  onEntrySaved
}) {
  const [entry, setEntry] = useState(getDefaultJournal());
  const [step, setStep] = useState(0);
  const [entries, setEntries] = useState([]);
  const [message, setMessage] = useState("");
  const [busy, setBusy] = useState(false);

  const containerClass = lowStim
    ? "bg-slate-50 text-slate-900"
    : "bg-gradient-to-br from-violet-50 via-white to-cyan-50 text-slate-900";

  const steps = useMemo(
    () => [
      "¿Cómo me siento?",
      "Mi rutina de hoy",
      "Qué he hecho",
      "Qué me gustó y qué me costó",
      "Mañana quiero"
    ],
    []
  );

  const progress = useMemo(() => {
    let value = 0;
    if (entry.estado) value += 20;
    if (entry.rutina.length > 0 || !teaMode) value += 20;
    if (entry.dia.trim()) value += 20;
    if (entry.gusto.trim() || entry.costo.trim()) value += 20;
    if (entry.manana.trim()) value += 20;
    return value;
  }, [entry, teaMode]);

  function updateField(field, value) {
    setEntry((prev) => ({ ...prev, [field]: value }));
  }

  function toggleInArray(field, value) {
    setEntry((prev) => {
      const current = new Set(prev[field]);
      if (current.has(value)) {
        current.delete(value);
      } else {
        current.add(value);
      }
      return { ...prev, [field]: Array.from(current) };
    });
  }

  async function handleSave() {
    if (!parentPin || String(parentPin).length < 4) {
      setMessage("Necesitas un PIN local del adulto para guardar el diario cifrado.");
      return;
    }

    try {
      setBusy(true);
      const saved = await saveJournalEntry(parentPin, entry, { namespace });
      setMessage("Diario guardado localmente y cifrado.");
      if (onEntrySaved) onEntrySaved(saved);
    } catch (error) {
      setMessage("No se ha podido guardar la entrada del diario.");
    } finally {
      setBusy(false);
    }
  }

  async function handleLoadCurrentDate() {
    if (!parentPin || String(parentPin).length < 4) {
      setMessage("Introduce el PIN local del adulto para cargar esta fecha.");
      return;
    }

    try {
      setBusy(true);
      const saved = await loadJournalEntry(parentPin, entry.fecha, { namespace });

      if (!saved) {
        setMessage("No hay entrada guardada para esta fecha.");
        return;
      }

      setEntry(saved);
      setMessage("Entrada cargada correctamente.");
    } catch (error) {
      setMessage("No se ha podido descifrar la entrada. Revisa el PIN.");
    } finally {
      setBusy(false);
    }
  }

  async function handleListEntries() {
    if (!parentPin || String(parentPin).length < 4) {
      setMessage("Introduce el PIN local del adulto para ver el historial.");
      return;
    }

    try {
      setBusy(true);
      const loaded = await loadAllJournalEntries(parentPin, { namespace });
      setEntries(loaded);
      setMessage(loaded.length ? "Historial local cargado." : "No hay entradas guardadas.");
    } catch (error) {
      setMessage("No se ha podido cargar el historial.");
    } finally {
      setBusy(false);
    }
  }

  function handleDeleteCurrent() {
    deleteJournalEntry(entry.fecha, { namespace });
    setMessage("Entrada local eliminada para la fecha seleccionada.");
  }

  function renderStep() {
    switch (step) {
      case 0:
        return (
          <div className="space-y-4">
            <SectionTitle>¿Cómo me siento hoy?</SectionTitle>
            <p className="text-sm text-slate-600">
              Elige una emoción. Solo una acción por pantalla.
            </p>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {MOODS.map((mood) => (
                <TeaButton
                  key={mood.key}
                  active={entry.estado === mood.key}
                  onClick={() => updateField("estado", mood.key)}
                >
                  <span className="text-lg mr-2">{mood.emoji}</span>
                  <span className="font-medium">{mood.label}</span>
                </TeaButton>
              ))}
            </div>

            <div className="grid sm:grid-cols-2 gap-3">
              <label className="rounded-2xl border bg-white p-3">
                <span className="block text-sm font-medium mb-2">Nivel de ruido</span>
                <select
                  className="w-full rounded-xl border px-3 py-2 bg-white"
                  value={entry.ruido}
                  onChange={(e) => updateField("ruido", e.target.value)}
                >
                  <option value="bajo">Bajo</option>
                  <option value="medio">Medio</option>
                  <option value="alto">Alto</option>
                </select>
              </label>

              <label className="rounded-2xl border bg-white p-3">
                <span className="block text-sm font-medium mb-2">Energía</span>
                <select
                  className="w-full rounded-xl border px-3 py-2 bg-white"
                  value={entry.energia}
                  onChange={(e) => updateField("energia", e.target.value)}
                >
                  <option value="baja">Baja</option>
                  <option value="media">Media</option>
                  <option value="alta">Alta</option>
                </select>
              </label>
            </div>
          </div>
        );

      case 1:
        return (
          <div className="space-y-4">
            <SectionTitle>Mi rutina de hoy</SectionTitle>
            <p className="text-sm text-slate-600">
              Marca las actividades que has hecho. Esto ayuda mucho en modo TEA.
            </p>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {TEA_ROUTINES.map((item) => (
                <TeaButton
                  key={item.key}
                  active={entry.rutina.includes(item.key)}
                  onClick={() => toggleInArray("rutina", item.key)}
                >
                  <span className="text-lg mr-2">{item.icon}</span>
                  <span className="font-medium">{item.label}</span>
                </TeaButton>
              ))}
            </div>

            <div className="rounded-2xl border bg-white p-4">
              <p className="text-sm font-medium mb-2">Apoyos que me ayudaron</p>
              <div className="grid sm:grid-cols-2 gap-2">
                {SUPPORTS.map((item) => (
                  <TeaButton
                    key={item.key}
                    active={entry.apoyos.includes(item.key)}
                    onClick={() => toggleInArray("apoyos", item.key)}
                  >
                    <span className="font-medium">{item.label}</span>
                  </TeaButton>
                ))}
              </div>
            </div>
          </div>
        );

      case 2:
        return (
          <div className="space-y-4">
            <SectionTitle>Hoy he hecho…</SectionTitle>
            <p className="text-sm text-slate-600">
              Escribe con frases cortas. Si lo prefieres, usa un modelo guiado.
            </p>

            <div className="grid gap-3">
              {teaMode && (
                <div className="rounded-2xl border bg-white p-4 text-sm text-slate-600">
                  <p className="font-medium text-slate-800 mb-2">Modelo TEA</p>
                  <p>
                    Hoy he ido a _______. Después he hecho _______. Luego me he sentido _______.
                  </p>
                </div>
              )}

              <textarea
                className="w-full min-h-[140px] rounded-2xl border bg-white px-4 py-3 outline-none"
                value={entry.dia}
                onChange={(e) => updateField("dia", e.target.value)}
                placeholder="Escribe aquí lo que has hecho hoy…"
              />
            </div>
          </div>
        );

      case 3:
        return (
          <div className="space-y-4">
            <SectionTitle>Lo bueno y lo difícil</SectionTitle>

            <div className="grid md:grid-cols-2 gap-4">
              <div className="rounded-2xl border bg-white p-4 space-y-2">
                <label className="block text-sm font-medium">Lo que más me gustó</label>
                <textarea
                  className="w-full min-h-[120px] rounded-2xl border px-4 py-3 outline-none"
                  value={entry.gusto}
                  onChange={(e) => updateField("gusto", e.target.value)}
                  placeholder="¿Qué ha sido lo mejor del día?"
                />
              </div>

              <div className="rounded-2xl border bg-white p-4 space-y-2">
                <label className="block text-sm font-medium">Algo que me costó</label>
                <textarea
                  className="w-full min-h-[120px] rounded-2xl border px-4 py-3 outline-none"
                  value={entry.costo}
                  onChange={(e) => updateField("costo", e.target.value)}
                  placeholder="¿Qué parte fue difícil?"
                />
              </div>
            </div>

            <div className="rounded-2xl border bg-white p-4">
              <label className="block text-sm font-medium mb-2">¿Necesité ayuda?</label>
              <div className="flex gap-2">
                <TeaButton active={entry.ayuda === "si"} onClick={() => updateField("ayuda", "si")}>
                  Sí
                </TeaButton>
                <TeaButton active={entry.ayuda === "no"} onClick={() => updateField("ayuda", "no")}>
                  No
                </TeaButton>
              </div>
            </div>
          </div>
        );

      case 4:
      default:
        return (
          <div className="space-y-4">
            <SectionTitle>Mañana quiero…</SectionTitle>
            <p className="text-sm text-slate-600">
              Piensa en una sola cosa importante para mañana.
            </p>

            <textarea
              className="w-full min-h-[140px] rounded-2xl border bg-white px-4 py-3 outline-none"
              value={entry.manana}
              onChange={(e) => updateField("manana", e.target.value)}
              placeholder="Mañana quiero…"
            />
          </div>
        );
    }
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", containerClass].join(" ")}>
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold tracking-tight">Diario del alumno</h2>
          <p className="text-sm text-slate-600">Local, cifrado y con soporte TEA/TGD.</p>
        </div>

        <div className="text-sm text-slate-600 rounded-2xl border bg-white px-3 py-2">
          Progreso: <strong>{progress}%</strong>
        </div>
      </div>

      <div className="grid md:grid-cols-[0.75fr_1.25fr] gap-4">
        <div className="space-y-4">
          <div className="rounded-2xl border bg-white p-4 space-y-3">
            <label className="block text-sm font-medium">Fecha</label>
            <input
              type="date"
              className="w-full rounded-2xl border px-3 py-2"
              value={entry.fecha}
              onChange={(e) => updateField("fecha", e.target.value)}
            />

            {teaMode && (
              <div className="rounded-2xl bg-slate-50 border p-3 text-sm text-slate-600">
                <p className="font-medium text-slate-800 mb-1">Modo TEA activo</p>
                <p>Una instrucción por pantalla, lenguaje simple y botones grandes.</p>
              </div>
            )}
          </div>

          <div className="rounded-2xl border bg-white p-4 space-y-2">
            <p className="text-sm font-medium">Pasos</p>
            <div className="space-y-2">
              {steps.map((label, index) => (
                <button
                  key={label}
                  type="button"
                  onClick={() => setStep(index)}
                  className={[
                    "w-full text-left rounded-2xl border px-3 py-2 text-sm transition",
                    step === index
                      ? "bg-slate-900 text-white border-slate-900"
                      : "bg-white hover:bg-slate-50 border-slate-200"
                  ].join(" ")}
                >
                  {index + 1}. {label}
                </button>
              ))}
            </div>
          </div>
        </div>

        <div className="space-y-4">
          <div className="rounded-2xl border bg-white p-4 md:p-5">
            {renderStep()}
          </div>

          <div className="flex flex-wrap gap-3">
            <button
              type="button"
              onClick={() => setStep((prev) => Math.max(prev - 1, 0))}
              className="rounded-2xl border px-4 py-3 bg-white hover:bg-slate-50"
            >
              Anterior
            </button>

            <button
              type="button"
              onClick={() => setStep((prev) => Math.min(prev + 1, steps.length - 1))}
              className="rounded-2xl border px-4 py-3 bg-slate-900 text-white"
            >
              Siguiente
            </button>

            <button
              type="button"
              disabled={busy}
              onClick={handleSave}
              className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white disabled:opacity-60"
            >
              Guardar cifrado
            </button>

            <button
              type="button"
              disabled={busy}
              onClick={handleLoadCurrentDate}
              className="rounded-2xl border px-4 py-3 bg-white hover:bg-slate-50"
            >
              Cargar fecha
            </button>

            <button
              type="button"
              onClick={handleListEntries}
              className="rounded-2xl border px-4 py-3 bg-white hover:bg-slate-50"
            >
              Ver historial
            </button>

            <button
              type="button"
              onClick={handleDeleteCurrent}
              className="rounded-2xl border px-4 py-3 bg-rose-600 text-white"
            >
              Borrar fecha
            </button>
          </div>

          {message && (
            <div className="rounded-2xl border bg-sky-50 text-sky-900 px-4 py-3 text-sm">
              {message}
            </div>
          )}

          {entries.length > 0 && (
            <div className="rounded-2xl border bg-white p-4 space-y-3">
              <SectionTitle>Historial local</SectionTitle>

              <div className="grid gap-3">
                {entries.map((item) => (
                  <button
                    key={item.fecha}
                    type="button"
                    onClick={() => setEntry(item)}
                    className="rounded-2xl border bg-slate-50 hover:bg-slate-100 p-4 text-left"
                  >
                    <div className="flex items-center justify-between gap-3">
                      <div>
                        <p className="font-medium">{item.fecha}</p>
                        <p className="text-sm text-slate-600">
                          Estado: {item.estado} · Ruido: {item.ruido}
                        </p>
                      </div>

                      <span className="text-2xl">
                        {MOODS.find((m) => m.key === item.estado)?.emoji || "📝"}
                      </span>
                    </div>
                  </button>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
JOURNAL_EOF

echo "✅ src/modules/journal/journal-view.js"

# ============================================================
# 12. Instalar dependencias
# ============================================================
echo ""
echo "📦 Instalando dependencias con npm..."
echo ""
npm install

# ============================================================
# 13. Mostrar resultado
# ============================================================
echo ""
echo "============================================================"
echo "  ESTRUCTURA FINAL DEL PROYECTO"
echo "============================================================"
echo ""
find . -not -path './node_modules/*' -not -path './.git/*' -not -name 'setup_tgd*.sh' -type f | sort | while read f; do
  size=$(wc -c < "$f")
  printf "  %-45s %s bytes\n" "$f" "$size"
done

echo ""
echo "🚀 ¡Proyecto TGD listo!"
echo ""
echo "Para arrancar:"
echo "  npm run dev"
echo ""
echo "Se abrirá en http://localhost:3000"
echo ""
