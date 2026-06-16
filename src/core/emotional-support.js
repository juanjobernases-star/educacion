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
