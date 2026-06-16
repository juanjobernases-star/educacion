#!/bin/bash
set -e
echo ""
echo "🧡 Fase 3: Compañero emocional + Autoestima + Respiración"
echo ""
mkdir -p src/core
mkdir -p src/modules/journal

# ============================================================
# 1. src/core/emotional-support.js
# ============================================================
cat << 'EMOSUPPORT_EOF' > src/core/emotional-support.js
export const BREATHING_EXERCISES = [
  {
    id: "vela_pastel",
    name: "La vela y el pastel",
    icon: "🎂",
    forMood: ["triste", "cansado"],
    description: "Imagina un pastel con una vela. Huele el pastel y sopla la vela.",
    steps: [
      { icon: "🎂", text: "Imagina que tienes un pastel delante", duration: 3 },
      { icon: "👃", text: "Huele el pastel… inspira por la nariz", duration: 4 },
      { icon: "🕯️", text: "Sopla la vela suavemente… exhala por la boca", duration: 5 },
      { icon: "😌", text: "Muy bien. Vamos a repetirlo", duration: 2 },
      { icon: "👃", text: "Inspira otra vez… huele el pastel", duration: 4 },
      { icon: "🕯️", text: "Sopla… la vela se apaga", duration: 5 },
      { icon: "⭐", text: "Genial. Una vez más", duration: 2 },
      { icon: "👃", text: "Inspira profundo…", duration: 4 },
      { icon: "🕯️", text: "Sopla despacio…", duration: 5 },
      { icon: "🌟", text: "¡Lo has hecho muy bien! ¿Te sientes un poco mejor?", duration: 0 }
    ]
  },
  {
    id: "cuadrada",
    name: "Respiración cuadrada",
    icon: "⬜",
    forMood: ["nervioso", "enfadado"],
    description: "Respira siguiendo un cuadrado: inspira, mantén, suelta, espera.",
    steps: [
      { icon: "▶️", text: "Inspira contando: 1… 2… 3… 4…", duration: 4 },
      { icon: "⏸️", text: "Mantén el aire: 1… 2… 3… 4…", duration: 4 },
      { icon: "◀️", text: "Suelta el aire: 1… 2… 3… 4…", duration: 4 },
      { icon: "⏸️", text: "Espera: 1… 2… 3… 4…", duration: 4 },
      { icon: "▶️", text: "Otra vez. Inspira: 1… 2… 3… 4…", duration: 4 },
      { icon: "⏸️", text: "Mantén: 1… 2… 3… 4…", duration: 4 },
      { icon: "◀️", text: "Suelta: 1… 2… 3… 4…", duration: 4 },
      { icon: "⏸️", text: "Espera: 1… 2… 3… 4…", duration: 4 },
      { icon: "▶️", text: "Última vez. Inspira…", duration: 4 },
      { icon: "⏸️", text: "Mantén…", duration: 4 },
      { icon: "◀️", text: "Suelta…", duration: 4 },
      { icon: "🌟", text: "¡Perfecto! Has completado la respiración cuadrada.", duration: 0 }
    ]
  },
  {
    id: "mano_estrella",
    name: "La mano estrella",
    icon: "⭐",
    forMood: ["enfadado", "nervioso"],
    description: "Recorre tus dedos con el otro dedo. Subir = inspira, bajar = exhala.",
    steps: [
      { icon: "✋", text: "Extiende tu mano como una estrella", duration: 3 },
      { icon: "☝️", text: "Sube por el pulgar… inspira", duration: 4 },
      { icon: "👇", text: "Baja por el pulgar… exhala", duration: 4 },
      { icon: "☝️", text: "Sube por el índice… inspira", duration: 4 },
      { icon: "👇", text: "Baja por el índice… exhala", duration: 4 },
      { icon: "☝️", text: "Sube por el corazón… inspira", duration: 4 },
      { icon: "👇", text: "Baja por el corazón… exhala", duration: 4 },
      { icon: "☝️", text: "Sube por el anular… inspira", duration: 4 },
      { icon: "👇", text: "Baja por el anular… exhala", duration: 4 },
      { icon: "☝️", text: "Sube por el meñique… inspira", duration: 4 },
      { icon: "👇", text: "Baja por el meñique… exhala", duration: 4 },
      { icon: "🌟", text: "¡Has recorrido toda tu mano estrella! ¿Notas la calma?", duration: 0 }
    ]
  },
  {
    id: "tortuga",
    name: "La técnica de la tortuga",
    icon: "🐢",
    forMood: ["enfadado", "nervioso"],
    description: "Como la tortuga, escóndete en tu caparazón, respira y luego piensa.",
    steps: [
      { icon: "🛑", text: "PARA. Di 'tortuga' en tu cabeza", duration: 3 },
      { icon: "🐢", text: "ESCÓNDETE. Cruza los brazos, baja la cabeza, cierra los ojos", duration: 5 },
      { icon: "🫁", text: "RESPIRA. Dentro del caparazón, respira despacio… 1…", duration: 4 },
      { icon: "🫁", text: "Respira otra vez… 2…", duration: 4 },
      { icon: "🫁", text: "Y una más… 3…", duration: 4 },
      { icon: "💡", text: "PIENSA. ¿Cómo me siento? ¿Qué puedo hacer?", duration: 5 },
      { icon: "🚀", text: "SAL del caparazón cuando estés preparado", duration: 3 },
      { icon: "🌟", text: "¡Muy bien! Has usado la técnica de la tortuga. Eso es ser valiente.", duration: 0 }
    ]
  },
  {
    id: "ola",
    name: "La respiración de la ola",
    icon: "🌊",
    forMood: ["cansado", "triste", "nervioso"],
    description: "Eres una ola del mar. Sube y baja con calma.",
    steps: [
      { icon: "🏖️", text: "Imagina que estás en la playa, muy tranquilo", duration: 3 },
      { icon: "🌊", text: "La ola sube… inspira lento… 1… 2… 3… 4… 5…", duration: 5 },
      { icon: "🏖️", text: "La ola baja… exhala lento… 1… 2… 3… 4… 5… 6… 7…", duration: 7 },
      { icon: "🌊", text: "La ola sube otra vez… inspira…", duration: 5 },
      { icon: "🏖️", text: "La ola baja suavemente… exhala…", duration: 7 },
      { icon: "🌊", text: "Sube…", duration: 5 },
      { icon: "🏖️", text: "Baja…", duration: 7 },
      { icon: "🌊", text: "Sube…", duration: 5 },
      { icon: "🏖️", text: "Baja…", duration: 7 },
      { icon: "🌊", text: "Última ola… sube…", duration: 5 },
      { icon: "🏖️", text: "Y baja… siente la calma del mar…", duration: 7 },
      { icon: "🌟", text: "El mar está tranquilo. Y tú también.", duration: 0 }
    ]
  }
];

