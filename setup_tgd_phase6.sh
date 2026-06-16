#!/bin/bash
# ============================================================
# setup_tgd_phase6.sh
# Fase 6: hábitos saludables, historias sociales ampliadas,
# más retos sociales y quiz de nutrición/deporte.
# Ejecutar desde: ~/Escritorio/TGD/
# ============================================================
set -e

echo ""
echo "🌱 Fase 6: instalando hábitos saludables, historias sociales y más retos..."
echo ""

mkdir -p src/core
mkdir -p src/modules/habits
mkdir -p src/modules/social
mkdir -p src/modules/challenges

# ============================================================
# 1) Preguntas y quiz de hábitos saludables, nutrición y deporte
# ============================================================
cat << 'EOF' > src/core/questions-habits.js
export const HABITS_QUESTIONS = [
  // Alimentación / nutrición
  { id: "habit_001", topic: "nutricion", nivel: "basico", pregunta: "¿Qué opción es un desayuno más equilibrado?", opciones: ["Bollería y refresco", "Fruta, lácteo y cereal", "Solo chucherías"], correcta: 1, explicacion: "Un desayuno equilibrado combina varios grupos de alimentos." },
  { id: "habit_002", topic: "nutricion", nivel: "basico", pregunta: "Beber agua es importante porque", opciones: ["El cuerpo la necesita para funcionar bien", "Solo sirve en verano", "No importa"], correcta: 0, explicacion: "El agua ayuda a muchas funciones del cuerpo." },
  { id: "habit_003", topic: "nutricion", nivel: "basico", pregunta: "Una merienda saludable puede ser", opciones: ["Fruta y yogur", "Solo golosinas", "Bebida energética"], correcta: 0, explicacion: "Una merienda saludable aporta energía y nutrientes." },
  { id: "habit_004", topic: "nutricion", nivel: "medio", pregunta: "Comer muchas frutas y verduras ayuda a", opciones: ["Cuidar la salud", "Dormir menos", "No hacer ejercicio"], correcta: 0, explicacion: "Frutas y verduras aportan vitaminas, fibra y otros nutrientes." },
  { id: "habit_005", topic: "nutricion", nivel: "medio", pregunta: "Leer etiquetas de alimentos sirve para", opciones: ["Saber qué estás consumiendo", "Decorar la cocina", "Perder tiempo"], correcta: 0, explicacion: "Las etiquetas ayudan a conocer ingredientes y cantidades." },
  { id: "habit_006", topic: "nutricion", nivel: "medio", pregunta: "Tomar demasiadas bebidas azucaradas puede", opciones: ["No afectar nunca", "Ser poco saludable", "Sustituir el agua"], correcta: 1, explicacion: "Las bebidas muy azucaradas conviene tomarlas con moderación." },
  { id: "habit_007", topic: "nutricion", nivel: "avanzado", pregunta: "Una dieta equilibrada suele incluir", opciones: ["Variedad y moderación", "Solo dulces", "Solo fritos"], correcta: 0, explicacion: "Comer variado en cantidades adecuadas ayuda a la salud." },
  { id: "habit_008", topic: "nutricion", nivel: "avanzado", pregunta: "Planificar menús saludables puede ayudar a", opciones: ["Elegir mejor los alimentos", "Comer peor", "Olvidar las comidas"], correcta: 0, explicacion: "Planificar facilita tomar decisiones más saludables." },

  // Salud general / hábitos diarios
  { id: "habit_009", topic: "salud", nivel: "basico", pregunta: "Dormir bien ayuda a", opciones: ["Descansar y aprender mejor", "Estar más cansado", "No recordar nada"], correcta: 0, explicacion: "El descanso es importante para el cuerpo y la mente." },
  { id: "habit_010", topic: "salud", nivel: "basico", pregunta: "Lavarse las manos es importante", opciones: ["Antes de comer y después de ir al baño", "Nunca hace falta", "Solo una vez a la semana"], correcta: 0, explicacion: "Lavarse las manos ayuda a prevenir enfermedades." },
  { id: "habit_011", topic: "salud", nivel: "basico", pregunta: "Cepillarse los dientes ayuda a", opciones: ["Cuidar la salud bucal", "Dormir más", "Ver mejor"], correcta: 0, explicacion: "La higiene dental es un hábito saludable básico." },
  { id: "habit_012", topic: "salud", nivel: "medio", pregunta: "Pasar muchas horas sentado sin descansar puede", opciones: ["No importar", "Ser poco saludable", "Mejorar la respiración"], correcta: 1, explicacion: "Conviene moverse y hacer pausas activas." },
  { id: "habit_013", topic: "salud", nivel: "medio", pregunta: "Si te encuentras mal durante una actividad física, lo mejor es", opciones: ["Seguir sin parar", "Parar y avisar a un adulto", "Correr más"], correcta: 1, explicacion: "Si algo duele o preocupa, hay que parar y pedir ayuda." },
  { id: "habit_014", topic: "salud", nivel: "medio", pregunta: "Tener rutinas de sueño regulares ayuda a", opciones: ["Dormir y descansar mejor", "No influir en nada", "Comer más rápido"], correcta: 0, explicacion: "Las rutinas estables favorecen un mejor descanso." },
  { id: "habit_015", topic: "salud", nivel: "avanzado", pregunta: "Un hábito saludable sostenido en el tiempo es", opciones: ["Una costumbre buena repetida", "Algo que solo haces una vez", "Un castigo"], correcta: 0, explicacion: "Los hábitos se construyen con pequeñas repeticiones." },
  { id: "habit_016", topic: "salud", nivel: "avanzado", pregunta: "Combinar descanso, alimentación y ejercicio ayuda a", opciones: ["El bienestar general", "No aprender", "Eliminar el sueño"], correcta: 0, explicacion: "La salud se apoya en varios hábitos que trabajan juntos." },

  // Deporte / actividad física
  { id: "habit_017", topic: "deporte", nivel: "basico", pregunta: "Mover el cuerpo cada día ayuda a", opciones: ["Cuidar músculos y corazón", "No sirve para nada", "Dormir menos"], correcta: 0, explicacion: "La actividad física ayuda al cuerpo y al ánimo." },
  { id: "habit_018", topic: "deporte", nivel: "basico", pregunta: "Antes de hacer deporte conviene", opciones: ["Calentar un poco", "No beber nunca", "Empezar de golpe"], correcta: 0, explicacion: "Calentar ayuda a preparar el cuerpo." },
  { id: "habit_019", topic: "deporte", nivel: "basico", pregunta: "Después de hacer ejercicio es buena idea", opciones: ["Descansar e hidratarse", "No respirar", "Comer solo chucherías"], correcta: 0, explicacion: "Después de la actividad, el cuerpo necesita recuperarse." },
  { id: "habit_020", topic: "deporte", nivel: "medio", pregunta: "Un deporte de equipo ayuda también a", opciones: ["Cooperar y respetar normas", "Ignorar a otros", "Pelearse"], correcta: 0, explicacion: "Además del ejercicio, se trabajan valores sociales." },
  { id: "habit_021", topic: "deporte", nivel: "medio", pregunta: "Usar ropa y calzado adecuados en deporte sirve para", opciones: ["Estar más seguro y cómodo", "No importa", "Solo correr más"], correcta: 0, explicacion: "El material adecuado ayuda a prevenir molestias y lesiones." },
  { id: "habit_022", topic: "deporte", nivel: "medio", pregunta: "La actividad física moderada puede mejorar", opciones: ["El estado de ánimo", "Solo el hambre", "Nada"], correcta: 0, explicacion: "Moverse puede ayudar a sentirse mejor emocionalmente." },
  { id: "habit_023", topic: "deporte", nivel: "avanzado", pregunta: "Una rutina deportiva saludable necesita", opciones: ["Constancia y descanso", "Solo intensidad máxima", "No planificar nada"], correcta: 0, explicacion: "Entrenar bien incluye constancia, progresión y descanso." },
  { id: "habit_024", topic: "deporte", nivel: "avanzado", pregunta: "Escuchar a tu cuerpo durante el esfuerzo significa", opciones: ["Parar si hay dolor o malestar", "Ignorar cualquier señal", "Competir siempre"], correcta: 0, explicacion: "Escuchar al cuerpo ayuda a prevenir problemas." },

  // Hábitos diarios / autonomía
  { id: "habit_025", topic: "rutinas", nivel: "basico", pregunta: "Preparar la mochila la noche antes puede ayudar a", opciones: ["Ir con más calma al cole", "Perder más cosas", "Dormir peor"], correcta: 0, explicacion: "La organización reduce el estrés por la mañana." },
  { id: "habit_026", topic: "rutinas", nivel: "basico", pregunta: "Tener un horario visual sirve para", opciones: ["Saber qué toca y anticiparte", "Confundirte más", "Olvidarlo todo"], correcta: 0, explicacion: "Los apoyos visuales ayudan mucho a la organización." },
  { id: "habit_027", topic: "rutinas", nivel: "medio", pregunta: "Dividir una tarea grande en pasos pequeños ayuda a", opciones: ["Sentirse más capaz", "No hacerla", "Tardarlo todo"], correcta: 0, explicacion: "Pequeños pasos facilitan empezar y continuar." },
  { id: "habit_028", topic: "rutinas", nivel: "medio", pregunta: "Usar una lista de verificación puede servir para", opciones: ["Ir marcando lo que ya hice", "Borrar el trabajo", "Saltar pasos"], correcta: 0, explicacion: "Las listas ayudan a revisar y organizarse." },
  { id: "habit_029", topic: "rutinas", nivel: "avanzado", pregunta: "Una rutina saludable bien diseñada suele ser", opciones: ["Predecible y flexible a la vez", "Caótica siempre", "Inútil"], correcta: 0, explicacion: "La rutina ayuda, pero también debe poder adaptarse." },
  { id: "habit_030", topic: "rutinas", nivel: "avanzado", pregunta: "Tener hábitos de autocuidado ayuda a", opciones: ["La autonomía personal", "Depender más de todo", "No descansar"], correcta: 0, explicacion: "El autocuidado favorece la autonomía y el bienestar." }
];

