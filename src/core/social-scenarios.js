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
