import React, { useMemo, useState } from "react";
import { SOCIAL_STORIES_DATA } from "../../core/social-stories-data.js";

const CATEGORIES = [
  { key: "internet", icon: "🌐", label: "Internet" },
  { key: "escuela", icon: "🏫", label: "Escuela" },
  { key: "emociones", icon: "💛", label: "Emociones" },
  { key: "amigos", icon: "🤝", label: "Amigos" },
  { key: "rutinas", icon: "🗂️", label: "Rutinas" },
  { key: "salud", icon: "🌱", label: "Salud" }
];

export default function SocialStoriesView({ teaMode = true, lowStim = true }) {
  const [category, setCategory] = useState("internet");
  const stories = useMemo(() => SOCIAL_STORIES_DATA.filter((s) => s.category === category), [category]);
  const [index, setIndex] = useState(0);
  const story = stories[index] || SOCIAL_STORIES_DATA[0];
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  function nextStory() {
    setIndex((i) => (i + 1) % stories.length);
  }

  function changeCategory(next) {
    setCategory(next);
    setIndex(0);
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div>
        <h2 className="text-xl font-bold">📘 Historias sociales</h2>
        <p className="text-sm text-slate-600">Lecturas guiadas, claras y predecibles para apoyar comprensión social y emocional.</p>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
        {CATEGORIES.map((c) => (
          <button key={c.key} onClick={() => changeCategory(c.key)} className={["rounded-2xl border p-4 text-left", category === c.key ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>
            <div className="text-2xl mb-1">{c.icon}</div>
            <div className="font-medium text-sm">{c.label}</div>
          </button>
        ))}
      </div>

      <div className="rounded-2xl border bg-white p-5 space-y-4">
        <div className="flex items-center justify-between gap-3">
          <h3 className="font-semibold">{story.title}</h3>
          {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Lenguaje claro</span>}
        </div>
        <p className="text-slate-700">{story.intro}</p>
        <div className="space-y-2">
          {story.steps.map((step, idx) => (
            <div key={idx} className="rounded-xl border bg-slate-50 p-4">
              <strong>{idx + 1}.</strong> {step}
            </div>
          ))}
        </div>
        <div className="rounded-2xl border bg-emerald-50 text-emerald-900 p-4 text-sm">{story.closing}</div>
        <div className="flex flex-wrap gap-3">
          <button onClick={nextStory} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Siguiente historia</button>
        </div>
      </div>
    </div>
  );
}
