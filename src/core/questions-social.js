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
