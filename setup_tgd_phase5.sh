#!/bin/bash
# ============================================================
# setup_tgd_phase5.sh
# Fase 5: módulo social, retos de seguridad digital,
# ampliación TEA/TGD/Asperger y nuevos quizzes/desafíos.
# Ejecutar desde: ~/Escritorio/TGD/
# ============================================================
set -e

echo ""
echo "🌐 Fase 5: instalando módulo social, retos y apoyos TEA..."
echo ""

mkdir -p src/core
mkdir -p src/modules/social
mkdir -p src/modules/challenges
mkdir -p src/modules/tea

# ============================================================
# 1) Preguntas sobre redes sociales y ciudadanía digital
# ============================================================
cat << 'EOF' > src/core/questions-social.js
export const SOCIAL_QUESTIONS = [
  // Importancia / uso positivo
  { id: "social_001", topic: "importancia", materia: "digital", nivel: "basico", pregunta: "¿Para qué puede servir una red social de forma positiva?", opciones: ["Para aprender y compartir aficiones", "Para dar contraseñas", "Para insultar"], correcta: 0, explicacion: "Las redes pueden usarse para aprender, crear y compartir intereses de forma segura." },
  { id: "social_002", topic: "importancia", materia: "digital", nivel: "basico", pregunta: "Una red social también puede ayudar a", opciones: ["Conectar con comunidades y proyectos", "Dormir mejor por la noche sin parar", "Ocultar problemas"], correcta: 0, explicacion: "Las comunidades pueden ayudar a colaborar y aprender cosas nuevas." },
  { id: "social_003", topic: "importancia", materia: "digital", nivel: "medio", pregunta: "Seguir cuentas educativas puede ser útil porque", opciones: ["Ayuda a descubrir contenido interesante", "Hace los deberes sola", "Evita estudiar"], correcta: 0, explicacion: "Hay contenido educativo útil, pero siempre conviene contrastarlo." },
  { id: "social_004", topic: "importancia", materia: "digital", nivel: "medio", pregunta: "Crear contenido digital responsable significa", opciones: ["Compartir cualquier cosa sin pensar", "Publicar con respeto y cuidado", "Copiar siempre"], correcta: 1, explicacion: "Ser responsable implica pensar antes de publicar y respetar a otras personas." },
  { id: "social_005", topic: "importancia", materia: "digital", nivel: "avanzado", pregunta: "Una buena ciudadanía digital incluye", opciones: ["Respeto, privacidad y pensamiento crítico", "Solo usar filtros", "Ganar likes a cualquier precio"], correcta: 0, explicacion: "La ciudadanía digital se basa en respeto, seguridad y criterio." },

  // Privacidad
  { id: "social_006", topic: "privacidad", materia: "digital", nivel: "basico", pregunta: "¿Qué dato NO debes compartir en una red social?", opciones: ["Tu color favorito", "Tu dirección de casa", "Tu animal favorito"], correcta: 1, explicacion: "La dirección es un dato personal sensible." },
  { id: "social_007", topic: "privacidad", materia: "digital", nivel: "basico", pregunta: "Una cuenta privada sirve para", opciones: ["Controlar mejor quién ve tu contenido", "Tener más deberes", "Enviar el PIN a otros"], correcta: 0, explicacion: "Una cuenta privada permite tener más control sobre quién accede a tus publicaciones." },
  { id: "social_008", topic: "privacidad", materia: "digital", nivel: "medio", pregunta: "La huella digital es", opciones: ["Las marcas de tus zapatos", "El rastro que dejas en internet", "Una contraseña"], correcta: 1, explicacion: "Lo que publicas, comentas o compartes deja huella." },
  { id: "social_009", topic: "privacidad", materia: "digital", nivel: "medio", pregunta: "Etiquetar a un amigo en una foto sin permiso puede", opciones: ["Ser una falta de respeto", "No importar nunca", "Ser obligatorio"], correcta: 0, explicacion: "Siempre es mejor pedir permiso antes de compartir información de otra persona." },
  { id: "social_010", topic: "privacidad", materia: "digital", nivel: "avanzado", pregunta: "Compartir tu ubicación en tiempo real puede ser", opciones: ["Inofensivo siempre", "Un riesgo para tu privacidad", "Una obligación escolar"], correcta: 1, explicacion: "La geolocalización puede exponer información sensible." },

  // Riesgos
  { id: "social_011", topic: "riesgos", materia: "digital", nivel: "basico", pregunta: "Si una persona desconocida te escribe por redes, lo mejor es", opciones: ["Responder con tus datos", "No compartir información y avisar a un adulto", "Enviar una foto"], correcta: 1, explicacion: "Nunca debes compartir datos con desconocidos." },
  { id: "social_012", topic: "riesgos", materia: "digital", nivel: "basico", pregunta: "Aceptar a personas que no conoces puede ser", opciones: ["Un riesgo", "Siempre seguro", "Obligatorio"], correcta: 0, explicacion: "No sabes quién está realmente detrás de una cuenta." },
  { id: "social_013", topic: "riesgos", materia: "digital", nivel: "medio", pregunta: "El ciberacoso es", opciones: ["Una broma sin importancia", "Acoso a través de medios digitales", "Un juego"], correcta: 1, explicacion: "El acoso digital puede hacer mucho daño y debe comunicarse a un adulto." },
  { id: "social_014", topic: "riesgos", materia: "digital", nivel: "medio", pregunta: "Si un contenido te hace sentir incómodo, debes", opciones: ["Seguir mirándolo", "Parar, salir y pedir ayuda", "Compartirlo"], correcta: 1, explicacion: "Si algo te hace sentir mal, lo mejor es parar y contarlo a un adulto." },
  { id: "social_015", topic: "riesgos", materia: "digital", nivel: "avanzado", pregunta: "Una cuenta falsa puede intentar", opciones: ["Engañarte o robar datos", "Ayudarte siempre", "Explicar deberes"], correcta: 0, explicacion: "Las cuentas falsas pueden usarse para engañar o manipular." },

  // Fake news / pensamiento crítico
  { id: "social_016", topic: "fake_news", materia: "digital", nivel: "basico", pregunta: "Si una noticia suena increíble, debes", opciones: ["Compartirla rápido", "Comprobar la fuente", "Creértela siempre"], correcta: 1, explicacion: "Antes de compartir algo, conviene comprobar de dónde viene." },
  { id: "social_017", topic: "fake_news", materia: "digital", nivel: "basico", pregunta: "Una cadena viral puede ser", opciones: ["Información falsa o exagerada", "Siempre cierta", "Una ley"], correcta: 0, explicacion: "Las cadenas virales no siempre dicen la verdad." },
  { id: "social_018", topic: "fake_news", materia: "digital", nivel: "medio", pregunta: "Para verificar una noticia conviene", opciones: ["Mirar varias fuentes fiables", "Solo leer el titular", "Preguntar solo a un compañero"], correcta: 0, explicacion: "Comparar varias fuentes fiables mejora la verificación." },
  { id: "social_019", topic: "fake_news", materia: "digital", nivel: "medio", pregunta: "Una imagen manipulada puede", opciones: ["Cambiar el significado de un hecho", "No influir nunca", "Ser siempre educativa"], correcta: 0, explicacion: "Las imágenes también pueden engañar." },
  { id: "social_020", topic: "fake_news", materia: "digital", nivel: "avanzado", pregunta: "Pensamiento crítico en redes significa", opciones: ["Dudar y comprobar antes de creer", "Aceptar todo", "No leer nada"], correcta: 0, explicacion: "Pensar críticamente ayuda a distinguir información fiable." },

  // Bienestar digital / autoestima
  { id: "social_021", topic: "bienestar", materia: "digital", nivel: "basico", pregunta: "Pasar demasiado tiempo en redes puede", opciones: ["Afectar al sueño y al descanso", "No influir nunca", "Ser obligatorio"], correcta: 0, explicacion: "El exceso de pantallas puede afectar al descanso." },
  { id: "social_022", topic: "bienestar", materia: "digital", nivel: "basico", pregunta: "Compararte con otras personas en redes puede", opciones: ["Hacerte sentir mal a veces", "Ser siempre bueno", "No pasar nunca"], correcta: 0, explicacion: "Las redes no siempre muestran la realidad completa." },
  { id: "social_023", topic: "bienestar", materia: "digital", nivel: "medio", pregunta: "Si una red social te pone nervioso, conviene", opciones: ["Seguir sin parar", "Hacer una pausa y hablarlo", "Ocultarlo siempre"], correcta: 1, explicacion: "Parar y pedir ayuda es una buena estrategia de cuidado." },
  { id: "social_024", topic: "bienestar", materia: "digital", nivel: "medio", pregunta: "Los likes no miden", opciones: ["Tu valor como persona", "La actividad de una publicación", "El tiempo en pantalla"], correcta: 0, explicacion: "Tu valor no depende de reacciones o seguidores." },
  { id: "social_025", topic: "bienestar", materia: "digital", nivel: "avanzado", pregunta: "Un uso equilibrado de redes incluye", opciones: ["Descansos, límites y otras actividades", "Pantalla sin pausa", "Dormir con el móvil"], correcta: 0, explicacion: "El equilibrio digital ayuda al bienestar emocional y físico." },

  // Respeto y convivencia
  { id: "social_026", topic: "convivencia", materia: "digital", nivel: "basico", pregunta: "Antes de escribir un comentario conviene", opciones: ["Pensar si es respetuoso", "Escribirlo con enfado", "Copiar insultos"], correcta: 0, explicacion: "La convivencia digital requiere respeto." },
  { id: "social_027", topic: "convivencia", materia: "digital", nivel: "basico", pregunta: "Burlarse de alguien por redes", opciones: ["No tiene importancia", "Puede hacer mucho daño", "Es divertido siempre"], correcta: 1, explicacion: "Los comentarios pueden afectar mucho a otras personas." },
  { id: "social_028", topic: "convivencia", materia: "digital", nivel: "medio", pregunta: "Si ves acoso a un compañero, puedes", opciones: ["Ignorarlo siempre", "Avisar a un adulto y apoyar a la víctima", "Compartirlo"], correcta: 1, explicacion: "Pedir ayuda y apoyar a la persona afectada es lo correcto." },
  { id: "social_029", topic: "convivencia", materia: "digital", nivel: "medio", pregunta: "Un mensaje escrito en mayúsculas puede parecer", opciones: ["Más calmado", "Un grito o tono agresivo", "Más amable"], correcta: 1, explicacion: "El tono en digital también importa." },
  { id: "social_030", topic: "convivencia", materia: "digital", nivel: "avanzado", pregunta: "Ser un buen compañero digital significa", opciones: ["Respetar, ayudar y comunicar con cuidado", "Reenviar rumores", "Publicar sin pensar"], correcta: 0, explicacion: "La convivencia positiva también existe en internet." },

  // Contraseñas y seguridad digital específica
  { id: "social_031", topic: "seguridad", materia: "digital", nivel: "basico", pregunta: "Una contraseña segura debe tener", opciones: ["Letras, números y símbolos", "Solo tu nombre", "Solo 1234"], correcta: 0, explicacion: "Combinar tipos de caracteres aumenta la seguridad." },
  { id: "social_032", topic: "seguridad", materia: "digital", nivel: "basico", pregunta: "Compartir tu contraseña con amigos es", opciones: ["Seguro", "Mala idea", "Obligatorio"], correcta: 1, explicacion: "Las contraseñas son personales y privadas." },
  { id: "social_033", topic: "seguridad", materia: "digital", nivel: "medio", pregunta: "Si una app pide acceso que no necesita, debes", opciones: ["Aceptar siempre", "Revisar y limitar permisos", "Ignorarlo"], correcta: 1, explicacion: "Es importante revisar permisos y dar solo los necesarios." },
  { id: "social_034", topic: "seguridad", materia: "digital", nivel: "medio", pregunta: "La verificación en dos pasos sirve para", opciones: ["Tener más seguridad", "Quitar privacidad", "Borrar fotos"], correcta: 0, explicacion: "La verificación en dos pasos refuerza la seguridad." },
  { id: "social_035", topic: "seguridad", materia: "digital", nivel: "avanzado", pregunta: "Un reto de seguridad digital responsable sería", opciones: ["Cambiar contraseñas débiles por fuertes", "Publicar el PIN", "Aceptar a desconocidos"], correcta: 0, explicacion: "Mejorar contraseñas es una acción de seguridad real." }
];

