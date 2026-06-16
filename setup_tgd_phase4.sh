#!/bin/bash
# ============================================================
# setup_tgd_phase4.sh
# Fase 4: seguridad PIN+PUK, exámenes semanales, juegos,
# certificados PDF, módulo emocional y más preguntas LOMLOE
# Ejecutar desde: ~/Escritorio/TGD/
# ============================================================
set -e

echo ""
echo "🚀 Fase 4: instalando seguridad, exámenes, juegos, certificados y módulo emocional..."
echo ""

mkdir -p src/core
mkdir -p src/modules/exams
mkdir -p src/modules/games
mkdir -p src/modules/emotion

# Dependencia para PDF local
if [ -f package.json ]; then
  echo "📦 Instalando jsPDF para certificados PDF..."
  npm install jspdf
fi

# ============================================================
# 1) Seguridad PIN + PUK local
# ============================================================
cat << 'EOF' > src/core/pin-security.js
const SECURITY_KEY = "tgd_security_config";

function enc() {
  return new TextEncoder();
}

function toBase64(buffer) {
  const bytes = new Uint8Array(buffer);
  let binary = "";
  for (let i = 0; i < bytes.byteLength; i++) binary += String.fromCharCode(bytes[i]);
  return btoa(binary);
}

async function sha256(text) {
  const data = enc().encode(text);
  const digest = await crypto.subtle.digest("SHA-256", data);
  return toBase64(digest);
}

function randomString(length = 8) {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  const bytes = crypto.getRandomValues(new Uint8Array(length));
  return Array.from(bytes).map((b) => alphabet[b % alphabet.length]).join("");
}

export function generateTeacherPuk() {
  return randomString(8);
}

export function hasPinConfig() {
  return localStorage.getItem(SECURITY_KEY) !== null;
}

export function getPinConfigMeta() {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) return null;
  const cfg = JSON.parse(raw);
  return {
    childLabel: cfg.childLabel || "Alumno",
    createdAt: cfg.createdAt || null,
    hasTeacherPuk: !!cfg.teacherPukHash
  };
}

export async function setupPinSecurity({ childPin, teacherPuk, childLabel = "Alumno" }) {
  if (!childPin || String(childPin).length < 4) {
    throw new Error("El PIN del alumno debe tener al menos 4 caracteres.");
  }
  if (!teacherPuk || String(teacherPuk).length < 6) {
    throw new Error("El PUK del maestro debe tener al menos 6 caracteres.");
  }
  const salt = randomString(12);
  const childPinHash = await sha256(`${salt}:${childPin}`);
  const teacherPukHash = await sha256(`${salt}:${teacherPuk}`);
  const config = {
    version: 1,
    salt,
    childLabel,
    childPinHash,
    teacherPukHash,
    createdAt: new Date().toISOString()
  };
  localStorage.setItem(SECURITY_KEY, JSON.stringify(config));
  return true;
}

export async function verifyChildPin(pin) {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) return false;
  const cfg = JSON.parse(raw);
  const hash = await sha256(`${cfg.salt}:${pin}`);
  return hash === cfg.childPinHash;
}

export async function verifyTeacherPuk(puk) {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) return false;
  const cfg = JSON.parse(raw);
  const hash = await sha256(`${cfg.salt}:${puk}`);
  return hash === cfg.teacherPukHash;
}

export async function resetChildPinWithPuk(teacherPuk, newChildPin) {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) throw new Error("No hay seguridad configurada todavía.");
  if (!newChildPin || String(newChildPin).length < 4) {
    throw new Error("El nuevo PIN debe tener al menos 4 caracteres.");
  }
  const cfg = JSON.parse(raw);
  const teacherHash = await sha256(`${cfg.salt}:${teacherPuk}`);
  if (teacherHash !== cfg.teacherPukHash) {
    throw new Error("PUK del maestro incorrecto.");
  }
  cfg.childPinHash = await sha256(`${cfg.salt}:${newChildPin}`);
  cfg.updatedAt = new Date().toISOString();
  localStorage.setItem(SECURITY_KEY, JSON.stringify(cfg));
  return true;
}

export function clearPinSecurity() {
  localStorage.removeItem(SECURITY_KEY);
}
EOF

echo "✅ src/core/pin-security.js"

# ============================================================
# 2) Más preguntas LOMLOE (extra, generadas localmente)
# ============================================================
cat << 'EOF' > src/core/questions-lomloe-extra.js
const PROFILE_THEMES = {
  perfilA: ["divisibilidad", "coordenadas", "gramática", "cartografía", "seguridad digital", "present simple"],
  perfilB: ["potencias", "acentuación", "células", "algoritmos", "past simple", "mapas"],
  perfilC: ["vida cotidiana", "noticias", "salud", "scratch", "rutinas", "consumo responsable"],
  perfilD: ["retos", "creatividad", "ecosistemas", "steam", "role-play", "razonamiento"],
  perfilE: ["costa", "descripción", "territorio", "presentaciones", "vocabulario", "orientación"],
  perfilF: ["lluvia", "leyendas", "rías", "fuentes fiables", "comprensión", "naturaleza"],
  perfilG: ["volcanes", "biodiversidad", "islas", "datos", "forest", "ecosistemas"],
  perfilH: ["relieve", "gramática", "organización", "ríos", "friendly", "cálculo mental"]
};

