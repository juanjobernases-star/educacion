import React, { useMemo, useState } from "react";

const VISUAL_ROUTINES = [
  "Me siento y respiro",
  "Leo la tarea",
  "Hago un paso pequeño",
  "Reviso si está bien",
  "Descanso breve",
  "Continúo"
];

const SOCIAL_STORIES = [
  {
    title: "Si algo me preocupa en internet",
    steps: [
      "Paro y no sigo mirando.",
      "No respondo si me hace sentir mal.",
      "Hago una captura si hace falta.",
      "Lo cuento a un adulto de confianza."
    ]
  },
  {
    title: "Si no entiendo una consigna",
    steps: [
      "Respiro una vez.",
      "Leo solo la primera parte.",
      "Busco una palabra clave.",
      "Pido ayuda si sigo sin entenderlo."
    ]
  },
  {
    title: "Si me pongo nervioso con una red social",
    steps: [
      "Cierro la app un momento.",
      "Me muevo o bebo agua.",
      "Pienso cómo me siento.",
      "Se lo explico a un adulto."
    ]
  }
];

function VisualRoutine() {
  const [done, setDone] = useState([]);
  function toggle(idx) {
    setDone((prev) => prev.includes(idx) ? prev.filter((n) => n !== idx) : [...prev, idx]);
  }
  return (
    <div className="rounded-2xl border bg-white p-4 space-y-3">
      <h3 className="font-semibold">🗂️ Rutina visual</h3>
      {VISUAL_ROUTINES.map((step, idx) => (
        <button key={idx} onClick={() => toggle(idx)} className={["w-full rounded-2xl border p-3 text-left", done.includes(idx) ? "bg-emerald-50 border-emerald-300" : "bg-white hover:bg-slate-50"].join(" ")}>
          {done.includes(idx) ? "✅" : "⬜"} {step}
        </button>
      ))}
    </div>
  );
}

function SensoryMeter() {
  const [level, setLevel] = useState(2);
  const labels = ["Muy tranquilo", "Tranquilo", "Activado", "Muy activado", "Necesito ayuda"];
  return (
    <div className="rounded-2xl border bg-white p-4 space-y-3">
      <h3 className="font-semibold">🌡️ Termómetro sensorial</h3>
      <input type="range" min="0" max="4" value={level} onChange={(e) => setLevel(Number(e.target.value))} className="w-full" />
      <p className="text-sm text-slate-700">Ahora me siento: <strong>{labels[level]}</strong></p>
      <p className="text-xs text-slate-500">Si estás muy activado, puede ayudar parar, respirar y pedir apoyo.</p>
    </div>
  );
}

function SocialStories() {
  const [index, setIndex] = useState(0);
  const story = useMemo(() => SOCIAL_STORIES[index], [index]);
  return (
    <div className="rounded-2xl border bg-white p-4 space-y-3">
      <div className="flex items-center justify-between gap-3">
        <h3 className="font-semibold">📘 Historia social</h3>
        <div className="flex gap-2">
          {SOCIAL_STORIES.map((_, i) => <button key={i} onClick={() => setIndex(i)} className={["rounded-xl border px-3 py-1 text-sm", i === index ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>{i + 1}</button>)}
        </div>
      </div>
      <p className="font-medium">{story.title}</p>
      <div className="space-y-2">
        {story.steps.map((step, idx) => <div key={idx} className="rounded-xl border p-3 bg-slate-50">{idx + 1}. {step}</div>)}
      </div>
    </div>
  );
}

function VisualTimer() {
  const [seconds, setSeconds] = useState(180);
  const [running, setRunning] = useState(false);
  React.useEffect(() => {
    if (!running) return;
    if (seconds <= 0) {
      setRunning(false);
      return;
    }
    const id = setTimeout(() => setSeconds((s) => s - 1), 1000);
    return () => clearTimeout(id);
  }, [running, seconds]);
  const minutes = String(Math.floor(seconds / 60)).padStart(2, "0");
  const secs = String(seconds % 60).padStart(2, "0");
  return (
    <div className="rounded-2xl border bg-white p-4 space-y-3">
      <h3 className="font-semibold">⏱️ Temporizador visual</h3>
      <div className="rounded-2xl border bg-slate-50 p-6 text-center text-3xl font-bold">{minutes}:{secs}</div>
      <div className="flex flex-wrap gap-3">
        <button onClick={() => setRunning(true)} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Iniciar</button>
        <button onClick={() => setRunning(false)} className="rounded-2xl border px-4 py-3 bg-white">Pausar</button>
        <button onClick={() => { setRunning(false); setSeconds(180); }} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar 3 min</button>
      </div>
    </div>
  );
}

export default function TeaSupportView() {
  return (
    <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
      <div>
        <h2 className="text-xl font-bold">🧩 Apoyos TEA / TGD / Asperger</h2>
        <p className="text-sm text-slate-600">Herramientas visuales y predecibles para reducir estrés y aumentar autonomía.</p>
      </div>
      <div className="grid lg:grid-cols-2 gap-4">
        <VisualRoutine />
        <SensoryMeter />
        <SocialStories />
        <VisualTimer />
      </div>
    </div>
  );
}