export const MOOD_RESPONSES = {
  feliz: {
    validation: "¡Qué bien que estés feliz! Es un sentimiento genial.",
    tips: [
      "Recuerda este momento. Cuando un día sea más difícil, piensa en cómo te sientes ahora.",
      "Puedes dibujar o escribir qué te ha hecho feliz. Así lo recordarás siempre.",
      "Compartir la alegría la hace más grande. ¿Quieres contarle a alguien lo bien que te sientes?"
    ],
    breathingExercise: null,
    selfEsteem: "Tu sonrisa es importante. Cuando tú estás bien, el mundo a tu alrededor también mejora.",
    showAchievements: true
  },
  tranquilo: {
    validation: "Estar tranquilo es muy bueno. Significa que tu cuerpo y tu mente están en calma.",
    tips: [
      "Este es un buen momento para aprender algo nuevo. Tu cerebro está preparado.",
      "Puedes escribir en tu diario cómo es este momento de calma.",
      "Disfruta de esta tranquilidad. Es un superpoder."
    ],
    breathingExercise: null,
    selfEsteem: "Eres capaz de encontrar la calma. Eso es una habilidad muy valiosa.",
    showAchievements: true
  },
  cansado: {
    validation: "Es normal sentirse cansado. Tu cuerpo te está diciendo que necesita descansar.",
    tips: [
      "Está bien parar. No tienes que hacer todo hoy.",
      "Beber un poco de agua puede ayudarte a sentirte mejor.",
      "Si quieres, podemos hacer una respiración suave juntos para relajarnos.",
      "Has trabajado mucho. Descansar también es importante."
    ],
    breathingExercise: "ola",
    selfEsteem: "Aunque estés cansado, mira todo lo que has conseguido. Eso demuestra tu esfuerzo.",
    showAchievements: true
  },
  nervioso: {
    validation: "Entiendo que te sientas nervioso. Es una emoción que todos sentimos a veces.",
    tips: [
      "Los nervios no son malos. Significan que algo te importa.",
      "Vamos a respirar juntos. Eso ayuda mucho.",
      "Piensa: ¿qué es lo peor que puede pasar? Seguro que no es tan grave.",
      "Cuando estés preparado, puedes intentarlo poco a poco."
    ],
    breathingExercise: "cuadrada",
    selfEsteem: "Sentir nervios y seguir adelante es de valientes. Y tú lo eres.",
    showAchievements: false
  },
  enfadado: {
    validation: "El enfado es una emoción normal. No está mal sentirla. Lo importante es qué hacemos con ella.",
    tips: [
      "Vamos a usar la técnica de la tortuga. Funciona muy bien.",
      "Cuenta hasta 10 antes de hablar o actuar. El enfado pasa.",
      "Puedes apretar una pelota imaginaria con las manos y luego soltar.",
      "Está bien decir: 'estoy enfadado'. Nombrar lo que sientes ayuda mucho."
    ],
    breathingExercise: "tortuga",
    selfEsteem: "Que busques ayuda cuando estás enfadado demuestra que eres inteligente y fuerte.",
    showAchievements: false
  },
  triste: {
    validation: "Está bien sentirse triste. Todo el mundo se siente así a veces. No estás solo.",
    tips: [
      "La tristeza pasa. No va a durar para siempre.",
      "¿Quieres contarme qué te ha hecho sentir así? Escribir ayuda.",
      "Hacer la respiración de la vela y el pastel puede ayudarte a sentir un poquito mejor.",
      "Recuerda: las personas que te quieren siguen ahí."
    ],
    breathingExercise: "vela_pastel",
    selfEsteem: "Aunque hoy sea un día difícil, mira todo lo que has aprendido y lo que has conseguido. Eres más fuerte de lo que crees.",
    showAchievements: true
  }
};