export function getHabitQuestionsByTopic(topic) {
  return HABITS_QUESTIONS.filter((q) => q.topic === topic);
}

export function getRandomHabitQuestions(topic, count = 5) {
  let pool = topic ? getHabitQuestionsByTopic(topic) : [...HABITS_QUESTIONS];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, count);
}
EOF

echo "✅ src/core/questions-habits.js"

# ============================================================
# 2) Historias sociales ampliadas
# ============================================================
cat << 'EOF' > src/core/social-stories-data.js
export const SOCIAL_STORIES_DATA = [
  {
    id: "story_001",
    category: "internet",
    title: "Si algo me preocupa en internet",
    intro: "A veces puedo ver o recibir algo en internet que me incomoda o me asusta.",
    steps: [
      "Paro y no sigo mirando.",
      "No respondo si me hace sentir peor.",
      "Respiro despacio una vez.",
      "Se lo cuento a un adulto de confianza."
    ],
    closing: "Pedir ayuda es una forma de cuidarme."
  },
  {
    id: "story_002",
    category: "escuela",
    title: "Si no entiendo una consigna",
    intro: "A veces una tarea me parece larga o difícil.",
    steps: [
      "Miro solo la primera parte.",
      "Busco una palabra clave.",
      "Hago un paso pequeño.",
      "Pido ayuda si la necesito."
    ],
    closing: "Puedo avanzar poco a poco."
  },
  {
    id: "story_003",
    category: "emociones",
    title: "Si me pongo nervioso con una red social",
    intro: "A veces algo que veo online me hace sentir nervioso o triste.",
    steps: [
      "Cierro la app un momento.",
      "Bebo agua o respiro.",
      "Pienso qué emoción siento.",
      "Lo hablo con alguien de confianza."
    ],
    closing: "No estoy solo. Pedir ayuda está bien."
  },
  {
    id: "story_004",
    category: "amigos",
    title: "Si un compañero se enfada conmigo",
    intro: "A veces un compañero puede enfadarse o hablar de manera brusca.",
    steps: [
      "Intento hablar con voz tranquila.",
      "Escucho lo que ha pasado.",
      "Busco ayuda si el conflicto sigue.",
      "Recuerdo que un problema tiene solución."
    ],
    closing: "Puedo aprender maneras seguras de resolver conflictos."
  },
  {
    id: "story_005",
    category: "rutinas",
    title: "Si me cuesta empezar una tarea",
    intro: "A veces empezar es la parte más difícil.",
    steps: [
      "Preparo el lugar de trabajo.",
      "Miro qué necesito.",
      "Empiezo por un paso de 2 minutos.",
      "Celebro haber empezado."
    ],
    closing: "Empezar pequeño también es avanzar."
  },
  {
    id: "story_006",
    category: "salud",
    title: "Si noto que mi cuerpo necesita descanso",
    intro: "A veces mi cuerpo me manda señales de cansancio.",
    steps: [
      "Paro un momento.",
      "Respiro y noto cómo estoy.",
      "Bebo agua o me siento un rato.",
      "Le digo a un adulto cómo me siento."
    ],
    closing: "Escuchar mi cuerpo me ayuda a cuidarme."
  }
];

