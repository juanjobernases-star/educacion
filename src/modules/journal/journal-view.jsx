import React, { useMemo, useState } from "react";
import {
  saveJournalEntry,
  loadJournalEntry,
  loadAllJournalEntries,
  deleteJournalEntry
} from "../../core/secure-store.js";
import EmotionCompanion from "./emotion-companion.jsx";

const MOODS = [
  { key: "feliz", emoji: "😊", label: "Feliz" },
  { key: "tranquilo", emoji: "😌", label: "Tranquilo" },
  { key: "cansado", emoji: "😴", label: "Cansado" },
  { key: "nervioso", emoji: "😟", label: "Nervioso" },
  { key: "enfadado", emoji: "😠", label: "Enfadado" },
  { key: "triste", emoji: "😢", label: "Triste" }
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
    <button type="button" onClick={onClick}
      className={["rounded-2xl border px-4 py-3 text-left transition w-full",
        active ? "bg-slate-900 text-white border-slate-900" : "bg-white hover:bg-slate-50 border-slate-200"
      ].join(" ")}>{children}</button>
  );
}

function SectionTitle({ children }) {
  return <h3 className="text-base font-semibold tracking-tight">{children}</h3>;
}

function getDefaultJournal() {
  return {
    fecha: new Date().toISOString().slice(0, 10),
    estado: "tranquilo", dia: "", gusto: "", costo: "", manana: "",
    ruido: "bajo", ayuda: "no", energia: "media", rutina: [], apoyos: []
  };
}