export const SELF_ESTEEM_MESSAGES = {
  general: [
    "Eres único y especial. No hay nadie como tú en el mundo.",
    "Cada día aprendes algo nuevo. Eso es increíble.",
    "Está bien no saberlo todo. Lo importante es intentarlo.",
    "Tú puedes con esto. Y si necesitas ayuda, pedirla es de valientes.",
    "Lo que te hace diferente es lo que te hace especial.",
    "Tu esfuerzo importa, aunque no siempre se note el resultado.",
    "No tienes que ser perfecto. Solo tienes que ser tú.",
    "Cada paso cuenta, por pequeño que sea.",
    "Hoy es un buen día para aprender algo nuevo.",
    "Tu cerebro es una máquina increíble. Dale tiempo."
  ],
  after_correct: [
    "¡Lo sabías! Tu esfuerzo está dando frutos.",
    "¡Genial! Cada acierto demuestra lo que has aprendido.",
    "¡Correcto! Tu cerebro está trabajando muy bien.",
    "¡Bravo! Estás progresando. Sigue así.",
    "¡Eso es! Cada respuesta correcta te acerca a ser un experto."
  ],
  after_wrong: [
    "No pasa nada. Los errores son la mejor forma de aprender.",
    "Equivocarse significa que lo estás intentando. Eso es lo que importa.",
    "Ahora ya sabes la respuesta. La próxima vez la acertarás.",
    "Los mejores científicos fallaron muchas veces antes de descubrir cosas increíbles.",
    "Un error no te define. Tu esfuerzo sí."
  ],
  streak: [
    "¡Llevas una racha increíble! Tu concentración es genial.",
    "¡Imparable! Cada acierto seguido demuestra tu nivel.",
    "¡Qué bien vas! La constancia es un superpoder."
  ],
  level_up: [
    "¡Has subido de nivel! Todo tu trabajo ha merecido la pena.",
    "¡Nuevo nivel desbloqueado! Eres más sabio que ayer.",
    "¡Felicidades! Has demostrado que puedes aprender cosas cada vez más difíciles."
  ],
  daily_login: [
    "¡Has vuelto! Cada día que practicas, tu cerebro se hace más fuerte.",
    "Me alegro de verte. ¿Preparado para aprender algo genial?",
    "¡Bienvenido de vuelta! Hoy puede ser un gran día."
  ],
  subject_strength: [
    "Eres muy bueno en {materia}. ¡Eso es un talento!",
    "Tu nivel en {materia} es impresionante. Sigue disfrutando de ella.",
    "En {materia} destacas mucho. Es una de tus fortalezas."
  ]
};

const MATERIA_LABELS = {
  matematicas: "Matemáticas",
  lengua: "Lengua",
  medio: "Conocimiento del Medio",
  digital: "Competencia Digital",
  ingles: "Inglés"
};