export function getStoriesByCategory(category) {
  return SOCIAL_STORIES_DATA.filter((s) => s.category === category);
}
EOF

echo "✅ src/core/social-stories-data.js"

# ============================================================
# 3) Retos sociales y de hábitos
# ============================================================
cat << 'EOF' > src/core/social-challenges-extra.js
export const EXTRA_SOCIAL_CHALLENGES = [
  {
    id: "extra_ch_001",
    category: "social",
    title: "Rumor en un grupo",
    situation: "En un grupo empiezan a hablar mal de un compañero y te animan a participar.",
    options: [
      "Participo para encajar",
      "No participo y puedo avisar a un adulto",
      "Reenvío el rumor"
    ],
    correct: 1,
    explanation: "No participar en rumores protege la convivencia y evita daño a otras personas.",
    teaHint: "Si algo hace daño, puedo parar y pedir ayuda."
  },
  {
    id: "extra_ch_002",
    category: "social",
    title: "Foto en una fiesta",
    situation: "Quieres subir una foto donde aparecen otras personas del cole.",
    options: [
      "La subo sin pensar",
      "Pido permiso antes de compartirla",
      "La envío a personas desconocidas"
    ],
    correct: 1,
    explanation: "Pedir permiso demuestra respeto y cuida la privacidad.",
    teaHint: "Pedir permiso = respeto."
  },
  {
    id: "extra_ch_003",
    category: "salud",
    title: "Saltarte la merienda",
    situation: "Te notas cansado por la tarde y no has merendado nada.",
    options: [
      "Sigo sin comer ni beber",
      "Elijo una merienda saludable e hidratarme",
      "Solo tomo refresco"
    ],
    correct: 1,
    explanation: "Una merienda equilibrada y el agua ayudan a recuperar energía.",
    teaHint: "Comida saludable + agua puede ayudar al cuerpo."
  },
  {
    id: "extra_ch_004",
    category: "deporte",
    title: "Antes de correr",
    situation: "Vas a empezar a correr en educación física.",
    options: [
      "Empiezo muy fuerte sin preparar el cuerpo",
      "Caliento un poco y reviso cómo me siento",
      "No bebo agua nunca"
    ],
    correct: 1,
    explanation: "Calentar y revisar cómo te sientes ayuda a hacer deporte con más seguridad.",
    teaHint: "Prepararme antes me ayuda a estar mejor."
  },
  {
    id: "extra_ch_005",
    category: "rutinas",
    title: "Cinco tareas a la vez",
    situation: "Tienes varias cosas por hacer y te sientes bloqueado.",
    options: [
      "Intento hacerlas todas a la vez",
      "Hago una lista y empiezo por una pequeña",
      "Lo dejo todo sin mirar"
    ],
    correct: 1,
    explanation: "Elegir un paso pequeño ayuda a empezar y reduce la sensación de bloqueo.",
    teaHint: "Una tarea pequeña cada vez."
  }
];
EOF