export default function JournalView({ parentPin, teaMode = true, lowStim = true, namespace = "tgd_journal", onEntrySaved, engineStats }) {
  const [entry, setEntry] = useState(getDefaultJournal());
  const [step, setStep] = useState(0);
  const [entries, setEntries] = useState([]);
  const [message, setMessage] = useState("");
  const [busy, setBusy] = useState(false);

  const containerClass = lowStim ? "bg-slate-50 text-slate-900" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50 text-slate-900";

  const steps = useMemo(() => ["¿Cómo me siento?", "Mi rutina de hoy", "Qué he hecho", "Qué me gustó y qué me costó", "Mañana quiero"], []);

  const progress = useMemo(() => {
    let v = 0;
    if (entry.estado) v += 20;
    if (entry.rutina.length > 0 || !teaMode) v += 20;
    if (entry.dia.trim()) v += 20;
    if (entry.gusto.trim() || entry.costo.trim()) v += 20;
    if (entry.manana.trim()) v += 20;
    return v;
  }, [entry, teaMode]);

  function updateField(field, value) { setEntry((prev) => ({ ...prev, [field]: value })); }
  function toggleInArray(field, value) {
    setEntry((prev) => {
      const current = new Set(prev[field]);
      if (current.has(value)) current.delete(value); else current.add(value);
      return { ...prev, [field]: Array.from(current) };
    });
  }

  async function handleSave() {
    if (!parentPin || String(parentPin).length < 4) { setMessage("Necesitas un PIN local del adulto."); return; }
    try { setBusy(true); const saved = await saveJournalEntry(parentPin, entry, { namespace }); setMessage("Diario guardado y cifrado."); if (onEntrySaved) onEntrySaved(saved); }
    catch (e) { setMessage("No se ha podido guardar."); } finally { setBusy(false); }
  }
  async function handleLoad() {
    if (!parentPin || String(parentPin).length < 4) { setMessage("Introduce el PIN local."); return; }
    try { setBusy(true); const saved = await loadJournalEntry(parentPin, entry.fecha, { namespace }); if (!saved) { setMessage("No hay entrada para esta fecha."); return; } setEntry(saved); setMessage("Entrada cargada."); }
    catch (e) { setMessage("PIN incorrecto o datos no válidos."); } finally { setBusy(false); }
  }
  async function handleList() {
    if (!parentPin || String(parentPin).length < 4) { setMessage("Introduce el PIN."); return; }
    try { setBusy(true); const loaded = await loadAllJournalEntries(parentPin, { namespace }); setEntries(loaded); setMessage(loaded.length ? "Historial cargado." : "No hay entradas."); }
    catch (e) { setMessage("Error al cargar historial."); } finally { setBusy(false); }
  }
  function handleDelete() { deleteJournalEntry(entry.fecha, { namespace }); setMessage("Entrada eliminada."); }

  function renderStep() {
    switch (step) {
      case 0: return (
        <div className="space-y-4">
          <SectionTitle>¿Cómo me siento hoy?</SectionTitle>
          <p className="text-sm text-slate-600">Elige una emoción. Tu compañero te ayudará.</p>
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
            {MOODS.map((m) => (
              <TeaButton key={m.key} active={entry.estado === m.key} onClick={() => updateField("estado", m.key)}>
                <span className="text-2xl mr-2">{m.emoji}</span><span className="font-medium">{m.label}</span>
              </TeaButton>
            ))}
          </div>
          <EmotionCompanion mood={entry.estado} engineStats={engineStats} teaMode={teaMode} lowStim={lowStim} />
          <div className="grid sm:grid-cols-2 gap-3">
            <label className="rounded-2xl border bg-white p-3">
              <span className="block text-sm font-medium mb-2">Nivel de ruido</span>
              <select className="w-full rounded-xl border px-3 py-2 bg-white" value={entry.ruido} onChange={(e) => updateField("ruido", e.target.value)}>
                <option value="bajo">Bajo</option><option value="medio">Medio</option><option value="alto">Alto</option>
              </select>
            </label>
            <label className="rounded-2xl border bg-white p-3">
              <span className="block text-sm font-medium mb-2">Energía</span>
              <select className="w-full rounded-xl border px-3 py-2 bg-white" value={entry.energia} onChange={(e) => updateField("energia", e.target.value)}>
                <option value="baja">Baja</option><option value="media">Media</option><option value="alta">Alta</option>
              </select>
            </label>
          </div>
        </div>
      );
      case 1: return (
        <div className="space-y-4">
          <SectionTitle>Mi rutina de hoy</SectionTitle>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {TEA_ROUTINES.map((item) => (
              <TeaButton key={item.key} active={entry.rutina.includes(item.key)} onClick={() => toggleInArray("rutina", item.key)}>
                <span className="text-lg mr-2">{item.icon}</span><span className="font-medium">{item.label}</span>
              </TeaButton>
            ))}
          </div>
          <div className="rounded-2xl border bg-white p-4">
            <p className="text-sm font-medium mb-2">Apoyos que me ayudaron</p>
            <div className="grid sm:grid-cols-2 gap-2">
              {SUPPORTS.map((item) => (
                <TeaButton key={item.key} active={entry.apoyos.includes(item.key)} onClick={() => toggleInArray("apoyos", item.key)}>
                  <span className="font-medium">{item.label}</span>
                </TeaButton>
              ))}
            </div>
          </div>
        </div>
      );
      case 2: return (
        <div className="space-y-4">
          <SectionTitle>Hoy he hecho…</SectionTitle>
          {teaMode && (
            <div className="rounded-2xl border bg-white p-4 text-sm text-slate-600">
              <p className="font-medium text-slate-800 mb-2">Modelo TEA</p>
              <p>Hoy he ido a _______. Después he hecho _______. Luego me he sentido _______.</p>
            </div>
          )}
          <textarea className="w-full min-h-[140px] rounded-2xl border bg-white px-4 py-3 outline-none" value={entry.dia} onChange={(e) => updateField("dia", e.target.value)} placeholder="Escribe lo que has hecho hoy…" />
        </div>
      );
      case 3: return (
        <div className="space-y-4">
          <SectionTitle>Lo bueno y lo difícil</SectionTitle>
          <div className="grid md:grid-cols-2 gap-4">
            <div className="rounded-2xl border bg-white p-4 space-y-2">
              <label className="block text-sm font-medium">Lo que más me gustó</label>
              <textarea className="w-full min-h-[120px] rounded-2xl border px-4 py-3 outline-none" value={entry.gusto} onChange={(e) => updateField("gusto", e.target.value)} placeholder="¿Qué ha sido lo mejor?" />
            </div>
            <div className="rounded-2xl border bg-white p-4 space-y-2">
              <label className="block text-sm font-medium">Algo que me costó</label>
              <textarea className="w-full min-h-[120px] rounded-2xl border px-4 py-3 outline-none" value={entry.costo} onChange={(e) => updateField("costo", e.target.value)} placeholder="¿Qué fue difícil?" />
            </div>
          </div>
          <div className="rounded-2xl border bg-white p-4">
            <label className="block text-sm font-medium mb-2">¿Necesité ayuda?</label>
            <div className="flex gap-2">
              <TeaButton active={entry.ayuda === "si"} onClick={() => updateField("ayuda", "si")}>Sí</TeaButton>
              <TeaButton active={entry.ayuda === "no"} onClick={() => updateField("ayuda", "no")}>No</TeaButton>
            </div>
          </div>
        </div>
      );
      case 4: default: return (
        <div className="space-y-4">
          <SectionTitle>Mañana quiero…</SectionTitle>
          <p className="text-sm text-slate-600">Piensa en una sola cosa importante.</p>
          <textarea className="w-full min-h-[140px] rounded-2xl border bg-white px-4 py-3 outline-none" value={entry.manana} onChange={(e) => updateField("manana", e.target.value)} placeholder="Mañana quiero…" />
        </div>
      );
    }
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", containerClass].join(" ")}>
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold tracking-tight">Diario del alumno</h2>
          <p className="text-sm text-slate-600">Con compañero emocional, cifrado y soporte TEA.</p>
        </div>
        <div className="flex items-center gap-3">
          {engineStats?.levelInfo && (
            <span className="text-sm rounded-2xl border bg-white px-3 py-2">
              {engineStats.levelInfo.icon} {engineStats.levelInfo.totalPoints} pts
            </span>
          )}
          <span className="text-sm rounded-2xl border bg-white px-3 py-2">{progress}%</span>
        </div>
      </div>

      <div className="grid md:grid-cols-[0.75fr_1.25fr] gap-4">
        <div className="space-y-4">
          <div className="rounded-2xl border bg-white p-4 space-y-3">
            <label className="block text-sm font-medium">Fecha</label>
            <input type="date" className="w-full rounded-2xl border px-3 py-2" value={entry.fecha} onChange={(e) => updateField("fecha", e.target.value)} />
            {teaMode && (
              <div className="rounded-2xl bg-slate-50 border p-3 text-sm text-slate-600">
                <p className="font-medium text-slate-800 mb-1">Modo TEA activo</p>
                <p>Una instrucción por pantalla, lenguaje simple.</p>
              </div>
            )}
          </div>
          <div className="rounded-2xl border bg-white p-4 space-y-2">
            <p className="text-sm font-medium">Pasos</p>
            {steps.map((label, index) => (
              <button key={label} type="button" onClick={() => setStep(index)}
                className={["w-full text-left rounded-2xl border px-3 py-2 text-sm transition",
                  step === index ? "bg-slate-900 text-white border-slate-900" : "bg-white hover:bg-slate-50 border-slate-200"].join(" ")}>
                {index + 1}. {label}
              </button>
            ))}
          </div>
        </div>

        <div className="space-y-4">
          <div className="rounded-2xl border bg-white p-4 md:p-5">{renderStep()}</div>
          <div className="flex flex-wrap gap-3">
            <button type="button" onClick={() => setStep((p) => Math.max(p - 1, 0))} className="rounded-2xl border px-4 py-3 bg-white hover:bg-slate-50">Anterior</button>
            <button type="button" onClick={() => setStep((p) => Math.min(p + 1, steps.length - 1))} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Siguiente</button>
            <button type="button" disabled={busy} onClick={handleSave} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white disabled:opacity-60">Guardar cifrado</button>
            <button type="button" disabled={busy} onClick={handleLoad} className="rounded-2xl border px-4 py-3 bg-white hover:bg-slate-50">Cargar fecha</button>
            <button type="button" onClick={handleList} className="rounded-2xl border px-4 py-3 bg-white hover:bg-slate-50">Ver historial</button>
            <button type="button" onClick={handleDelete} className="rounded-2xl border px-4 py-3 bg-rose-600 text-white">Borrar fecha</button>
          </div>
          {message && <div className="rounded-2xl border bg-sky-50 text-sky-900 px-4 py-3 text-sm">{message}</div>}
          {entries.length > 0 && (
            <div className="rounded-2xl border bg-white p-4 space-y-3">
              <SectionTitle>Historial local</SectionTitle>
              {entries.map((item) => (
                <button key={item.fecha} type="button" onClick={() => setEntry(item)} className="rounded-2xl border bg-slate-50 hover:bg-slate-100 p-4 text-left w-full">
                  <div className="flex items-center justify-between gap-3">
                    <div><p className="font-medium">{item.fecha}</p><p className="text-sm text-slate-600">Estado: {item.estado} · Ruido: {item.ruido}</p></div>
                    <span className="text-2xl">{MOODS.find((m) => m.key === item.estado)?.emoji || "📝"}</span>
                  </div>
                </button>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