export function getSocialQuestionsByTopic(topic) {
  return SOCIAL_QUESTIONS.filter((q) => q.topic === topic);
}

export function getRandomSocialQuestions(topic, count = 5) {
  let pool = topic ? getSocialQuestionsByTopic(topic) : [...SOCIAL_QUESTIONS];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, count);
}
EOF

echo "✅ src/core/questions-social.js"

# ============================================================
# 2) Escenarios sociales y retos de seguridad digital
# ============================================================
cat << 'EOF' > src/core/social-scenarios.js
export const SOCIAL_SCENARIOS = [
  {
    id: "scenario_001",
    category: "seguridad",
    title: "Mensaje de una persona desconocida",
    situation: "Una cuenta que no conoces te escribe y te pide una foto privada porque dice que es de tu edad.",
    options: [
      "Se la envío para ser amable",
      "No respondo, bloqueo y aviso a un adulto",
      "Le doy mi número de teléfono"
    ],
    correct: 1,
    explanation: "Nunca debes enviar fotos ni datos personales a personas desconocidas.",
    teaHint: "Piensa: persona desconocida = parar, bloquear, avisar."
  },
  {
    id: "scenario_002",
    category: "privacidad",
    title: "Publicar ubicación",
    situation: "Vas a subir una foto y la app te propone añadir tu ubicación exacta en tiempo real.",
    options: [
      "La activo siempre",
      "La reviso y normalmente no comparto ubicación exacta",
      "Le digo a todos dónde estoy"
    ],
    correct: 1,
    explanation: "No conviene compartir ubicación exacta porque afecta a tu privacidad.",
    teaHint: "Ubicación exacta = dato sensible."
  },
  {
    id: "scenario_003",
    category: "ciberacoso",
    title: "Comentarios hirientes",
    situation: "Ves que a un compañero le están dejando comentarios ofensivos en una red social.",
    options: [
      "Me río y lo comparto",
      "Lo ignoro siempre",
      "Aviso a un adulto y apoyo al compañero"
    ],
    correct: 2,
    explanation: "Ante el ciberacoso, hay que cortar la situación y pedir ayuda.",
    teaHint: "Si alguien sufre, buscar ayuda es una buena acción."
  },
  {
    id: "scenario_004",
    category: "fake_news",
    title: "Noticia viral increíble",
    situation: "Te llega un vídeo que dice algo muy impactante y te piden que lo reenvíes rápido.",
    options: [
      "Lo reenvío sin mirar",
      "Compruebo si es real antes de compartir",
      "Me lo creo siempre"
    ],
    correct: 1,
    explanation: "Las noticias y vídeos virales deben comprobarse antes de compartir.",
    teaHint: "Si algo parece muy sorprendente, parar y comprobar."
  },
  {
    id: "scenario_005",
    category: "bienestar",
    title: "Demasiado tiempo mirando la pantalla",
    situation: "Llevas mucho rato mirando vídeos y te notas cansado, nervioso y con sueño.",
    options: [
      "Sigo mirando más tiempo",
      "Hago una pausa y cambio de actividad",
      "Duermo con el móvil en la mano"
    ],
    correct: 1,
    explanation: "Las pausas ayudan a cuidar tu cuerpo y tus emociones.",
    teaHint: "Pausa breve + respiración + agua puede ayudar."
  },
  {
    id: "scenario_006",
    category: "seguridad",
    title: "Petición de contraseña",
    situation: "Alguien te dice que si le das tu contraseña te hará subir de nivel en un juego.",
    options: [
      "Se la doy para ganar rápido",
      "No la comparto con nadie",
      "Le doy el PIN de casa"
    ],
    correct: 1,
    explanation: "Las contraseñas no se comparten. Nadie debe pedírtelas.",
    teaHint: "Contraseña = privada."
  },
  {
    id: "scenario_007",
    category: "autoestima",
    title: "Comparación en redes",
    situation: "Ves perfiles con vidas perfectas y empiezas a pensar que tu vida es peor.",
    options: [
      "Recuerdo que no todo lo que se ve es real y hablo con alguien de confianza",
      "Creo que todo lo que veo es verdad",
      "Me insulto a mí mismo"
    ],
    correct: 0,
    explanation: "Las redes no muestran toda la realidad. Hablarlo ayuda mucho.",
    teaHint: "Compararte puede doler; pedir ayuda está bien."
  },
  {
    id: "scenario_008",
    category: "respeto",
    title: "Foto de un amigo",
    situation: "Tienes una foto graciosa de un amigo y piensas subirla sin pedir permiso.",
    options: [
      "La subo sin preguntar",
      "Le pido permiso antes",
      "La envío a un grupo grande primero"
    ],
    correct: 1,
    explanation: "Antes de compartir contenido de otra persona, debes pedir permiso.",
    teaHint: "Pedir permiso = respeto."
  }
];