const SUBJECT_TEMPLATES = {
  matematicas: [
    { nivel: "basico", pregunta: (t) => `¿Qué operación usarías primero en un problema sobre ${t}?`, opciones: ["Suma o resta simple", "Multiplicación o división si corresponde", "Nunca se calcula"], correcta: 1, explicacion: "En problemas compuestos, primero resuelves la parte que organiza la situación." },
    { nivel: "basico", pregunta: (t) => `Si una actividad de ${t} dura 20 minutos y haces 3, ¿cuánto tiempo usas?`, opciones: ["40", "60", "80"], correcta: 1, explicacion: "20 × 3 = 60 minutos." },
    { nivel: "medio", pregunta: (t) => `En una tabla sobre ${t}, ¿qué te ayuda a comparar datos?`, opciones: ["Ignorarlos", "Ordenarlos y observar diferencias", "Borrarlos"], correcta: 1, explicacion: "Ordenar y comparar ayuda a analizar datos." },
    { nivel: "medio", pregunta: (t) => `Si una cantidad relacionada con ${t} baja de 7 a 2, la diferencia es`, opciones: ["3", "5", "9"], correcta: 1, explicacion: "7 − 2 = 5." },
    { nivel: "avanzado", pregunta: (t) => `Para comprobar un resultado en ${t}, lo mejor es`, opciones: ["Adivinar", "Rehacer el cálculo o usar la operación inversa", "Cambiar la pregunta"], correcta: 1, explicacion: "Comprobar con la operación inversa reduce errores." }
  ],
  lengua: [
    { nivel: "basico", pregunta: (t) => `En un texto sobre ${t}, la idea principal es`, opciones: ["Una palabra al azar", "El mensaje más importante del texto", "La última letra"], correcta: 1, explicacion: "La idea principal resume el contenido más importante." },
    { nivel: "basico", pregunta: (t) => `Un adjetivo en una descripción sobre ${t} sirve para`, opciones: ["Nombrar acciones", "Decir cómo es algo", "Contar números"], correcta: 1, explicacion: "Los adjetivos describen cualidades." },
    { nivel: "medio", pregunta: (t) => `Para entender mejor un texto sobre ${t}, conviene`, opciones: ["Leer solo el final", "Subrayar palabras clave", "Ignorar el título"], correcta: 1, explicacion: "Las palabras clave ayudan a comprender el texto." },
    { nivel: "medio", pregunta: (t) => `En una narración relacionada con ${t}, el nudo es`, opciones: ["El conflicto o problema", "El título", "La firma"], correcta: 0, explicacion: "El nudo es la parte donde aparece el conflicto." },
    { nivel: "avanzado", pregunta: (t) => `Una buena conclusión sobre ${t} debe`, opciones: ["Repetir sin sentido", "Cerrar y resumir la idea principal", "Cambiar de tema"], correcta: 1, explicacion: "La conclusión cierra el texto y resume su sentido." }
  ],
  medio: [
    { nivel: "basico", pregunta: (t) => `Una pregunta de Conocimiento del Medio sobre ${t} busca`, opciones: ["Inventar datos", "Comprender el mundo natural o social", "Borrar información"], correcta: 1, explicacion: "Esta materia ayuda a comprender el entorno." },
    { nivel: "basico", pregunta: (t) => `Un mapa o esquema sobre ${t} sirve para`, opciones: ["Confundir", "Representar información", "Dibujar sin orden"], correcta: 1, explicacion: "Los mapas y esquemas representan información." },
    { nivel: "medio", pregunta: (t) => `Para cuidar el entorno relacionado con ${t}, conviene`, opciones: ["Contaminar más", "Usar hábitos sostenibles", "Romper señales"], correcta: 1, explicacion: "Los hábitos sostenibles protegen el medio." },
    { nivel: "medio", pregunta: (t) => `Cuando comparas dos paisajes o fenómenos sobre ${t}, estás trabajando`, opciones: ["Análisis y comparación", "Copia sin leer", "Solo memoria"], correcta: 0, explicacion: "Comparar es una habilidad científica importante." },
    { nivel: "avanzado", pregunta: (t) => `Una explicación científica sobre ${t} debe basarse en`, opciones: ["Datos y observaciones", "Rumores", "Suposiciones sin pruebas"], correcta: 0, explicacion: "Las explicaciones científicas se apoyan en datos." }
  ],
  digital: [
    { nivel: "basico", pregunta: (t) => `En una tarea digital sobre ${t}, lo primero es`, opciones: ["Compartir contraseñas", "Organizar archivos y datos", "Borrar todo"], correcta: 1, explicacion: "La organización es clave en tareas digitales." },
    { nivel: "basico", pregunta: (t) => `Si una web relacionada con ${t} te pide datos raros, debes`, opciones: ["Darlos", "Cerrar y avisar a un adulto", "Compartirla"], correcta: 1, explicacion: "Ante una web sospechosa, hay que detenerse y avisar." },
    { nivel: "medio", pregunta: (t) => `Un algoritmo para resolver una tarea de ${t} es`, opciones: ["Una serie ordenada de pasos", "Un dibujo aleatorio", "Una contraseña"], correcta: 0, explicacion: "Un algoritmo es una secuencia de pasos." },
    { nivel: "medio", pregunta: (t) => `En programación, repetir una acción con ${t} se hace con`, opciones: ["Un bucle", "Un saludo", "Una carpeta"], correcta: 0, explicacion: "Los bucles repiten instrucciones." },
    { nivel: "avanzado", pregunta: (t) => `Una buena práctica digital al trabajar ${t} es`, opciones: ["Guardar copias de seguridad", "Usar claves débiles", "Enviar datos personales"], correcta: 0, explicacion: "Las copias de seguridad protegen tu trabajo." }
  ],
  ingles: [
    { nivel: "basico", pregunta: (t) => `Si hablas de una rutina relacionada con ${t}, usas normalmente`, opciones: ["Present Simple", "Past Simple", "Future perfecto"], correcta: 0, explicacion: "Las rutinas suelen expresarse en Present Simple." },
    { nivel: "basico", pregunta: (t) => `Si algo ocurre ahora en una escena sobre ${t}, usas`, opciones: ["Present Continuous", "Pasado", "Imperativo"], correcta: 0, explicacion: "Acciones en progreso → Present Continuous." },
    { nivel: "medio", pregunta: (t) => `Para contar algo de ayer sobre ${t}, usas`, opciones: ["Past Simple", "Present Simple", "Going to"], correcta: 0, explicacion: "Ayer o en el pasado → Past Simple." },
    { nivel: "medio", pregunta: (t) => `Para mejorar vocabulario sobre ${t}, conviene`, opciones: ["Relacionar palabra e imagen", "Borrar palabras", "No leer"], correcta: 0, explicacion: "Asociar imagen y palabra mejora la memoria." },
    { nivel: "avanzado", pregunta: (t) => `Si revisas una frase en inglés sobre ${t}, debes comprobar`, opciones: ["Sujeto y verbo", "Solo el color", "Solo la longitud"], correcta: 0, explicacion: "Revisar sujeto y verbo mejora la corrección gramatical." }
  ]
};