export function getResponseForMood(mood, engineStats) {
  const response = MOOD_RESPONSES[mood] || MOOD_RESPONSES.tranquilo;
  const result = {
    validation: response.validation,
    tips: response.tips,
    selfEsteem: response.selfEsteem,
    breathingExercise: null,
    achievements: null,
    subjectStrength: null
  };

  if (response.breathingExercise) {
    result.breathingExercise = BREATHING_EXERCISES.find((e) => e.id === response.breathingExercise) || null;
  }

  if (response.showAchievements && engineStats) {
    result.achievements = {
      totalPoints: engineStats.totalPoints || 0,
      totalAnswered: engineStats.totalAnswered || 0,
      totalCorrect: engineStats.totalCorrect || 0,
      accuracy: engineStats.accuracy || 0,
      levelInfo: engineStats.levelInfo || null
    };
  }

  if (engineStats && engineStats.statsByMateria) {
    let bestMateria = null;
    let bestAccuracy = 0;
    for (const [mat, stats] of Object.entries(engineStats.statsByMateria)) {
      if (stats.total >= 3) {
        const acc = Math.round((stats.correct / stats.total) * 100);
        if (acc > bestAccuracy) {
          bestAccuracy = acc;
          bestMateria = mat;
        }
      }
    }
    if (bestMateria && bestAccuracy >= 60) {
      const label = MATERIA_LABELS[bestMateria] || bestMateria;
      const templates = SELF_ESTEEM_MESSAGES.subject_strength;
      const template = templates[Math.floor(Math.random() * templates.length)];
      result.subjectStrength = template.replace("{materia}", label);
    }
  }

  return result;
}

export function getBreathingExercise(mood) {
  const candidates = BREATHING_EXERCISES.filter((e) => e.forMood.includes(mood));
  if (candidates.length === 0) return BREATHING_EXERCISES[0];
  return candidates[Math.floor(Math.random() * candidates.length)];
}

export function getRandomSelfEsteemMessage(category) {
  const pool = SELF_ESTEEM_MESSAGES[category] || SELF_ESTEEM_MESSAGES.general;
  return pool[Math.floor(Math.random() * pool.length)];
}
EMOSUPPORT_EOF

echo "✅ src/core/emotional-support.js"

# ============================================================
# 2. src/modules/journal/emotion-companion.jsx
# ============================================================
cat << 'COMPANION_EOF' > src/modules/journal/emotion-companion.jsx
import React, { useEffect, useState } from "react";
import { getResponseForMood } from "../../core/emotional-support.js";