export function getScenarioByCategory(category) {
  return SOCIAL_SCENARIOS.filter((s) => s.category === category);
}

export function getRandomScenarios(count = 4) {
  let pool = [...SOCIAL_SCENARIOS];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, count);
}
EOF

echo "✅ src/core/social-scenarios.js"

# ============================================================
# 3) Engine de retos y desafíos digitales
# ============================================================
cat << 'EOF' > src/core/challenges-engine.js
import { SOCIAL_SCENARIOS, getRandomScenarios } from "./social-scenarios.js";
import { getRandomSocialQuestions } from "./questions-social.js";

export function buildSecurityChallengePack() {
  const scenarios = getRandomScenarios(3);
  const quiz = getRandomSocialQuestions("seguridad", 3);
  return {
    id: `challenge-pack-${Date.now()}`,
    createdAt: new Date().toISOString(),
    scenarios,
    quiz
  };
}

export function scoreChallengePack(pack, scenarioAnswers = [], quizAnswers = []) {
  const scenarioDetails = pack.scenarios.map((s, idx) => ({
    id: s.id,
    correct: scenarioAnswers[idx] === s.correct,
    type: "scenario"
  }));
  const quizDetails = pack.quiz.map((q, idx) => ({
    id: q.id,
    correct: quizAnswers[idx] === q.correcta,
    type: "quiz"
  }));

  const details = [...scenarioDetails, ...quizDetails];
  const correct = details.filter((d) => d.correct).length;
  const total = details.length;
  const percent = total > 0 ? Math.round((correct / total) * 100) : 0;
  const points = correct * 15 + (percent >= 80 ? 20 : 0);

  return {
    total,
    correct,
    percent,
    points,
    passed: percent >= 70,
    details
  };
}