echo "✅ src/core/social-challenges-extra.js"

# ============================================================
# 4) Módulo de historias sociales
# ============================================================
cat << 'EOF' > src/modules/social/social-stories-view.jsx
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
EOF

echo "✅ src/modules/social/social-stories-view.jsx"

# ============================================================
# 5) Módulo de hábitos saludables
# ============================================================
cat << 'EOF' > src/modules/habits/habits-view.jsx
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
EOF

echo "✅ src/modules/habits/habits-view.jsx"

# ============================================================
# 6) ChallengesView ampliado con retos extra sociales/hábitos
# ============================================================
cat << 'EOF' > src/modules/challenges/challenges-view.jsx
import React, { useMemo, useState } from "react";
import { buildSecurityChallengePack, scoreChallengePack, getChallengeTips } from "../../core/challenges-engine.js";
import { EXTRA_SOCIAL_CHALLENGES } from "../../core/social-challenges-extra.js";

function ChallengeOption({ active, onClick, children }) {
  return <button onClick={onClick} className={["rounded-2xl border px-4 py-4 text-left w-full", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>{children}</button>;
}

function ChallengeScenarioBlock({ item, answer, onAnswer, teaMode }) {
  return (
    <div className="rounded-2xl border bg-white p-5 space-y-4">
      <div className="flex items-center justify-between gap-3">
        <h3 className="font-semibold">{item.title}</h3>
        {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Paso a paso</span>}
      </div>
      <p className="text-lg font-medium leading-relaxed">{item.situation}</p>
      <div className="grid gap-3">
        {item.options.map((opt, i) => <ChallengeOption key={i} active={answer === i} onClick={() => onAnswer(i)}>{opt}</ChallengeOption>)}
      </div>
      {item.teaHint && <div className="rounded-2xl border bg-sky-50 text-sky-900 p-3 text-sm">Pista TEA: {item.teaHint}</div>}
    </div>
  );
}

export default function ChallengesView({ teaMode = true, lowStim = true }) {
  const [mode, setMode] = useState("digital");
  const [pack, setPack] = useState(() => buildSecurityChallengePack());
  const [phase, setPhase] = useState("scenario");
  const [index, setIndex] = useState(0);
  const [scenarioAnswers, setScenarioAnswers] = useState([]);
  const [quizAnswers, setQuizAnswers] = useState([]);
  const [finished, setFinished] = useState(false);
  const [extraAnswers, setExtraAnswers] = useState([]);
  const tips = useMemo(() => getChallengeTips(), []);
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  const currentScenario = pack.scenarios[index];
  const currentQuiz = pack.quiz[index];
  const totalPerSection = 3;
  const extraCurrent = EXTRA_SOCIAL_CHALLENGES[index];

  function startMode(next) {
    setMode(next);
    setPhase("scenario");
    setIndex(0);
    setScenarioAnswers([]);
    setQuizAnswers([]);
    setExtraAnswers([]);
    setFinished(false);
    setPack(buildSecurityChallengePack());
  }

  function chooseScenario(option) {
    const copy = [...scenarioAnswers];
    copy[index] = option;
    setScenarioAnswers(copy);
  }

  function chooseQuiz(option) {
    const copy = [...quizAnswers];
    copy[index] = option;
    setQuizAnswers(copy);
  }

  function chooseExtra(option) {
    const copy = [...extraAnswers];
    copy[index] = option;
    setExtraAnswers(copy);
  }

  function next() {
    if (mode === "digital") {
      if (phase === "scenario") {
        if (index < totalPerSection - 1) setIndex((i) => i + 1);
        else { setPhase("quiz"); setIndex(0); }
      } else {
        if (index < totalPerSection - 1) setIndex((i) => i + 1);
        else setFinished(true);
      }
    } else {
      if (index < EXTRA_SOCIAL_CHALLENGES.length - 1) setIndex((i) => i + 1);
      else setFinished(true);
    }
  }

  function resetAll() {
    startMode(mode);
  }

  let score = null;
  if (finished) {
    if (mode === "digital") {
      score = scoreChallengePack(pack, scenarioAnswers, quizAnswers);
    } else {
      const correct = EXTRA_SOCIAL_CHALLENGES.filter((item, idx) => extraAnswers[idx] === item.correct).length;
      const total = EXTRA_SOCIAL_CHALLENGES.length;
      const percent = total > 0 ? Math.round((correct / total) * 100) : 0;
      score = { total, correct, percent, points: correct * 15 + (percent >= 80 ? 20 : 0), passed: percent >= 70 };
    }
  }

  if (finished && score) {
    return (
      <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
        <div className="flex flex-wrap gap-2">
          <button onClick={() => startMode("digital")} className={["rounded-2xl border px-4 py-2", mode === "digital" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Seguridad digital</button>
          <button onClick={() => startMode("social")} className={["rounded-2xl border px-4 py-2", mode === "social" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Retos sociales y hábitos</button>
        </div>
        <h2 className="text-xl font-bold">🛡️ Resultados de retos</h2>
        <div className="grid sm:grid-cols-3 gap-4">
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{score.percent}%</p><p className="text-sm text-slate-600">Resultado</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{score.correct}/{score.total}</p><p className="text-sm text-slate-600">Correctas</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">+{score.points}</p><p className="text-sm text-slate-600">Puntos</p></div>
        </div>
        <div className="rounded-2xl border bg-white p-4 space-y-2">
          <h3 className="font-semibold">Consejos clave</h3>
          {tips.map((tip, idx) => <p key={idx} className="text-sm text-slate-700">• {tip}</p>)}
        </div>
        <div className="flex flex-wrap gap-3">
          <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Nuevo reto</button>
        </div>
      </div>
    );
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div>
        <h2 className="text-xl font-bold">🛡️ Retos y desafíos</h2>
        <p className="text-sm text-slate-600">Entrena decisiones seguras, sociales y saludables con retos paso a paso.</p>
      </div>
      <div className="flex flex-wrap gap-2">
        <button onClick={() => startMode("digital")} className={["rounded-2xl border px-4 py-2", mode === "digital" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Seguridad digital</button>
        <button onClick={() => startMode("social")} className={["rounded-2xl border px-4 py-2", mode === "social" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Retos sociales y hábitos</button>
      </div>

      {mode === "digital" ? (
        <div className="rounded-2xl border bg-white p-5 space-y-4">
          <div className="flex items-center justify-between gap-3">
            <h3 className="font-semibold">{phase === "scenario" ? `Escenario ${index + 1} de ${totalPerSection}` : `Mini quiz ${index + 1} de ${totalPerSection}`}</h3>
            {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Paso a paso</span>}
          </div>
          {phase === "scenario" ? (
            <ChallengeScenarioBlock item={currentScenario} answer={scenarioAnswers[index]} onAnswer={chooseScenario} teaMode={teaMode} />
          ) : (
            <div className="space-y-4">
              <p className="text-lg font-medium leading-relaxed">{currentQuiz.pregunta}</p>
              <div className="grid gap-3">
                {currentQuiz.opciones.map((opt, i) => <ChallengeOption key={i} active={quizAnswers[index] === i} onClick={() => chooseQuiz(i)}>{opt}</ChallengeOption>)}
              </div>
            </div>
          )}
          <div className="flex flex-wrap gap-3">
            <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{phase === "quiz" && index === totalPerSection - 1 ? "Finalizar reto" : "Siguiente"}</button>
            <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
          </div>
        </div>
      ) : (
        <div className="space-y-4">
          <p className="text-sm text-slate-600">Reto {index + 1} de {EXTRA_SOCIAL_CHALLENGES.length}</p>
          <ChallengeScenarioBlock item={extraCurrent} answer={extraAnswers[index]} onAnswer={chooseExtra} teaMode={teaMode} />
          <div className="flex flex-wrap gap-3">
            <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{index === EXTRA_SOCIAL_CHALLENGES.length - 1 ? "Finalizar reto" : "Siguiente"}</button>
            <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
          </div>
        </div>
      )}
    </div>
  );
}
EOF

echo "✅ src/modules/challenges/challenges-view.jsx"

# ============================================================
# 7) Actualización App.jsx con hábitos e historias sociales
# ============================================================
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
import { resolverPerfil, listarComunidades } from "./core/curriculum-profiles.js";
import { generateTeacherPuk, getPinConfigMeta, setupPinSecurity, resetChildPinWithPuk } from "./core/pin-security.js";

const TABS = [
  { key: "inicio", icon: "🏠", label: "Inicio" },
  { key: "aprender", icon: "📚", label: "Aprender" },
  { key: "redes", icon: "🌐", label: "Redes Sociales" },
  { key: "retos", icon: "🛡️", label: "Retos" },
  { key: "historias", icon: "📘", label: "Historias Sociales" },
  { key: "habitos", icon: "🌱", label: "Hábitos Saludables" },
  { key: "examenes", icon: "📝", label: "Exámenes" },
  { key: "juegos", icon: "🎮", label: "Juegos" },
  { key: "tea", icon: "🧩", label: "Apoyos TEA" },
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
              <p className="text-slate-600">Configura comunidad, accesibilidad y nombre del alumno. La app adapta las preguntas LOMLOE a tu perfil y añade ciudadanía digital, hábitos saludables e historias sociales.</p>
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
        {activeTab === "redes" && <SocialView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "retos" && <ChallengesView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "historias" && <SocialStoriesView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "habitos" && <HabitsView teaMode={teaMode} lowStim={lowStim} />}
        {activeTab === "examenes" && <ExamsView perfil={perfil.key} perfilNombre={perfil.nombre} studentName={studentName} />}
        {activeTab === "juegos" && <GamesView />}
        {activeTab === "tea" && <TeaSupportView />}
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
# 8) Resumen final
# ============================================================
echo ""
echo "============================================================"
echo "  FASE 6 COMPLETADA"
echo "============================================================"
echo ""
echo "  Añadido:"
echo "   • Módulo de historias sociales"
echo "   • Módulo de hábitos saludables"
echo "   • Quiz de nutrición, salud y deporte"
echo "   • Más retos sociales y de hábitos"
echo "   • Mejoras para TEA/TGD/Asperger"
echo ""
echo "  Ahora ejecuta: npm run dev"
echo ""
