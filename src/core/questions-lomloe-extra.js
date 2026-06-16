const PROFILE_THEMES = {
  perfilA: ["divisibilidad", "coordenadas", "gramática", "cartografía", "seguridad digital", "present simple"],
  perfilB: ["potencias", "acentuación", "células", "algoritmos", "past simple", "mapas"],
  perfilC: ["vida cotidiana", "noticias", "salud", "scratch", "rutinas", "consumo responsable"],
  perfilD: ["retos", "creatividad", "ecosistemas", "steam", "role-play", "razonamiento"],
  perfilE: ["costa", "descripción", "territorio", "presentaciones", "vocabulario", "orientación"],
  perfilF: ["lluvia", "leyendas", "rías", "fuentes fiables", "comprensión", "naturaleza"],
  perfilG: ["volcanes", "biodiversidad", "islas", "datos", "forest", "ecosistemas"],
  perfilH: ["relieve", "gramática", "organización", "ríos", "friendly", "cálculo mental"]
};

const SUBJECT_TEMPLATES = {
  matematicas: [
    { nivel: "basico", pregunta: (t) => `¿Qué operación usarías primero en un problema sobre ${t}?`, opciones: ["Suma o resta simple", "Multiplicación o división si corresponde", "Nunca se calcula"], correcta: 1, explicacion: "En problemas compuestos, primero resuelves la parte que organiza la situación." },
    { nivel: "basico", pregunta: (t) => `Si una actividad de ${t} dura 20 minutos y haces 3, ¿cuánto tiempo usas?`, opciones: ["40", "60", "80"], correcta: 1, explicacion: "20 × 3 = 60 minutos." },
    { nivel: "medio", pregunta: (t) => `En una tabla sobre ${t}, ¿qué te ayuda a comparar datos?`, opciones: ["Ignorarlos", "Ordenarlos y observar diferencias", "Borrarlos"], correcta: 1, explicacion: "Ordenar y comparar ayuda a analizar datos." },
    { nivel: "medio", pregunta: (t) => `Si una cantidad relacionada con ${t} baja de 7 a 2, la diferencia es`, opciones: ["3", "5", "9"], correcta: 1, explicacion: "7 − 2 = 5." },
    { nivel: "avanzado", pregunta: (t) => `Para comprobar un resultado en ${t}, lo mejor es`, opciones: ["Adivinar", "Rehacer el cálculo o usar la operación inversa", "Cambiar la pregunta"], correcta: 1, explicacion: "Comprobar con la operación inversa reduce errores." }
  ],
  lengua: [
    { nivel: "basico", pregunta: (t) => `En un texto sobre ${t}, la idea principal es`, opciones: ["Una palabra al azar", "El mensaje más importante del texto", "La última letra"], correcta: 1, explicacion: "La idea principal resume el contenido más importante." },
    { nivel: "basico", pregunta: (t) => `Un adjetivo en una descripción sobre ${t} sirve para`, opciones: ["Nombrar acciones", "Decir cómo es algo", "Contar números"], correcta: 1, explicacion: "Los adjetivos describen cualidades." },
    { nivel: "medio", pregunta: (t) => `Para entender mejor un texto sobre ${t}, conviene`, opciones: ["Leer solo el final", "Subrayar palabras clave", "Ignorar el título"], correcta: 1, explicacion: "Las palabras clave ayudan a comprender el texto." },
    { nivel: "medio", pregunta: (t) => `En una narración relacionada con ${t}, el nudo es`, opciones: ["El conflicto o problema", "El título", "La firma"], correcta: 0, explicacion: "El nudo es la parte donde aparece el conflicto." },
    { nivel: "avanzado", pregunta: (t) => `Una buena conclusión sobre ${t} debe`, opciones: ["Repetir sin sentido", "Cerrar y resumir la idea principal", "Cambiar de tema"], correcta: 1, explicacion: "La conclusión cierra el texto y resume su sentido." }
  ],
  medio: [
    { nivel: "basico", pregunta: (t) => `Una pregunta de Conocimiento del Medio sobre ${t} busca`, opciones: ["Inventar datos", "Comprender el mundo natural o social", "Borrar información"], correcta: 1, explicacion: "Esta materia ayuda a comprender el entorno." },
    { nivel: "basico", pregunta: (t) => `Un mapa o esquema sobre ${t} sirve para`, opciones: ["Confundir", "Representar información", "Dibujar sin orden"], correcta: 1, explicacion: "Los mapas y esquemas representan información." },
    { nivel: "medio", pregunta: (t) => `Para cuidar el entorno relacionado con ${t}, conviene`, opciones: ["Contaminar más", "Usar hábitos sostenibles", "Romper señales"], correcta: 1, explicacion: "Los hábitos sostenibles protegen el medio." },
    { nivel: "medio", pregunta: (t) => `Cuando comparas dos paisajes o fenómenos sobre ${t}, estás trabajando`, opciones: ["Análisis y comparación", "Copia sin leer", "Solo memoria"], correcta: 0, explicacion: "Comparar es una habilidad científica importante." },
    { nivel: "avanzado", pregunta: (t) => `Una explicación científica sobre ${t} debe basarse en`, opciones: ["Datos y observaciones", "Rumores", "Suposiciones sin pruebas"], correcta: 0, explicacion: "Las explicaciones científicas se apoyan en datos." }
  ],
  digital: [
    { nivel: "basico", pregunta: (t) => `En una tarea digital sobre ${t}, lo primero es`, opciones: ["Compartir contraseñas", "Organizar archivos y datos", "Borrar todo"], correcta: 1, explicacion: "La organización es clave en tareas digitales." },
    { nivel: "basico", pregunta: (t) => `Si una web relacionada con ${t} te pide datos raros, debes`, opciones: ["Darlos", "Cerrar y avisar a un adulto", "Compartirla"], correcta: 1, explicacion: "Ante una web sospechosa, hay que detenerse y avisar." },
    { nivel: "medio", pregunta: (t) => `Un algoritmo para resolver una tarea de ${t} es`, opciones: ["Una serie ordenada de pasos", "Un dibujo aleatorio", "Una contraseña"], correcta: 0, explicacion: "Un algoritmo es una secuencia de pasos." },
    { nivel: "medio", pregunta: (t) => `En programación, repetir una acción con ${t} se hace con`, opciones: ["Un bucle", "Un saludo", "Una carpeta"], correcta: 0, explicacion: "Los bucles repiten instrucciones." },
    { nivel: "avanzado", pregunta: (t) => `Una buena práctica digital al trabajar ${t} es`, opciones: ["Guardar copias de seguridad", "Usar claves débiles", "Enviar datos personales"], correcta: 0, explicacion: "Las copias de seguridad protegen tu trabajo." }
  ],
  ingles: [
    { nivel: "basico", pregunta: (t) => `Si hablas de una rutina relacionada con ${t}, usas normalmente`, opciones: ["Present Simple", "Past Simple", "Future perfecto"], correcta: 0, explicacion: "Las rutinas suelen expresarse en Present Simple." },
    { nivel: "basico", pregunta: (t) => `Si algo ocurre ahora en una escena sobre ${t}, usas`, opciones: ["Present Continuous", "Pasado", "Imperativo"], correcta: 0, explicacion: "Acciones en progreso → Present Continuous." },
    { nivel: "medio", pregunta: (t) => `Para contar algo de ayer sobre ${t}, usas`, opciones: ["Past Simple", "Present Simple", "Going to"], correcta: 0, explicacion: "Ayer o en el pasado → Past Simple." },
    { nivel: "medio", pregunta: (t) => `Para mejorar vocabulario sobre ${t}, conviene`, opciones: ["Relacionar palabra e imagen", "Borrar palabras", "No leer"], correcta: 0, explicacion: "Asociar imagen y palabra mejora la memoria." },
    { nivel: "avanzado", pregunta: (t) => `Si revisas una frase en inglés sobre ${t}, debes comprobar`, opciones: ["Sujeto y verbo", "Solo el color", "Solo la longitud"], correcta: 0, explicacion: "Revisar sujeto y verbo mejora la corrección gramatical." }
  ]
};

function normalizeQuestion(obj) {
  return {
    id: obj.id,
    perfil: obj.perfil,
    materia: obj.materia,
    nivel: obj.nivel,
    pregunta: obj.pregunta,
    opciones: obj.opciones,
    correcta: obj.correcta,
    explicacion: obj.explicacion
  };
}

export const EXTRA_QUESTIONS_BANK = Object.entries(PROFILE_THEMES).flatMap(([perfil, topics]) => {
  return Object.entries(SUBJECT_TEMPLATES).flatMap(([materia, templates]) => {
    return templates.map((tpl, idx) => normalizeQuestion({
      id: `${perfil}_${materia}_extra_${idx + 1}`,
      perfil,
      materia,
      nivel: tpl.nivel,
      pregunta: tpl.pregunta(topics[idx % topics.length]),
      opciones: tpl.opciones,
      correcta: tpl.correcta,
      explicacion: tpl.explicacion
    }));
  });
});
