export const PERFILES = {
  perfilA: { nombre: "Comunidad de Madrid", comunidades: ["madrid"], estilo: "Académico-exigente", dificultad: "alta", feedback: "paso_a_paso",
    enfoque: { matematicas: "Cálculo, problemas encadenados y preparación ESO", lengua: "Gramática, ortografía y redacción", medio: "Contenidos sólidos y mapas", digital: "Algoritmia y seguridad", ingles: "Base gramatical fuerte" } },
  perfilB: { nombre: "Académico-tradicional", comunidades: ["castilla y leon", "la rioja"], estilo: "Académico-sólido", dificultad: "media-alta", feedback: "estructurado",
    enfoque: { matematicas: "Cálculo sólido con razonamiento", lengua: "Gramática exigente", medio: "Teoría celular y cartografía", digital: "Uso responsable", ingles: "Estructura y vocabulario" } },
  perfilC: { nombre: "Práctico-contextual", comunidades: ["andalucia", "castilla-la mancha", "extremadura", "murcia"], estilo: "Práctico-contextual", dificultad: "media", feedback: "ejemplo_real",
    enfoque: { matematicas: "Situaciones reales", lengua: "Expresión oral y comprensión", medio: "Entorno cercano y salud", digital: "Uso funcional y seguro", ingles: "Comunicación práctica" } },
  perfilD: { nombre: "Competencial-STEAM", comunidades: ["cataluna", "pais vasco", "navarra"], estilo: "Competencial-STEAM", dificultad: "media", feedback: "reto_y_razonamiento",
    enfoque: { matematicas: "Razonamiento y retos", lengua: "Comunicación y escritura creativa", medio: "Proyectos interdisciplinares", digital: "STEAM y Scratch", ingles: "Interacción funcional" } },
  perfilE: { nombre: "Bilingüe-litoral", comunidades: ["comunitat valenciana", "illes balears"], estilo: "Bilingüe-comunicativo", dificultad: "media", feedback: "uso_funcional",
    enfoque: { matematicas: "Cálculo y razonamiento", lengua: "Comunicación y contexto", medio: "Territorio y costa", digital: "Presentaciones", ingles: "Vocabulario contextual" } },
  perfilF: { nombre: "Bilingüe-cultural", comunidades: ["galicia"], estilo: "Bilingüe-cultural", dificultad: "media", feedback: "apoyo_visual",
    enfoque: { matematicas: "Aplicación equilibrada", lengua: "Lectura y expresión", medio: "Paisaje y naturaleza", digital: "Búsqueda responsable", ingles: "Rutinas y comprensión" } },
  perfilG: { nombre: "Natural-insular", comunidades: ["canarias"], estilo: "Natural-insular", dificultad: "media", feedback: "contexto_cientifico",
    enfoque: { matematicas: "Medidas y datos reales", lengua: "Textos expositivos", medio: "Volcanes y ecosistemas", digital: "Exploración y proyectos", ingles: "Naturaleza y viajes" } },
  perfilH: { nombre: "Equilibrado-territorial", comunidades: ["aragon", "asturias", "cantabria", "ceuta", "melilla"], estilo: "Equilibrado-territorial", dificultad: "media", feedback: "mixto",
    enfoque: { matematicas: "Cálculo estándar LOMLOE", lengua: "Gramática y comprensión", medio: "Relieve y cuerpo humano", digital: "Seguridad y bucles", ingles: "Present/Past Simple" } }
};
export const CCAA_MAP = {
  "madrid":"perfilA","castilla y leon":"perfilB","la rioja":"perfilB",
  "andalucia":"perfilC","castilla-la mancha":"perfilC","extremadura":"perfilC","murcia":"perfilC",
  "cataluna":"perfilD","pais vasco":"perfilD","navarra":"perfilD",
  "comunitat valenciana":"perfilE","illes balears":"perfilE",
  "galicia":"perfilF","canarias":"perfilG",
  "aragon":"perfilH","asturias":"perfilH","cantabria":"perfilH","ceuta":"perfilH","melilla":"perfilH"
};
export function resolverPerfil(comunidad) {
  const key = CCAA_MAP[(comunidad || "").toLowerCase().trim()];
  return key ? { key, ...PERFILES[key] } : { key: "perfilH", ...PERFILES.perfilH };
}
export function listarComunidades() { return Object.keys(CCAA_MAP).sort(); }
