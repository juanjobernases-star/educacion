import React, { useEffect, useState } from "react";
import { AdaptiveEngine } from "../../core/adaptive-engine.js";
import { saveEncryptedJSON, loadEncryptedJSON } from "../../core/secure-store.js";

const MATERIAS = [
  { key: "matematicas", icon: "🧮", label: "Matemáticas" },
  { key: "lengua", icon: "📖", label: "Lengua" },
  { key: "medio", icon: "🌍", label: "Conocimiento del Medio" },
  { key: "digital", icon: "💻", label: "Competencia Digital" },
  { key: "ingles", icon: "🇬🇧", label: "Inglés" }
];
const NIVEL_LABELS = { basico: "⭐ Básico", medio: "⭐⭐ Medio", avanzado: "⭐⭐⭐ Avanzado" };

function BigButton({ correct, wrong, onClick, children, disabled }) {
  let cls = "rounded-2xl border px-5 py-4 text-left transition w-full font-medium ";
  if (correct) cls += "bg-emerald-100 border-emerald-500 text-emerald-900";
  else if (wrong) cls += "bg-rose-100 border-rose-500 text-rose-900";
  else cls += "bg-white hover:bg-slate-50 border-slate-200";
  return <button type="button" onClick={onClick} disabled={disabled} className={cls}>{children}</button>;
}