function normalizeQuestion(obj) {
  return {
    id: obj.id,
    perfil: obj.perfil,
    materia: obj.materia,
    nivel: obj.nivel,
    pregunta: obj.pregunta,
    opciones: obj.opciones,
    correcta: obj.correcta,
    explicacion: obj.explicacion
  };
}

export const EXTRA_QUESTIONS_BANK = Object.entries(PROFILE_THEMES).flatMap(([perfil, topics]) => {
  return Object.entries(SUBJECT_TEMPLATES).flatMap(([materia, templates]) => {
    return templates.map((tpl, idx) => normalizeQuestion({
      id: `${perfil}_${materia}_extra_${idx + 1}`,
      perfil,
      materia,
      nivel: tpl.nivel,
      pregunta: tpl.pregunta(topics[idx % topics.length]),
      opciones: tpl.opciones,
      correcta: tpl.correcta,
      explicacion: tpl.explicacion
    }));
  });
});
EOF

echo "✅ src/core/questions-lomloe-extra.js"

# ============================================================
# 3) Banco combinado de preguntas
# ============================================================
cat << 'EOF' > src/core/questions-bank.js
import { QUESTIONS_BANK } from "./questions-ccaa.js";
import { EXTRA_QUESTIONS_BANK } from "./questions-lomloe-extra.js";

export const ALL_QUESTIONS_BANK = [...QUESTIONS_BANK, ...EXTRA_QUESTIONS_BANK];

export function getQuestionsByPerfil(perfil) {
  return ALL_QUESTIONS_BANK.filter((q) => q.perfil === perfil);
}
export function getQuestionsByMateria(materia) {
  return ALL_QUESTIONS_BANK.filter((q) => q.materia === materia);
}
export function getQuestionsByNivel(nivel) {
  return ALL_QUESTIONS_BANK.filter((q) => q.nivel === nivel);
}
export function getRandomQuestions(perfil, materia, nivel, count = 5) {
  let pool = ALL_QUESTIONS_BANK.filter((q) =>
    (!perfil || q.perfil === perfil) &&
    (!materia || q.materia === materia) &&
    (!nivel || q.nivel === nivel)
  );
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, count);
}
EOF

echo "✅ src/core/questions-bank.js"

# ============================================================
# 4) Motor adaptativo Fase 4
# ============================================================
cat << 'EOF' > src/core/adaptive-engine.js
import { getRandomQuestions } from "./questions-bank.js";

const LEVELS = ["basico", "medio", "avanzado"];
const POINTS_MAP = { basico: 10, medio: 20, avanzado: 30 };
const GAME_LEVELS = [
  { name: "Explorador", icon: "🔍", min: 0, max: 99 },
  { name: "Aventurero", icon: "🗺️", min: 100, max: 299 },
  { name: "Sabio", icon: "📚", min: 300, max: 599 },
  { name: "Maestro", icon: "🏆", min: 600, max: Infinity }
];

export class AdaptiveEngine {
  constructor(perfil) {
    this.perfil = perfil;
    this.history = [];
    this.streaks = {};
    this.levels = {};
    this.answeredIds = new Set();
    this.totalPoints = 0;
    this.currentStreak = 0;
  }

  _ensureMateria(materia) {
    if (!this.streaks[materia]) this.streaks[materia] = { correct: 0, wrong: 0 };
    if (!this.levels[materia]) this.levels[materia] = "basico";
  }

  track(questionId, materia, correct) {
    this._ensureMateria(materia);
    this.answeredIds.add(questionId);

    let pointsEarned = 0;
    if (correct) {
      const nivel = this.levels[materia];
      pointsEarned = POINTS_MAP[nivel] || 10;
      this.currentStreak += 1;
      if (this.currentStreak > 0 && this.currentStreak % 3 === 0) pointsEarned += 5;
      this.totalPoints += pointsEarned;
      this.streaks[materia].correct += 1;
      this.streaks[materia].wrong = 0;
    } else {
      this.currentStreak = 0;
      this.streaks[materia].wrong += 1;
      this.streaks[materia].correct = 0;
    }

    this.history.push({ questionId, materia, correct, pointsEarned, timestamp: Date.now() });

    const idx = LEVELS.indexOf(this.levels[materia]);
    if (this.streaks[materia].correct >= 3 && idx < LEVELS.length - 1) {
      this.levels[materia] = LEVELS[idx + 1];
      this.streaks[materia].correct = 0;
    }
    if (this.streaks[materia].wrong >= 2 && idx > 0) {
      this.levels[materia] = LEVELS[idx - 1];
      this.streaks[materia].wrong = 0;
    }
    return pointsEarned;
  }

  getLevel(materia) {
    this._ensureMateria(materia);
    return this.levels[materia];
  }

  getLevelInfo() {
    const current = GAME_LEVELS.find((l) => this.totalPoints >= l.min && this.totalPoints <= l.max) || GAME_LEVELS[0];
    const nextIdx = GAME_LEVELS.indexOf(current) + 1;
    const next = nextIdx < GAME_LEVELS.length ? GAME_LEVELS[nextIdx] : null;
    const progress = next ? Math.min(100, Math.round(((this.totalPoints - current.min) / (next.min - current.min)) * 100)) : 100;
    return {
      name: current.name,
      icon: current.icon,
      totalPoints: this.totalPoints,
      currentStreak: this.currentStreak,
      nextLevel: next ? next.name : null,
      pointsToNext: next ? next.min - this.totalPoints : 0,
      progress
    };
  }

  getNextQuestions(materia, count = 5) {
    const nivel = this.getLevel(materia);
    let pool = getRandomQuestions(this.perfil, materia, nivel, count + 12).filter((q) => !this.answeredIds.has(q.id));
    if (pool.length < count) {
      const extra = getRandomQuestions(this.perfil, materia, null, count + 12).filter((q) => !this.answeredIds.has(q.id));
      pool = [...pool, ...extra];
    }
    return pool.slice(0, count);
  }