export default function EmotionCompanion({ mood, engineStats, teaMode, lowStim }) {
  const [response, setResponse] = useState(null);
  const [breathingStep, setBreathingStep] = useState(-1);
  const [breathingActive, setBreathingActive] = useState(false);
  const [timer, setTimer] = useState(0);

  useEffect(() => {
    if (mood) {
      setResponse(getResponseForMood(mood, engineStats));
      setBreathingStep(-1);
      setBreathingActive(false);
    }
  }, [mood, engineStats]);

  useEffect(() => {
    if (!breathingActive || !response?.breathingExercise) return;
    const steps = response.breathingExercise.steps;
    if (breathingStep >= steps.length) {
      setBreathingActive(false);
      return;
    }
    const current = steps[breathingStep];
    if (!current || current.duration === 0) return;

    setTimer(current.duration);
    const interval = setInterval(() => {
      setTimer((prev) => {
        if (prev <= 1) {
          clearInterval(interval);
          setBreathingStep((s) => s + 1);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [breathingStep, breathingActive, response]);

  function startBreathing() {
    setBreathingStep(0);
    setBreathingActive(true);
  }

  if (!response || !mood) return null;

  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-blue-50 to-violet-50";
  const exercise = response.breathingExercise;
  const currentStep = exercise && breathingStep >= 0 && breathingStep < exercise.steps.length
    ? exercise.steps[breathingStep]
    : null;
  const breathingDone = exercise && breathingStep >= exercise.steps.length;

  return (
    <div className={["rounded-2xl border p-4 md:p-5 space-y-4", bg].join(" ")}>
      <div className="rounded-2xl bg-white border p-4">
        <p className="text-base leading-relaxed">{response.validation}</p>
      </div>

      {response.selfEsteem && (
        <div className="rounded-2xl bg-white border p-4">
          <p className="text-sm font-medium text-slate-800 mb-1">💪 Recuerda</p>
          <p className="text-sm text-slate-700">{response.selfEsteem}</p>
        </div>
      )}

      {response.subjectStrength && (
        <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-4">
          <p className="text-sm text-emerald-800">🌟 {response.subjectStrength}</p>
        </div>
      )}

      {response.tips && response.tips.length > 0 && (
        <div className="rounded-2xl bg-white border p-4 space-y-2">
          <p className="text-sm font-medium text-slate-800">💡 Tips que pueden ayudarte</p>
          {response.tips.map((tip, i) => (
            <p key={i} className="text-sm text-slate-600 pl-4 border-l-2 border-slate-200">{tip}</p>
          ))}
        </div>
      )}

      {exercise && !breathingActive && !breathingDone && (
        <div className="rounded-2xl bg-white border p-4 space-y-3">
          <p className="text-sm font-medium text-slate-800">
            {exercise.icon} {exercise.name}
          </p>
          <p className="text-sm text-slate-600">{exercise.description}</p>
          <button
            onClick={startBreathing}
            className="rounded-2xl border px-4 py-3 bg-slate-900 text-white text-sm w-full"
          >
            Empezar ejercicio de respiración
          </button>
        </div>
      )}

      {breathingActive && currentStep && (
        <div className="rounded-2xl bg-white border p-6 text-center space-y-4">
          <p className="text-5xl">{currentStep.icon}</p>
          <p className="text-lg font-medium leading-relaxed">{currentStep.text}</p>
          {currentStep.duration > 0 && (
            <div className="space-y-2">
              <div className="w-full bg-slate-200 rounded-full h-3 max-w-xs mx-auto">
                <div
                  className="bg-slate-900 h-3 rounded-full transition-all duration-1000"
                  style={{ width: Math.round((timer / currentStep.duration) * 100) + "%" }}
                ></div>
              </div>
              <p className="text-sm text-slate-500">{timer}s</p>
            </div>
          )}
        </div>
      )}

      {breathingActive && breathingStep >= 0 && exercise && breathingStep < exercise.steps.length && exercise.steps[breathingStep]?.duration === 0 && (
        <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-6 text-center space-y-3">
          <p className="text-5xl">{exercise.steps[breathingStep].icon}</p>
          <p className="text-lg font-medium text-emerald-900">{exercise.steps[breathingStep].text}</p>
          <button
            onClick={() => setBreathingActive(false)}
            className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white text-sm"
          >
            Listo
          </button>
        </div>
      )}

      {breathingDone && (
        <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-4 text-center">
          <p className="text-emerald-800 font-medium">🌟 ¡Ejercicio completado! Lo has hecho muy bien.</p>
        </div>
      )}

      {response.achievements && response.achievements.totalAnswered > 0 && (
        <div className="rounded-2xl bg-white border p-4 space-y-2">
          <p className="text-sm font-medium text-slate-800">🏆 Tus logros</p>
          <div className="grid grid-cols-3 gap-2 text-center text-sm">
            <div className="rounded-xl bg-slate-50 p-2">
              <p className="font-bold">{response.achievements.totalAnswered}</p>
              <p className="text-xs text-slate-500">Respondidas</p>
            </div>
            <div className="rounded-xl bg-slate-50 p-2">
              <p className="font-bold text-emerald-600">{response.achievements.totalCorrect}</p>
              <p className="text-xs text-slate-500">Correctas</p>
            </div>
            <div className="rounded-xl bg-slate-50 p-2">
              <p className="font-bold">{response.achievements.totalPoints} pts</p>
              <p className="text-xs text-slate-500">Puntos</p>
            </div>
          </div>
          {response.achievements.levelInfo && (
            <p className="text-sm text-center text-slate-600">
              {response.achievements.levelInfo.icon} Nivel: {response.achievements.levelInfo.name}
            </p>
          )}
        </div>
      )}
    </div>
  );
}
COMPANION_EOF

echo "✅ src/modules/journal/emotion-companion.jsx"

# ============================================================
# 3. src/modules/journal/journal-view.jsx (ACTUALIZADO)
# ============================================================
cat << 'JOURNALV2_EOF' > src/modules/journal/journal-view.jsx
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
JOURNALV2_EOF

echo "✅ src/modules/journal/journal-view.jsx (con compañero emocional)"

# ============================================================
# Resultado
# ============================================================
echo ""
echo "============================================================"
echo "  FASE 3 COMPLETADA"
echo "============================================================"
echo ""
echo "  Ficheros creados/actualizados:"
echo "    src/core/emotional-support.js       (mensajes + respiración + autoestima)"
echo "    src/modules/journal/emotion-companion.jsx (compañero emocional visual)"
echo "    src/modules/journal/journal-view.jsx (actualizado con compañero)"
echo ""
echo "  Para arrancar: npm run dev"
echo ""
echo "  🧡 Compañero emocional + ejercicios de respiración instalados"
echo ""
