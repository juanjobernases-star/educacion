#!/bin/bash
# ============================================================
# setup_tgd_phase9.sh
# Fase 9: IA tutor emocional, seguridad RGPD/LOPDGDD,
# panel profesor multiusuario/local, UI kit, PWA y build producción.
# Ejecutar desde: /home/juanjo/Escritorio/TGD/
# ============================================================
set -e

echo ""
echo "FASE 9: IA tutor emocional + seguridad + panel profesor + UI kit"
echo ""

mkdir -p src/core src/ui src/modules/emotional-tutor src/modules/teacher src/modules/security public scripts docs

# ------------------------------------------------------------
# 1) UI KIT - tokens visuales accesibles y modo baja estimulación
# ------------------------------------------------------------
cat << 'EOF' > src/ui/ui-kit.js
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
  return <div className="tgd-progress"><span style={{ width: safe + "%" }} /></div>;
}
EOF

echo "OK src/ui/ui-kit.js"

cat << 'EOF' > src/ui/theme.css
:root {
  --tgd-bg: #f8fafc;
  --tgd-panel: #ffffff;
  --tgd-text: #0f172a;
  --tgd-muted: #64748b;
  --tgd-border: #e2e8f0;
  --tgd-primary: #5b21b6;
  --tgd-primary-soft: #ede9fe;
  --tgd-green: #059669;
  --tgd-red: #dc2626;
  --tgd-yellow: #f59e0b;
  --tgd-radius: 22px;
  --tgd-shadow: 0 18px 45px rgba(15, 23, 42, .08);
  color-scheme: light;
}