export default function QuizView({ perfil, teaMode, lowStim, parentPin, onStatsUpdate }) {
  const [engine, setEngine] = useState(null);
  const [materia, setMateria] = useState(null);
  const [questions, setQuestions] = useState([]);
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [answered, setAnswered] = useState(false);
  const [lastPoints, setLastPoints] = useState(0);
  const [showStats, setShowStats] = useState(false);

  useEffect(() => {
    async function load() {
      let loaded = null;
      if (parentPin && parentPin.length >= 4) {
        try {
          const data = await loadEncryptedJSON("adaptive_engine", parentPin, { namespace: "tgd_progress" });
          if (data && data.perfil === perfil) loaded = AdaptiveEngine.fromJSON(data);
        } catch (e) {}
      }
      const eng = loaded || new AdaptiveEngine(perfil);
      setEngine(eng);
      if (onStatsUpdate) onStatsUpdate(eng.getStats());
    }
    load();
  }, [perfil, parentPin]);

  async function saveProgress(eng) {
    if (parentPin && parentPin.length >= 4) {
      try { await saveEncryptedJSON("adaptive_engine", eng.toJSON(), parentPin, { namespace: "tgd_progress" }); } catch (e) {}
    }
    if (onStatsUpdate) onStatsUpdate(eng.getStats());
  }

  function startMateria(key) {
    if (!engine) return;
    setMateria(key); setQuestions(engine.getNextQuestions(key, 5));
    setIdx(0); setSelected(null); setAnswered(false); setShowStats(false); setLastPoints(0);
  }

  function handleSelect(i) {
    if (answered || !engine) return;
    setSelected(i); setAnswered(true);
    const qst = questions[idx];
    const pts = engine.track(qst.id, qst.materia, i === qst.correcta);
    setLastPoints(pts);
    saveProgress(engine);
  }

  function handleNext() {
    if (idx < questions.length - 1) { setIdx(idx + 1); setSelected(null); setAnswered(false); setLastPoints(0); }
    else setShowStats(true);
  }

  function backToSubjects() { setMateria(null); setQuestions([]); setIdx(0); setSelected(null); setAnswered(false); setShowStats(false); setLastPoints(0); }

  const stats = engine ? engine.getStats() : null;
  const levelInfo = engine ? engine.getLevelInfo() : null;
  const currentQ = questions[idx] || null;
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  if (!engine) return <div className="rounded-2xl border p-6 bg-white text-center">Cargando...</div>;

  const levelBar = levelInfo ? (
    <div className="rounded-2xl border bg-white p-4 space-y-2">
      <div className="flex items-center justify-between">
        <span className="font-semibold">{levelInfo.icon} {levelInfo.name}</span>
        <span className="text-sm text-slate-600">{levelInfo.totalPoints} pts</span>
      </div>
      <div className="w-full bg-slate-200 rounded-full h-3">
        <div className="bg-slate-900 h-3 rounded-full transition-all" style={{ width: levelInfo.progress + "%" }}></div>
      </div>
      {levelInfo.nextLevel && <p className="text-xs text-slate-500">{levelInfo.pointsToNext} pts para {levelInfo.nextLevel}</p>}
      {levelInfo.currentStreak > 0 && <p className="text-xs text-emerald-600">🔥 Racha: {stats.currentStreak}</p>}
    </div>
  ) : null;

  if (showStats) return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <h2 className="text-xl font-bold">Resultados</h2>
      {levelBar}
      <div className="grid sm:grid-cols-3 gap-4">
        <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{stats.totalAnswered}</p><p className="text-sm text-slate-600">Respondidas</p></div>
        <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold text-emerald-600">{stats.totalCorrect}</p><p className="text-sm text-slate-600">Correctas</p></div>
        <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{stats.accuracy}%</p><p className="text-sm text-slate-600">Precisión</p></div>
      </div>
      <div className="rounded-2xl border bg-white p-4 space-y-3">
        <h3 className="font-semibold">Nivel por asignatura</h3>
        {MATERIAS.map((m) => (
          <div key={m.key} className="flex items-center justify-between rounded-xl border p-3">
            <span>{m.icon} {m.label}</span>
            <span className="text-sm font-medium">{NIVEL_LABELS[engine.getLevel(m.key)]}</span>
          </div>
        ))}
      </div>
      <div className="flex flex-wrap gap-3">
        <button onClick={backToSubjects} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Volver</button>
        <button onClick={() => startMateria(materia)} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white">Repetir</button>
      </div>
    </div>
  );

  if (!materia) return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div><h2 className="text-xl font-bold">Aprender</h2><p className="text-sm text-slate-600">Elige asignatura. Las preguntas se adaptan a tu nivel.</p></div>
      {levelBar}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
        {MATERIAS.map((m) => (
          <button key={m.key} onClick={() => startMateria(m.key)} className="rounded-2xl border bg-white hover:bg-slate-50 p-5 text-left transition">
            <span className="text-3xl block mb-2">{m.icon}</span>
            <span className="font-semibold block">{m.label}</span>
            <span className="text-sm text-slate-500 block mt-1">Nivel: {NIVEL_LABELS[engine.getLevel(m.key)]}</span>
          </button>
        ))}
      </div>
    </div>
  );

  if (!currentQ) return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <p>No hay más preguntas disponibles.</p>
      <button onClick={backToSubjects} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Volver</button>
    </div>
  );

  const mi = MATERIAS.find((m) => m.key === materia);
  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold">{mi?.icon} {mi?.label}</h2>
          <p className="text-sm text-slate-600">Pregunta {idx + 1} de {questions.length} · {NIVEL_LABELS[engine.getLevel(materia)]}</p>
        </div>
        <div className="flex items-center gap-3">
          <span className="text-sm font-medium">{levelInfo?.icon} {levelInfo?.totalPoints} pts</span>
          <button onClick={backToSubjects} className="rounded-2xl border px-3 py-2 bg-white hover:bg-slate-50 text-sm">Volver</button>
        </div>
      </div>
      <div className="rounded-2xl border bg-white p-5"><p className="text-lg font-medium leading-relaxed">{currentQ.pregunta}</p></div>
      <div className="grid grid-cols-1 gap-3">
        {currentQ.opciones.map((opt, i) => (
          <BigButton key={i} onClick={() => handleSelect(i)} disabled={answered} correct={answered && i === currentQ.correcta} wrong={answered && i === selected && i !== currentQ.correcta}>{opt}</BigButton>
        ))}
      </div>
      {answered && (
        <div className="space-y-3">
          <div className={["rounded-2xl border p-4 text-sm", selected === currentQ.correcta ? "bg-emerald-50 text-emerald-900 border-emerald-200" : "bg-rose-50 text-rose-900 border-rose-200"].join(" ")}>
            <p className="font-semibold mb-1">
              {selected === currentQ.correcta ? "¡Correcto! 🎉" : "No es correcto 😕"}
              {lastPoints > 0 && <span className="ml-2 text-emerald-600 font-bold">+{lastPoints} pts</span>}
            </p>
            <p>{currentQ.explicacion}</p>
          </div>
          <button onClick={handleNext} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">
            {idx < questions.length - 1 ? "Siguiente pregunta" : "Ver resultados"}
          </button>
        </div>
      )}
    </div>
  );
}