  getStats() {
    const total = this.history.length;
    const correct = this.history.filter((h) => h.correct).length;
    const byMateria = {};
    for (const h of this.history) {
      if (!byMateria[h.materia]) byMateria[h.materia] = { total: 0, correct: 0 };
      byMateria[h.materia].total += 1;
      if (h.correct) byMateria[h.materia].correct += 1;
    }
    return {
      totalAnswered: total,
      totalCorrect: correct,
      accuracy: total > 0 ? Math.round((correct / total) * 100) : 0,
      totalPoints: this.totalPoints,
      currentStreak: this.currentStreak,
      levelByMateria: { ...this.levels },
      statsByMateria: byMateria,
      levelInfo: this.getLevelInfo()
    };
  }

  getTodayStats() {
    const today = new Date().toISOString().slice(0, 10);
    const todayHistory = this.history.filter((h) => new Date(h.timestamp).toISOString().slice(0, 10) === today);
    const total = todayHistory.length;
    const correct = todayHistory.filter((h) => h.correct).length;
    const points = todayHistory.reduce((s, h) => s + (h.pointsEarned || 0), 0);
    const materias = [...new Set(todayHistory.map((h) => h.materia))];
    return { total, correct, accuracy: total > 0 ? Math.round((correct / total) * 100) : 0, points, materias };
  }

  reset() {
    this.history = [];
    this.streaks = {};
    this.levels = {};
    this.answeredIds = new Set();
    this.totalPoints = 0;
    this.currentStreak = 0;
  }

  toJSON() {
    return {
      perfil: this.perfil,
      history: this.history,
      streaks: this.streaks,
      levels: this.levels,
      answeredIds: Array.from(this.answeredIds),
      totalPoints: this.totalPoints,
      currentStreak: this.currentStreak
    };
  }

  static fromJSON(data) {
    const e = new AdaptiveEngine(data.perfil);
    e.history = data.history || [];
    e.streaks = data.streaks || {};
    e.levels = data.levels || {};
    e.answeredIds = new Set(data.answeredIds || []);
    e.totalPoints = data.totalPoints || 0;
    e.currentStreak = data.currentStreak || 0;
    return e;
  }
}
EOF

echo "✅ src/core/adaptive-engine.js"

# ============================================================
# 5) Exámenes semanales
# ============================================================
cat << 'EOF' > src/core/exams-engine.js
import { getRandomQuestions } from "./questions-bank.js";

const SUBJECTS = ["matematicas", "lengua", "medio", "digital", "ingles"];

export function getWeekKey(date = new Date()) {
  const d = new Date(date);
  const firstJan = new Date(d.getFullYear(), 0, 1);
  const days = Math.floor((d - firstJan) / 86400000);
  const week = Math.ceil((days + firstJan.getDay() + 1) / 7);
  return `${d.getFullYear()}-W${String(week).padStart(2, "0")}`;
}

export function isWeeklyExamDay(date = new Date()) {
  return new Date(date).getDay() === 5; // viernes
}

export function buildWeeklyExam(perfil, countPerSubject = 2) {
  const questions = SUBJECTS.flatMap((materia) => getRandomQuestions(perfil, materia, null, countPerSubject));
  return {
    examId: `exam-${getWeekKey()}`,
    createdAt: new Date().toISOString(),
    questions
  };
}

export function scoreExam(questions, answers) {
  const details = questions.map((q, idx) => ({
    id: q.id,
    materia: q.materia,
    correct: answers[idx] === q.correcta
  }));
  const correct = details.filter((d) => d.correct).length;
  const total = questions.length;
  const percent = total > 0 ? Math.round((correct / total) * 100) : 0;
  const byMateria = {};
  for (const d of details) {
    if (!byMateria[d.materia]) byMateria[d.materia] = { total: 0, correct: 0 };
    byMateria[d.materia].total += 1;
    if (d.correct) byMateria[d.materia].correct += 1;
  }
  return { total, correct, percent, byMateria, passed: percent >= 70 };
}
EOF

echo "✅ src/core/exams-engine.js"

# ============================================================
# 6) Certificados PDF locales
# ============================================================
cat << 'EOF' > src/core/certificates-pdf.js
import { jsPDF } from "jspdf";

export function createCertificatePdf({ studentName, weekKey, percent, perfilNombre }) {
  const doc = new jsPDF({ orientation: "landscape", unit: "mm", format: "a4" });
  doc.setDrawColor(40, 40, 40);
  doc.rect(10, 10, 277, 190);
  doc.setFont("helvetica", "bold");
  doc.setFontSize(24);
  doc.text("Certificado de superación", 148, 35, { align: "center" });
  doc.setFontSize(14);
  doc.setFont("helvetica", "normal");
  doc.text("App educativa segura TGD", 148, 48, { align: "center" });
  doc.setFontSize(18);
  doc.text(`Se certifica que ${studentName || "el alumno"}`, 148, 80, { align: "center" });
  doc.text(`ha superado el examen semanal ${weekKey}`, 148, 95, { align: "center" });
  doc.text(`con una puntuación de ${percent}%`, 148, 110, { align: "center" });
  doc.setFontSize(12);
  doc.text(`Perfil curricular: ${perfilNombre || "General"}`, 148, 130, { align: "center" });
  doc.text(`Fecha: ${new Date().toLocaleDateString("es-ES")}`, 148, 145, { align: "center" });
  doc.save(`certificado_${weekKey}.pdf`);
}
EOF

echo "✅ src/core/certificates-pdf.js"

# ============================================================
# 7) Juegos interactivos
# ============================================================
cat << 'EOF' > src/modules/games/games-view.jsx
import React, { useMemo, useState } from "react";

const MEMORY_WORDS = ["célula", "volcán", "mapa", "play", "río", "robot"];
const HANGMAN_WORDS = ["ecosistema", "fracción", "gramática", "algoritmo", "mountain"];
const SORT_WORDS = ["celula", "volcan", "friend", "island", "reciclar"];

function shuffle(arr) {
  const copy = [...arr];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}

