#!/bin/bash
set -e
echo ""
echo "🧠 Fase 2: Motor educativo + 200 preguntas LOMLOE + Sistema de puntos"
echo ""
mkdir -p src/core
mkdir -p src/modules/learning

cat << 'PROFILES_EOF' > src/core/curriculum-profiles.js
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
PROFILES_EOF
echo "✅ src/core/curriculum-profiles.js"

cat << 'QUESTIONS_EOF' > src/core/questions-ccaa.js
export const QUESTIONS_BANK = [
  { id: "pA_mat_01", perfil: "perfilA", materia: "matematicas", nivel: "basico", pregunta: "Calcula: (24 ÷ 6) + 7 × 3", opciones: ["16", "25", "31"], correcta: 1, explicacion: "Primero 24÷6=4 y 7×3=21, luego 4+21=25." },
  { id: "pA_mat_02", perfil: "perfilA", materia: "matematicas", nivel: "basico", pregunta: "Descompón 54 en factores primos", opciones: ["2 × 27", "2 × 3 × 3 × 3", "6 × 9"], correcta: 1, explicacion: "54 = 2 × 3 × 3 × 3." },
  { id: "pA_mat_03", perfil: "perfilA", materia: "matematicas", nivel: "medio", pregunta: "¿Cuál es el m.c.d. de 18 y 24?", opciones: ["3", "6", "12"], correcta: 1, explicacion: "Factores comunes al menor exponente: 2×3=6." },
  { id: "pA_mat_04", perfil: "perfilA", materia: "matematicas", nivel: "medio", pregunta: "Sitúa −3 respecto a 2 en la recta numérica", opciones: ["A la derecha de 2", "A la izquierda de 2", "En el mismo punto"], correcta: 1, explicacion: "Los negativos van a la izquierda." },
  { id: "pA_mat_05", perfil: "perfilA", materia: "matematicas", nivel: "avanzado", pregunta: "¿En qué cuadrante está el punto (3, −2)?", opciones: ["I", "II", "IV"], correcta: 2, explicacion: "x positivo, y negativo → cuadrante IV." },
  { id: "pA_len_01", perfil: "perfilA", materia: "lengua", nivel: "basico", pregunta: "En 'La casa grande', el núcleo del GN es", opciones: ["La", "casa", "grande"], correcta: 1, explicacion: "El sustantivo es el núcleo del GN." },
  { id: "pA_len_02", perfil: "perfilA", materia: "lengua", nivel: "basico", pregunta: "'Árbol' es palabra", opciones: ["aguda", "llana", "esdrújula"], correcta: 1, explicacion: "Sílaba tónica 'ár' = penúltima → llana." },
  { id: "pA_len_03", perfil: "perfilA", materia: "lengua", nivel: "medio", pregunta: "Sinónimo de 'rápido'", opciones: ["lento", "veloz", "alto"], correcta: 1, explicacion: "Veloz significa lo mismo que rápido." },
  { id: "pA_len_04", perfil: "perfilA", materia: "lengua", nivel: "medio", pregunta: "En un texto narrativo, el nudo es", opciones: ["El inicio", "Donde ocurre el problema", "El final"], correcta: 1, explicacion: "El nudo es el conflicto central." },
  { id: "pA_len_05", perfil: "perfilA", materia: "lengua", nivel: "avanzado", pregunta: "Corrige: 'El lapiz azul'", opciones: ["El lapiz azul", "El lápiz azul", "El lapíz azul"], correcta: 1, explicacion: "Lápiz: llana acabada en z → tilde." },
  { id: "pA_med_01", perfil: "perfilA", materia: "medio", nivel: "basico", pregunta: "La unidad básica de los seres vivos es", opciones: ["El átomo", "La célula", "El tejido"], correcta: 1, explicacion: "La célula es la unidad funcional de la vida." },
  { id: "pA_med_02", perfil: "perfilA", materia: "medio", nivel: "basico", pregunta: "El aparato que absorbe nutrientes es el", opciones: ["Respiratorio", "Digestivo", "Circulatorio"], correcta: 1, explicacion: "El digestivo transforma alimentos en nutrientes." },
  { id: "pA_med_03", perfil: "perfilA", materia: "medio", nivel: "medio", pregunta: "La Meseta Central está en", opciones: ["Europa central", "La Península Ibérica", "América"], correcta: 1, explicacion: "Ocupa el centro de la Península Ibérica." },
  { id: "pA_med_04", perfil: "perfilA", materia: "medio", nivel: "medio", pregunta: "Los meridianos sirven para medir", opciones: ["Latitud", "Longitud", "Altitud"], correcta: 1, explicacion: "Los meridianos miden longitud geográfica." },
  { id: "pA_med_05", perfil: "perfilA", materia: "medio", nivel: "avanzado", pregunta: "La sangre circula gracias al", opciones: ["Cerebro", "Corazón", "Hígado"], correcta: 1, explicacion: "El corazón bombea la sangre." },
  { id: "pA_dig_01", perfil: "perfilA", materia: "digital", nivel: "basico", pregunta: "Una contraseña segura debe mezclar", opciones: ["Solo números", "Letras, números y símbolos", "Tu nombre"], correcta: 1, explicacion: "La mezcla aumenta la seguridad." },
  { id: "pA_dig_02", perfil: "perfilA", materia: "digital", nivel: "basico", pregunta: "Scratch usa programación por", opciones: ["Texto", "Bloques", "Voz"], correcta: 1, explicacion: "Scratch es visual por bloques." },
  { id: "pA_dig_03", perfil: "perfilA", materia: "digital", nivel: "medio", pregunta: "Guardar archivos en carpetas ayuda a", opciones: ["Que ocupen menos", "Encontrarlos mejor", "Que se borren"], correcta: 1, explicacion: "La organización mejora la productividad." },
  { id: "pA_dig_04", perfil: "perfilA", materia: "digital", nivel: "medio", pregunta: "Un phishing escolar intenta", opciones: ["Ayudarte", "Engañarte para obtener datos", "Mejorar tu nota"], correcta: 1, explicacion: "El phishing roba información personal." },
  { id: "pA_dig_05", perfil: "perfilA", materia: "digital", nivel: "avanzado", pregunta: "'Si… entonces…' es estructura", opciones: ["Bucle", "Condicional", "Variable"], correcta: 1, explicacion: "Es una estructura de decisión lógica." },
  { id: "pA_ing_01", perfil: "perfilA", materia: "ingles", nivel: "basico", pregunta: "'I play football every Friday' está en", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 0, explicacion: "Every Friday → hábito → Present Simple." },
  { id: "pA_ing_02", perfil: "perfilA", materia: "ingles", nivel: "basico", pregunta: "'She is reading now' está en", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Now → acción en progreso → Continuous." },
  { id: "pA_ing_03", perfil: "perfilA", materia: "ingles", nivel: "medio", pregunta: "Past Simple de 'go'", opciones: ["goed", "went", "gone"], correcta: 1, explicacion: "Go → went → gone." },
  { id: "pA_ing_04", perfil: "perfilA", materia: "ingles", nivel: "medio", pregunta: "Traduce 'amable'", opciones: ["angry", "kind", "tall"], correcta: 1, explicacion: "Kind = amable." },
  { id: "pA_ing_05", perfil: "perfilA", materia: "ingles", nivel: "avanzado", pregunta: "'Yesterday I ___ to school'", opciones: ["go", "went", "going"], correcta: 1, explicacion: "Yesterday → Past Simple → went." },
  { id: "pB_mat_01", perfil: "perfilB", materia: "matematicas", nivel: "basico", pregunta: "Calcula: 6²", opciones: ["12", "36", "64"], correcta: 1, explicacion: "6×6=36." },
  { id: "pB_mat_02", perfil: "perfilB", materia: "matematicas", nivel: "basico", pregunta: "Raíz cuadrada exacta de 81", opciones: ["8", "9", "10"], correcta: 1, explicacion: "9×9=81." },
  { id: "pB_mat_03", perfil: "perfilB", materia: "matematicas", nivel: "medio", pregunta: "¿Es 72 divisible entre 9?", opciones: ["Sí", "No", "Solo entre 8"], correcta: 0, explicacion: "72÷9=8, sin resto." },
  { id: "pB_mat_04", perfil: "perfilB", materia: "matematicas", nivel: "medio", pregunta: "Ordena: −4, 0, 3, −1", opciones: ["0,−1,−4,3", "−4,−1,0,3", "3,0,−1,−4"], correcta: 1, explicacion: "De menor a mayor." },
  { id: "pB_mat_05", perfil: "perfilB", materia: "matematicas", nivel: "avanzado", pregunta: "m.c.m. de 4 y 6", opciones: ["10", "12", "24"], correcta: 1, explicacion: "4=2² y 6=2×3 → m.c.m.=12." },
  { id: "pB_len_01", perfil: "perfilB", materia: "lengua", nivel: "basico", pregunta: "En 'aquellos libros', el determinante es", opciones: ["libros", "aquellos", "los"], correcta: 1, explicacion: "Aquellos es demostrativo." },
  { id: "pB_len_02", perfil: "perfilB", materia: "lengua", nivel: "basico", pregunta: "'Cantábamos' es palabra", opciones: ["aguda", "llana", "esdrújula"], correcta: 2, explicacion: "Sílaba tónica 'tá' = antepenúltima." },
  { id: "pB_len_03", perfil: "perfilB", materia: "lengua", nivel: "medio", pregunta: "Antónimo de 'oscuro'", opciones: ["negro", "claro", "turbio"], correcta: 1, explicacion: "Claro es lo opuesto." },
  { id: "pB_len_04", perfil: "perfilB", materia: "lengua", nivel: "medio", pregunta: "El narrador en 1ª persona usa", opciones: ["él", "yo", "ellos"], correcta: 1, explicacion: "Primera persona = yo." },
  { id: "pB_len_05", perfil: "perfilB", materia: "lengua", nivel: "avanzado", pregunta: "Corrige: 'Raul tenia un baul'", opciones: ["Raul tenia un baul", "Raúl tenía un baúl", "Rául ténia un bául"], correcta: 1, explicacion: "Hiatos con tilde." },
  { id: "pB_med_01", perfil: "perfilB", materia: "medio", nivel: "basico", pregunta: "Célula vegetal vs animal", opciones: ["Son iguales", "La vegetal tiene pared celular", "La animal tiene cloroplastos"], correcta: 1, explicacion: "La vegetal tiene pared celular." },
  { id: "pB_med_02", perfil: "perfilB", materia: "medio", nivel: "basico", pregunta: "Los capilares son", opciones: ["Huesos", "Vasos sanguíneos muy finos", "Nervios"], correcta: 1, explicacion: "Conectan arterias y venas." },
  { id: "pB_med_03", perfil: "perfilB", materia: "medio", nivel: "medio", pregunta: "Los Pirineos separan", opciones: ["España y Portugal", "España y Francia", "España y Marruecos"], correcta: 1, explicacion: "Frontera con Francia." },
  { id: "pB_med_04", perfil: "perfilB", materia: "medio", nivel: "medio", pregunta: "Escala del mapa sirve para", opciones: ["Decorar", "Calcular distancias reales", "Indicar norte"], correcta: 1, explicacion: "Relaciona mapa-realidad." },
  { id: "pB_med_05", perfil: "perfilB", materia: "medio", nivel: "avanzado", pregunta: "Riñones pertenecen al aparato", opciones: ["Digestivo", "Excretor", "Respiratorio"], correcta: 1, explicacion: "Filtran sangre." },
  { id: "pB_dig_01", perfil: "perfilB", materia: "digital", nivel: "basico", pregunta: "Archivo .odt suele ser de", opciones: ["Imagen", "Texto", "Vídeo"], correcta: 1, explicacion: "ODT = documento de texto." },
  { id: "pB_dig_02", perfil: "perfilB", materia: "digital", nivel: "basico", pregunta: "Reutilizar misma contraseña es", opciones: ["Seguro", "Inseguro", "Recomendable"], correcta: 1, explicacion: "Si la descubren, acceden a todo." },
  { id: "pB_dig_03", perfil: "perfilB", materia: "digital", nivel: "medio", pregunta: "Un algoritmo es", opciones: ["Un virus", "Serie ordenada de pasos", "Red social"], correcta: 1, explicacion: "Resuelve problemas paso a paso." },
  { id: "pB_dig_04", perfil: "perfilB", materia: "digital", nivel: "medio", pregunta: "Copias de seguridad ayudan a", opciones: ["Gastar espacio", "No perder información", "Hacer virus"], correcta: 1, explicacion: "Protegen contra pérdida." },
  { id: "pB_dig_05", perfil: "perfilB", materia: "digital", nivel: "avanzado", pregunta: "Compartir contraseña con amigos", opciones: ["Buena idea", "Mala práctica", "Obligatorio"], correcta: 1, explicacion: "Son personales e intransferibles." },
  { id: "pB_ing_01", perfil: "perfilB", materia: "ingles", nivel: "basico", pregunta: "'He usually gets up at 7' usa adverbio de", opciones: ["lugar", "frecuencia", "tiempo"], correcta: 1, explicacion: "Usually = frecuencia." },
  { id: "pB_ing_02", perfil: "perfilB", materia: "ingles", nivel: "basico", pregunta: "Past Simple de 'see'", opciones: ["seed", "saw", "seen"], correcta: 1, explicacion: "See → saw → seen." },
  { id: "pB_ing_03", perfil: "perfilB", materia: "ingles", nivel: "medio", pregunta: "'Now we are studying' está en", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Now + are studying." },
  { id: "pB_ing_04", perfil: "perfilB", materia: "ingles", nivel: "medio", pregunta: "Traduce 'fiable'", opciones: ["reliable", "funny", "angry"], correcta: 0, explicacion: "Reliable = fiable." },
  { id: "pB_ing_05", perfil: "perfilB", materia: "ingles", nivel: "avanzado", pregunta: "'My sister ___ very cheerful'", opciones: ["are", "is", "am"], correcta: 1, explicacion: "She → is." },
  { id: "pC_mat_01", perfil: "perfilC", materia: "matematicas", nivel: "basico", pregunta: "3 cuadernos de 4€, pagas", opciones: ["7€", "12€", "15€"], correcta: 1, explicacion: "3×4=12." },
  { id: "pC_mat_02", perfil: "perfilC", materia: "matematicas", nivel: "basico", pregunta: "Bus sale 9:15, tarda 45min. Llega", opciones: ["9:45", "10:00", "10:15"], correcta: 1, explicacion: "9:15+45=10:00." },
  { id: "pC_mat_03", perfil: "perfilC", materia: "matematicas", nivel: "medio", pregunta: "24 galletas entre 6 amigos", opciones: ["3", "4", "6"], correcta: 1, explicacion: "24÷6=4." },
  { id: "pC_mat_04", perfil: "perfilC", materia: "matematicas", nivel: "medio", pregunta: "De 2ºC a −1ºC baja", opciones: ["1ºC", "3ºC", "5ºC"], correcta: 1, explicacion: "De 2 a −1 = 3." },
  { id: "pC_mat_05", perfil: "perfilC", materia: "matematicas", nivel: "avanzado", pregunta: "Mapa 1cm=2km. 3cm son", opciones: ["3km", "6km", "9km"], correcta: 1, explicacion: "3×2=6." },
  { id: "pC_len_01", perfil: "perfilC", materia: "lengua", nivel: "basico", pregunta: "En noticia, lo importante va en", opciones: ["El final", "El titular", "Pie de foto"], correcta: 1, explicacion: "Pirámide invertida." },
  { id: "pC_len_02", perfil: "perfilC", materia: "lengua", nivel: "basico", pregunta: "'Bonito' y 'hermoso' son", opciones: ["Antónimos", "Sinónimos", "Homónimos"], correcta: 1, explicacion: "Significan lo mismo." },
  { id: "pC_len_03", perfil: "perfilC", materia: "lengua", nivel: "medio", pregunta: "Idea principal texto reciclar", opciones: ["Exámenes", "Importancia de reciclar", "Historia papel"], correcta: 1, explicacion: "Tema central = reciclaje." },
  { id: "pC_len_04", perfil: "perfilC", materia: "lengua", nivel: "medio", pregunta: "Adjetivo para aula", opciones: ["Corriendo", "Luminosa", "Ayer"], correcta: 1, explicacion: "Luminosa describe lugar." },
  { id: "pC_len_05", perfil: "perfilC", materia: "lengua", nivel: "avanzado", pregunta: "Inicio de rutina diaria", opciones: ["Hace mucho tiempo", "Por la mañana me levanto", "Érase una vez"], correcta: 1, explicacion: "Rutinas usan presente." },
  { id: "pC_med_01", perfil: "perfilC", materia: "medio", nivel: "basico", pregunta: "Desayuno saludable incluye", opciones: ["Solo bollería", "Fruta, cereal y lácteo", "Solo zumo"], correcta: 1, explicacion: "Equilibrio alimenticio." },
  { id: "pC_med_02", perfil: "perfilC", materia: "medio", nivel: "basico", pregunta: "Aparato respiratorio sirve para", opciones: ["Digerir", "Tomar O₂ y expulsar CO₂", "Mover músculos"], correcta: 1, explicacion: "Intercambio gases." },
  { id: "pC_med_03", perfil: "perfilC", materia: "medio", nivel: "medio", pregunta: "Río vertiente atlántica", opciones: ["Ebro", "Tajo", "Segura"], correcta: 1, explicacion: "Tajo → Atlántico." },
  { id: "pC_med_04", perfil: "perfilC", materia: "medio", nivel: "medio", pregunta: "Parque natural enseña sobre", opciones: ["Matemáticas", "Ecosistemas", "Gramática"], correcta: 1, explicacion: "Ecosistemas vivos." },
  { id: "pC_med_05", perfil: "perfilC", materia: "medio", nivel: "avanzado", pregunta: "Poca agua afecta al aparato", opciones: ["Locomotor", "Excretor", "Auditivo"], correcta: 1, explicacion: "El excretor necesita agua." },
  { id: "pC_dig_01", perfil: "perfilC", materia: "digital", nivel: "basico", pregunta: "Web pide datos extraños, debes", opciones: ["Darlos", "Cerrar y avisar", "Ignorar"], correcta: 1, explicacion: "Ante sospecha, avisar." },
  { id: "pC_dig_02", perfil: "perfilC", materia: "digital", nivel: "basico", pregunta: "Carpeta 'Deberes/Mates' está", opciones: ["Mal", "Bien organizada", "Vacía"], correcta: 1, explicacion: "Subcarpetas = orden." },
  { id: "pC_dig_03", perfil: "perfilC", materia: "digital", nivel: "medio", pregunta: "Scratch: repetir 5 veces usa", opciones: ["Variable", "Bucle", "Condicional"], correcta: 1, explicacion: "Bucles repiten." },
  { id: "pC_dig_04", perfil: "perfilC", materia: "digital", nivel: "medio", pregunta: "Foto sin permiso es", opciones: ["Correcto", "Incorrecto", "Obligatorio"], correcta: 1, explicacion: "Necesitas consentimiento." },
  { id: "pC_dig_05", perfil: "perfilC", materia: "digital", nivel: "avanzado", pregunta: "Icono nube indica", opciones: ["Peligro", "Almacenamiento online", "Lluvia"], correcta: 1, explicacion: "Nube = almacenamiento." },
  { id: "pC_ing_01", perfil: "perfilC", materia: "ingles", nivel: "basico", pregunta: "'I play with friends after school'", opciones: ["Pasado", "Rutina", "Futuro"], correcta: 1, explicacion: "Hábito diario." },
  { id: "pC_ing_02", perfil: "perfilC", materia: "ingles", nivel: "basico", pregunta: "'I am doing homework now'", opciones: ["Rutina", "Acción en progreso", "Pasado"], correcta: 1, explicacion: "Now → progreso." },
  { id: "pC_ing_03", perfil: "perfilC", materia: "ingles", nivel: "medio", pregunta: "Past Simple 'buy'", opciones: ["buyed", "bought", "buyd"], correcta: 1, explicacion: "Buy → bought." },
  { id: "pC_ing_04", perfil: "perfilC", materia: "ingles", nivel: "medio", pregunta: "Traduce 'patio de recreo'", opciones: ["classroom", "playground", "library"], correcta: 1, explicacion: "Playground." },
  { id: "pC_ing_05", perfil: "perfilC", materia: "ingles", nivel: "avanzado", pregunta: "'Yesterday we ___ to the park'", opciones: ["go", "went", "going"], correcta: 1, explicacion: "Yesterday → went." },
  { id: "pD_mat_01", perfil: "perfilD", materia: "matematicas", nivel: "basico", pregunta: "3×(4+2) vs 3×4+2", opciones: ["Iguales", "Paréntesis cambia orden", "No se puede"], correcta: 1, explicacion: "3×6=18 vs 14." },
  { id: "pD_mat_02", perfil: "perfilD", materia: "matematicas", nivel: "basico", pregunta: "¿121 es cuadrado perfecto?", opciones: ["Dividir entre 2", "11×11=121", "Imposible"], correcta: 1, explicacion: "11²=121." },
  { id: "pD_mat_03", perfil: "perfilD", materia: "matematicas", nivel: "medio", pregunta: "Ganas 5, pierdes 8. Resultado", opciones: ["3", "−3", "13"], correcta: 1, explicacion: "5−8=−3." },
  { id: "pD_mat_04", perfil: "perfilD", materia: "matematicas", nivel: "medio", pregunta: "Punto 2 derecha, 4 arriba", opciones: ["(4,2)", "(2,4)", "(−2,4)"], correcta: 1, explicacion: "Derecha=x+, arriba=y+." },
  { id: "pD_mat_05", perfil: "perfilD", materia: "matematicas", nivel: "avanzado", pregunta: "Comprobar m.c.m.", opciones: ["Sumando", "Ambos dividen resultado", "×10"], correcta: 1, explicacion: "Múltiplo de ambos." },
  { id: "pD_len_01", perfil: "perfilD", materia: "lengua", nivel: "basico", pregunta: "Pistas para inferir", opciones: ["Adivinanza", "Contexto y acciones", "Índice"], correcta: 1, explicacion: "Inferencia usa contexto." },
  { id: "pD_len_02", perfil: "perfilD", materia: "lengua", nivel: "basico", pregunta: "Pronombre 'María y Juan'", opciones: ["él", "ella", "ellos"], correcta: 2, explicacion: "Plural mixto → ellos." },
  { id: "pD_len_03", perfil: "perfilD", materia: "lengua", nivel: "medio", pregunta: "Inicio para leyenda", opciones: ["Querido diario", "Cuenta la leyenda que…", "1+1=2"], correcta: 1, explicacion: "Fórmulas evocadoras." },
  { id: "pD_len_04", perfil: "perfilD", materia: "lengua", nivel: "medio", pregunta: "Enriquecer 'El gato duerme'", opciones: ["El gato duerme", "El gato gris duerme plácidamente", "Gato"], correcta: 1, explicacion: "Adjetivos enriquecen." },
  { id: "pD_len_05", perfil: "perfilD", materia: "lengua", nivel: "avanzado", pregunta: "Título texto robots", opciones: ["Matemáticas", "Robots en el aula: aprender con tecnología", "Llovió"], correcta: 1, explicacion: "Resume el tema." },
  { id: "pD_med_01", perfil: "perfilD", materia: "medio", nivel: "basico", pregunta: "Maqueta digestivo: primero", opciones: ["Estómago", "Boca", "Intestino"], correcta: 1, explicacion: "Digestión empieza en boca." },
  { id: "pD_med_02", perfil: "perfilD", materia: "medio", nivel: "basico", pregunta: "Diferencia órgano y aparato", opciones: ["Iguales", "Órgano parte; aparato agrupa", "Aparato menor"], correcta: 1, explicacion: "Aparato = conjunto órganos." },
  { id: "pD_med_03", perfil: "perfilD", materia: "medio", nivel: "medio", pregunta: "Mapa temático vs físico", opciones: ["Iguales", "Info distinta", "Temático más grande"], correcta: 1, explicacion: "Propósito diferente." },
  { id: "pD_med_04", perfil: "perfilD", materia: "medio", nivel: "medio", pregunta: "Clima seco → vegetación", opciones: ["Bosques densos", "Matorrales adaptados", "Selva"], correcta: 1, explicacion: "Resistente a sequía." },
  { id: "pD_med_05", perfil: "perfilD", materia: "medio", nivel: "avanzado", pregunta: "Ciudad más sostenible", opciones: ["Más coches", "Transporte público y verde", "Talar"], correcta: 1, explicacion: "Transporte limpio + naturaleza." },
  { id: "pD_dig_01", perfil: "perfilD", materia: "digital", nivel: "basico", pregunta: "Videojuego reacciona a tecla usa", opciones: ["Bucle", "Condicional", "Nada"], correcta: 1, explicacion: "Si pulsas → ocurre algo." },
  { id: "pD_dig_02", perfil: "perfilD", materia: "digital", nivel: "basico", pregunta: "Repetir movimiento 10 veces", opciones: ["Variable", "Bucle", "Condicional"], correcta: 1, explicacion: "Repetir N = bucle." },
  { id: "pD_dig_03", perfil: "perfilD", materia: "digital", nivel: "medio", pregunta: "Depurar un programa es", opciones: ["Borrarlo", "Corregir errores", "Copiarlo"], correcta: 1, explicacion: "Encontrar y arreglar fallos." },
  { id: "pD_dig_04", perfil: "perfilD", materia: "digital", nivel: "medio", pregunta: "App pide micro sin necesitarlo", opciones: ["Aceptar", "Denegar permiso", "Desinstalar"], correcta: 1, explicacion: "Solo permisos necesarios." },
  { id: "pD_dig_05", perfil: "perfilD", materia: "digital", nivel: "avanzado", pregunta: "Proyecto STEAM combina", opciones: ["Solo mates", "Ciencia, tecnología, ingeniería, arte, mates", "Solo arte"], correcta: 1, explicacion: "Integra disciplinas." },
  { id: "pD_ing_01", perfil: "perfilD", materia: "ingles", nivel: "basico", pregunta: "Pedir ayuda en clase", opciones: ["Give me now", "Can you help me, please?", "I no understand"], correcta: 1, explicacion: "Forma correcta y educada." },
  { id: "pD_ing_02", perfil: "perfilD", materia: "ingles", nivel: "basico", pregunta: "'We are building a robot'", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Are building → progreso." },
  { id: "pD_ing_03", perfil: "perfilD", materia: "ingles", nivel: "medio", pregunta: "Past Simple con 'see'", opciones: ["I see a bird", "I saw a bird yesterday", "I seeing"], correcta: 1, explicacion: "See → saw." },
  { id: "pD_ing_04", perfil: "perfilD", materia: "ingles", nivel: "medio", pregunta: "Traduce 'curioso'", opciones: ["boring", "curious", "angry"], correcta: 1, explicacion: "Curious = curioso." },
  { id: "pD_ing_05", perfil: "perfilD", materia: "ingles", nivel: "avanzado", pregunta: "'My friends usually ___ games'", opciones: ["plays", "play", "playing"], correcta: 1, explicacion: "They → play." },
  { id: "pE_mat_01", perfil: "perfilE", materia: "matematicas", nivel: "basico", pregunta: "2km + 3km =", opciones: ["4km", "5km", "6km"], correcta: 1, explicacion: "2+3=5." },
  { id: "pE_mat_02", perfil: "perfilE", materia: "matematicas", nivel: "basico", pregunta: "5 naranjas = 10€. Una vale", opciones: ["1€", "2€", "5€"], correcta: 1, explicacion: "10÷5=2." },
  { id: "pE_mat_03", perfil: "perfilE", materia: "matematicas", nivel: "medio", pregunta: "Barco a −2m indica", opciones: ["Encima agua", "Bajo nivel referencia", "2km"], correcta: 1, explicacion: "Negativo = bajo referencia." },
  { id: "pE_mat_04", perfil: "perfilE", materia: "matematicas", nivel: "medio", pregunta: "Escala 1cm=1km. 7cm son", opciones: ["3,5km", "7km", "14km"], correcta: 1, explicacion: "7×1=7." },
  { id: "pE_mat_05", perfil: "perfilE", materia: "matematicas", nivel: "avanzado", pregunta: "Mayor: −1 o −5", opciones: ["−5", "−1", "Iguales"], correcta: 1, explicacion: "−1 más cerca de 0." },
  { id: "pE_len_01", perfil: "perfilE", materia: "lengua", nivel: "basico", pregunta: "'Mar' y 'océano' son", opciones: ["Antónimos", "Sinónimos parciales", "Homónimos"], correcta: 1, explicacion: "Masas agua similares." },
  { id: "pE_len_02", perfil: "perfilE", materia: "lengua", nivel: "basico", pregunta: "Texto descriptivo se centra en", opciones: ["Qué pasó", "Cómo es algo", "Opinión"], correcta: 1, explicacion: "Describir = cómo es." },
  { id: "pE_len_03", perfil: "perfilE", materia: "lengua", nivel: "medio", pregunta: "Corrige: 'El camion paso rapido'", opciones: ["El camion paso rapido", "El camión pasó rápido", "El camiòn pasò"], correcta: 1, explicacion: "Tildes necesarias." },
  { id: "pE_len_04", perfil: "perfilE", materia: "lengua", nivel: "medio", pregunta: "Un retrato describe", opciones: ["Solo físico", "Físico y carácter", "Solo gustos"], correcta: 1, explicacion: "Prosopografía + etopeya." },
  { id: "pE_len_05", perfil: "perfilE", materia: "lengua", nivel: "avanzado", pregunta: "Adjetivo para playa", opciones: ["Corriendo", "Tranquila", "Ayer"], correcta: 1, explicacion: "Tranquila describe lugar." },
  { id: "pE_med_01", perfil: "perfilE", materia: "medio", nivel: "basico", pregunta: "Un archipiélago es", opciones: ["Montaña", "Conjunto de islas", "Río"], correcta: 1, explicacion: "Grupo de islas." },
  { id: "pE_med_02", perfil: "perfilE", materia: "medio", nivel: "basico", pregunta: "Latitud se mide con", opciones: ["Meridianos", "Paralelos", "Brújula"], correcta: 1, explicacion: "Paralelos miden latitud." },
  { id: "pE_med_03", perfil: "perfilE", materia: "medio", nivel: "medio", pregunta: "Costa mediterránea", opciones: ["Mucha lluvia", "Clima templado y turismo", "Nieve"], correcta: 1, explicacion: "Clima suave." },
  { id: "pE_med_04", perfil: "perfilE", materia: "medio", nivel: "medio", pregunta: "Actividad económica mar", opciones: ["Minería", "Pesca y turismo", "Ganadería"], correcta: 1, explicacion: "Pesca, turismo." },
  { id: "pE_med_05", perfil: "perfilE", materia: "medio", nivel: "avanzado", pregunta: "Agua es importante para", opciones: ["Solo beber", "Seres vivos, clima, actividades", "Nada"], correcta: 1, explicacion: "Esencial para vida." },
  { id: "pE_dig_01", perfil: "perfilE", materia: "digital", nivel: "basico", pregunta: "Presentación clara tiene", opciones: ["Mucho texto", "Pocas palabras ordenadas", "Muchos colores"], correcta: 1, explicacion: "Menos = más claro." },
  { id: "pE_dig_02", perfil: "perfilE", materia: "digital", nivel: "basico", pregunta: "Subir a nube requiere", opciones: ["Nada", "Conexión y seguridad", "Cable USB"], correcta: 1, explicacion: "Internet + precaución." },
  { id: "pE_dig_03", perfil: "perfilE", materia: "digital", nivel: "medio", pregunta: "'Sol!29Azul' es contraseña", opciones: ["Débil", "Más segura", "Igual a 123456"], correcta: 1, explicacion: "Mezcla caracteres." },
  { id: "pE_dig_04", perfil: "perfilE", materia: "digital", nivel: "medio", pregunta: "Enlace raro por chat", opciones: ["Abrirlo", "No abrir y avisar", "Compartir"], correcta: 1, explicacion: "Sospechoso = peligro." },
  { id: "pE_dig_05", perfil: "perfilE", materia: "digital", nivel: "avanzado", pregunta: "Archivo bien nombrado facilita", opciones: ["Pesar menos", "Organización y búsqueda", "Borrarse"], correcta: 1, explicacion: "Buenos nombres." },
  { id: "pE_ing_01", perfil: "perfilE", materia: "ingles", nivel: "basico", pregunta: "'The sea is beautiful' vocabulario", opciones: ["Colegio", "Naturaleza", "Deportes"], correcta: 1, explicacion: "Sea → naturaleza." },
  { id: "pE_ing_02", perfil: "perfilE", materia: "ingles", nivel: "basico", pregunta: "'I am swimming now'", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Am swimming + now." },
  { id: "pE_ing_03", perfil: "perfilE", materia: "ingles", nivel: "medio", pregunta: "Past Simple 'have'", opciones: ["haved", "had", "having"], correcta: 1, explicacion: "Have → had." },
  { id: "pE_ing_04", perfil: "perfilE", materia: "ingles", nivel: "medio", pregunta: "Traduce 'isla'", opciones: ["mountain", "island", "river"], correcta: 1, explicacion: "Island = isla." },
  { id: "pE_ing_05", perfil: "perfilE", materia: "ingles", nivel: "avanzado", pregunta: "'She usually ___ to beach'", opciones: ["go", "goes", "going"], correcta: 1, explicacion: "She → goes." },
  { id: "pF_mat_01", perfil: "perfilF", materia: "matematicas", nivel: "basico", pregunta: "12km, mitad =", opciones: ["4km", "6km", "8km"], correcta: 1, explicacion: "12÷2=6." },
  { id: "pF_mat_02", perfil: "perfilF", materia: "matematicas", nivel: "basico", pregunta: "De −2ºC a 4ºC sube", opciones: ["2ºC", "6ºC", "8ºC"], correcta: 1, explicacion: "De −2 a 4 = 6." },
  { id: "pF_mat_03", perfil: "perfilF", materia: "matematicas", nivel: "medio", pregunta: "Más cerca de 0: −1 o −4", opciones: ["−4", "−1", "Iguales"], correcta: 1, explicacion: "−1 a 1 unidad." },
  { id: "pF_mat_04", perfil: "perfilF", materia: "matematicas", nivel: "medio", pregunta: "3 cajas × 8 manzanas", opciones: ["11", "24", "32"], correcta: 1, explicacion: "3×8=24." },
  { id: "pF_mat_05", perfil: "perfilF", materia: "matematicas", nivel: "avanzado", pregunta: "Raíz cuadrada de 49", opciones: ["6", "7", "8"], correcta: 1, explicacion: "7×7=49." },
  { id: "pF_len_01", perfil: "perfilF", materia: "lengua", nivel: "basico", pregunta: "Homónimo puede", opciones: ["Sonar igual distinto significado", "Significar lo mismo", "No existir"], correcta: 0, explicacion: "Suenan o escriben igual." },
  { id: "pF_len_02", perfil: "perfilF", materia: "lengua", nivel: "basico", pregunta: "'Aquella torre antigua': adjetivo", opciones: ["aquella", "torre", "antigua"], correcta: 2, explicacion: "Antigua califica torre." },
  { id: "pF_len_03", perfil: "perfilF", materia: "lengua", nivel: "medio", pregunta: "'Música' es palabra", opciones: ["aguda", "llana", "esdrújula"], correcta: 2, explicacion: "Mú-si-ca: antepenúltima." },
  { id: "pF_len_04", perfil: "perfilF", materia: "lengua", nivel: "medio", pregunta: "Leyenda mezcla", opciones: ["Solo real", "Reales y fantásticos", "Solo fantasía"], correcta: 1, explicacion: "Real + fantástico." },
  { id: "pF_len_05", perfil: "perfilF", materia: "lengua", nivel: "avanzado", pregunta: "Descripción paisaje lluvioso", opciones: ["Hacía sol", "Cielo gris, lluvia fina", "1+1=2"], correcta: 1, explicacion: "Adjetivos sensoriales." },
  { id: "pF_med_01", perfil: "perfilF", materia: "medio", nivel: "basico", pregunta: "Una ría es", opciones: ["Volcán", "Entrada del mar en costa", "Árbol"], correcta: 1, explicacion: "Típicas de Galicia." },
  { id: "pF_med_02", perfil: "perfilF", materia: "medio", nivel: "basico", pregunta: "Seres pluricelulares tienen", opciones: ["Una célula", "Muchas células", "Ninguna"], correcta: 1, explicacion: "Pluri = muchas." },
  { id: "pF_med_03", perfil: "perfilF", materia: "medio", nivel: "medio", pregunta: "La lluvia influye en", opciones: ["Nada", "Vegetación, ríos, paisaje", "Solo mar"], correcta: 1, explicacion: "Modela el paisaje." },
  { id: "pF_med_04", perfil: "perfilF", materia: "medio", nivel: "medio", pregunta: "Pulmones realizan", opciones: ["Digestión", "Intercambio gaseoso", "Filtrado"], correcta: 1, explicacion: "O₂ y CO₂." },
  { id: "pF_med_05", perfil: "perfilF", materia: "medio", nivel: "avanzado", pregunta: "Mapa físico representa", opciones: ["Datos población", "Relieve, ríos, montañas", "Rutas bus"], correcta: 1, explicacion: "Geografía natural." },
  { id: "pF_dig_01", perfil: "perfilF", materia: "digital", nivel: "basico", pregunta: "Info fiable implica", opciones: ["Primer enlace", "Comprobar fuente", "Copiar sin leer"], correcta: 1, explicacion: "Verificar fuente." },
  { id: "pF_dig_02", perfil: "perfilF", materia: "digital", nivel: "basico", pregunta: "Datos personales en foro es", opciones: ["Seguro", "Arriesgado", "Obligatorio"], correcta: 1, explicacion: "Proteger datos." },
  { id: "pF_dig_03", perfil: "perfilF", materia: "digital", nivel: "medio", pregunta: "Carpeta 'Proyectos/Ciencias'", opciones: ["Desordenada", "Bien clasificada", "Vacía"], correcta: 1, explicacion: "Subcarpetas temáticas." },
  { id: "pF_dig_04", perfil: "perfilF", materia: "digital", nivel: "medio", pregunta: "Condicional en bloques para", opciones: ["Repetir", "Tomar decisiones", "Borrar"], correcta: 1, explicacion: "Si…entonces." },
  { id: "pF_dig_05", perfil: "perfilF", materia: "digital", nivel: "avanzado", pregunta: "Antes publicar imagen clase", opciones: ["Publicar rápido", "Tener permiso", "Editar"], correcta: 1, explicacion: "Consentimiento." },
  { id: "pF_ing_01", perfil: "perfilF", materia: "ingles", nivel: "basico", pregunta: "'It is raining'", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Is raining → progreso." },
  { id: "pF_ing_02", perfil: "perfilF", materia: "ingles", nivel: "basico", pregunta: "Traduce 'montaña'", opciones: ["river", "mountain", "beach"], correcta: 1, explicacion: "Mountain." },
  { id: "pF_ing_03", perfil: "perfilF", materia: "ingles", nivel: "medio", pregunta: "Past Simple 'do'", opciones: ["doed", "did", "done"], correcta: 1, explicacion: "Do → did." },
  { id: "pF_ing_04", perfil: "perfilF", materia: "ingles", nivel: "medio", pregunta: "'We usually read in class'", opciones: ["Futuro", "Hábito", "Pasado"], correcta: 1, explicacion: "Usually = hábito." },
  { id: "pF_ing_05", perfil: "perfilF", materia: "ingles", nivel: "avanzado", pregunta: "'Yesterday I ___ homework'", opciones: ["do", "did", "doing"], correcta: 1, explicacion: "Yesterday → did." },
  { id: "pG_mat_01", perfil: "perfilG", materia: "matematicas", nivel: "basico", pregunta: "De 200m a 700m, asciendes", opciones: ["200m", "500m", "700m"], correcta: 1, explicacion: "700−200=500." },
  { id: "pG_mat_02", perfil: "perfilG", materia: "matematicas", nivel: "basico", pregunta: "De −1ºC a 3ºC, diferencia", opciones: ["2ºC", "4ºC", "3ºC"], correcta: 1, explicacion: "De −1 a 3 = 4." },
  { id: "pG_mat_03", perfil: "perfilG", materia: "matematicas", nivel: "medio", pregunta: "15km en 3 tramos iguales", opciones: ["3km", "5km", "7km"], correcta: 1, explicacion: "15÷3=5." },
  { id: "pG_mat_04", perfil: "perfilG", materia: "matematicas", nivel: "medio", pregunta: "Punto 1 izquierda, 2 arriba", opciones: ["(1,2)", "(−1,2)", "(2,−1)"], correcta: 1, explicacion: "Izq=x−, arriba=y+." },
  { id: "pG_mat_05", perfil: "perfilG", materia: "matematicas", nivel: "avanzado", pregunta: "m.c.m. 3 y 5", opciones: ["8", "15", "30"], correcta: 1, explicacion: "Primos → 3×5=15." },
  { id: "pG_len_01", perfil: "perfilG", materia: "lengua", nivel: "basico", pregunta: "Texto expositivo explica", opciones: ["Historia inventada", "Información tema", "Chiste"], correcta: 1, explicacion: "Informan sobre temas." },
  { id: "pG_len_02", perfil: "perfilG", materia: "lengua", nivel: "basico", pregunta: "'Océano' lleva tilde porque", opciones: ["Aguda", "Llana", "Esdrújula"], correcta: 2, explicacion: "O-cé-a-no: antepenúltima." },
  { id: "pG_len_03", perfil: "perfilG", materia: "lengua", nivel: "medio", pregunta: "Idea ecosistemas canarios", opciones: ["Coches", "Ecosistemas únicos", "Llovió"], correcta: 1, explicacion: "Tema principal." },
  { id: "pG_len_04", perfil: "perfilG", materia: "lengua", nivel: "medio", pregunta: "'Seco' y 'húmedo' son", opciones: ["Sinónimos", "Antónimos", "Homónimos"], correcta: 1, explicacion: "Opuestos." },
  { id: "pG_len_05", perfil: "perfilG", materia: "lengua", nivel: "avanzado", pregunta: "Adjetivo para volcán", opciones: ["Rápido", "Imponente", "Dulce"], correcta: 1, explicacion: "Transmite grandeza." },
  { id: "pG_med_01", perfil: "perfilG", materia: "medio", nivel: "basico", pregunta: "Un volcán es", opciones: ["Río", "Abertura corteza con magma", "Lago"], correcta: 1, explicacion: "Expulsa magma." },
  { id: "pG_med_02", perfil: "perfilG", materia: "medio", nivel: "basico", pregunta: "Biodiversidad significa", opciones: ["Muchos edificios", "Variedad seres vivos", "Tipo roca"], correcta: 1, explicacion: "Bio+diversidad." },
  { id: "pG_med_03", perfil: "perfilG", materia: "medio", nivel: "medio", pregunta: "Relieve insular condiciona", opciones: ["Solo temperatura", "Clima, cultivos, comunicaciones", "Idioma"], correcta: 1, explicacion: "Geografía afecta vida." },
  { id: "pG_med_04", perfil: "perfilG", materia: "medio", nivel: "medio", pregunta: "Respiración ocurre en", opciones: ["Corazón", "Pulmones", "Hígado"], correcta: 1, explicacion: "Órgano principal." },
  { id: "pG_med_05", perfil: "perfilG", materia: "medio", nivel: "avanzado", pregunta: "Especie endémica vive", opciones: ["Todo el mundo", "Lugar concreto", "Solo agua"], correcta: 1, explicacion: "Exclusivo territorio." },
  { id: "pG_dig_01", perfil: "perfilG", materia: "digital", nivel: "basico", pregunta: "Presentación volcán exige", opciones: ["Solo fotos", "Buscar, ordenar, resumir", "Copiar todo"], correcta: 1, explicacion: "Investigación y síntesis." },
  { id: "pG_dig_02", perfil: "perfilG", materia: "digital", nivel: "basico", pregunta: "Algoritmo excursión incluye", opciones: ["Solo diversión", "Pasos ordenados", "Nada"], correcta: 1, explicacion: "Ordena pasos." },
  { id: "pG_dig_03", perfil: "perfilG", materia: "digital", nivel: "medio", pregunta: "Enlace acortado desconocido", opciones: ["Siempre seguro", "Peligroso", "Más rápido"], correcta: 1, explicacion: "Puede ocultar malware." },
  { id: "pG_dig_04", perfil: "perfilG", materia: "digital", nivel: "medio", pregunta: "Identidad digital es", opciones: ["Nombre real", "Huella en internet", "Contraseña"], correcta: 1, explicacion: "Lo que publicas." },
  { id: "pG_dig_05", perfil: "perfilG", materia: "digital", nivel: "avanzado", pregunta: "MakeCode con sensores trabaja", opciones: ["Solo escritura", "Programación y datos", "Solo dibujo"], correcta: 1, explicacion: "Programación + hardware." },
  { id: "pG_ing_01", perfil: "perfilG", materia: "ingles", nivel: "basico", pregunta: "'Volcano is very high' vocabulario", opciones: ["Colegio", "Naturaleza", "Comida"], correcta: 1, explicacion: "Volcano → naturaleza." },
  { id: "pG_ing_02", perfil: "perfilG", materia: "ingles", nivel: "basico", pregunta: "'We are visiting island now'", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Are visiting + now." },
  { id: "pG_ing_03", perfil: "perfilG", materia: "ingles", nivel: "medio", pregunta: "Past Simple 'be' (I/he)", opciones: ["were", "was", "been"], correcta: 1, explicacion: "I/he → was." },
  { id: "pG_ing_04", perfil: "perfilG", materia: "ingles", nivel: "medio", pregunta: "Traduce 'forest'", opciones: ["playa", "bosque", "montaña"], correcta: 1, explicacion: "Forest = bosque." },
  { id: "pG_ing_05", perfil: "perfilG", materia: "ingles", nivel: "avanzado", pregunta: "'They usually ___ in sea'", opciones: ["swims", "swim", "swimming"], correcta: 1, explicacion: "They → swim." },
  { id: "pH_mat_01", perfil: "perfilH", materia: "matematicas", nivel: "basico", pregunta: "18 − 4 × 2", opciones: ["28", "10", "14"], correcta: 1, explicacion: "4×2=8, 18−8=10." },
  { id: "pH_mat_02", perfil: "perfilH", materia: "matematicas", nivel: "basico", pregunta: "Divisible entre 2 y 5 termina en", opciones: ["5", "0", "1"], correcta: 1, explicacion: "Par + 0/5 → 0." },
  { id: "pH_mat_03", perfil: "perfilH", materia: "matematicas", nivel: "medio", pregunta: "Ordena: 3,−2,5,0", opciones: ["3,−2,5,0", "−2,0,3,5", "5,3,0,−2"], correcta: 1, explicacion: "De menor a mayor." },
  { id: "pH_mat_04", perfil: "perfilH", materia: "matematicas", nivel: "medio", pregunta: "Escala 1:100000. 1cm son", opciones: ["100m", "1km", "10km"], correcta: 1, explicacion: "100.000cm=1km." },
  { id: "pH_mat_05", perfil: "perfilH", materia: "matematicas", nivel: "avanzado", pregunta: "Raíz cuadrada 64", opciones: ["6", "8", "10"], correcta: 1, explicacion: "8×8=64." },
  { id: "pH_len_01", perfil: "perfilH", materia: "lengua", nivel: "basico", pregunta: "'Mis dos amigos': posesivo", opciones: ["dos", "amigos", "mis"], correcta: 2, explicacion: "Mis = posesión." },
  { id: "pH_len_02", perfil: "perfilH", materia: "lengua", nivel: "basico", pregunta: "'Camión' es palabra", opciones: ["llana", "aguda", "esdrújula"], correcta: 1, explicacion: "Última sílaba tónica." },
  { id: "pH_len_03", perfil: "perfilH", materia: "lengua", nivel: "medio", pregunta: "Pronombre personal sustituye", opciones: ["Verbo", "Nombre o GN", "Adjetivo"], correcta: 1, explicacion: "Reemplaza sustantivos." },
  { id: "pH_len_04", perfil: "perfilH", materia: "lengua", nivel: "medio", pregunta: "Descripción persona incluye", opciones: ["Solo peso", "Rasgos físicos y carácter", "Solo edad"], correcta: 1, explicacion: "Físico + personalidad." },
  { id: "pH_len_05", perfil: "perfilH", materia: "lengua", nivel: "avanzado", pregunta: "'Subir' y 'bajar' son", opciones: ["Sinónimos", "Antónimos", "Homónimos"], correcta: 1, explicacion: "Contrarios." },
  { id: "pH_med_01", perfil: "perfilH", materia: "medio", nivel: "basico", pregunta: "Circulatorio transporta", opciones: ["Aire", "Sangre y sustancias", "Comida"], correcta: 1, explicacion: "Nutrientes y oxígeno." },
  { id: "pH_med_02", perfil: "perfilH", materia: "medio", nivel: "basico", pregunta: "Río nace en", opciones: ["Mar", "Nacimiento o zona alta", "Ciudad"], correcta: 1, explicacion: "Montañas o manantiales." },
  { id: "pH_med_03", perfil: "perfilH", materia: "medio", nivel: "medio", pregunta: "Paralelos miden", opciones: ["Longitud", "Latitud", "Altitud"], correcta: 1, explicacion: "Latitud norte-sur." },
  { id: "pH_med_04", perfil: "perfilH", materia: "medio", nivel: "medio", pregunta: "Organismo unicelular tiene", opciones: ["Muchas células", "Una sola célula", "Ninguna"], correcta: 1, explicacion: "Uni = una." },
  { id: "pH_med_05", perfil: "perfilH", materia: "medio", nivel: "avanzado", pregunta: "Relieve influye en", opciones: ["Solo color suelo", "Clima, comunicaciones, población", "Nada"], correcta: 1, explicacion: "Condiciona muchos aspectos." },
  { id: "pH_dig_01", perfil: "perfilH", materia: "digital", nivel: "basico", pregunta: "Mejor: '123456' o 'Nube!84Sol'", opciones: ["123456", "Nube!84Sol", "Iguales"], correcta: 1, explicacion: "Mezclar caracteres." },
  { id: "pH_dig_02", perfil: "perfilH", materia: "digital", nivel: "basico", pregunta: "Archivo perdido se recupera si", opciones: ["Nunca se guardó", "Bien guardado y nombrado", "Borrado adrede"], correcta: 1, explicacion: "Buena organización." },
  { id: "pH_dig_03", perfil: "perfilH", materia: "digital", nivel: "medio", pregunta: "Bucle sirve para", opciones: ["Borrar datos", "Repetir instrucciones", "Apagar"], correcta: 1, explicacion: "Ejecuta varias veces." },
  { id: "pH_dig_04", perfil: "perfilH", materia: "digital", nivel: "medio", pregunta: "No enviar dirección porque", opciones: ["Aburrido", "Dato personal sensible", "Obligatorio"], correcta: 1, explicacion: "Info privada." },
  { id: "pH_dig_05", perfil: "perfilH", materia: "digital", nivel: "avanzado", pregunta: "Documento compartido requiere", opciones: ["Copiar mil veces", "Uso responsable y permisos", "Borrar"], correcta: 1, explicacion: "Respeto y permisos." },
  { id: "pH_ing_01", perfil: "perfilH", materia: "ingles", nivel: "basico", pregunta: "'I usually go to school by bus'", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 0, explicacion: "Usually → hábito." },
  { id: "pH_ing_02", perfil: "perfilH", materia: "ingles", nivel: "basico", pregunta: "'She is writing a story now'", opciones: ["Present Simple", "Present Continuous", "Past Simple"], correcta: 1, explicacion: "Is writing + now." },
  { id: "pH_ing_03", perfil: "perfilH", materia: "ingles", nivel: "medio", pregunta: "Past Simple 'buy'", opciones: ["buyed", "bought", "buying"], correcta: 1, explicacion: "Buy → bought." },
  { id: "pH_ing_04", perfil: "perfilH", materia: "ingles", nivel: "medio", pregunta: "Traduce 'friendly'", opciones: ["enfadado", "amable", "triste"], correcta: 1, explicacion: "Friendly = amable." },
  { id: "pH_ing_05", perfil: "perfilH", materia: "ingles", nivel: "avanzado", pregunta: "'Yesterday we ___ a film'", opciones: ["see", "saw", "seeing"], correcta: 1, explicacion: "Yesterday → saw." }
];

export function getQuestionsByPerfil(perfil) {
  return QUESTIONS_BANK.filter((q) => q.perfil === perfil);
}
export function getQuestionsByMateria(materia) {
  return QUESTIONS_BANK.filter((q) => q.materia === materia);
}
export function getQuestionsByNivel(nivel) {
  return QUESTIONS_BANK.filter((q) => q.nivel === nivel);
}
export function getRandomQuestions(perfil, materia, nivel, count) {
  count = count || 5;
  let pool = QUESTIONS_BANK.filter((q) =>
    (!perfil || q.perfil === perfil) &&
    (!materia || q.materia === materia) &&
    (!nivel || q.nivel === nivel)
  );
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, count);
}

QUESTIONS_EOF
echo "✅ src/core/questions-ccaa.js (200 preguntas LOMLOE)"

cat << 'ENGINE_EOF' > src/core/adaptive-engine.js
import { getRandomQuestions } from "./questions-ccaa.js";

const LEVELS = ["basico", "medio", "avanzado"];
const POINTS_MAP = { basico: 10, medio: 20, avanzado: 30 };
const GAME_LEVELS = [
  { name: "Explorador", icon: "🔍", min: 0, max: 99 },
  { name: "Aventurero", icon: "🗺️", min: 100, max: 299 },
  { name: "Sabio", icon: "📚", min: 300, max: 599 },
  { name: "Maestro", icon: "🏆", min: 600, max: Infinity }
];

export class AdaptiveEngine {
  constructor(perfil) {
    this.perfil = perfil;
    this.history = [];
    this.streaks = {};
    this.levels = {};
    this.answeredIds = new Set();
    this.totalPoints = 0;
    this.currentStreak = 0;
  }

  _ensureMateria(materia) {
    if (!this.streaks[materia]) this.streaks[materia] = { correct: 0, wrong: 0 };
    if (!this.levels[materia]) this.levels[materia] = "basico";
  }

  track(questionId, materia, correct) {
    this._ensureMateria(materia);
    this.answeredIds.add(questionId);

    let pointsEarned = 0;
    if (correct) {
      const nivel = this.levels[materia];
      pointsEarned = POINTS_MAP[nivel] || 10;
      this.currentStreak += 1;
      if (this.currentStreak > 0 && this.currentStreak % 3 === 0) {
        pointsEarned += 5;
      }
      this.totalPoints += pointsEarned;
      this.streaks[materia].correct += 1;
      this.streaks[materia].wrong = 0;
    } else {
      this.currentStreak = 0;
      this.streaks[materia].wrong += 1;
      this.streaks[materia].correct = 0;
    }

    this.history.push({ questionId, materia, correct, pointsEarned, timestamp: Date.now() });

    const idx = LEVELS.indexOf(this.levels[materia]);
    if (this.streaks[materia].correct >= 3 && idx < LEVELS.length - 1) {
      this.levels[materia] = LEVELS[idx + 1];
      this.streaks[materia].correct = 0;
    }
    if (this.streaks[materia].wrong >= 2 && idx > 0) {
      this.levels[materia] = LEVELS[idx - 1];
      this.streaks[materia].wrong = 0;
    }

    return pointsEarned;
  }

  getLevel(materia) { this._ensureMateria(materia); return this.levels[materia]; }

  getLevelInfo() {
    const current = GAME_LEVELS.find((l) => this.totalPoints >= l.min && this.totalPoints <= l.max) || GAME_LEVELS[0];
    const nextIdx = GAME_LEVELS.indexOf(current) + 1;
    const next = nextIdx < GAME_LEVELS.length ? GAME_LEVELS[nextIdx] : null;
    const progress = next ? Math.min(100, Math.round(((this.totalPoints - current.min) / (next.min - current.min)) * 100)) : 100;
    return {
      name: current.name,
      icon: current.icon,
      totalPoints: this.totalPoints,
      currentStreak: this.currentStreak,
      nextLevel: next ? next.name : null,
      pointsToNext: next ? next.min - this.totalPoints : 0,
      progress
    };
  }

  getNextQuestions(materia, count) {
    count = count || 5;
    const nivel = this.getLevel(materia);
    let pool = getRandomQuestions(this.perfil, materia, nivel, count + 10);
    pool = pool.filter((q) => !this.answeredIds.has(q.id));
    if (pool.length < count) {
      const extra = getRandomQuestions(this.perfil, materia, null, count + 10);
      pool = [...pool, ...extra.filter((q) => !this.answeredIds.has(q.id))];
    }
    return pool.slice(0, count);
  }

  getStats() {
    const total = this.history.length;
    const correct = this.history.filter((h) => h.correct).length;
    const byMateria = {};
    for (const h of this.history) {
      if (!byMateria[h.materia]) byMateria[h.materia] = { total: 0, correct: 0 };
      byMateria[h.materia].total += 1;
      if (h.correct) byMateria[h.materia].correct += 1;
    }
    return {
      totalAnswered: total, totalCorrect: correct,
      accuracy: total > 0 ? Math.round((correct / total) * 100) : 0,
      totalPoints: this.totalPoints, currentStreak: this.currentStreak,
      levelByMateria: { ...this.levels }, statsByMateria: byMateria,
      levelInfo: this.getLevelInfo()
    };
  }

  getTodayStats() {
    const today = new Date().toISOString().slice(0, 10);
    const todayHistory = this.history.filter((h) => new Date(h.timestamp).toISOString().slice(0, 10) === today);
    const total = todayHistory.length;
    const correct = todayHistory.filter((h) => h.correct).length;
    const points = todayHistory.reduce((s, h) => s + (h.pointsEarned || 0), 0);
    const materias = [...new Set(todayHistory.map((h) => h.materia))];
    return { total, correct, accuracy: total > 0 ? Math.round((correct / total) * 100) : 0, points, materias };
  }

  reset() { this.history = []; this.streaks = {}; this.levels = {}; this.answeredIds = new Set(); this.totalPoints = 0; this.currentStreak = 0; }

  toJSON() {
    return { perfil: this.perfil, history: this.history, streaks: this.streaks, levels: this.levels, answeredIds: Array.from(this.answeredIds), totalPoints: this.totalPoints, currentStreak: this.currentStreak };
  }

  static fromJSON(data) {
    const e = new AdaptiveEngine(data.perfil);
    e.history = data.history || []; e.streaks = data.streaks || {}; e.levels = data.levels || {};
    e.answeredIds = new Set(data.answeredIds || []); e.totalPoints = data.totalPoints || 0; e.currentStreak = data.currentStreak || 0;
    return e;
  }
}
ENGINE_EOF
echo "✅ src/core/adaptive-engine.js (con sistema de puntos y niveles)"

cat << 'QUIZ_EOF' > src/modules/learning/quiz-view.jsx
import React, { useEffect, useState } from "react";
import { AdaptiveEngine } from "../../core/adaptive-engine.js";
import { saveEncryptedJSON, loadEncryptedJSON } from "../../core/secure-store.js";

const MATERIAS = [
  { key: "matematicas", icon: "🧮", label: "Matemáticas" },
  { key: "lengua", icon: "📖", label: "Lengua" },
  { key: "medio", icon: "🌍", label: "Conocimiento del Medio" },
  { key: "digital", icon: "💻", label: "Competencia Digital" },
  { key: "ingles", icon: "🇬🇧", label: "Inglés" }
];
const NIVEL_LABELS = { basico: "⭐ Básico", medio: "⭐⭐ Medio", avanzado: "⭐⭐⭐ Avanzado" };

function BigButton({ correct, wrong, onClick, children, disabled }) {
  let cls = "rounded-2xl border px-5 py-4 text-left transition w-full font-medium ";
  if (correct) cls += "bg-emerald-100 border-emerald-500 text-emerald-900";
  else if (wrong) cls += "bg-rose-100 border-rose-500 text-rose-900";
  else cls += "bg-white hover:bg-slate-50 border-slate-200";
  return <button type="button" onClick={onClick} disabled={disabled} className={cls}>{children}</button>;
}

export default function QuizView({ perfil, teaMode, lowStim, parentPin, onStatsUpdate }) {
  const [engine, setEngine] = useState(null);
  const [materia, setMateria] = useState(null);
  const [questions, setQuestions] = useState([]);
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [answered, setAnswered] = useState(false);
  const [lastPoints, setLastPoints] = useState(0);
  const [showStats, setShowStats] = useState(false);

  useEffect(() => {
    async function load() {
      let loaded = null;
      if (parentPin && parentPin.length >= 4) {
        try {
          const data = await loadEncryptedJSON("adaptive_engine", parentPin, { namespace: "tgd_progress" });
          if (data && data.perfil === perfil) loaded = AdaptiveEngine.fromJSON(data);
        } catch (e) {}
      }
      const eng = loaded || new AdaptiveEngine(perfil);
      setEngine(eng);
      if (onStatsUpdate) onStatsUpdate(eng.getStats());
    }
    load();
  }, [perfil, parentPin]);

  async function saveProgress(eng) {
    if (parentPin && parentPin.length >= 4) {
      try { await saveEncryptedJSON("adaptive_engine", eng.toJSON(), parentPin, { namespace: "tgd_progress" }); } catch (e) {}
    }
    if (onStatsUpdate) onStatsUpdate(eng.getStats());
  }

  function startMateria(key) {
    if (!engine) return;
    setMateria(key); setQuestions(engine.getNextQuestions(key, 5));
    setIdx(0); setSelected(null); setAnswered(false); setShowStats(false); setLastPoints(0);
  }

  function handleSelect(i) {
    if (answered || !engine) return;
    setSelected(i); setAnswered(true);
    const qst = questions[idx];
    const pts = engine.track(qst.id, qst.materia, i === qst.correcta);
    setLastPoints(pts);
    saveProgress(engine);
  }

  function handleNext() {
    if (idx < questions.length - 1) { setIdx(idx + 1); setSelected(null); setAnswered(false); setLastPoints(0); }
    else setShowStats(true);
  }

  function backToSubjects() { setMateria(null); setQuestions([]); setIdx(0); setSelected(null); setAnswered(false); setShowStats(false); setLastPoints(0); }

  const stats = engine ? engine.getStats() : null;
  const levelInfo = engine ? engine.getLevelInfo() : null;
  const currentQ = questions[idx] || null;
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  if (!engine) return <div className="rounded-2xl border p-6 bg-white text-center">Cargando...</div>;

  const levelBar = levelInfo ? (
    <div className="rounded-2xl border bg-white p-4 space-y-2">
      <div className="flex items-center justify-between">
        <span className="font-semibold">{levelInfo.icon} {levelInfo.name}</span>
        <span className="text-sm text-slate-600">{levelInfo.totalPoints} pts</span>
      </div>
      <div className="w-full bg-slate-200 rounded-full h-3">
        <div className="bg-slate-900 h-3 rounded-full transition-all" style={{ width: levelInfo.progress + "%" }}></div>
      </div>
      {levelInfo.nextLevel && <p className="text-xs text-slate-500">{levelInfo.pointsToNext} pts para {levelInfo.nextLevel}</p>}
      {levelInfo.currentStreak > 0 && <p className="text-xs text-emerald-600">🔥 Racha: {stats.currentStreak}</p>}
    </div>
  ) : null;

  if (showStats) return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <h2 className="text-xl font-bold">Resultados</h2>
      {levelBar}
      <div className="grid sm:grid-cols-3 gap-4">
        <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{stats.totalAnswered}</p><p className="text-sm text-slate-600">Respondidas</p></div>
        <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold text-emerald-600">{stats.totalCorrect}</p><p className="text-sm text-slate-600">Correctas</p></div>
        <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{stats.accuracy}%</p><p className="text-sm text-slate-600">Precisión</p></div>
      </div>
      <div className="rounded-2xl border bg-white p-4 space-y-3">
        <h3 className="font-semibold">Nivel por asignatura</h3>
        {MATERIAS.map((m) => (
          <div key={m.key} className="flex items-center justify-between rounded-xl border p-3">
            <span>{m.icon} {m.label}</span>
            <span className="text-sm font-medium">{NIVEL_LABELS[engine.getLevel(m.key)]}</span>
          </div>
        ))}
      </div>
      <div className="flex flex-wrap gap-3">
        <button onClick={backToSubjects} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Volver</button>
        <button onClick={() => startMateria(materia)} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white">Repetir</button>
      </div>
    </div>
  );

  if (!materia) return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div><h2 className="text-xl font-bold">Aprender</h2><p className="text-sm text-slate-600">Elige asignatura. Las preguntas se adaptan a tu nivel.</p></div>
      {levelBar}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
        {MATERIAS.map((m) => (
          <button key={m.key} onClick={() => startMateria(m.key)} className="rounded-2xl border bg-white hover:bg-slate-50 p-5 text-left transition">
            <span className="text-3xl block mb-2">{m.icon}</span>
            <span className="font-semibold block">{m.label}</span>
            <span className="text-sm text-slate-500 block mt-1">Nivel: {NIVEL_LABELS[engine.getLevel(m.key)]}</span>
          </button>
        ))}
      </div>
    </div>
  );

  if (!currentQ) return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <p>No hay más preguntas disponibles.</p>
      <button onClick={backToSubjects} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Volver</button>
    </div>
  );

  const mi = MATERIAS.find((m) => m.key === materia);
  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold">{mi?.icon} {mi?.label}</h2>
          <p className="text-sm text-slate-600">Pregunta {idx + 1} de {questions.length} · {NIVEL_LABELS[engine.getLevel(materia)]}</p>
        </div>
        <div className="flex items-center gap-3">
          <span className="text-sm font-medium">{levelInfo?.icon} {levelInfo?.totalPoints} pts</span>
          <button onClick={backToSubjects} className="rounded-2xl border px-3 py-2 bg-white hover:bg-slate-50 text-sm">Volver</button>
        </div>
      </div>
      <div className="rounded-2xl border bg-white p-5"><p className="text-lg font-medium leading-relaxed">{currentQ.pregunta}</p></div>
      <div className="grid grid-cols-1 gap-3">
        {currentQ.opciones.map((opt, i) => (
          <BigButton key={i} onClick={() => handleSelect(i)} disabled={answered} correct={answered && i === currentQ.correcta} wrong={answered && i === selected && i !== currentQ.correcta}>{opt}</BigButton>
        ))}
      </div>
      {answered && (
        <div className="space-y-3">
          <div className={["rounded-2xl border p-4 text-sm", selected === currentQ.correcta ? "bg-emerald-50 text-emerald-900 border-emerald-200" : "bg-rose-50 text-rose-900 border-rose-200"].join(" ")}>
            <p className="font-semibold mb-1">
              {selected === currentQ.correcta ? "¡Correcto! 🎉" : "No es correcto 😕"}
              {lastPoints > 0 && <span className="ml-2 text-emerald-600 font-bold">+{lastPoints} pts</span>}
            </p>
            <p>{currentQ.explicacion}</p>
          </div>
          <button onClick={handleNext} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">
            {idx < questions.length - 1 ? "Siguiente pregunta" : "Ver resultados"}
          </button>
        </div>
      )}
    </div>
  );
}
QUIZ_EOF
echo "✅ src/modules/learning/quiz-view.jsx (con puntos y niveles)"

cat << 'APPV2_EOF' > src/App.jsx
import React, { useState } from "react";
import JournalView from "./modules/journal/journal-view.jsx";
import QuizView from "./modules/learning/quiz-view.jsx";
import { resolverPerfil, listarComunidades } from "./core/curriculum-profiles.js";

const TABS = [
  { key: "inicio", icon: "🏠", label: "Inicio" },
  { key: "aprender", icon: "📚", label: "Aprender" },
  { key: "diario", icon: "📓", label: "Diario" },
  { key: "ajustes", icon: "⚙️", label: "Ajustes" }
];

export default function App() {
  const [activeTab, setActiveTab] = useState("inicio");
  const [community, setCommunity] = useState("madrid");
  const [teaMode, setTeaMode] = useState(true);
  const [lowStim, setLowStim] = useState(true);
  const [parentPin, setParentPin] = useState("");
  const [engineStats, setEngineStats] = useState(null);

  const perfil = resolverPerfil(community);
  const comunidades = listarComunidades();
  const frame = lowStim ? "min-h-screen bg-slate-50 text-slate-900" : "min-h-screen bg-gradient-to-br from-violet-50 via-white to-cyan-50 text-slate-900";

  return (
    <div className={frame}>
      <div className="max-w-5xl mx-auto p-4 md:p-6 space-y-4">
        <header className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-2xl md:text-3xl font-bold tracking-tight">TGD · App educativa segura</h1>
            <p className="text-sm text-slate-600">Local-first · Sin telemetría · Sin rastreo · Cifrado local</p>
          </div>
          {engineStats?.levelInfo && (
            <div className="text-sm rounded-2xl border bg-white px-3 py-2">
              {engineStats.levelInfo.icon} {engineStats.levelInfo.name} · {engineStats.levelInfo.totalPoints} pts
            </div>
          )}
        </header>

        <nav className="flex flex-wrap gap-2">
          {TABS.map((tab) => (
            <button key={tab.key} onClick={() => setActiveTab(tab.key)}
              className={["rounded-2xl border px-4 py-3 text-sm font-medium transition", activeTab === tab.key ? "bg-slate-900 text-white border-slate-900" : "bg-white hover:bg-slate-50 border-slate-200"].join(" ")}>
              <span className="mr-1">{tab.icon}</span>{tab.label}
            </button>
          ))}
        </nav>

        {activeTab === "inicio" && (
          <div className="space-y-4">
            <div className="rounded-2xl border bg-white p-5 space-y-4">
              <h2 className="text-xl font-bold">Bienvenido</h2>
              <p className="text-slate-600">Configura tu comunidad y accesibilidad. La app adapta las preguntas LOMLOE a tu comunidad.</p>
              <div className="grid sm:grid-cols-3 gap-4">
                <div className="space-y-2">
                  <label className="block text-sm font-medium">Comunidad autónoma</label>
                  <select className="w-full rounded-xl border px-3 py-2 bg-white" value={community} onChange={(e) => setCommunity(e.target.value)}>
                    {comunidades.map((c) => <option key={c} value={c}>{c.charAt(0).toUpperCase() + c.slice(1)}</option>)}
                  </select>
                </div>
                <div className="flex items-center justify-between rounded-2xl border p-3">
                  <div><p className="font-medium text-sm">Modo TEA/TGD</p><p className="text-xs text-slate-500">Apoyos visuales</p></div>
                  <button onClick={() => setTeaMode(!teaMode)} className={["rounded-xl px-3 py-1 text-sm font-medium border", teaMode ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>{teaMode ? "ON" : "OFF"}</button>
                </div>
                <div className="flex items-center justify-between rounded-2xl border p-3">
                  <div><p className="font-medium text-sm">Baja estimulación</p><p className="text-xs text-slate-500">Menos distracción</p></div>
                  <button onClick={() => setLowStim(!lowStim)} className={["rounded-xl px-3 py-1 text-sm font-medium border", lowStim ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>{lowStim ? "ON" : "OFF"}</button>
                </div>
              </div>
            </div>
            <div className="rounded-2xl border bg-white p-5 space-y-3">
              <h3 className="font-semibold">Perfil curricular: {perfil.nombre}</h3>
              <div className="grid sm:grid-cols-5 gap-3 text-sm">
                {Object.entries(perfil.enfoque).map(([key, desc]) => (
                  <div key={key} className="rounded-xl border p-3"><p className="font-medium capitalize">{key}</p><p className="text-slate-600 text-xs mt-1">{desc}</p></div>
                ))}
              </div>
            </div>
          </div>
        )}

        {activeTab === "aprender" && <QuizView perfil={perfil.key} teaMode={teaMode} lowStim={lowStim} parentPin={parentPin} onStatsUpdate={setEngineStats} />}

        {activeTab === "diario" && <JournalView parentPin={parentPin} teaMode={teaMode} lowStim={lowStim} engineStats={engineStats} />}

        {activeTab === "ajustes" && (
          <div className="space-y-4">
            <div className="rounded-2xl border bg-white p-5 space-y-3">
              <h2 className="text-xl font-bold">Ajustes</h2>
              <div className="space-y-2">
                <label className="block text-sm font-medium">PIN del adulto (local)</label>
                <input type="password" value={parentPin} onChange={(e) => setParentPin(e.target.value)} placeholder="PIN de 4+ caracteres" className="w-full max-w-sm border rounded-xl px-3 py-2 outline-none" />
                <p className="text-sm text-slate-500">Este PIN no se envía a ningún servidor.</p>
              </div>
            </div>
            <div className="rounded-2xl border bg-white p-5 space-y-2 text-sm text-slate-600">
              <h3 className="font-semibold text-slate-900">Privacidad y seguridad</h3>
              <p>✅ Sin telemetría ni analíticas</p><p>✅ Sin cuentas ni identificadores</p>
              <p>✅ Cifrado local AES-256-GCM con PBKDF2</p><p>✅ 100% offline</p>
              <p>✅ Ningún dato viaja a servidores</p><p>✅ Sin rastreo del dispositivo</p>
            </div>
            <div className="rounded-2xl border bg-white p-5 text-sm text-slate-500">TGD · App Educativa Segura · v0.2.0 · LOMLOE 6º Primaria</div>
          </div>
        )}
      </div>
    </div>
  );
}
APPV2_EOF
echo "✅ src/App.jsx (con navegación y sistema de puntos)"

echo ""
echo "============================================================"
echo "  FASE 2 COMPLETADA"
echo "============================================================"
echo ""
echo "  Ficheros creados/actualizados:"
echo "    src/core/curriculum-profiles.js   (8 perfiles, 19 CCAA)"
echo "    src/core/questions-ccaa.js        (200 preguntas LOMLOE)"
echo "    src/core/adaptive-engine.js       (motor + puntos + niveles)"
echo "    src/modules/learning/quiz-view.jsx (quiz TEA-friendly)"
echo "    src/App.jsx                       (navegación completa)"
echo ""
echo "  Para arrancar: npm run dev"
echo ""
echo "🚀 ¡Motor educativo LOMLOE instalado!"
echo ""
