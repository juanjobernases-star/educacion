#!/bin/bash
# ============================================================
# setup_tgd_phase11.sh
# Fase 11: Selector de edad + etapa educativa + filtrado
# Ejecutar desde: ~/Escritorio/TGD/
# ============================================================
set -e

echo ""
echo "🎓 Fase 11: Selector de edad, etapa educativa y filtrado de contenido"
echo ""

mkdir -p src/core src/modules/stage-selector

# ============================================================
# 1) Datos de etapas y filtrado por edad
# ============================================================
cat << 'STAGESEOF' > src/core/stages-data.js
export const STAGES = [
  {
    id: "infantil",
    name: "Educacion Infantil",
    ageRange: "3 - 5 anios",
    ageMin: 3,
    ageMax: 5,
    icon: "🧒",
    description: "Rutinas, emociones, juego y autonomia personal.",
    courses: [
      { id: "inf_3", label: "3 anios" },
      { id: "inf_4", label: "4 anios" },
      { id: "inf_5", label: "5 anios" }
    ]
  },
  {
    id: "primaria",
    name: "Educacion Primaria",
    ageRange: "6 - 12 anios",
    ageMin: 6,
    ageMax: 12,
    icon: "📚",
    description: "Contenidos LOMLOE, competencias y ciudadania digital.",
    courses: [
      { id: "pri_1", label: "1 Primaria (6-7)" },
      { id: "pri_2", label: "2 Primaria (7-8)" },
      { id: "pri_3", label: "3 Primaria (8-9)" },
      { id: "pri_4", label: "4 Primaria (9-10)" },
      { id: "pri_5", label: "5 Primaria (10-11)" },
      { id: "pri_6", label: "6 Primaria (11-12)" }
    ]
  },
  {
    id: "eso",
    name: "Educacion Secundaria (ESO)",
    ageRange: "12 - 16 anios",
    ageMin: 12,
    ageMax: 16,
    icon: "🎓",
    description: "Profundizacion academica y pensamiento critico.",
    courses: [
      { id: "eso_1", label: "1 ESO (12-13)" },
      { id: "eso_2", label: "2 ESO (13-14)" },
      { id: "eso_3", label: "3 ESO (14-15)" },
      { id: "eso_4", label: "4 ESO (15-16)" }
    ]
  },
  {
    id: "bachillerato",
    name: "Bachillerato",
    ageRange: "16 - 18 anios",
    ageMin: 16,
    ageMax: 18,
    icon: "🏆",
    description: "Preparacion universitaria y autonomia.",
    courses: [
      { id: "bach_1", label: "1 Bachillerato (16-17)" },
      { id: "bach_2", label: "2 Bachillerato (17-18)" }
    ]
  }
];

export const STAGE_TABS = {
  infantil: [
    { key: "inicio", label: "Inicio" },
    { key: "rutinas", label: "Rutinas" },
    { key: "emociones", label: "Emociones" },
    { key: "juegos", label: "Juegos" },
    { key: "tea", label: "Apoyos TEA" },
    { key: "diario", label: "Diario" },
    { key: "familia", label: "Familia" },
    { key: "ajustes", label: "Ajustes" }
  ],
  primaria: [
    { key: "inicio", label: "Inicio" },
    { key: "aprender", label: "Aprender" },
    { key: "tutor", label: "Tutor emocional" },
    { key: "profesor", label: "Panel profesor" },
    { key: "redes", label: "Redes Sociales" },
    { key: "retos", label: "Retos" },
    { key: "historias", label: "Historias" },
    { key: "habitos", label: "Habitos" },
    { key: "examenes", label: "Examenes" },
    { key: "juegos", label: "Juegos" },
    { key: "tea", label: "Apoyos TEA" },
    { key: "rutinas", label: "Rutinas" },
    { key: "emociones", label: "Emociones" },
    { key: "diario", label: "Diario" },
    { key: "familia", label: "Familia" },
    { key: "informes", label: "Informes" },
    { key: "seguridad", label: "Seguridad" },
    { key: "ajustes", label: "Ajustes" }
  ],
  eso: [
    { key: "inicio", label: "Inicio" },
    { key: "aprender", label: "Aprender" },
    { key: "redes", label: "Redes Sociales" },
    { key: "retos", label: "Retos" },
    { key: "habitos", label: "Habitos" },
    { key: "examenes", label: "Examenes" },
    { key: "tea", label: "Apoyos TEA" },
    { key: "emociones", label: "Emociones" },
    { key: "diario", label: "Diario" },
    { key: "informes", label: "Informes" },
    { key: "familia", label: "Familia" },
    { key: "seguridad", label: "Seguridad" },
    { key: "ajustes", label: "Ajustes" }
  ],
  bachillerato: [
    { key: "inicio", label: "Inicio" },
    { key: "aprender", label: "Aprender" },
    { key: "redes", label: "Redes Sociales" },
    { key: "retos", label: "Retos" },
    { key: "habitos", label: "Habitos" },
    { key: "examenes", label: "Examenes" },
    { key: "informes", label: "Informes" },
    { key: "ajustes", label: "Ajustes" }
  ]
};

