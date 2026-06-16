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
