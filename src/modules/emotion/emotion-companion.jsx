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