const STORE_KEY = "tgd_stage_selection";

export function getStageByAge(age) {
  const n = Number(age);
  if (!Number.isFinite(n) || n < 3) return null;
  return STAGES.find(s => n >= s.ageMin && n <= s.ageMax) || STAGES[STAGES.length - 1];
}

export function getCourseByAge(stage, age) {
  if (!stage || !stage.courses.length) return stage?.courses[0] || null;
  const n = Number(age);
  const idx = Math.min(Math.max(0, n - stage.ageMin), stage.courses.length - 1);
  return stage.courses[idx];
}

export function getStageById(id) {
  return STAGES.find(s => s.id === id) || null;
}

export function getAvailableTabs(stageId) {
  return STAGE_TABS[stageId] || STAGE_TABS.primaria;
}

export function saveStageSelection(data) {
  localStorage.setItem(STORE_KEY, JSON.stringify({ ...data, savedAt: new Date().toISOString() }));
}

export function loadStageSelection() {
  try { return JSON.parse(localStorage.getItem(STORE_KEY)); } catch { return null; }
}

export function clearStageSelection() {
  localStorage.removeItem(STORE_KEY);
}
STAGESEOF

echo "OK src/core/stages-data.js"

# ============================================================
# 2) Selector de edad + etapa
# ============================================================
cat << 'SELECTOREOF' > src/modules/stage-selector/stage-selector-view.jsx
import React, { useMemo, useState } from "react";
import { STAGES, getStageByAge, getCourseByAge, saveStageSelection } from "../../core/stages-data.js";

const AGES = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];

