import React, { useMemo, useState } from "react";
import { getRandomHabitQuestions } from "../../core/questions-habits.js";

const HABIT_TOPICS = [
  { key: "nutricion", icon: "🍎", label: "Nutrición" },
  { key: "salud", icon: "🩺", label: "Salud" },
  { key: "deporte", icon: "🏃", label: "Deporte" },
  { key: "rutinas", icon: "🗂️", label: "Rutinas" }
];

function TopicButton({ active, onClick, icon, label }) {
  return <button onClick={onClick} className={["rounded-2xl border p-4 text-left", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}><div className="text-2xl mb-1">{icon}</div><div className="font-medium">{label}</div></button>;
}

function QuestionCard({ question, selected, answered, onSelect }) {
  return (
    <div className="rounded-2xl border bg-white p-5 space-y-4">
      <p className="text-lg font-medium leading-relaxed">{question.pregunta}</p>
      <div className="grid gap-3">
        {question.opciones.map((opt, i) => (
          <button key={i} onClick={() => onSelect(i)} className={[
            "rounded-2xl border px-4 py-4 text-left",
            answered && i === question.correcta ? "bg-emerald-100 border-emerald-500" :
            answered && i === selected && i !== question.correcta ? "bg-rose-100 border-rose-500" :
            "bg-white hover:bg-slate-50"
          ].join(" ")}>
            {opt}
          </button>
        ))}
      </div>
    </div>
  );
}

export default function HabitsView({ teaMode = true, lowStim = true }) {
  const [topic, setTopic] = useState("nutricion");
  const [questions, setQuestions] = useState(() => getRandomHabitQuestions("nutricion", 5));
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [answered, setAnswered] = useState(false);
  const current = questions[idx];
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  function changeTopic(next) {
    setTopic(next);
    setQuestions(getRandomHabitQuestions(next, 5));
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
      setQuestions(getRandomHabitQuestions(topic, 5));
      setSelected(null);
      setAnswered(false);
    }
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div>
        <h2 className="text-xl font-bold">🌱 Hábitos saludables</h2>
        <p className="text-sm text-slate-600">Comida, salud, deporte y rutinas saludables con preguntas claras y visuales.</p>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        {HABIT_TOPICS.map((t) => <TopicButton key={t.key} active={topic === t.key} onClick={() => changeTopic(t.key)} icon={t.icon} label={t.label} />)}
      </div>

      <div className="flex items-center justify-between gap-3">
        <h3 className="font-semibold">Quiz {HABIT_TOPICS.find((t) => t.key === topic)?.label} · Pregunta {idx + 1} de {questions.length}</h3>
        {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-white">Paso a paso</span>}
      </div>

      <QuestionCard question={current} selected={selected} answered={answered} onSelect={selectOption} />

      {answered && (
        <div className={[
          "rounded-2xl border p-4 text-sm",
          selected === current.correcta ? "bg-emerald-50 text-emerald-900 border-emerald-200" : "bg-rose-50 text-rose-900 border-rose-200"
        ].join(" ")}>
          <p className="font-semibold mb-1">{selected === current.correcta ? "¡Muy bien!" : "Lo revisamos juntos"}</p>
          <p>{current.explicacion}</p>
        </div>
      )}

      <div className="rounded-2xl border bg-white p-4 space-y-2 text-sm text-slate-700">
        <h4 className="font-semibold">Ideas de autocuidado</h4>
        <p>• Beber agua a lo largo del día</p>
        <p>• Hacer pausas activas cuando llevas mucho tiempo sentado</p>
        <p>• Dormir con una rutina estable</p>
        <p>• Mover el cuerpo cada día de una forma que te guste</p>
      </div>

      <div className="flex flex-wrap gap-3">
        <button onClick={nextQuestion} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Siguiente</button>
      </div>
    </div>
  );
}
