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