export function getChallengeTips() {
  return [
    "Usa contraseñas fuertes y no las compartas.",
    "Piensa antes de publicar una foto o comentario.",
    "Si algo te incomoda, para y busca ayuda.",
    "No aceptes a desconocidos sin pensar.",
    "Comprueba la información antes de reenviarla."
  ];
}
EOF

echo "✅ src/core/challenges-engine.js"

# ============================================================
# 4) Módulo social
# ============================================================
cat << 'EOF' > src/modules/social/social-view.jsx
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
EOF

echo "✅ src/modules/social/social-view.jsx"

# ============================================================
# 5) Retos de seguridad digital
# ============================================================
cat << 'EOF' > src/modules/challenges/challenges-view.jsx
import React, { useMemo, useState } from "react";
import { buildSecurityChallengePack, scoreChallengePack, getChallengeTips } from "../../core/challenges-engine.js";

function ChallengeOption({ active, onClick, children }) {
  return <button onClick={onClick} className={["rounded-2xl border px-4 py-4 text-left w-full", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>{children}</button>;
}

export default function ChallengesView({ teaMode = true, lowStim = true }) {
  const [pack, setPack] = useState(() => buildSecurityChallengePack());
  const [phase, setPhase] = useState("scenario");
  const [index, setIndex] = useState(0);
  const [scenarioAnswers, setScenarioAnswers] = useState([]);
  const [quizAnswers, setQuizAnswers] = useState([]);
  const [finished, setFinished] = useState(false);
  const tips = useMemo(() => getChallengeTips(), []);
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  const currentScenario = pack.scenarios[index];
  const currentQuiz = pack.quiz[index];
  const totalPerSection = 3;

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

  function next() {
    if (phase === "scenario") {
      if (index < totalPerSection - 1) setIndex((i) => i + 1);
      else { setPhase("quiz"); setIndex(0); }
    } else {
      if (index < totalPerSection - 1) setIndex((i) => i + 1);
      else setFinished(true);
    }
  }

  function resetAll() {
    setPack(buildSecurityChallengePack());
    setPhase("scenario");
    setIndex(0);
    setScenarioAnswers([]);
    setQuizAnswers([]);
    setFinished(false);
  }

  const score = finished ? scoreChallengePack(pack, scenarioAnswers, quizAnswers) : null;

  if (finished && score) {
    return (
      <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
        <h2 className="text-xl font-bold">🛡️ Reto de seguridad digital</h2>
        <div className="grid sm:grid-cols-3 gap-4">
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{score.percent}%</p><p className="text-sm text-slate-600">Resultado</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{score.correct}/{score.total}</p><p className="text-sm text-slate-600">Correctas</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">+{score.points}</p><p className="text-sm text-slate-600">Puntos reto</p></div>
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
        <h2 className="text-xl font-bold">🛡️ Reto de seguridad digital</h2>
        <p className="text-sm text-slate-600">Entrena tus decisiones y tu pensamiento crítico ante situaciones reales.</p>
      </div>
      <div className="rounded-2xl border bg-white p-5 space-y-4">
        <div className="flex items-center justify-between gap-3">
          <h3 className="font-semibold">{phase === "scenario" ? `Escenario ${index + 1} de ${totalPerSection}` : `Mini quiz ${index + 1} de ${totalPerSection}`}</h3>
          {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Paso a paso</span>}
        </div>

        {phase === "scenario" ? (
          <>
            <p className="text-sm text-slate-500">{currentScenario.title}</p>
            <p className="text-lg font-medium leading-relaxed">{currentScenario.situation}</p>
            <div className="grid gap-3">
              {currentScenario.options.map((opt, i) => <ChallengeOption key={i} active={scenarioAnswers[index] === i} onClick={() => chooseScenario(i)}>{opt}</ChallengeOption>)}
            </div>
            <div className="rounded-2xl border bg-sky-50 text-sky-900 p-3 text-sm">Pista TEA: {currentScenario.teaHint}</div>
          </>
        ) : (
          <>
            <p className="text-lg font-medium leading-relaxed">{currentQuiz.pregunta}</p>
            <div className="grid gap-3">
              {currentQuiz.opciones.map((opt, i) => <ChallengeOption key={i} active={quizAnswers[index] === i} onClick={() => chooseQuiz(i)}>{opt}</ChallengeOption>)}
            </div>
          </>
        )}

        <div className="flex flex-wrap gap-3">
          <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{phase === "quiz" && index === totalPerSection - 1 ? "Finalizar reto" : "Siguiente"}</button>
          <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
        </div>
      </div>
    </div>
  );
}
EOF

echo "✅ src/modules/challenges/challenges-view.jsx"

# ============================================================
# 6) Apoyos TEA / TGD / Asperger dentro de la app
# ============================================================
cat << 'EOF' > src/modules/tea/tea-support-view.jsx
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
EOF

echo "✅ src/modules/tea/tea-support-view.jsx"

# ============================================================
# 7) Actualización App.jsx con nuevos módulos
# ============================================================
cat << 'EOF' > src/App.jsx
import React, { useEffect, useState } from "react";
import JournalView from "./modules/journal/journal-view.jsx";
import QuizView from "./modules/learning/quiz-view.jsx";
import GamesView from "./modules/games/games-view.jsx";
import ExamsView from "./modules/exams/exams-view.jsx";
import EmotionCompanion from "./modules/emotion/emotion-companion.jsx";
import SocialView from "./modules/social/social-view.jsx";
import ChallengesView from "./modules/challenges/challenges-view.jsx";
import TeaSupportView from "./modules/tea/tea-support-view.jsx";
import { resolverPerfil, listarComunidades } from "./core/curriculum-profiles.js";
import { generateTeacherPuk, getPinConfigMeta, setupPinSecurity, resetChildPinWithPuk } from "./core/pin-security.js";

const TABS = [
  { key: "inicio", icon: "🏠", label: "Inicio" },
  { key: "aprender", icon: "📚", label: "Aprender" },
  { key: "redes", icon: "🌐", label: "Redes Sociales" },
  { key: "retos", icon: "🛡️", label: "Retos" },
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
              <p className="text-slate-600">Configura comunidad, accesibilidad y nombre del alumno. La app adapta las preguntas LOMLOE a tu perfil y añade ciudadanía digital y apoyos TEA.</p>
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
echo "  FASE 5 COMPLETADA"
echo "============================================================"
echo ""
echo "  Añadido:"
echo "   • Módulo social / redes sociales"
echo "   • Reto de seguridad digital"
echo "   • Más preguntas, quiz y desafíos"
echo "   • Apoyos TEA/TGD/Asperger dentro de la app"
echo "   • Historias sociales, rutinas visuales y temporizador"
echo ""
echo "  Ahora ejecuta: npm run dev"
echo ""