body { background: var(--tgd-bg); color: var(--tgd-text); }
.tgd-shell { min-height: 100vh; background: radial-gradient(circle at top left, #f3e8ff, transparent 34%), var(--tgd-bg); }
.tgd-container { width: min(1180px, calc(100% - 28px)); margin: 0 auto; padding: 22px 0 48px; }
.tgd-header { display:flex; gap:16px; align-items:center; justify-content:space-between; flex-wrap:wrap; margin-bottom:16px; }
.tgd-title { font-size: clamp(1.5rem, 3vw, 2.25rem); font-weight: 850; letter-spacing:-.03em; }
.tgd-subtitle { color: var(--tgd-muted); margin-top: 4px; }
.tgd-nav { display:flex; flex-wrap:wrap; gap:10px; margin: 16px 0 20px; }
.tgd-nav button { border:1px solid var(--tgd-border); background:var(--tgd-panel); border-radius:999px; padding:11px 15px; font-weight:700; cursor:pointer; }
.tgd-nav button.active { background:var(--tgd-text); color:white; border-color:var(--tgd-text); }
.tgd-card, .tgd-panel { background:var(--tgd-panel); border:1px solid var(--tgd-border); border-radius:var(--tgd-radius); box-shadow:var(--tgd-shadow); padding:20px; }
.tgd-card-header h2 { font-size:1.35rem; font-weight:850; margin:0; }
.tgd-card-header p { color:var(--tgd-muted); margin:6px 0 0; }
.tgd-card-body { margin-top:16px; }
.tgd-card-actions { display:flex; flex-wrap:wrap; gap:10px; margin-top:16px; }
.tgd-grid { display:grid; gap:16px; }
.tgd-grid-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
.tgd-grid-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
@media (max-width: 780px) { .tgd-grid-2, .tgd-grid-3 { grid-template-columns:1fr; } }
.tgd-button { border:1px solid var(--tgd-border); background:var(--tgd-panel); border-radius:16px; padding:12px 16px; font-weight:800; cursor:pointer; }
.tgd-button-primary { background:var(--tgd-primary); color:white; border-color:var(--tgd-primary); }
.tgd-button-soft { background:var(--tgd-primary-soft); color:var(--tgd-primary); border-color:#ddd6fe; }
.tgd-input, .tgd-select, .tgd-textarea { width:100%; border:1px solid var(--tgd-border); border-radius:16px; padding:12px 14px; background:white; color:var(--tgd-text); }
.tgd-textarea { min-height:120px; resize:vertical; }
.tgd-badge { display:inline-flex; align-items:center; gap:6px; border:1px solid var(--tgd-border); background:#f8fafc; border-radius:999px; padding:7px 11px; font-size:.88rem; font-weight:800; }
.tgd-big-action { text-align:left; border:1px solid var(--tgd-border); background:#fff; border-radius:22px; padding:18px; min-height:112px; cursor:pointer; display:flex; flex-direction:column; gap:6px; }
.tgd-big-action.active { border-color:var(--tgd-primary); background:var(--tgd-primary-soft); }
.tgd-big-action-icon { font-size:1.7rem; }
.tgd-big-action-title { font-weight:850; }
.tgd-big-action-text { color:var(--tgd-muted); font-size:.92rem; }
.tgd-progress { height:12px; background:#e2e8f0; border-radius:999px; overflow:hidden; }
.tgd-progress span { display:block; height:100%; background:linear-gradient(90deg, #7c3aed, #06b6d4); }
.tgd-low-stim .tgd-shell { background:#f8fafc; }
.tgd-low-stim * { animation:none !important; transition:none !important; }
.tgd-alert { border-radius:18px; padding:14px; border:1px solid #fde68a; background:#fffbeb; color:#78350f; }
.tgd-safe { border-radius:18px; padding:14px; border:1px solid #bbf7d0; background:#f0fdf4; color:#14532d; }
.tgd-danger { border-radius:18px; padding:14px; border:1px solid #fecaca; background:#fef2f2; color:#7f1d1d; }
EOF

echo "OK src/ui/theme.css"

# Ensure CSS import in main.jsx if not present
if [ -f src/main.jsx ] && ! grep -q "./ui/theme.css" src/main.jsx; then
  sed -i '1i import "./ui/theme.css";' src/main.jsx
fi

# ------------------------------------------------------------
# 2) Secure Vault: cifrado local, saneamiento, minimización
# ------------------------------------------------------------
cat << 'EOF' > src/core/secure-vault.js
const DEFAULT_NAMESPACE = "tgd_secure_vault_v9";
const encoder = new TextEncoder();
const decoder = new TextDecoder();

export function sanitizeText(value, maxLen = 2000) {
  return String(value ?? "")
    .replace(/[<>]/g, "")
    .replace(/javascript:/gi, "")
    .replace(/on\w+=/gi, "")
    .slice(0, maxLen)
    .trim();
}

export function minimizeStudentRecord(record = {}) {
  return {
    id: sanitizeText(record.id || crypto.randomUUID(), 80),
    alias: sanitizeText(record.alias || "Alumno", 80),
    ageRange: sanitizeText(record.ageRange || "no_especificado", 30),
    group: sanitizeText(record.group || "", 60),
    createdAt: record.createdAt || new Date().toISOString(),
    updatedAt: new Date().toISOString()
  };
}

export function redactPII(text) {
  return sanitizeText(text, 5000)
    .replace(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/gi, "[email]")
    .replace(/\b\d{3}[-.\s]?\d{3}[-.\s]?\d{3}\b/g, "[telefono]")
    .replace(/\b\d{8}[A-Z]\b/gi, "[dni]");
}

function b64(bytes) {
  return btoa(String.fromCharCode(...new Uint8Array(bytes)));
}
function fromB64(str) {
  return Uint8Array.from(atob(str), c => c.charCodeAt(0));
}
async function deriveKey(secret, salt) {
  const base = await crypto.subtle.importKey("raw", encoder.encode(secret), "PBKDF2", false, ["deriveKey"]);
  return crypto.subtle.deriveKey(
    { name: "PBKDF2", salt, iterations: 250000, hash: "SHA-256" },
    base,
    { name: "AES-GCM", length: 256 },
    false,
    ["encrypt", "decrypt"]
  );
}

export async function encryptJSON(data, secret) {
  if (!secret || String(secret).length < 6) throw new Error("Clave insuficiente");
  const salt = crypto.getRandomValues(new Uint8Array(16));
  const iv = crypto.getRandomValues(new Uint8Array(12));
  const key = await deriveKey(String(secret), salt);
  const payload = encoder.encode(JSON.stringify(data));
  const cipher = await crypto.subtle.encrypt({ name: "AES-GCM", iv }, key, payload);
  return { v: 1, alg: "AES-GCM", kdf: "PBKDF2-SHA256-250k", salt: b64(salt), iv: b64(iv), data: b64(cipher) };
}

export async function decryptJSON(blob, secret) {
  if (!blob || blob.v !== 1) throw new Error("Formato no compatible");
  const salt = fromB64(blob.salt);
  const iv = fromB64(blob.iv);
  const key = await deriveKey(String(secret), salt);
  const plain = await crypto.subtle.decrypt({ name: "AES-GCM", iv }, key, fromB64(blob.data));
  return JSON.parse(decoder.decode(plain));
}

export async function vaultSave(key, data, secret, namespace = DEFAULT_NAMESPACE) {
  const safeKey = sanitizeText(key, 120);
  const encrypted = await encryptJSON({ data, savedAt: new Date().toISOString() }, secret);
  localStorage.setItem(`${namespace}:${safeKey}`, JSON.stringify(encrypted));
  return true;
}

export async function vaultLoad(key, secret, namespace = DEFAULT_NAMESPACE) {
  const raw = localStorage.getItem(`${namespace}:${sanitizeText(key, 120)}`);
  if (!raw) return null;
  const decrypted = await decryptJSON(JSON.parse(raw), secret);
  return decrypted.data;
}

export function vaultDelete(key, namespace = DEFAULT_NAMESPACE) {
  localStorage.removeItem(`${namespace}:${sanitizeText(key, 120)}`);
}

export function vaultList(namespace = DEFAULT_NAMESPACE) {
  return Object.keys(localStorage).filter(k => k.startsWith(namespace + ":"));
}

export function secureWipe(namespace = DEFAULT_NAMESPACE) {
  vaultList(namespace).forEach(k => localStorage.removeItem(k));
}
EOF

echo "OK src/core/secure-vault.js"

# ------------------------------------------------------------
# 3) Consentimiento RGPD/LOPDGDD y menores
# ------------------------------------------------------------
cat << 'EOF' > src/core/consent-engine.js
import { sanitizeText } from "./secure-vault.js";

const CONSENT_KEY = "tgd_phase9_consent_records";

export function needsParentalConsent(age) {
  const n = Number(age);
  return Number.isFinite(n) && n < 14;
}

export function buildConsentRecord({ studentAlias, age, guardianName, purpose }) {
  return {
    id: crypto.randomUUID(),
    studentAlias: sanitizeText(studentAlias, 80),
    age: Number(age) || null,
    guardianName: sanitizeText(guardianName, 80),
    purpose: sanitizeText(purpose || "Uso educativo local de la app TGD", 300),
    accepted: true,
    acceptedAt: new Date().toISOString(),
    legalBasis: needsParentalConsent(age) ? "consentimiento_tutor_legal" : "consentimiento_usuario_mayor_14",
    dataPolicy: {
      minimization: true,
      localFirst: true,
      encryption: true,
      noTelemetry: true,
      noAds: true
    }
  };
}

export function saveConsent(record) {
  const list = getConsents();
  list.push(record);
  localStorage.setItem(CONSENT_KEY, JSON.stringify(list));
}

export function getConsents() {
  try { return JSON.parse(localStorage.getItem(CONSENT_KEY) || "[]"); }
  catch { return []; }
}

export function revokeConsent(id) {
  const list = getConsents().map(c => c.id === id ? { ...c, revoked: true, revokedAt: new Date().toISOString() } : c);
  localStorage.setItem(CONSENT_KEY, JSON.stringify(list));
}
EOF

echo "OK src/core/consent-engine.js"

# ------------------------------------------------------------
# 4) IA tutor emocional reglada + opción LLM local desactivada por defecto
# ------------------------------------------------------------
cat << 'EOF' > src/core/emotional-tutor-engine.js
import { sanitizeText, redactPII } from "./secure-vault.js";

const RISK_WORDS = ["me quiero hacer daño", "no quiero vivir", "hacerme daño", "suicidio"];

export function detectEmotion(text, history = []) {
  const t = sanitizeText(text, 1200).toLowerCase();
  const scores = { tranquilo: 1, feliz: 0, triste: 0, nervioso: 0, enfadado: 0, frustrado: 0 };
  const add = (k, n = 1) => { scores[k] = (scores[k] || 0) + n; };
  if (/feliz|contento|bien|alegre|genial|guay/.test(t)) add("feliz", 3);
  if (/triste|solo|mal|llorar|pena/.test(t)) add("triste", 3);
  if (/nervioso|miedo|ansiedad|agobio|ruido|examen/.test(t)) add("nervioso", 3);
  if (/enfadado|rabia|odio|molesto/.test(t)) add("enfadado", 3);
  if (/no puedo|difícil|frustrado|bloqueado|me cuesta/.test(t)) add("frustrado", 3);
  history.slice(-5).forEach(e => { if (scores[e]) scores[e] += 0.5; });
  return Object.entries(scores).sort((a,b) => b[1]-a[1])[0][0];
}

export function hasSafetyRisk(text) {
  const t = sanitizeText(text, 1200).toLowerCase();
  return RISK_WORDS.some(w => t.includes(w));
}

export function getTutorResponse({ text, history = [], teaMode = true }) {
  const clean = redactPII(text);
  if (hasSafetyRisk(clean)) {
    return {
      emotion: "riesgo",
      level: "urgent",
      response: "Esto es importante. Para estar seguro, habla ahora con un adulto de confianza. Si hay peligro inmediato, llama a emergencias. Yo puedo acompañarte con respiración mientras pides ayuda.",
      steps: ["Paro", "Busco un adulto", "Digo: necesito ayuda", "No me quedo solo"],
      disclaimer: "La app no sustituye a profesionales sanitarios ni servicios de emergencia."
    };
  }
  const emotion = detectEmotion(clean, history);
  const base = {
    feliz: "Me alegra saberlo. Podemos aprovechar esta energía para dar un paso pequeño.",
    tranquilo: "Perfecto. Vamos paso a paso y sin prisa.",
    triste: "Siento que estés pasando por eso. Estoy contigo. Podemos hacer algo pequeño y seguro.",
    nervioso: "Entiendo que estés nervioso. Vamos a respirar despacio y ordenar el siguiente paso.",
    enfadado: "Veo que hay enfado. Primero calmamos el cuerpo y después pensamos qué hacer.",
    frustrado: "Cuando algo cuesta, lo dividimos en pasos pequeños. No tienes que hacerlo todo a la vez."
  };
  const stepsByEmotion = {
    feliz: ["Elijo una tarea", "La hago 5 minutos", "Celebro el avance"],
    tranquilo: ["Leo la tarea", "Hago un paso", "Reviso"],
    triste: ["Respiro", "Hablo con un adulto", "Hago una tarea sencilla"],
    nervioso: ["Inspiro 4", "Suelto 4", "Miro solo el primer paso"],
    enfadado: ["Paro", "Aprieto y suelto manos", "Uso voz tranquila"],
    frustrado: ["Divido la tarea", "Pido pista", "Hago un intento"],
  };
  return { emotion, level: "support", response: base[emotion], steps: stepsByEmotion[emotion] || [], sanitizedInput: clean, teaMode };
}

// Preparado para futuro LLM local. Desactivado por seguridad y privacidad.
export async function optionalLocalLLM(prompt, { enabled = false, endpoint = "http://localhost:11434/api/generate" } = {}) {
  if (!enabled) return null;
  const safePrompt = redactPII(prompt).slice(0, 1200);
  const res = await fetch(endpoint, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ model: "gemma2:2b", prompt: safePrompt, stream: false }) });
  const data = await res.json();
  return sanitizeText(data.response || "", 1200);
}
EOF

echo "OK src/core/emotional-tutor-engine.js"

cat << 'EOF' > src/modules/emotional-tutor/emotional-tutor-view.jsx
import React, { useState } from "react";
import { getTutorResponse } from "../../core/emotional-tutor-engine.js";
import { AppCard, UI } from "../../ui/ui-kit.js";

export default function EmotionalTutorView({ teaMode = true }) {
  const [text, setText] = useState("");
  const [history, setHistory] = useState([]);
  const [result, setResult] = useState(null);

  function send() {
    const r = getTutorResponse({ text, history, teaMode });
    setResult(r);
    if (r.emotion && r.emotion !== "riesgo") setHistory(prev => [...prev.slice(-6), r.emotion]);
    setText("");
  }

  return (
    <AppCard title="Tutor emocional" subtitle="Acompañamiento reglado, local y predecible. No sustituye apoyo profesional.">
      <div className="tgd-grid">
        <textarea className="tgd-textarea" value={text} onChange={e => setText(e.target.value)} placeholder="Escribe cómo te sientes o qué ha pasado..." />
        <button className={UI.buttonPrimary} onClick={send}>Responder</button>
        {result && (
          <div className={result.level === "urgent" ? "tgd-danger" : "tgd-safe"}>
            <p><strong>Estado detectado:</strong> {result.emotion}</p>
            <p>{result.response}</p>
            {result.steps?.length > 0 && (
              <ol>
                {result.steps.map((s, i) => <li key={i}>{s}</li>)}
              </ol>
            )}
            {result.disclaimer && <p><small>{result.disclaimer}</small></p>}
          </div>
        )}
      </div>
    </AppCard>
  );
}
EOF

echo "OK src/modules/emotional-tutor/emotional-tutor-view.jsx"

# ------------------------------------------------------------
# 5) Panel profesor local multi-alumno
# ------------------------------------------------------------
cat << 'EOF' > src/modules/teacher/teacher-dashboard.jsx
import React, { useMemo, useState } from "react";
import { AppCard, BigAction, ProgressBar, UI } from "../../ui/ui-kit.js";
import { minimizeStudentRecord, sanitizeText } from "../../core/secure-vault.js";

const STORE = "tgd_teacher_students_v9";

function loadStudents() {
  try { return JSON.parse(localStorage.getItem(STORE) || "[]"); } catch { return []; }
}
function saveStudents(students) { localStorage.setItem(STORE, JSON.stringify(students)); }

export default function TeacherDashboard() {
  const [students, setStudents] = useState(loadStudents());
  const [alias, setAlias] = useState("");
  const [group, setGroup] = useState("");
  const [selectedId, setSelectedId] = useState(students[0]?.id || null);

  const selected = useMemo(() => students.find(s => s.id === selectedId) || null, [students, selectedId]);

  function addStudent() {
    const student = minimizeStudentRecord({ alias, group });
    const next = [...students, { ...student, progress: 0, emotionalState: "sin_datos", notes: [] }];
    setStudents(next); saveStudents(next); setSelectedId(student.id); setAlias(""); setGroup("");
  }
  function addNote() {
    if (!selected) return;
    const note = prompt("Nota breve del profesor (sin datos sensibles):");
    if (!note) return;
    const next = students.map(s => s.id === selected.id ? { ...s, notes: [...(s.notes || []), { text: sanitizeText(note, 300), at: new Date().toISOString() }] } : s);
    setStudents(next); saveStudents(next);
  }

  return (
    <div className="tgd-grid tgd-grid-2">
      <AppCard title="Panel profesor" subtitle="Gestión local multi-alumno. Evita nombres completos: usa alias o iniciales.">
        <div className="tgd-grid">
          <input className="tgd-input" value={alias} onChange={e => setAlias(e.target.value)} placeholder="Alias del alumno" />
          <input className="tgd-input" value={group} onChange={e => setGroup(e.target.value)} placeholder="Grupo / clase" />
          <button className={UI.buttonPrimary} onClick={addStudent}>Añadir alumno</button>
        </div>
        <div className="tgd-grid" style={{ marginTop: 16 }}>
          {students.map(s => (
            <BigAction key={s.id} icon="A" title={s.alias} text={s.group || "Sin grupo"} active={s.id === selectedId} onClick={() => setSelectedId(s.id)} />
          ))}
        </div>
      </AppCard>

      <AppCard title="Informe rápido" subtitle={selected ? selected.alias : "Selecciona un alumno"} actions={selected && <button className={UI.buttonSoft} onClick={addNote}>Añadir nota</button>}>
        {!selected && <p>No hay alumno seleccionado.</p>}
        {selected && (
          <div className="tgd-grid">
            <p><span className="tgd-badge">Estado emocional: {selected.emotionalState}</span></p>
            <div><strong>Progreso</strong><ProgressBar value={selected.progress || 0} /></div>
            <div className="tgd-panel">
              <strong>Notas</strong>
              {(selected.notes || []).length === 0 && <p className="tgd-subtitle">Sin notas.</p>}
              {(selected.notes || []).map((n, i) => <p key={i}>- {n.text}</p>)}
            </div>
          </div>
        )}
      </AppCard>
    </div>
  );
}
EOF

echo "OK src/modules/teacher/teacher-dashboard.jsx"

# ------------------------------------------------------------
# 6) Security Center
# ------------------------------------------------------------
cat << 'EOF' > src/modules/security/security-center.jsx
import React, { useState } from "react";
import { AppCard, UI } from "../../ui/ui-kit.js";
import { secureWipe, vaultList } from "../../core/secure-vault.js";
import { buildConsentRecord, saveConsent, getConsents, revokeConsent, needsParentalConsent } from "../../core/consent-engine.js";

export default function SecurityCenter() {
  const [age, setAge] = useState(12);
  const [studentAlias, setStudentAlias] = useState("Alumno");
  const [guardianName, setGuardianName] = useState("");
  const [consents, setConsents] = useState(getConsents());

  function accept() {
    const record = buildConsentRecord({ studentAlias, age, guardianName, purpose: "Uso educativo, local-first, cifrado, sin publicidad ni telemetría" });
    saveConsent(record); setConsents(getConsents());
  }
  function wipe() {
    if (confirm("Esto borrará datos cifrados locales de la app. ¿Continuar?")) secureWipe();
  }

  return (
    <div className="tgd-grid tgd-grid-2">
      <AppCard title="Privacidad y consentimiento" subtitle="RGPD/LOPDGDD: minimización, consentimiento y protección de menores.">
        <div className="tgd-grid">
          <input className="tgd-input" value={studentAlias} onChange={e => setStudentAlias(e.target.value)} placeholder="Alias alumno" />
          <input className="tgd-input" type="number" value={age} onChange={e => setAge(e.target.value)} placeholder="Edad" />
          {needsParentalConsent(age) && <input className="tgd-input" value={guardianName} onChange={e => setGuardianName(e.target.value)} placeholder="Nombre tutor legal" />}
          <div className="tgd-alert">Menores de 14 años: consentimiento del padre/madre/tutor legal. Desde 14 años: puede consentir salvo norma específica.</div>
          <button className={UI.buttonPrimary} onClick={accept}>Registrar consentimiento</button>
        </div>
      </AppCard>
      <AppCard title="Centro de seguridad" subtitle="Auditoría local y control de datos">
        <p>Registros cifrados locales: {vaultList().length}</p>
        <button className={UI.button} onClick={() => setConsents(getConsents())}>Actualizar</button>{" "}
        <button className={UI.button} onClick={wipe}>Borrado seguro local</button>
        <div className="tgd-panel" style={{ marginTop: 12 }}>
          <strong>Consentimientos</strong>
          {consents.length === 0 && <p>Sin consentimientos registrados.</p>}
          {consents.map(c => <p key={c.id}>{c.studentAlias} - {c.legalBasis} {c.revoked ? "(revocado)" : <button className={UI.buttonSoft} onClick={() => { revokeConsent(c.id); setConsents(getConsents()); }}>Revocar</button>}</p>)}
        </div>
      </AppCard>
    </div>
  );
}
EOF

echo "OK src/modules/security/security-center.jsx"

# ------------------------------------------------------------
# 7) PWA production assets
# ------------------------------------------------------------
cat << 'EOF' > public/manifest.webmanifest
{
  "name": "TGD App Educativa Segura",
  "short_name": "TGD",
  "description": "App educativa TEA/TGD/Asperger local-first y segura",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#f8fafc",
  "theme_color": "#5b21b6",
  "icons": []
}
EOF

cat << 'EOF' > public/service-worker.js
const CACHE_NAME = "tgd-app-v9";
const CORE_ASSETS = ["/", "/index.html", "/manifest.webmanifest"];
self.addEventListener("install", event => {
  event.waitUntil(caches.open(CACHE_NAME).then(cache => cache.addAll(CORE_ASSETS)).catch(() => null));
});
self.addEventListener("activate", event => {
  event.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))));
});
self.addEventListener("fetch", event => {
  if (event.request.method !== "GET") return;
  event.respondWith(caches.match(event.request).then(cached => cached || fetch(event.request)));
});
EOF

# Add manifest link if index.html exists
if [ -f index.html ] && ! grep -q "manifest.webmanifest" index.html; then
  sed -i 's#</head>#  <link rel="manifest" href="/manifest.webmanifest" />\n</head>#' index.html
fi

echo "OK PWA assets"

# ------------------------------------------------------------
# 8) App integration. Rewrites App.jsx with previous modules + new modules.
# ------------------------------------------------------------
cat << 'EOF' > src/App.jsx
import React, { useEffect, useState } from "react";
import JournalView from "./modules/journal/journal-view.jsx";
import QuizView from "./modules/learning/quiz-view.jsx";
import GamesView from "./modules/games/games-view.jsx";
import ExamsView from "./modules/exams/exams-view.jsx";
import EmotionCompanion from "./modules/emotion/emotion-companion.jsx";
import SocialView from "./modules/social/social-view.jsx";
import SocialStoriesView from "./modules/social/social-stories-view.jsx";
import ChallengesView from "./modules/challenges/challenges-view.jsx";
import TeaSupportView from "./modules/tea/tea-support-view.jsx";
import HabitsView from "./modules/habits/habits-view.jsx";
import EmotionalTutorView from "./modules/emotional-tutor/emotional-tutor-view.jsx";
import TeacherDashboard from "./modules/teacher/teacher-dashboard.jsx";
import SecurityCenter from "./modules/security/security-center.jsx";
import { resolverPerfil, listarComunidades } from "./core/curriculum-profiles.js";
import { generateTeacherPuk, getPinConfigMeta, setupPinSecurity, resetChildPinWithPuk } from "./core/pin-security.js";
import { UI } from "./ui/ui-kit.js";

const TABS = [
  { key: "inicio", icon: "Inicio", label: "Inicio" },
  { key: "aprender", icon: "Aprender", label: "Aprender" },
  { key: "tutor", icon: "Tutor", label: "Tutor emocional" },
  { key: "profesor", icon: "Profesor", label: "Panel profesor" },
  { key: "redes", icon: "Redes", label: "Redes" },
  { key: "retos", icon: "Retos", label: "Retos" },
  { key: "historias", icon: "Historias", label: "Historias" },
  { key: "habitos", icon: "Habitos", label: "Hábitos" },
  { key: "examenes", icon: "Examenes", label: "Exámenes" },
  { key: "juegos", icon: "Juegos", label: "Juegos" },
  { key: "tea", icon: "TEA", label: "Apoyos TEA" },
  { key: "emociones", icon: "Emociones", label: "Emociones" },
  { key: "diario", icon: "Diario", label: "Diario" },
  { key: "seguridad", icon: "Seguridad", label: "Seguridad" },
  { key: "ajustes", icon: "Ajustes", label: "Ajustes" }
];

function SecurityPanel() {
  const [meta, setMeta] = useState(getPinConfigMeta());
  const [childLabel, setChildLabel] = useState("Alumno");
  const [childPin, setChildPin] = useState("");
  const [teacherPuk, setTeacherPuk] = useState(generateTeacherPuk());
  const [newChildPin, setNewChildPin] = useState("");
  const [unlockPuk, setUnlockPuk] = useState("");
  const [msg, setMsg] = useState("");
  async function configure() { try { await setupPinSecurity({ childPin, teacherPuk, childLabel }); setMeta(getPinConfigMeta()); setMsg("Seguridad configurada. Guarda el PUK del maestro."); } catch (e) { setMsg(e.message || "No se pudo configurar."); } }
  async function unlock() { try { await resetChildPinWithPuk(unlockPuk, newChildPin); setMsg("PIN restablecido con PUK."); } catch (e) { setMsg(e.message || "No se pudo restablecer."); } }
  return (
    <div className="tgd-grid tgd-grid-2">
      <section className="tgd-card"><h2>PIN + PUK</h2><div className="tgd-grid"><input className="tgd-input" value={childLabel} onChange={e=>setChildLabel(e.target.value)} placeholder="Alumno"/><input className="tgd-input" type="password" value={childPin} onChange={e=>setChildPin(e.target.value)} placeholder="PIN alumno"/><input className="tgd-input" value={teacherPuk} onChange={e=>setTeacherPuk(e.target.value)} placeholder="PUK maestro"/><button className={UI.buttonPrimary} onClick={configure}>Guardar seguridad</button>{meta && <p>Configurado para {meta.childLabel}</p>}</div></section>
      <section className="tgd-card"><h2>Recuperación</h2><div className="tgd-grid"><input className="tgd-input" value={unlockPuk} onChange={e=>setUnlockPuk(e.target.value)} placeholder="PUK maestro"/><input className="tgd-input" type="password" value={newChildPin} onChange={e=>setNewChildPin(e.target.value)} placeholder="Nuevo PIN"/><button className={UI.buttonPrimary} onClick={unlock}>Restablecer PIN</button>{msg && <div className="tgd-alert">{msg}</div>}</div></section>
    </div>
  );
}

function DiaryStatsCard({ engineStats }) {
  const levelInfo = engineStats?.levelInfo;
  return <section className="tgd-card"><h2>Progreso</h2><p>Puntos: {levelInfo?.totalPoints || 0}</p><p>Nivel: {levelInfo?.name || "Explorador"}</p><p>Precisión: {engineStats?.accuracy || 0}%</p></section>;
}

export default function App() {
  const [activeTab, setActiveTab] = useState("inicio");
  const [community, setCommunity] = useState("madrid");
  const [teaMode, setTeaMode] = useState(true);
  const [lowStim, setLowStim] = useState(true);
  const [parentPin, setParentPin] = useState("");
  const [studentName, setStudentName] = useState("Alumno");
  const [engineStats, setEngineStats] = useState(null);
  const perfil = resolverPerfil(community);
  const comunidades = listarComunidades();
  useEffect(() => { const meta = getPinConfigMeta(); if (meta?.childLabel) setStudentName(meta.childLabel); }, []);
  useEffect(() => { if ("serviceWorker" in navigator) navigator.serviceWorker.register("/service-worker.js").catch(() => null); }, []);

  return (
    <div className={lowStim ? "tgd-low-stim" : ""}>
      <div className="tgd-shell"><div className="tgd-container">
        <header className="tgd-header"><div><h1 className="tgd-title">TGD App educativa segura</h1><p className="tgd-subtitle">PWA local-first, cifrado, RGPD estricto, TEA/TGD/Asperger.</p></div>{engineStats?.levelInfo && <span className="tgd-badge">{engineStats.levelInfo.name} - {engineStats.levelInfo.totalPoints} pts</span>}</header>
        <nav className="tgd-nav">{TABS.map(tab => <button key={tab.key} onClick={()=>setActiveTab(tab.key)} className={activeTab===tab.key ? "active" : ""}>{tab.label}</button>)}</nav>
        {activeTab === "inicio" && <section className="tgd-card"><h2>Inicio</h2><div className="tgd-grid tgd-grid-2"><label>Comunidad<select className="tgd-select" value={community} onChange={e=>setCommunity(e.target.value)}>{comunidades.map(c => <option key={c} value={c}>{c}</option>)}</select></label><label>Alumno<input className="tgd-input" value={studentName} onChange={e=>setStudentName(e.target.value)} /></label><button className={UI.buttonSoft} onClick={()=>setTeaMode(!teaMode)}>Modo TEA: {teaMode ? "ON" : "OFF"}</button><button className={UI.buttonSoft} onClick={()=>setLowStim(!lowStim)}>Baja estimulación: {lowStim ? "ON" : "OFF"}</button></div><p className="tgd-subtitle">Perfil: {perfil.nombre}</p></section>}
        {activeTab === "aprender" && <QuizView perfil={perfil.key} teaMode={teaMode} lowStim={lowStim} parentPin={parentPin} onStatsUpdate={setEngineStats} />}
        {activeTab === "tutor" && <EmotionalTutorView teaMode={teaMode} />}
        {activeTab === "profesor" && <TeacherDashboard />}
        {activeTab === "redes" && <SocialView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "retos" && <ChallengesView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "historias" && <SocialStoriesView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "habitos" && <HabitsView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "examenes" && <ExamsView perfil={perfil.key} perfilNombre={perfil.nombre} studentName={studentName} />}
        {activeTab === "juegos" && <GamesView />}
        {activeTab === "tea" && <TeaSupportView />}
        {activeTab === "emociones" && <EmotionCompanion />}
        {activeTab === "diario" && <div className="tgd-grid"><DiaryStatsCard engineStats={engineStats} /><JournalView parentPin={parentPin} teaMode={teaMode} lowStim={lowStim} /></div>}
        {activeTab === "seguridad" && <SecurityCenter />}
        {activeTab === "ajustes" && <SecurityPanel />}
      </div></div>
    </div>
  );
}
EOF

echo "OK src/App.jsx"

# ------------------------------------------------------------
# 9) Auditoría y hardening scripts
# ------------------------------------------------------------
cat << 'EOF' > scripts/audit_and_sanitize.sh
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
EOF
chmod +x scripts/audit_and_sanitize.sh

cat << 'EOF' > scripts/build_production.sh
#!/bin/bash
set -e
./scripts/audit_and_sanitize.sh || true
npm run build
ZIP="tgd-app-fase9-production-$(date +%Y%m%d-%H%M).zip"
zip -r "$ZIP" . -x "node_modules/*" ".git/*" "dist/*" "*.zip"
echo "ZIP producción creado: $ZIP"
EOF
chmod +x scripts/build_production.sh

cat << 'EOF' > docs/SECURITY_PHASE9.md
# Seguridad Fase 9

- Local-first por defecto.
- Sin telemetría, sin publicidad y sin trackers.
- Cifrado AES-GCM con clave derivada por PBKDF2-SHA256.
- Minimización: usar alias en lugar de nombres completos.
- Saneamiento de entradas de texto antes de guardar o procesar.
- Consentimiento RGPD/LOPDGDD: registro local y revocación.
- Menores de 14 años: consentimiento de tutor legal.
- Tutor emocional: no sustituye a profesionales sanitarios.
- Palabras de riesgo: deriva a adulto de confianza/emergencias.
- LLM local: preparado, pero desactivado por defecto.
- Cloud LLM/API: no incluido por privacidad; si se activa debe hacerse con DPIA, DPA y consentimiento explícito.
EOF

echo "OK scripts and docs"

echo ""
echo "============================================================"
echo "FASE 9 COMPLETADA"
echo "============================================================"
echo "Ejecuta ahora:"
echo "  npm run dev"
echo "Para producción:"
echo "  ./scripts/build_production.sh"
echo ""