export default function StageSelectorView({ onSelect }) {
  const [step, setStep] = useState("age");
  const [age, setAge] = useState(null);
  const [courseId, setCourseId] = useState(null);

  const detectedStage = useMemo(() => age !== null ? getStageByAge(age) : null, [age]);
  const suggestedCourse = useMemo(() => detectedStage ? getCourseByAge(detectedStage, age) : null, [detectedStage, age]);

  function selectAge(a) {
    setAge(a);
    setCourseId(null);
    setStep("confirm");
  }

  function confirm() {
    if (!detectedStage) return;
    const finalCourse = courseId || suggestedCourse?.id;
    const selection = { age, stageId: detectedStage.id, courseId: finalCourse };
    saveStageSelection(selection);
    onSelect(selection);
  }

  if (step === "age") {
    return (
      <div className="min-h-screen bg-slate-50 flex items-center justify-center p-6">
        <div className="max-w-3xl w-full space-y-6">
          <div className="text-center space-y-3">
            <h1 className="text-3xl font-bold tracking-tight">TGD App educativa segura</h1>
            <p className="text-lg text-slate-600">Cuantos anios tiene el alumno?</p>
            <p className="text-sm text-slate-500">Esto adapta todo el contenido a su edad.</p>
          </div>

          <div className="grid grid-cols-4 sm:grid-cols-8 gap-3">
            {AGES.map(a => (
              <button key={a} onClick={() => selectAge(a)}
                className="rounded-2xl border-2 bg-white p-4 text-center hover:border-slate-900 hover:shadow-lg transition">
                <span className="text-2xl font-bold block">{a}</span>
                <span className="text-xs text-slate-500">anios</span>
              </button>
            ))}
          </div>

          <div className="text-center text-sm text-slate-500">
            <p>La app es local, cifrada y sin telemetria. La edad no se envia a ningun servidor.</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center p-6">
      <div className="max-w-2xl w-full space-y-6">
        <div className="text-center space-y-3">
          <p className="text-5xl">{detectedStage?.icon}</p>
          <h1 className="text-2xl font-bold">{age} anios → {detectedStage?.name}</h1>
          <p className="text-slate-600">{detectedStage?.description}</p>
        </div>

        <div className="rounded-2xl border bg-white p-5 space-y-4">
          <h3 className="font-semibold">Selecciona el curso</h3>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {detectedStage?.courses.map(course => {
              const isActive = (courseId || suggestedCourse?.id) === course.id;
              return (
                <button key={course.id} onClick={() => setCourseId(course.id)}
                  className={["rounded-2xl border-2 p-4 text-left transition",
                    isActive ? "bg-slate-900 text-white border-slate-900" : "bg-white hover:border-slate-400"
                  ].join(" ")}>
                  <span className="font-bold">{course.label}</span>
                </button>
              );
            })}
          </div>
        </div>

        <div className="flex flex-wrap gap-3 justify-center">
          <button onClick={() => { setStep("age"); setAge(null); setCourseId(null); }}
            className="rounded-2xl border px-5 py-3 bg-white hover:bg-slate-50">
            Cambiar edad
          </button>
          <button onClick={confirm}
            className="rounded-2xl border px-5 py-3 bg-slate-900 text-white">
            Comenzar
          </button>
        </div>
      </div>
    </div>
  );
}
SELECTOREOF

echo "OK src/modules/stage-selector/stage-selector-view.jsx"

# ============================================================
# 3) App.jsx completo con selector de edad y filtrado
# ============================================================
cat << 'APPEOF' > src/App.jsx
import React, { useEffect, useState } from "react";
import StageSelectorView from "./modules/stage-selector/stage-selector-view.jsx";
import { getStageById, getAvailableTabs, loadStageSelection, clearStageSelection } from "./core/stages-data.js";
import { resolverPerfil, listarComunidades } from "./core/curriculum-profiles.js";
import { getPinConfigMeta, generateTeacherPuk, setupPinSecurity, resetChildPinWithPuk } from "./core/pin-security.js";
import JournalView from "./modules/journal/journal-view.jsx";
import EmotionCompanion from "./modules/emotion/emotion-companion.jsx";

function Placeholder({ name }) {
  return (
    <div className="rounded-2xl border bg-white p-8 text-center space-y-3">
      <p className="text-3xl">🚧</p>
      <p className="font-bold text-lg">{name}</p>
      <p className="text-slate-600">Contenido en desarrollo para esta etapa educativa.</p>
    </div>
  );
}

function LazyModule({ load, fallbackName, props }) {
  const [Comp, setComp] = useState(null);
  const [failed, setFailed] = useState(false);
  useEffect(() => {
    let mounted = true;
    load().then(m => { if (mounted) setComp(() => m.default); }).catch(() => { if (mounted) setFailed(true); });
    return () => { mounted = false; };
  }, []);
  if (failed) return <Placeholder name={fallbackName} />;
  if (!Comp) return <div className="rounded-2xl border bg-white p-6 text-center">Cargando...</div>;
  return <Comp {...props} />;
}

function SecurityPanel() {
  const [meta, setMeta] = useState(getPinConfigMeta());
  const [childLabel, setChildLabel] = useState("Alumno");
  const [childPin, setChildPin] = useState("");
  const [teacherPuk, setTeacherPuk] = useState(generateTeacherPuk());
  const [newChildPin, setNewChildPin] = useState("");
  const [unlockPuk, setUnlockPuk] = useState("");
  const [msg, setMsg] = useState("");
  async function configure() { try { await setupPinSecurity({ childPin, teacherPuk, childLabel }); setMeta(getPinConfigMeta()); setMsg("Seguridad configurada."); } catch (e) { setMsg(e.message); } }
  async function unlock() { try { await resetChildPinWithPuk(unlockPuk, newChildPin); setMsg("PIN restablecido."); } catch (e) { setMsg(e.message); } }
  return (
    <div className="space-y-4">
      <section className="rounded-2xl border bg-white p-5 space-y-3">
        <h3 className="text-lg font-bold">PIN + PUK</h3>
        <div className="grid sm:grid-cols-3 gap-4">
          <input className="rounded-xl border px-3 py-2 w-full" value={childLabel} onChange={e => setChildLabel(e.target.value)} placeholder="Alumno" />
          <input className="rounded-xl border px-3 py-2 w-full" type="password" value={childPin} onChange={e => setChildPin(e.target.value)} placeholder="PIN alumno" />
          <div className="flex gap-2"><input className="rounded-xl border px-3 py-2 w-full" value={teacherPuk} onChange={e => setTeacherPuk(e.target.value)} /><button onClick={() => setTeacherPuk(generateTeacherPuk())} className="rounded-xl border px-3 py-2 bg-white">Generar</button></div>
        </div>
        <button onClick={configure} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Guardar</button>
        {meta && <p className="text-sm text-slate-500">Config: {meta.childLabel}</p>}
      </section>
      <section className="rounded-2xl border bg-white p-5 space-y-3">
        <h4 className="font-semibold">Recuperacion</h4>
        <div className="grid sm:grid-cols-2 gap-4">
          <input className="rounded-xl border px-3 py-2 w-full" value={unlockPuk} onChange={e => setUnlockPuk(e.target.value)} placeholder="PUK maestro" />
          <input className="rounded-xl border px-3 py-2 w-full" type="password" value={newChildPin} onChange={e => setNewChildPin(e.target.value)} placeholder="Nuevo PIN" />
        </div>
        <button onClick={unlock} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white">Restablecer</button>
        {msg && <div className="rounded-2xl border bg-sky-50 text-sky-900 p-4 text-sm">{msg}</div>}
      </section>
    </div>
  );
}

export default function App() {
  const [selection, setSelection] = useState(loadStageSelection());
  const [activeTab, setActiveTab] = useState("inicio");
  const [community, setCommunity] = useState("madrid");
  const [teaMode, setTeaMode] = useState(true);
  const [lowStim, setLowStim] = useState(true);
  const [parentPin, setParentPin] = useState("");
  const [studentName, setStudentName] = useState("Alumno");
  const [engineStats, setEngineStats] = useState(null);

  const perfil = resolverPerfil(community);
  const comunidades = listarComunidades();

  const stage = selection ? getStageById(selection.stageId) : null;
  const course = stage ? stage.courses.find(c => c.id === selection.courseId) : null;
  const tabs = selection ? getAvailableTabs(selection.stageId) : [];

  useEffect(() => {
    const meta = getPinConfigMeta();
    if (meta?.childLabel) setStudentName(meta.childLabel);
  }, []);

  function changeAge() {
    clearStageSelection();
    setSelection(null);
    setActiveTab("inicio");
  }

  if (!selection) {
    return <StageSelectorView onSelect={(sel) => setSelection(sel)} />;
  }

  const frame = lowStim ? "min-h-screen bg-slate-50 text-slate-900" : "min-h-screen bg-gradient-to-br from-violet-50 via-white to-cyan-50 text-slate-900";
  const commonProps = { teaMode, lowStim, parentPin };

  function renderTab() {
    switch (activeTab) {
      case "inicio":
        return (
          <div className="space-y-4">
            <section className="rounded-2xl border bg-white p-5 space-y-4">
              <h2 className="text-xl font-bold">Bienvenido</h2>
              <p className="text-slate-600">{stage?.icon} {stage?.name} — {course?.label} ({selection.age} anios)</p>
              <div className="grid sm:grid-cols-4 gap-4">
                <div className="space-y-2">
                  <label className="block text-sm font-medium">Comunidad</label>
                  <select className="rounded-xl border px-3 py-2 w-full bg-white" value={community} onChange={e => setCommunity(e.target.value)}>
                    {comunidades.map(c => <option key={c} value={c}>{c}</option>)}
                  </select>
                </div>
                <div className="space-y-2">
                  <label className="block text-sm font-medium">Alumno</label>
                  <input className="rounded-xl border px-3 py-2 w-full" value={studentName} onChange={e => setStudentName(e.target.value)} />
                </div>
                <button onClick={() => setTeaMode(!teaMode)} className={["rounded-2xl border p-3 text-left", teaMode ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>
                  TEA: {teaMode ? "ON" : "OFF"}
                </button>
                <button onClick={() => setLowStim(!lowStim)} className={["rounded-2xl border p-3 text-left", lowStim ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>
                  Baja estimulacion: {lowStim ? "ON" : "OFF"}
                </button>
              </div>
            </section>
            <section className="rounded-2xl border bg-white p-5 space-y-3">
              <h3 className="font-semibold">Perfil: {perfil.nombre}</h3>
              <div className="grid sm:grid-cols-5 gap-3 text-sm">
                {Object.entries(perfil.enfoque).map(([k, v]) => (
                  <div key={k} className="rounded-xl border p-3">
                    <p className="font-medium capitalize">{k}</p>
                    <p className="text-slate-600 text-xs mt-1">{v}</p>
                  </div>
                ))}
              </div>
            </section>
          </div>
        );
      case "aprender": return <LazyModule load={() => import("./modules/learning/quiz-view.jsx")} fallbackName="Aprender" props={{ perfil: perfil.key, ...commonProps, onStatsUpdate: setEngineStats }} />;
      case "tutor": return <LazyModule load={() => import("./modules/emotional-tutor/emotional-tutor-view.jsx")} fallbackName="Tutor emocional" props={{ teaMode }} />;
      case "profesor": return <LazyModule load={() => import("./modules/teacher/teacher-dashboard.jsx")} fallbackName="Panel profesor" props={{}} />;
      case "redes": return <LazyModule load={() => import("./modules/social/social-view.jsx")} fallbackName="Redes Sociales" props={commonProps} />;
      case "retos": return <LazyModule load={() => import("./modules/challenges/challenges-view.jsx")} fallbackName="Retos" props={commonProps} />;
      case "historias": return <LazyModule load={() => import("./modules/social/social-stories-view.jsx")} fallbackName="Historias Sociales" props={commonProps} />;
      case "habitos": return <LazyModule load={() => import("./modules/habits/habits-view.jsx")} fallbackName="Habitos" props={commonProps} />;
      case "examenes": return <LazyModule load={() => import("./modules/exams/exams-view.jsx")} fallbackName="Examenes" props={{ perfil: perfil.key, perfilNombre: perfil.nombre, studentName }} />;
      case "juegos": return <LazyModule load={() => import("./modules/games/games-view.jsx")} fallbackName="Juegos" props={{}} />;
      case "tea": return <LazyModule load={() => import("./modules/tea/tea-support-view.jsx")} fallbackName="Apoyos TEA" props={{}} />;
      case "rutinas": return <LazyModule load={() => import("./modules/routines/routines-view.jsx")} fallbackName="Rutinas" props={commonProps} />;
      case "emociones": return <EmotionCompanion />;
      case "diario": return <JournalView parentPin={parentPin} teaMode={teaMode} lowStim={lowStim} />;
      case "familia": return <LazyModule load={() => import("./modules/family/family-view.jsx")} fallbackName="Familia" props={commonProps} />;
      case "informes": return <LazyModule load={() => import("./modules/reports/reports-view.jsx")} fallbackName="Informes" props={{ engineStats, studentName, perfilNombre: perfil.nombre }} />;
      case "seguridad": return <LazyModule load={() => import("./modules/security/security-center.jsx")} fallbackName="Seguridad" props={{}} />;
      case "ajustes": return <SecurityPanel />;
      default: return <Placeholder name="Seccion no encontrada" />;
    }
  }

  return (
    <div className={frame}>
      <div className="max-w-6xl mx-auto p-4 md:p-6 space-y-4">
        <header className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-2xl md:text-3xl font-bold tracking-tight">TGD App educativa segura</h1>
            <p className="text-sm text-slate-600">
              {stage?.icon} {stage?.name} — {course?.label} · {selection.age} anios · {perfil.nombre}
            </p>
          </div>
          <div className="flex flex-wrap gap-2">
            {engineStats?.levelInfo && (
              <span className="rounded-2xl border bg-white px-3 py-2 text-sm">
                {engineStats.levelInfo.icon} {engineStats.levelInfo.name} · {engineStats.levelInfo.totalPoints} pts
              </span>
            )}
            <button onClick={changeAge} className="rounded-2xl border px-3 py-2 bg-white hover:bg-slate-50 text-sm">
              Cambiar edad
            </button>
          </div>
        </header>

        <nav className="flex flex-wrap gap-2">
          {tabs.map(tab => (
            <button key={tab.key} onClick={() => setActiveTab(tab.key)}
              className={["rounded-2xl border px-4 py-3 text-sm font-medium transition",
                activeTab === tab.key ? "bg-slate-900 text-white border-slate-900" : "bg-white hover:bg-slate-50 border-slate-200"
              ].join(" ")}>
              {tab.label}
            </button>
          ))}
        </nav>

        {renderTab()}
      </div>
    </div>
  );
}
APPEOF

echo "OK src/App.jsx"

echo ""
echo "============================================================"
echo "  FASE 11 COMPLETADA"
echo "============================================================"
echo ""
echo "  Anadido:"
echo "   - Selector de edad (3-18) como primera pantalla"
echo "   - Deteccion automatica de etapa segun edad"
echo "   - Selector de curso dentro de cada etapa"
echo "   - Filtrado de navegacion segun etapa"
echo "   - Boton 'Cambiar edad' siempre visible"
echo "   - Lazy loading de modulos (sin top-level await)"
echo "   - Placeholder para modulos en desarrollo"
echo ""
echo "  Ejecuta: npm run dev"
echo ""
