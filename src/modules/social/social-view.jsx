import React, { useMemo, useState } from "react";
import { getRandomSocialQuestions } from "../../core/questions-social.js";

const TOPICS = [
  { key: "importancia", icon: "🌟", label: "Importancia" },
  { key: "privacidad", icon: "🔒", label: "Privacidad" },
  { key: "riesgos", icon: "⚠️", label: "Riesgos" },
  { key: "fake_news", icon: "📰", label: "Noticias falsas" },
  { key: "bienestar", icon: "💛", label: "Bienestar" },
  { key: "convivencia", icon: "🤝", label: "Convivencia" },
  { key: "seguridad", icon: "🛡️", label: "Seguridad" }
];

function TopicCard({ active, onClick, icon, label }) {
  return <button onClick={onClick} className={["rounded-2xl border p-4 text-left", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}><div className="text-2xl mb-1">{icon}</div><div className="font-medium">{label}</div></button>;
}

export default function SocialView({ teaMode = true, lowStim = true }) {
  const [topic, setTopic] = useState("importancia");
  const [questions, setQuestions] = useState(() => getRandomSocialQuestions("importancia", 5));
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [answered, setAnswered] = useState(false);
  const current = questions[idx];
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  function changeTopic(next) {
    setTopic(next);
    setQuestions(getRandomSocialQuestions(next, 5));
    setIdx(0);
    setSelected(null);
    setAnswered(false);
  }

  function selectOption(i) {
    if (answered) return;
    setSelected(i);
    setAnswered(true);
  }

  function nextQuestion() {
    if (idx < questions.length - 1) {
      setIdx((p) => p + 1);
      setSelected(null);
      setAnswered(false);
    } else {
      setIdx(0);
      setQuestions(getRandomSocialQuestions(topic, 5));
      setSelected(null);
      setAnswered(false);
    }
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div>
        <h2 className="text-xl font-bold">🌐 Redes sociales y ciudadanía digital</h2>
        <p className="text-sm text-slate-600">Aprende la parte positiva, los riesgos y cómo cuidarte en internet.</p>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-7 gap-3">
        {TOPICS.map((t) => <TopicCard key={t.key} active={topic === t.key} onClick={() => changeTopic(t.key)} icon={t.icon} label={t.label} />)}
      </div>

      <div className="rounded-2xl border bg-white p-5 space-y-4">
        <div className="flex items-center justify-between gap-3">
          <h3 className="font-semibold">Pregunta {idx + 1} de {questions.length}</h3>
          {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Una acción por pantalla</span>}
        </div>
        <p className="text-lg font-medium leading-relaxed">{current.pregunta}</p>
        <div className="grid gap-3">
          {current.opciones.map((opt, i) => (
            <button key={i} onClick={() => selectOption(i)} className={[
              "rounded-2xl border px-4 py-4 text-left",
              answered && i === current.correcta ? "bg-emerald-100 border-emerald-500" :
              answered && i === selected && i !== current.correcta ? "bg-rose-100 border-rose-500" :
              "bg-white hover:bg-slate-50"
            ].join(" ")}>
              {opt}
            </button>
          ))}
        </div>
        {answered && (
          <div className={[
            "rounded-2xl border p-4 text-sm",
            selected === current.correcta ? "bg-emerald-50 text-emerald-900 border-emerald-200" : "bg-rose-50 text-rose-900 border-rose-200"
          ].join(" ")}>
            <p className="font-semibold mb-1">{selected === current.correcta ? "¡Bien hecho!" : "Vamos a revisarlo"}</p>
            <p>{current.explicacion}</p>
          </div>
        )}
        <div className="flex flex-wrap gap-3">
          <button onClick={nextQuestion} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Siguiente</button>
        </div>
      </div>
    </div>
  );
}