function MemoryGame() {
  const cards = useMemo(() => shuffle([...MEMORY_WORDS, ...MEMORY_WORDS]).map((word, idx) => ({ id: idx, word })), []);
  const [open, setOpen] = useState([]);
  const [solved, setSolved] = useState([]);
  function clickCard(card) {
    if (open.includes(card.id) || solved.includes(card.word) || open.length === 2) return;
    const nextOpen = [...open, card.id];
    setOpen(nextOpen);
    if (nextOpen.length === 2) {
      const selected = cards.filter((c) => nextOpen.includes(c.id));
      if (selected[0].word === selected[1].word) {
        setSolved((prev) => [...prev, selected[0].word]);
        setOpen([]);
      } else {
        setTimeout(() => setOpen([]), 700);
      }
    }
  }
  return (
    <div className="space-y-3">
      <h3 className="font-semibold">🧠 Memory LOMLOE</h3>
      <div className="grid grid-cols-3 sm:grid-cols-4 gap-3">
        {cards.map((card) => {
          const visible = open.includes(card.id) || solved.includes(card.word);
          return (
            <button key={card.id} onClick={() => clickCard(card)} className="rounded-2xl border bg-white p-4 min-h-[72px]">
              {visible ? card.word : "?"}
            </button>
          );
        })}
      </div>
      <p className="text-sm text-slate-600">Parejas encontradas: {solved.length}/{MEMORY_WORDS.length}</p>
    </div>
  );
}

function HangmanGame() {
  const [word] = useState(HANGMAN_WORDS[Math.floor(Math.random() * HANGMAN_WORDS.length)].toUpperCase());
  const [guessed, setGuessed] = useState([]);
  const [wrong, setWrong] = useState(0);
  const letters = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ".split("");
  const masked = word.split("").map((ch) => (guessed.includes(ch) ? ch : "_"));
  const won = masked.join("") === word;
  const lost = wrong >= 6;
  function guess(letter) {
    if (guessed.includes(letter) || won || lost) return;
    setGuessed((p) => [...p, letter]);
    if (!word.includes(letter)) setWrong((w) => w + 1);
  }
  return (
    <div className="space-y-3">
      <h3 className="font-semibold">🎯 Ahorcado educativo</h3>
      <p className="text-2xl tracking-[0.35em]">{masked.join(" ")}</p>
      <p className="text-sm text-slate-600">Errores: {wrong}/6</p>
      {won && <p className="text-emerald-600 font-medium">¡Lo has conseguido!</p>}
      {lost && <p className="text-rose-600 font-medium">La palabra era {word}.</p>}
      <div className="grid grid-cols-6 sm:grid-cols-9 gap-2">
        {letters.map((l) => (
          <button key={l} onClick={() => guess(l)} className="rounded-xl border bg-white px-2 py-2 text-sm" disabled={guessed.includes(l) || won || lost}>{l}</button>
        ))}
      </div>
    </div>
  );
}

function SortWordGame() {
  const [word] = useState(SORT_WORDS[Math.floor(Math.random() * SORT_WORDS.length)].toUpperCase());
  const [letters, setLetters] = useState(shuffle(word.split("")));
  const [answer, setAnswer] = useState([]);
  const done = answer.join("") === word;
  function take(letter, idx) {
    if (done) return;
    setAnswer((a) => [...a, letter]);
    setLetters((arr) => arr.filter((_, i) => i !== idx));
  }
  function reset() {
    setLetters(shuffle(word.split("")));
    setAnswer([]);
  }
  return (
    <div className="space-y-3">
      <h3 className="font-semibold">🔤 Ordena la palabra</h3>
      <p className="text-sm text-slate-600">Forma la palabra correcta:</p>
      <div className="rounded-2xl border bg-white p-4 min-h-[64px] text-xl tracking-[0.2em]">{answer.join(" ")}</div>
      {done && <p className="text-emerald-600 font-medium">¡Correcto! La palabra es {word}.</p>}
      <div className="flex flex-wrap gap-2">
        {letters.map((l, idx) => <button key={idx} onClick={() => take(l, idx)} className="rounded-xl border bg-white px-4 py-2">{l}</button>)}
      </div>
      <button onClick={reset} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Reiniciar</button>
    </div>
  );
}

export default function GamesView() {
  const [tab, setTab] = useState("memory");
  return (
    <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
      <div>
        <h2 className="text-xl font-bold">🎮 Juegos interactivos</h2>
        <p className="text-sm text-slate-600">Juega y aprende sin salir de la app.</p>
      </div>
      <div className="flex flex-wrap gap-2">
        <button onClick={() => setTab("memory")} className="rounded-2xl border px-4 py-2 bg-white">Memory</button>
        <button onClick={() => setTab("hangman")} className="rounded-2xl border px-4 py-2 bg-white">Ahorcado</button>
        <button onClick={() => setTab("sort")} className="rounded-2xl border px-4 py-2 bg-white">Ordena palabra</button>
      </div>
      {tab === "memory" && <MemoryGame />}
      {tab === "hangman" && <HangmanGame />}
      {tab === "sort" && <SortWordGame />}
    </div>
  );
}
EOF

echo "✅ src/modules/games/games-view.jsx"

# ============================================================
# 8) Módulo emocional / compañero guiado
# ============================================================
cat << 'EOF' > src/modules/emotion/emotion-companion.jsx
import React, { useMemo, useState } from "react";

const MOODS = [
  { key: "feliz", emoji: "😊", title: "Feliz", response: "¡Qué bien! Vamos a aprovechar esa energía para aprender algo bonito hoy." },
  { key: "tranquilo", emoji: "😌", title: "Tranquilo", response: "Perfecto, estar tranquilo ayuda a concentrarse paso a paso." },
  { key: "nervioso", emoji: "😟", title: "Nervioso", response: "Respira despacio conmigo. No hace falta hacerlo perfecto, solo avanzar poco a poco." },
  { key: "cansado", emoji: "😴", title: "Cansado", response: "Podemos hacer una pausa breve, beber agua y volver con calma." },
  { key: "enfadado", emoji: "😠", title: "Enfadado", response: "Vamos a parar, respirar y poner nombre a lo que sientes. Después decidimos un paso pequeño." }
];

function BreathingBox() {
  const [step, setStep] = useState(0);
  const labels = ["Inspira 4", "Mantén 4", "Suelta 4", "Espera 4"];
  function next() {
    setStep((s) => (s + 1) % labels.length);
  }
  return (
    <div className="rounded-2xl border bg-white p-4 space-y-3">
      <h3 className="font-semibold">🫁 Respiración guiada</h3>
      <div className="rounded-2xl border bg-slate-50 p-6 text-center text-2xl font-bold">{labels[step]}</div>
      <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Siguiente paso</button>
    </div>
  );
}

export default function EmotionCompanion() {
  const [selected, setSelected] = useState("tranquilo");
  const mood = useMemo(() => MOODS.find((m) => m.key === selected) || MOODS[1], [selected]);
  return (
    <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
      <div>
        <h2 className="text-xl font-bold">💛 Compañero emocional guiado</h2>
        <p className="text-sm text-slate-600">Acompañamiento emocional local, amable y predecible.</p>
      </div>
      <div className="grid grid-cols-2 sm:grid-cols-5 gap-3">
        {MOODS.map((m) => (
          <button key={m.key} onClick={() => setSelected(m.key)} className={["rounded-2xl border p-4 text-center", selected === m.key ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>
            <div className="text-2xl mb-1">{m.emoji}</div>
            <div className="text-sm font-medium">{m.title}</div>
          </button>
        ))}
      </div>
      <div className="rounded-2xl border bg-white p-4 space-y-2">
        <p className="font-semibold">{mood.emoji} {mood.title}</p>
        <p className="text-slate-700">{mood.response}</p>
      </div>
      <BreathingBox />
      <div className="rounded-2xl border bg-white p-4 space-y-2 text-sm text-slate-600">
        <p className="font-medium text-slate-900">Ideas de apoyo</p>
        <p>• Elegir una sola tarea pequeña</p>
        <p>• Usar apoyos visuales o pictogramas</p>
        <p>• Hacer una pausa breve si hay mucho ruido</p>
        <p>• Pedir ayuda al adulto si algo preocupa</p>
      </div>
    </div>
  );
}
EOF

echo "✅ src/modules/emotion/emotion-companion.jsx"

# ============================================================
# 9) Exámenes semanales (vista)
# ============================================================
cat << 'EOF' > src/modules/exams/exams-view.jsx
import React, { useMemo, useState } from "react";
import { buildWeeklyExam, getWeekKey, isWeeklyExamDay, scoreExam } from "../../core/exams-engine.js";
import { createCertificatePdf } from "../../core/certificates-pdf.js";

function OptionButton({ onClick, active, disabled, children }) {
  return <button onClick={onClick} disabled={disabled} className={["rounded-2xl border px-4 py-4 text-left w-full", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>{children}</button>;
}

export default function ExamsView({ perfil, perfilNombre, studentName = "Alumno" }) {
  const [exam, setExam] = useState(() => buildWeeklyExam(perfil));
  const [idx, setIdx] = useState(0);
  const [answers, setAnswers] = useState([]);
  const [finished, setFinished] = useState(false);

  const current = exam.questions[idx];
  const weekKey = useMemo(() => getWeekKey(), []);
  const result = finished ? scoreExam(exam.questions, answers) : null;

  function select(optionIdx) {
    const copy = [...answers];
    copy[idx] = optionIdx;
    setAnswers(copy);
  }
  function next() {
    if (idx < exam.questions.length - 1) setIdx((i) => i + 1);
    else setFinished(true);
  }
  function restart() {
    setExam(buildWeeklyExam(perfil));
    setIdx(0);
    setAnswers([]);
    setFinished(false);
  }

  if (finished && result) {
    return (
      <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
        <h2 className="text-xl font-bold">📝 Examen semanal</h2>
        <div className="grid sm:grid-cols-3 gap-4">
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{result.percent}%</p><p className="text-sm text-slate-600">Puntuación</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{result.correct}/{result.total}</p><p className="text-sm text-slate-600">Correctas</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{result.passed ? "✅" : "📘"}</p><p className="text-sm text-slate-600">{result.passed ? "Superado" : "Sigue practicando"}</p></div>
        </div>
        <div className="rounded-2xl border bg-white p-4 space-y-2">
          <h3 className="font-semibold">Por asignatura</h3>
          {Object.entries(result.byMateria).map(([materia, stats]) => (
            <div key={materia} className="flex items-center justify-between rounded-xl border p-3">
              <span className="capitalize">{materia}</span>
              <span>{stats.correct}/{stats.total}</span>
            </div>
          ))}
        </div>
        <div className="flex flex-wrap gap-3">
          <button onClick={restart} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Nuevo examen</button>
          {result.passed && <button onClick={() => createCertificatePdf({ studentName, weekKey, percent: result.percent, perfilNombre })} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white">Certificado PDF</button>}
        </div>
      </div>
    );
  }

  return (
    <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold">📝 Examen semanal</h2>
          <p className="text-sm text-slate-600">Semana {weekKey} · {isWeeklyExamDay() ? "Hoy es viernes" : "Examen disponible"}</p>
        </div>
        <div className="text-sm rounded-2xl border bg-white px-3 py-2">Pregunta {idx + 1}/{exam.questions.length}</div>
      </div>
      <div className="rounded-2xl border bg-white p-5"><p className="text-lg font-medium leading-relaxed">{current.pregunta}</p></div>
      <div className="grid gap-3">
        {current.opciones.map((opt, i) => <OptionButton key={i} active={answers[idx] === i} onClick={() => select(i)}>{opt}</OptionButton>)}
      </div>
      <div className="flex flex-wrap gap-3">
        <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{idx < exam.questions.length - 1 ? "Siguiente" : "Finalizar examen"}</button>
        <button onClick={restart} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
      </div>
    </div>
  );
}
EOF

echo "✅ src/modules/exams/exams-view.jsx"

# ============================================================
# 10) App principal Fase 4
# ============================================================
cat << 'EOF' > src/App.jsx
import React, { useEffect, useState } from "react";
import JournalView from "./modules/journal/journal-view.jsx";
import QuizView from "./modules/learning/quiz-view.jsx";
import GamesView from "./modules/games/games-view.jsx";
import ExamsView from "./modules/exams/exams-view.jsx";
import EmotionCompanion from "./modules/emotion/emotion-companion.jsx";
import { resolverPerfil, listarComunidades } from "./core/curriculum-profiles.js";
import { generateTeacherPuk, getPinConfigMeta, setupPinSecurity, resetChildPinWithPuk } from "./core/pin-security.js";

const TABS = [
  { key: "inicio", icon: "🏠", label: "Inicio" },
  { key: "aprender", icon: "📚", label: "Aprender" },
  { key: "examenes", icon: "📝", label: "Exámenes" },
  { key: "juegos", icon: "🎮", label: "Juegos" },
  { key: "emociones", icon: "💛", label: "Emociones" },
  { key: "diario", icon: "📓", label: "Diario" },
  { key: "ajustes", icon: "⚙️", label: "Ajustes" }
];

function SecurityPanel() {
  const [meta, setMeta] = useState(getPinConfigMeta());
  const [childLabel, setChildLabel] = useState("Alumno");
  const [childPin, setChildPin] = useState("");
  const [teacherPuk, setTeacherPuk] = useState(generateTeacherPuk());
  const [newChildPin, setNewChildPin] = useState("");
  const [unlockPuk, setUnlockPuk] = useState("");
  const [msg, setMsg] = useState("");

  async function configure() {
    try {
      await setupPinSecurity({ childPin, teacherPuk, childLabel });
      setMeta(getPinConfigMeta());
      setMsg("Seguridad configurada. Guarda el PUK del maestro en un lugar seguro.");
    } catch (e) {
      setMsg(e.message || "No se pudo configurar la seguridad.");
    }
  }

  async function unlock() {
    try {
      await resetChildPinWithPuk(unlockPuk, newChildPin);
      setMsg("PIN del alumno restablecido correctamente con el PUK del maestro.");
    } catch (e) {
      setMsg(e.message || "No se pudo restablecer el PIN.");
    }
  }

  return (
    <div className="space-y-4">
      <div className="rounded-2xl border bg-white p-5 space-y-3">
        <h3 className="text-lg font-bold">🔐 Seguridad PIN + PUK</h3>
        <p className="text-sm text-slate-600">Configura un PIN del alumno y un PUK del maestro para desbloqueo local.</p>
        <div className="grid sm:grid-cols-3 gap-4">
          <div><label className="block text-sm font-medium mb-2">Nombre del alumno</label><input value={childLabel} onChange={(e) => setChildLabel(e.target.value)} className="w-full rounded-xl border px-3 py-2" placeholder="Alumno" /></div>
          <div><label className="block text-sm font-medium mb-2">PIN del alumno</label><input type="password" value={childPin} onChange={(e) => setChildPin(e.target.value)} className="w-full rounded-xl border px-3 py-2" placeholder="4+ dígitos" /></div>
          <div><label className="block text-sm font-medium mb-2">PUK del maestro</label><div className="flex gap-2"><input value={teacherPuk} onChange={(e) => setTeacherPuk(e.target.value)} className="w-full rounded-xl border px-3 py-2" /><button onClick={() => setTeacherPuk(generateTeacherPuk())} className="rounded-xl border px-3 py-2 bg-white">Generar</button></div></div>
        </div>
        <button onClick={configure} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Guardar seguridad</button>
        {meta && <p className="text-sm text-slate-500">Configurado para {meta.childLabel}. Creado: {meta.createdAt ? new Date(meta.createdAt).toLocaleString("es-ES") : "-"}</p>}
      </div>

      <div className="rounded-2xl border bg-white p-5 space-y-3">
        <h4 className="font-semibold">🧑‍🏫 Desbloqueo con PUK del maestro</h4>
        <p className="text-sm text-slate-600">Si el niño olvida su PIN, el maestro o adulto puede restablecerlo con el PUK local.</p>
        <div className="grid sm:grid-cols-2 gap-4">
          <div><label className="block text-sm font-medium mb-2">PUK del maestro</label><input value={unlockPuk} onChange={(e) => setUnlockPuk(e.target.value)} className="w-full rounded-xl border px-3 py-2" placeholder="Introduce el PUK" /></div>
          <div><label className="block text-sm font-medium mb-2">Nuevo PIN del alumno</label><input type="password" value={newChildPin} onChange={(e) => setNewChildPin(e.target.value)} className="w-full rounded-xl border px-3 py-2" placeholder="Nuevo PIN" /></div>
        </div>
        <button onClick={unlock} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white">Restablecer PIN con PUK</button>
      </div>

      {msg && <div className="rounded-2xl border bg-sky-50 text-sky-900 p-4 text-sm">{msg}</div>}
    </div>
  );
}

function DiaryStatsCard({ engineStats }) {
  const levelInfo = engineStats?.levelInfo;
  const statsByMateria = engineStats?.statsByMateria || {};
  return (
    <div className="rounded-2xl border bg-white p-5 space-y-3">
      <h3 className="text-lg font-bold">🏅 Puntos y niveles del diario</h3>
      <div className="grid sm:grid-cols-3 gap-4">
        <div className="rounded-2xl border p-4 text-center"><p className="text-3xl font-bold">{levelInfo?.totalPoints || 0}</p><p className="text-sm text-slate-600">Puntos</p></div>
        <div className="rounded-2xl border p-4 text-center"><p className="text-3xl font-bold">{levelInfo?.icon || "🔍"}</p><p className="text-sm text-slate-600">{levelInfo?.name || "Explorador"}</p></div>
        <div className="rounded-2xl border p-4 text-center"><p className="text-3xl font-bold">{engineStats?.accuracy || 0}%</p><p className="text-sm text-slate-600">Precisión</p></div>
      </div>
      <div className="rounded-2xl border p-4 space-y-2">
        <h4 className="font-semibold">📌 Logros del día</h4>
        {Object.keys(statsByMateria).length === 0 && <p className="text-sm text-slate-500">Todavía no hay práctica registrada en esta sesión.</p>}
        {Object.entries(statsByMateria).map(([materia, stats]) => (
          <div key={materia} className="flex items-center justify-between rounded-xl border p-3">
            <span className="capitalize">{materia}</span>
            <span>{stats.correct}/{stats.total}</span>
          </div>
        ))}
      </div>
    </div>
  );
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
  const frame = lowStim ? "min-h-screen bg-slate-50 text-slate-900" : "min-h-screen bg-gradient-to-br from-violet-50 via-white to-cyan-50 text-slate-900";

  useEffect(() => {
    const meta = getPinConfigMeta();
    if (meta?.childLabel) setStudentName(meta.childLabel);
  }, []);

  return (
    <div className={frame}>
      <div className="max-w-6xl mx-auto p-4 md:p-6 space-y-4">
        <header className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-2xl md:text-3xl font-bold tracking-tight">TGD · App educativa segura</h1>
            <p className="text-sm text-slate-600">Local-first · Sin telemetría · Sin rastreo · Cifrado local · LOMLOE</p>
          </div>
          {engineStats?.levelInfo && <div className="text-sm rounded-2xl border bg-white px-3 py-2">{engineStats.levelInfo.icon} {engineStats.levelInfo.name} · {engineStats.levelInfo.totalPoints} pts</div>}
        </header>

        <nav className="flex flex-wrap gap-2">
          {TABS.map((tab) => (
            <button key={tab.key} onClick={() => setActiveTab(tab.key)} className={["rounded-2xl border px-4 py-3 text-sm font-medium transition", activeTab === tab.key ? "bg-slate-900 text-white border-slate-900" : "bg-white hover:bg-slate-50 border-slate-200"].join(" ")}>
              <span className="mr-1">{tab.icon}</span>{tab.label}
            </button>
          ))}
        </nav>

        {activeTab === "inicio" && (
          <div className="space-y-4">
            <div className="rounded-2xl border bg-white p-5 space-y-4">
              <h2 className="text-xl font-bold">Bienvenido</h2>
              <p className="text-slate-600">Configura comunidad, accesibilidad y nombre del alumno. La app adapta las preguntas LOMLOE a tu perfil.</p>
              <div className="grid sm:grid-cols-4 gap-4">
                <div className="space-y-2"><label className="block text-sm font-medium">Comunidad autónoma</label><select className="w-full rounded-xl border px-3 py-2 bg-white" value={community} onChange={(e) => setCommunity(e.target.value)}>{comunidades.map((c) => <option key={c} value={c}>{c.charAt(0).toUpperCase() + c.slice(1)}</option>)}</select></div>
                <div className="space-y-2"><label className="block text-sm font-medium">Nombre del alumno</label><input value={studentName} onChange={(e) => setStudentName(e.target.value)} className="w-full rounded-xl border px-3 py-2" placeholder="Alumno" /></div>
                <div className="flex items-center justify-between rounded-2xl border p-3"><div><p className="font-medium text-sm">Modo TEA/TGD</p><p className="text-xs text-slate-500">Apoyos visuales</p></div><button onClick={() => setTeaMode(!teaMode)} className={["rounded-xl px-3 py-1 text-sm font-medium border", teaMode ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>{teaMode ? "ON" : "OFF"}</button></div>
                <div className="flex items-center justify-between rounded-2xl border p-3"><div><p className="font-medium text-sm">Baja estimulación</p><p className="text-xs text-slate-500">Menos distracción</p></div><button onClick={() => setLowStim(!lowStim)} className={["rounded-xl px-3 py-1 text-sm font-medium border", lowStim ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>{lowStim ? "ON" : "OFF"}</button></div>
              </div>
            </div>
            <div className="rounded-2xl border bg-white p-5 space-y-3">
              <h3 className="font-semibold">Perfil curricular: {perfil.nombre}</h3>
              <div className="grid sm:grid-cols-5 gap-3 text-sm">
                {Object.entries(perfil.enfoque).map(([key, desc]) => <div key={key} className="rounded-xl border p-3"><p className="font-medium capitalize">{key}</p><p className="text-slate-600 text-xs mt-1">{desc}</p></div>)}
              </div>
            </div>
          </div>
        )}

        {activeTab === "aprender" && <QuizView perfil={perfil.key} teaMode={teaMode} lowStim={lowStim} parentPin={parentPin} onStatsUpdate={setEngineStats} />}
        {activeTab === "examenes" && <ExamsView perfil={perfil.key} perfilNombre={perfil.nombre} studentName={studentName} />}
        {activeTab === "juegos" && <GamesView />}
        {activeTab === "emociones" && <EmotionCompanion />}
        {activeTab === "diario" && <div className="space-y-4"><DiaryStatsCard engineStats={engineStats} /><JournalView parentPin={parentPin} teaMode={teaMode} lowStim={lowStim} /></div>}
        {activeTab === "ajustes" && <div className="space-y-4"><SecurityPanel /><div className="rounded-2xl border bg-white p-5 space-y-2 text-sm text-slate-600"><h3 className="font-semibold text-slate-900">Privacidad y seguridad</h3><p>✅ Sin telemetría ni analíticas</p><p>✅ Sin cuentas ni identificadores</p><p>✅ Cifrado local AES-256-GCM con PBKDF2</p><p>✅ PIN del alumno + PUK del maestro (local)</p><p>✅ Certificados PDF generados en el dispositivo</p><p>✅ Ningún dato viaja a servidores</p></div></div>}
      </div>
    </div>
  );
}
EOF

echo "✅ src/App.jsx"

# ============================================================
# 11) Resumen final
# ============================================================
echo ""
echo "============================================================"
echo "  FASE 4 COMPLETADA"
echo "============================================================"
echo ""
echo "  Añadido:"
echo "   • Seguridad PIN del alumno + PUK del maestro"
echo "   • Más preguntas LOMLOE (banco extra)"
echo "   • Exámenes semanales por viernes"
echo "   • Juegos interactivos (Memory, Ahorcado, Ordena palabra)"
echo "   • Certificados PDF locales"
echo "   • Módulo emocional / compañero guiado"
echo "   • Sistema de puntos y niveles integrado"
echo ""
echo "  Ahora ejecuta: npm run dev"
echo ""
