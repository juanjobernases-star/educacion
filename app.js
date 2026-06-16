// School v4 - Exploradores de Sexto - app.js
// 260 preguntas LOMLOE + Motor completo

const QUESTIONS = [{"id": 1, "subject": "Matemáticas", "topic": "Fracciones", "question": "¿Cuánto es 1/4 + 2/4?", "options": ["1/4", "2/4", "3/4", "4/4"], "answer": 2, "explanation": "1+2=3, mismo denominador: 3/4."}, {"id": 2, "subject": "Matemáticas", "topic": "Fracciones", "question": "Fracción equivalente a 2/6:", "options": ["1/3", "1/2", "2/3", "3/6"], "answer": 0, "explanation": "Simplificando 2/6 entre 2 = 1/3."}, {"id": 3, "subject": "Matemáticas", "topic": "Fracciones", "question": "¿Cuánto es 3/5 − 1/5?", "options": ["1/5", "2/5", "3/5", "4/5"], "answer": 1, "explanation": "3−1=2, mismo denominador: 2/5."}, {"id": 4, "subject": "Matemáticas", "topic": "Fracciones", "question": "¿Cuánto es 2/3 × 3/4?", "options": ["6/12", "1/2", "5/7", "2/4"], "answer": 1, "explanation": "2×3=6, 3×4=12, simplificado: 1/2."}, {"id": 5, "subject": "Matemáticas", "topic": "Fracciones", "question": "Convierte 1 3/4 a fracción impropia:", "options": ["3/4", "4/4", "7/4", "5/4"], "answer": 2, "explanation": "1×4+3=7, denominador 4: 7/4."}, {"id": 6, "subject": "Matemáticas", "topic": "Fracciones", "question": "¿Qué fracción es mayor: 3/8 o 5/8?", "options": ["3/8", "5/8", "Iguales", "No se puede"], "answer": 1, "explanation": "Mismo denominador: mayor numerador es mayor."}, {"id": 7, "subject": "Matemáticas", "topic": "Fracciones", "question": "¿Cuánto es 1/2 + 1/3?", "options": ["2/5", "3/6", "5/6", "1/6"], "answer": 2, "explanation": "MCM 6: 3/6+2/6=5/6."}, {"id": 8, "subject": "Matemáticas", "topic": "Decimales", "question": "¿Cuánto es 3,45 + 2,3?", "options": ["5,75", "5,48", "5,35", "6,75"], "answer": 0, "explanation": "3,45+2,30=5,75."}, {"id": 9, "subject": "Matemáticas", "topic": "Decimales", "question": "Redondea 4,678 a las décimas:", "options": ["4,6", "4,7", "4,68", "5,0"], "answer": 1, "explanation": "Centésimas=7≥5, sube: 4,7."}, {"id": 10, "subject": "Matemáticas", "topic": "Decimales", "question": "¿Cuánto es 6,5 × 0,1?", "options": ["65", "0,65", "6,5", "0,065"], "answer": 1, "explanation": "×0,1 = ÷10: 0,65."}, {"id": 11, "subject": "Matemáticas", "topic": "Decimales", "question": "¿Cuánto es 12,6 − 4,25?", "options": ["8,35", "8,45", "7,35", "8,25"], "answer": 0, "explanation": "12,60−4,25=8,35."}, {"id": 12, "subject": "Matemáticas", "topic": "Decimales", "question": "Ordena de menor a mayor: 0,5; 0,05; 0,55", "options": ["0,5<0,05<0,55", "0,05<0,55<0,5", "0,05<0,5<0,55", "0,55<0,5<0,05"], "answer": 2, "explanation": "0,05<0,5<0,55."}, {"id": 13, "subject": "Matemáticas", "topic": "Porcentajes", "question": "¿Cuánto es el 25% de 200?", "options": ["25", "50", "75", "100"], "answer": 1, "explanation": "200×25/100=50."}, {"id": 14, "subject": "Matemáticas", "topic": "Porcentajes", "question": "Pantalón 40 € con 10% descuento:", "options": ["30 €", "36 €", "44 €", "38 €"], "answer": 1, "explanation": "Descuento=4 €, precio=36 €."}, {"id": 15, "subject": "Matemáticas", "topic": "Porcentajes", "question": "¿Qué porcentaje de 50 es 10?", "options": ["10%", "15%", "20%", "25%"], "answer": 2, "explanation": "(10/50)×100=20%."}, {"id": 16, "subject": "Matemáticas", "topic": "Porcentajes", "question": "Clase 30 alumnos, 12 chicas. ¿% chicas?", "options": ["30%", "40%", "50%", "60%"], "answer": 1, "explanation": "(12/30)×100=40%."}, {"id": 17, "subject": "Matemáticas", "topic": "Geometría", "question": "Área rectángulo 8×5 cm:", "options": ["13 cm²", "26 cm²", "40 cm²", "80 cm²"], "answer": 2, "explanation": "Área=b×h=40 cm²."}, {"id": 18, "subject": "Matemáticas", "topic": "Geometría", "question": "Área triángulo base 10, altura 6:", "options": ["60 cm²", "30 cm²", "16 cm²", "15 cm²"], "answer": 1, "explanation": "(10×6)/2=30 cm²."}, {"id": 19, "subject": "Matemáticas", "topic": "Geometría", "question": "Perímetro cuadrado lado 7 cm:", "options": ["14 cm", "21 cm", "28 cm", "49 cm"], "answer": 2, "explanation": "P=4×7=28 cm."}, {"id": 20, "subject": "Matemáticas", "topic": "Geometría", "question": "Un ángulo de 90° se llama:", "options": ["Agudo", "Recto", "Obtuso", "Llano"], "answer": 1, "explanation": "90° = ángulo recto."}, {"id": 21, "subject": "Matemáticas", "topic": "Geometría", "question": "¿Cuántos lados tiene un hexágono?", "options": ["5", "6", "7", "8"], "answer": 1, "explanation": "Hexa = seis."}, {"id": 22, "subject": "Matemáticas", "topic": "Geometría", "question": "Fórmula del área del círculo:", "options": ["π×r", "2×π×r", "π×r²", "π×d"], "answer": 2, "explanation": "Área = π × radio²."}, {"id": 23, "subject": "Matemáticas", "topic": "Geometría", "question": "Radio 5 cm, ¿diámetro?", "options": ["5 cm", "10 cm", "15 cm", "25 cm"], "answer": 1, "explanation": "D=2×r=10 cm."}, {"id": 24, "subject": "Matemáticas", "topic": "Geometría", "question": "Un ángulo de 135° es:", "options": ["Agudo", "Recto", "Obtuso", "Llano"], "answer": 2, "explanation": "Entre 90° y 180° = obtuso."}, {"id": 25, "subject": "Matemáticas", "topic": "Geometría", "question": "Perímetro rectángulo 12×4 cm:", "options": ["16 cm", "32 cm", "48 cm", "28 cm"], "answer": 1, "explanation": "P=2×(12+4)=32 cm."}, {"id": 26, "subject": "Matemáticas", "topic": "Estadística", "question": "Media de 4, 6, 8, 10, 12:", "options": ["6", "8", "10", "7"], "answer": 1, "explanation": "40/5=8."}, {"id": 27, "subject": "Matemáticas", "topic": "Estadística", "question": "Moda de {3,5,5,7,9}:", "options": ["3", "5", "7", "9"], "answer": 1, "explanation": "5 se repite más."}, {"id": 28, "subject": "Matemáticas", "topic": "Estadística", "question": "Mediana de {2,4,7,9,11}:", "options": ["4", "7", "9", "6"], "answer": 1, "explanation": "Valor central: 7."}, {"id": 29, "subject": "Matemáticas", "topic": "Estadística", "question": "Probabilidad de sacar 3 en un dado:", "options": ["1/3", "1/6", "1/2", "2/6"], "answer": 1, "explanation": "1 favorable / 6 posibles = 1/6."}, {"id": 30, "subject": "Matemáticas", "topic": "Estadística", "question": "Media=12, dos números son 10 y 14. ¿Tercero?", "options": ["10", "11", "12", "13"], "answer": 2, "explanation": "36−10−14=12."}, {"id": 31, "subject": "Matemáticas", "topic": "Proporcionalidad", "question": "3 kg manzanas=6 €. ¿5 kg?", "options": ["8 €", "9 €", "10 €", "12 €"], "answer": 2, "explanation": "2 €/kg × 5 = 10 €."}, {"id": 32, "subject": "Matemáticas", "topic": "Proporcionalidad", "question": "120 km en 2 h. ¿Velocidad?", "options": ["40 km/h", "50 km/h", "60 km/h", "80 km/h"], "answer": 2, "explanation": "120/2=60 km/h."}, {"id": 33, "subject": "Matemáticas", "topic": "Proporcionalidad", "question": "200 g harina/4 personas. ¿Para 8?", "options": ["300 g", "400 g", "500 g", "600 g"], "answer": 1, "explanation": "Doble: 400 g."}, {"id": 34, "subject": "Matemáticas", "topic": "Enteros", "question": "¿Cuál es menor: −5, −2, 0, 3?", "options": ["0", "3", "−2", "−5"], "answer": 3, "explanation": "−5 es el menor."}, {"id": 35, "subject": "Matemáticas", "topic": "Enteros", "question": "(−3) + 7 =", "options": ["−10", "−4", "4", "10"], "answer": 2, "explanation": "7−3=4."}, {"id": 36, "subject": "Matemáticas", "topic": "Enteros", "question": "(−4) − (−2) =", "options": ["−6", "−2", "2", "6"], "answer": 1, "explanation": "−4+2=−2."}, {"id": 37, "subject": "Matemáticas", "topic": "Enteros", "question": "Ordena −8, 3, −1, 5 de menor a mayor:", "options": ["−1,−8,3,5", "−8,−1,3,5", "3,5,−1,−8", "5,3,−1,−8"], "answer": 1, "explanation": "−8<−1<3<5."}, {"id": 38, "subject": "Matemáticas", "topic": "Medidas", "question": "2,5 metros = ¿cm?", "options": ["25", "250", "2500", "0,25"], "answer": 1, "explanation": "1m=100cm → 250cm."}, {"id": 39, "subject": "Matemáticas", "topic": "Medidas", "question": "3 kilogramos = ¿gramos?", "options": ["30", "300", "3000", "30000"], "answer": 2, "explanation": "1kg=1000g → 3000g."}, {"id": 40, "subject": "Matemáticas", "topic": "Medidas", "question": "1,5 litros = ¿ml?", "options": ["15", "150", "1500", "15000"], "answer": 2, "explanation": "1L=1000mL → 1500mL."}, {"id": 41, "subject": "Matemáticas", "topic": "Medidas", "question": "4,2 km = ¿metros?", "options": ["42", "420", "4200", "42000"], "answer": 2, "explanation": "1km=1000m → 4200m."}, {"id": 42, "subject": "Matemáticas", "topic": "Coordenadas", "question": "Punto (3,−2), ¿cuadrante?", "options": ["Primero", "Segundo", "Tercero", "Cuarto"], "answer": 3, "explanation": "x+ y−: cuarto cuadrante."}, {"id": 43, "subject": "Matemáticas", "topic": "Coordenadas", "question": "Coordenadas del origen:", "options": ["(1,1)", "(0,1)", "(0,0)", "(1,0)"], "answer": 2, "explanation": "El origen es (0,0)."}, {"id": 44, "subject": "Matemáticas", "topic": "Álgebra", "question": "Si x+5=12, ¿x?", "options": ["5", "6", "7", "8"], "answer": 2, "explanation": "x=12−5=7."}, {"id": 45, "subject": "Matemáticas", "topic": "Álgebra", "question": "Si 3×n=18, ¿n?", "options": ["3", "5", "6", "9"], "answer": 2, "explanation": "n=18/3=6."}, {"id": 46, "subject": "Lengua", "topic": "Verbos", "question": "¿Tiempo verbal de 'cantaré'?", "options": ["Presente", "Pret. perfecto", "Futuro simple", "Pret. imperfecto"], "answer": 2, "explanation": "Cantaré = futuro simple de indicativo."}, {"id": 47, "subject": "Lengua", "topic": "Verbos", "question": "Infinitivo de 'durmiendo':", "options": ["Dormir", "Durmir", "Dormiendo", "Durmor"], "answer": 0, "explanation": "Gerundio de dormir (3ª conjugación)."}, {"id": 48, "subject": "Lengua", "topic": "Verbos", "question": "¿Conjugación de 'correr'?", "options": ["Primera", "Segunda", "Tercera", "Ninguna"], "answer": 1, "explanation": "Verbos en -er = 2ª conjugación."}, {"id": 49, "subject": "Lengua", "topic": "Verbos", "question": "'Escribir' en 1ª persona pret. perfecto:", "options": ["Escribo", "Escribí", "Escribiré", "Escribía"], "answer": 1, "explanation": "Yo escribí."}, {"id": 50, "subject": "Lengua", "topic": "Verbos", "question": "¿Verbo irregular?", "options": ["Caminar", "Saltar", "Ir", "Hablar"], "answer": 2, "explanation": "Ir es irregular: voy, fui, iré..."}, {"id": 51, "subject": "Lengua", "topic": "Sustantivos", "question": "¿Sustantivo propio?", "options": ["ciudad", "perro", "Madrid", "libertad"], "answer": 2, "explanation": "Madrid = nombre propio, con mayúscula."}, {"id": 52, "subject": "Lengua", "topic": "Sustantivos", "question": "Tipo de sustantivo: 'felicidad'", "options": ["Concreto", "Propio", "Abstracto", "Colectivo"], "answer": 2, "explanation": "No se percibe con los sentidos = abstracto."}, {"id": 53, "subject": "Lengua", "topic": "Sustantivos", "question": "¿Sustantivo colectivo?", "options": ["Oveja", "Rebaño", "Pastor", "Campo"], "answer": 1, "explanation": "Rebaño = conjunto de ovejas."}, {"id": 54, "subject": "Lengua", "topic": "Adjetivos", "question": "Grado en 'la más alta de la clase':", "options": ["Positivo", "Comparativo", "Superlativo relativo", "Superlativo absoluto"], "answer": 2, "explanation": "La más alta de... = superlativo relativo."}, {"id": 55, "subject": "Lengua", "topic": "Adjetivos", "question": "Superlativo absoluto de 'bueno':", "options": ["Muy bueno", "Buenísimo", "Óptimo", "Buenísimo y Óptimo"], "answer": 3, "explanation": "Ambas formas son correctas."}, {"id": 56, "subject": "Lengua", "topic": "Adverbios", "question": "Tipo de adverbio: 'aquí'", "options": ["Tiempo", "Modo", "Lugar", "Cantidad"], "answer": 2, "explanation": "Aquí = adverbio de lugar."}, {"id": 57, "subject": "Lengua", "topic": "Adverbios", "question": "¿Adverbio de tiempo?", "options": ["Mucho", "Bien", "Ayer", "Cerca"], "answer": 2, "explanation": "Ayer = cuándo: adverbio de tiempo."}, {"id": 58, "subject": "Lengua", "topic": "Pronombres", "question": "'Ella come fruta'. ¿Tipo de 'ella'?", "options": ["Sustantivo", "Adjetivo", "Pronombre personal", "Determinante"], "answer": 2, "explanation": "Ella = pronombre personal, 3ª persona."}, {"id": 59, "subject": "Lengua", "topic": "Pronombres", "question": "Pronombre demostrativo cercano: '___ es mi libro'", "options": ["Aquel", "Ese", "Este", "Mío"], "answer": 2, "explanation": "Este = cercanía, demostrativo."}, {"id": 60, "subject": "Lengua", "topic": "Determinantes", "question": "'Los niños juegan'. ¿Tipo de 'los'?", "options": ["Pronombre", "Art. determinado", "Art. indeterminado", "Adjetivo"], "answer": 1, "explanation": "Los = artículo determinado."}, {"id": 61, "subject": "Lengua", "topic": "Preposiciones", "question": "¿Cuál es preposición?", "options": ["Pero", "Sin", "Muy", "Que"], "answer": 1, "explanation": "Sin = preposición."}, {"id": 62, "subject": "Lengua", "topic": "Sintaxis", "question": "Sujeto de 'Mi hermano lee un libro':", "options": ["Lee", "Un libro", "Mi hermano", "Lee un libro"], "answer": 2, "explanation": "Mi hermano realiza la acción."}, {"id": 63, "subject": "Lengua", "topic": "Sintaxis", "question": "¿Qué es el predicado?", "options": ["Quien realiza la acción", "Lo que se dice del sujeto", "El tiempo verbal", "El complemento"], "answer": 1, "explanation": "El predicado dice algo sobre el sujeto."}, {"id": 64, "subject": "Lengua", "topic": "Sintaxis", "question": "Tipo de oración: '¡Qué bonito día!'", "options": ["Enunciativa", "Interrogativa", "Exclamativa", "Imperativa"], "answer": 2, "explanation": "Signos de exclamación = exclamativa."}, {"id": 65, "subject": "Lengua", "topic": "Sintaxis", "question": "Tipo: 'Cierra la puerta'", "options": ["Enunciativa", "Interrogativa", "Exclamativa", "Imperativa"], "answer": 3, "explanation": "Expresa orden = imperativa."}, {"id": 66, "subject": "Lengua", "topic": "Ortografía", "question": "'Canción' según acentuación:", "options": ["Aguda", "Llana", "Esdrújula", "Sobreesdrújula"], "answer": 0, "explanation": "can-CIÓN: tónica en última = aguda."}, {"id": 67, "subject": "Lengua", "topic": "Ortografía", "question": "¿Escritura correcta?", "options": ["Aver", "Haber", "Haver", "Aber"], "answer": 1, "explanation": "Haber: con h y con b."}, {"id": 68, "subject": "Lengua", "topic": "Ortografía", "question": "'Música' según acento:", "options": ["Aguda", "Llana", "Esdrújula", "Sobreesdrújula"], "answer": 2, "explanation": "MÚ-si-ca: antepenúltima = esdrújula."}, {"id": 69, "subject": "Lengua", "topic": "Ortografía", "question": "¿Cuándo lleva tilde una llana?", "options": ["Siempre", "Acaba en vocal/n/s", "NO acaba en vocal/n/s", "Nunca"], "answer": 2, "explanation": "Llanas: tilde si NO acaban en vocal, n o s."}, {"id": 70, "subject": "Lengua", "topic": "Ortografía", "question": "Forma correcta:", "options": ["Vurro", "Burro", "Buro", "Vuro"], "answer": 1, "explanation": "Burro: con b y doble r."}, {"id": 71, "subject": "Lengua", "topic": "Ortografía", "question": "¿Palabra correcta?", "options": ["Jirafa", "Girafa", "Xirafa", "Hirafa"], "answer": 0, "explanation": "Jirafa: con j."}, {"id": 72, "subject": "Lengua", "topic": "Ortografía", "question": "¿Se escribe con h?", "options": ["Uevo", "Huevo", "Uebo", "Guevo"], "answer": 1, "explanation": "Palabras con hue- llevan h."}, {"id": 73, "subject": "Lengua", "topic": "Ortografía", "question": "'Los niños ___ en el parque' (ir, imperfecto):", "options": ["Ivan", "Iban", "Hiban", "Hivan"], "answer": 1, "explanation": "Iban: pret. imperfecto de ir."}, {"id": 74, "subject": "Lengua", "topic": "Literatura", "question": "Género de una novela:", "options": ["Lírico", "Narrativo", "Dramático", "Didáctico"], "answer": 1, "explanation": "La novela es narrativa."}, {"id": 75, "subject": "Lengua", "topic": "Literatura", "question": "¿Género del teatro?", "options": ["Narrativo", "Lírico", "Dramático", "Épico"], "answer": 2, "explanation": "Teatro = género dramático."}, {"id": 76, "subject": "Lengua", "topic": "Literatura", "question": "Un poema pertenece al género:", "options": ["Narrativo", "Lírico", "Dramático", "Periodístico"], "answer": 1, "explanation": "Poesía = género lírico."}, {"id": 77, "subject": "Lengua", "topic": "Figuras retóricas", "question": "'Tus ojos son dos luceros':", "options": ["Símil", "Metáfora", "Personificación", "Hipérbole"], "answer": 1, "explanation": "Identifica sin 'como' = metáfora."}, {"id": 78, "subject": "Lengua", "topic": "Figuras retóricas", "question": "'El viento susurraba':", "options": ["Metáfora", "Hipérbole", "Personificación", "Símil"], "answer": 2, "explanation": "Atribuye cualidad humana = personificación."}, {"id": 79, "subject": "Lengua", "topic": "Figuras retóricas", "question": "'Corrió más rápido que el viento':", "options": ["Metáfora", "Personificación", "Hipérbole", "Símil"], "answer": 2, "explanation": "Exageración = hipérbole."}, {"id": 80, "subject": "Lengua", "topic": "Figuras retóricas", "question": "'Suave como la seda':", "options": ["Metáfora", "Símil", "Personificación", "Hipérbole"], "answer": 1, "explanation": "Usa 'como' = símil/comparación."}, {"id": 81, "subject": "Lengua", "topic": "Narrativa", "question": "¿Quién cuenta la historia?", "options": ["El protagonista", "El narrador", "El autor", "El lector"], "answer": 1, "explanation": "El narrador cuenta la historia."}, {"id": 82, "subject": "Lengua", "topic": "Narrativa", "question": "¿Qué es el nudo?", "options": ["El inicio", "El desarrollo del conflicto", "El final", "La moraleja"], "answer": 1, "explanation": "Nudo = desarrollo del conflicto."}, {"id": 83, "subject": "Lengua", "topic": "Narrativa", "question": "Lugar donde ocurre la historia:", "options": ["Trama", "Ambiente/escenario", "Nudo", "Desenlace"], "answer": 1, "explanation": "Ambiente = lugar y tiempo."}, {"id": 84, "subject": "Lengua", "topic": "Vocabulario", "question": "Sinónimo de 'contento':", "options": ["Triste", "Alegre", "Enfadado", "Cansado"], "answer": 1, "explanation": "Alegre = sinónimo de contento."}, {"id": 85, "subject": "Lengua", "topic": "Vocabulario", "question": "Antónimo de 'valiente':", "options": ["Fuerte", "Cobarde", "Audaz", "Intrépido"], "answer": 1, "explanation": "Cobarde = opuesto a valiente."}, {"id": 86, "subject": "Lengua", "topic": "Vocabulario", "question": "Prefijo 'des-' en 'deshacer':", "options": ["Repetir", "Negación/inversión", "Antes de", "Después de"], "answer": 1, "explanation": "Des- = negación o acción contraria."}, {"id": 87, "subject": "Lengua", "topic": "Vocabulario", "question": "Sufijo de 'panadero':", "options": ["-ero", "-ado", "-mente", "-ción"], "answer": 0, "explanation": "-ero indica oficio."}, {"id": 88, "subject": "Lengua", "topic": "Vocabulario", "question": "'Zapato, zapatero, zapatería':", "options": ["Antónimos", "Familia de palabras", "Sinónimos", "Oración"], "answer": 1, "explanation": "Comparten raíz: familia de palabras."}, {"id": 89, "subject": "Lengua", "topic": "Verbos", "question": "Modo verbal de deseos:", "options": ["Indicativo", "Subjuntivo", "Imperativo", "Infinitivo"], "answer": 1, "explanation": "Subjuntivo = deseos, dudas."}, {"id": 90, "subject": "Lengua", "topic": "Sintaxis", "question": "CD en 'Juan compró un libro':", "options": ["Juan", "Compró", "Un libro", "En la tienda"], "answer": 2, "explanation": "Un libro recibe la acción."}, {"id": 91, "subject": "Ciencias Naturales", "topic": "Célula", "question": "¿Qué tiene la célula vegetal que no la animal?", "options": ["Núcleo", "Pared celular", "Membrana", "Citoplasma"], "answer": 1, "explanation": "Pared celular = exclusiva vegetal."}, {"id": 92, "subject": "Ciencias Naturales", "topic": "Célula", "question": "Orgánulo de la fotosíntesis:", "options": ["Mitocondria", "Ribosoma", "Cloroplasto", "Vacuola"], "answer": 2, "explanation": "Cloroplastos = fotosíntesis."}, {"id": 93, "subject": "Ciencias Naturales", "topic": "Célula", "question": "¿Dónde está el ADN?", "options": ["Membrana", "Citoplasma", "Núcleo", "Ribosomas"], "answer": 2, "explanation": "ADN en el núcleo celular."}, {"id": 94, "subject": "Ciencias Naturales", "topic": "Célula", "question": "Función de la mitocondria:", "options": ["Fabricar proteínas", "Obtener energía", "Almacenar agua", "Fotosíntesis"], "answer": 1, "explanation": "Mitocondrias = centrales energéticas."}, {"id": 95, "subject": "Ciencias Naturales", "topic": "Reinos", "question": "¿Cuántos reinos de seres vivos hay?", "options": ["3", "4", "5", "6"], "answer": 2, "explanation": "5: Moneras, Protoctistas, Hongos, Plantas, Animales."}, {"id": 96, "subject": "Ciencias Naturales", "topic": "Reinos", "question": "Reino de las bacterias:", "options": ["Protoctistas", "Hongos", "Moneras", "Plantas"], "answer": 2, "explanation": "Bacterias = reino Moneras."}, {"id": 97, "subject": "Ciencias Naturales", "topic": "Reinos", "question": "Reino del champiñón:", "options": ["Plantas", "Hongos", "Animales", "Moneras"], "answer": 1, "explanation": "Champiñón = hongo."}, {"id": 98, "subject": "Ciencias Naturales", "topic": "Animales", "question": "¿Vertebrado?", "options": ["Araña", "Medusa", "Sardina", "Lombriz"], "answer": 2, "explanation": "Sardina = pez, tiene columna vertebral."}, {"id": 99, "subject": "Ciencias Naturales", "topic": "Animales", "question": "Cuerpo cubierto de plumas:", "options": ["Mamíferos", "Reptiles", "Aves", "Anfibios"], "answer": 2, "explanation": "Solo las aves tienen plumas."}, {"id": 100, "subject": "Ciencias Naturales", "topic": "Animales", "question": "Característica de mamíferos:", "options": ["Ponen huevos", "Escamas", "Amamantan crías", "Branquias"], "answer": 2, "explanation": "Mamíferos = leche materna."}, {"id": 101, "subject": "Ciencias Naturales", "topic": "Animales", "question": "¿Invertebrado?", "options": ["Rana", "Serpiente", "Mariposa", "Águila"], "answer": 2, "explanation": "Mariposa = insecto, sin columna."}, {"id": 102, "subject": "Ciencias Naturales", "topic": "Ecosistemas", "question": "¿Qué es un ecosistema?", "options": ["Solo seres vivos", "Solo medio físico", "Seres vivos + medio", "Solo plantas"], "answer": 2, "explanation": "Ecosistema = biocenosis + biotopo."}, {"id": 103, "subject": "Ciencias Naturales", "topic": "Ecosistemas", "question": "Organismos que fabrican su alimento:", "options": ["Consumidores", "Descomponedores", "Productores", "Depredadores"], "answer": 2, "explanation": "Plantas = productores (fotosíntesis)."}, {"id": 104, "subject": "Ciencias Naturales", "topic": "Ecosistemas", "question": "¿Qué son los descomponedores?", "options": ["Herbívoros", "Productores", "Descomponen restos orgánicos", "Carnívoros"], "answer": 2, "explanation": "Hongos y bacterias descomponen materia muerta."}, {"id": 105, "subject": "Ciencias Naturales", "topic": "Ecosistemas", "question": "Hierba→conejo→zorro es:", "options": ["Red alimentaria", "Cadena alimentaria", "Ecosistema acuático", "Simbiosis"], "answer": 1, "explanation": "Secuencia lineal = cadena alimentaria."}, {"id": 106, "subject": "Ciencias Naturales", "topic": "Digestivo", "question": "¿Dónde empieza la digestión?", "options": ["Estómago", "Intestino delgado", "Boca", "Esófago"], "answer": 2, "explanation": "Masticación + saliva = boca."}, {"id": 107, "subject": "Ciencias Naturales", "topic": "Digestivo", "question": "Órgano de absorción de nutrientes:", "options": ["Estómago", "Intestino delgado", "Intestino grueso", "Esófago"], "answer": 1, "explanation": "Vellosidades intestinales absorben."}, {"id": 108, "subject": "Ciencias Naturales", "topic": "Digestivo", "question": "¿Qué órgano produce la bilis?", "options": ["Páncreas", "Estómago", "Hígado", "Intestino"], "answer": 2, "explanation": "Hígado produce bilis para digerir grasas."}, {"id": 109, "subject": "Ciencias Naturales", "topic": "Respiratorio", "question": "Órgano principal de la respiración:", "options": ["Laringe", "Tráquea", "Pulmones", "Bronquios"], "answer": 2, "explanation": "Pulmones = intercambio gaseoso."}, {"id": 110, "subject": "Ciencias Naturales", "topic": "Respiratorio", "question": "Músculo de la respiración:", "options": ["Bíceps", "Diafragma", "Cuádriceps", "Abdominales"], "answer": 1, "explanation": "Diafragma permite entrada/salida de aire."}, {"id": 111, "subject": "Ciencias Naturales", "topic": "Circulatorio", "question": "¿Qué bombea la sangre?", "options": ["Pulmones", "Hígado", "Corazón", "Riñones"], "answer": 2, "explanation": "Corazón = bomba del sistema circulatorio."}, {"id": 112, "subject": "Ciencias Naturales", "topic": "Circulatorio", "question": "Vasos que llevan sangre del corazón:", "options": ["Venas", "Capilares", "Arterias", "Linfáticos"], "answer": 2, "explanation": "Arterias llevan sangre desde el corazón."}, {"id": 113, "subject": "Ciencias Naturales", "topic": "Circulatorio", "question": "Células que transportan oxígeno:", "options": ["Glóbulos blancos", "Plaquetas", "Glóbulos rojos", "Plasma"], "answer": 2, "explanation": "Glóbulos rojos = hemoglobina + oxígeno."}, {"id": 114, "subject": "Ciencias Naturales", "topic": "Nervioso", "question": "Órgano principal del sistema nervioso:", "options": ["Médula espinal", "Cerebro", "Cerebelo", "Nervios"], "answer": 1, "explanation": "Cerebro = centro de control."}, {"id": 115, "subject": "Ciencias Naturales", "topic": "Nervioso", "question": "Células del sistema nervioso:", "options": ["Neuronas", "Glóbulos", "Hepatocitos", "Plaquetas"], "answer": 0, "explanation": "Neuronas transmiten impulsos nerviosos."}, {"id": 116, "subject": "Ciencias Naturales", "topic": "Nervioso", "question": "¿Qué protege la médula espinal?", "options": ["Cráneo", "Costillas", "Columna vertebral", "Esternón"], "answer": 2, "explanation": "Vértebras protegen la médula espinal."}, {"id": 117, "subject": "Ciencias Naturales", "topic": "Locomotor", "question": "Huesos del cuerpo humano (aprox.):", "options": ["106", "206", "306", "406"], "answer": 1, "explanation": "El esqueleto adulto tiene unos 206 huesos."}, {"id": 118, "subject": "Ciencias Naturales", "topic": "Locomotor", "question": "¿Qué une huesos entre sí?", "options": ["Músculos", "Tendones", "Ligamentos", "Cartílagos"], "answer": 2, "explanation": "Ligamentos unen hueso con hueso."}, {"id": 119, "subject": "Ciencias Naturales", "topic": "Locomotor", "question": "¿Qué une músculos a huesos?", "options": ["Ligamentos", "Tendones", "Nervios", "Cartílagos"], "answer": 1, "explanation": "Tendones conectan músculos con huesos."}, {"id": 120, "subject": "Ciencias Naturales", "topic": "Energía", "question": "Energía del sol:", "options": ["Eólica", "Solar", "Térmica", "Nuclear"], "answer": 1, "explanation": "Del sol = energía solar."}, {"id": 121, "subject": "Ciencias Naturales", "topic": "Energía", "question": "¿Fuente renovable?", "options": ["Petróleo", "Carbón", "Gas natural", "Viento"], "answer": 3, "explanation": "Viento = eólica = renovable."}, {"id": 122, "subject": "Ciencias Naturales", "topic": "Energía", "question": "Energía de un objeto en movimiento:", "options": ["Potencial", "Cinética", "Química", "Térmica"], "answer": 1, "explanation": "Energía cinética = movimiento."}, {"id": 123, "subject": "Ciencias Naturales", "topic": "Energía", "question": "¿Fuente NO renovable?", "options": ["Solar", "Eólica", "Petróleo", "Hidráulica"], "answer": 2, "explanation": "Petróleo = combustible fósil."}, {"id": 124, "subject": "Ciencias Naturales", "topic": "Materia", "question": "Los tres estados de la materia:", "options": ["Sólido, líquido, gaseoso", "Frío, tibio, caliente", "Duro, blando, flexible", "Pesado, ligero, medio"], "answer": 0, "explanation": "Sólido, líquido y gaseoso."}, {"id": 125, "subject": "Ciencias Naturales", "topic": "Materia", "question": "Cambio de líquido a gas:", "options": ["Fusión", "Solidificación", "Evaporación", "Condensación"], "answer": 2, "explanation": "Evaporación = líquido a gas."}, {"id": 126, "subject": "Ciencias Naturales", "topic": "Materia", "question": "Cambio de sólido a líquido:", "options": ["Evaporación", "Condensación", "Solidificación", "Fusión"], "answer": 3, "explanation": "Fusión = sólido a líquido."}, {"id": 127, "subject": "Ciencias Naturales", "topic": "Materia", "question": "Agua con sal disuelta es mezcla:", "options": ["Heterogénea", "Homogénea", "Compuesto puro", "Coloide"], "answer": 1, "explanation": "No se distinguen componentes = homogénea."}, {"id": 128, "subject": "Ciencias Naturales", "topic": "Materia", "question": "Separar arena del agua:", "options": ["Destilación", "Evaporación", "Filtración", "Imantación"], "answer": 2, "explanation": "Filtración: sólido de líquido."}, {"id": 129, "subject": "Ciencias Naturales", "topic": "Materia", "question": "Separar limaduras de hierro de arena:", "options": ["Filtración", "Decantación", "Evaporación", "Imantación"], "answer": 3, "explanation": "Imán atrae hierro = imantación."}, {"id": 130, "subject": "Ciencias Naturales", "topic": "Máquinas", "question": "¿Tipo de máquina de un columpio?", "options": ["Polea", "Plano inclinado", "Palanca", "Rueda"], "answer": 2, "explanation": "Columpio = palanca."}, {"id": 131, "subject": "Ciencias Naturales", "topic": "Máquinas", "question": "¿Para qué sirve una polea?", "options": ["Cortar", "Elevar cargas", "Medir temperatura", "Calentar agua"], "answer": 1, "explanation": "Polea = levantar objetos con menos fuerza."}, {"id": 132, "subject": "Ciencias Naturales", "topic": "Salud", "question": "Grupos principales de nutrientes:", "options": ["3", "5", "6", "8"], "answer": 2, "explanation": "6: carbohidratos, proteínas, grasas, vitaminas, minerales, agua."}, {"id": 133, "subject": "Ciencias Naturales", "topic": "Salud", "question": "Base de la pirámide alimentaria:", "options": ["Carnes", "Dulces", "Cereales y pan", "Lácteos"], "answer": 2, "explanation": "Cereales, pan, pasta = base energética."}, {"id": 134, "subject": "Ciencias Sociales", "topic": "Ríos", "question": "¿Río más largo de España?", "options": ["Guadalquivir", "Ebro", "Tajo", "Duero"], "answer": 2, "explanation": "El Tajo con ~1007 km."}, {"id": 135, "subject": "Ciencias Sociales", "topic": "Ríos", "question": "¿Vertiente del Ebro?", "options": ["Atlántica", "Cantábrica", "Mediterránea", "Todos"], "answer": 2, "explanation": "Desemboca en el Mediterráneo (delta en Tarragona)."}, {"id": 136, "subject": "Ciencias Sociales", "topic": "Ríos", "question": "¿Comunidad del Guadalquivir?", "options": ["Cataluña", "Andalucía", "Galicia", "Madrid"], "answer": 1, "explanation": "Atraviesa Andalucía."}, {"id": 137, "subject": "Ciencias Sociales", "topic": "Ríos", "question": "¿Río atlántico?", "options": ["Ebro", "Segura", "Duero", "Júcar"], "answer": 2, "explanation": "El Duero desemboca en el Atlántico (Oporto)."}, {"id": 138, "subject": "Ciencias Sociales", "topic": "Relieve", "question": "Cordillera entre España y Francia:", "options": ["Sierra Nevada", "Cantábrica", "Sistema Central", "Pirineos"], "answer": 3, "explanation": "Pirineos = frontera natural."}, {"id": 139, "subject": "Ciencias Sociales", "topic": "Relieve", "question": "Pico más alto de la Península:", "options": ["Teide", "Mulhacén", "Aneto", "Veleta"], "answer": 1, "explanation": "Mulhacén (3.479 m) en Sierra Nevada."}, {"id": 140, "subject": "Ciencias Sociales", "topic": "Relieve", "question": "¿Cordillera del Aneto?", "options": ["Sistema Central", "Sierra Nevada", "Pirineos", "Cantábrica"], "answer": 2, "explanation": "Aneto (3.404 m) está en los Pirineos."}, {"id": 141, "subject": "Ciencias Sociales", "topic": "Relieve", "question": "La Meseta está dividida por:", "options": ["Pirineos", "Sistema Central", "Cantábrica", "Sierra Morena"], "answer": 1, "explanation": "Sistema Central divide Submeseta Norte y Sur."}, {"id": 142, "subject": "Ciencias Sociales", "topic": "CCAA", "question": "¿Cuántas CCAA tiene España?", "options": ["15", "17", "19", "21"], "answer": 1, "explanation": "17 comunidades + 2 ciudades autónomas."}, {"id": 143, "subject": "Ciencias Sociales", "topic": "CCAA", "question": "Capital de Cataluña:", "options": ["Valencia", "Zaragoza", "Barcelona", "Bilbao"], "answer": 2, "explanation": "Barcelona."}, {"id": 144, "subject": "Ciencias Sociales", "topic": "CCAA", "question": "¿CCAA de Sevilla?", "options": ["Extremadura", "Castilla-La Mancha", "Andalucía", "Murcia"], "answer": 2, "explanation": "Sevilla es capital de Andalucía."}, {"id": 145, "subject": "Ciencias Sociales", "topic": "CCAA", "question": "CCAA más grande:", "options": ["Andalucía", "Castilla y León", "Castilla-La Mancha", "Aragón"], "answer": 1, "explanation": "Castilla y León es la más extensa."}, {"id": 146, "subject": "Ciencias Sociales", "topic": "Clima", "question": "Clima de la costa norte:", "options": ["Mediterráneo", "Oceánico", "Subtropical", "Continental"], "answer": 1, "explanation": "Oceánico: lluvioso, temperaturas suaves."}, {"id": 147, "subject": "Ciencias Sociales", "topic": "Clima", "question": "Veranos calurosos y secos, inviernos suaves:", "options": ["Oceánico", "Mediterráneo", "Polar", "Tropical"], "answer": 1, "explanation": "Clima mediterráneo."}, {"id": 148, "subject": "Ciencias Sociales", "topic": "Clima", "question": "¿Archipiélago con clima subtropical?", "options": ["Baleares", "Canarias", "Ambas", "Ninguna"], "answer": 1, "explanation": "Canarias por su cercanía al trópico."}, {"id": 149, "subject": "Ciencias Sociales", "topic": "Europa", "question": "Río más largo de Europa:", "options": ["Danubio", "Rin", "Volga", "Sena"], "answer": 2, "explanation": "Volga (~3.530 km) en Rusia."}, {"id": 150, "subject": "Ciencias Sociales", "topic": "Europa", "question": "Montaña más alta de Europa:", "options": ["Mont Blanc", "Elbrus", "Matterhorn", "Mulhacén"], "answer": 1, "explanation": "Elbrus (5.642 m) en el Cáucaso."}, {"id": 151, "subject": "Ciencias Sociales", "topic": "Europa", "question": "Capital de Francia:", "options": ["Lyon", "Marsella", "París", "Burdeos"], "answer": 2, "explanation": "París."}, {"id": 152, "subject": "Ciencias Sociales", "topic": "Europa", "question": "Países en la UE (aprox.):", "options": ["15", "20", "27", "35"], "answer": 2, "explanation": "27 tras el Brexit."}, {"id": 153, "subject": "Ciencias Sociales", "topic": "Población", "question": "¿Qué mide la tasa de natalidad?", "options": ["Muertes/año", "Nacimientos/1000 hab.", "Emigrantes", "Esperanza de vida"], "answer": 1, "explanation": "Nacimientos por cada 1000 habitantes."}, {"id": 154, "subject": "Ciencias Sociales", "topic": "Población", "question": "¿Qué es densidad de población?", "options": ["Total habitantes", "Habitantes/km²", "Edad media", "Nº ciudades"], "answer": 1, "explanation": "Habitantes por km²."}, {"id": 155, "subject": "Ciencias Sociales", "topic": "Población", "question": "Gráfico de edad y sexo:", "options": ["Climograma", "Mapa topográfico", "Pirámide de población", "Gráfico circular"], "answer": 2, "explanation": "Pirámide de población."}, {"id": 156, "subject": "Ciencias Sociales", "topic": "Economía", "question": "Sector de la agricultura:", "options": ["Primario", "Secundario", "Terciario", "Cuaternario"], "answer": 0, "explanation": "Agricultura = sector primario."}, {"id": 157, "subject": "Ciencias Sociales", "topic": "Economía", "question": "Sector de la industria:", "options": ["Primario", "Secundario", "Terciario", "Ninguno"], "answer": 1, "explanation": "Industria = sector secundario."}, {"id": 158, "subject": "Ciencias Sociales", "topic": "Economía", "question": "Turismo y sanidad son sector:", "options": ["Primario", "Secundario", "Terciario", "Cuaternario"], "answer": 2, "explanation": "Servicios = sector terciario."}, {"id": 159, "subject": "Ciencias Sociales", "topic": "Prehistoria", "question": "¿Cuándo se inventó la agricultura?", "options": ["Paleolítico", "Neolítico", "Edad Metales", "Edad Media"], "answer": 1, "explanation": "Neolítico: agricultura y sedentarismo."}, {"id": 160, "subject": "Ciencias Sociales", "topic": "Prehistoria", "question": "Característica del Paleolítico:", "options": ["Sedentarios", "Ciudades", "Nómadas, caza", "Metales"], "answer": 2, "explanation": "Vida nómada, caza y recolección."}, {"id": 161, "subject": "Ciencias Sociales", "topic": "Prehistoria", "question": "Primer metal usado por el humano:", "options": ["Hierro", "Bronce", "Cobre", "Oro"], "answer": 2, "explanation": "Cobre fue el primero."}, {"id": 162, "subject": "Ciencias Sociales", "topic": "Edad Antigua", "question": "Pueblos prerromanos en Iberia:", "options": ["Vikingos", "Iberos y celtas", "Francos", "Griegos"], "answer": 1, "explanation": "Iberos (costa) y celtas (interior)."}, {"id": 163, "subject": "Ciencias Sociales", "topic": "Edad Antigua", "question": "Idioma que dejaron los romanos:", "options": ["Griego", "Árabe", "Latín", "Celta"], "answer": 2, "explanation": "El latín evolucionó al castellano."}, {"id": 164, "subject": "Ciencias Sociales", "topic": "Edad Antigua", "question": "Nombre romano de la Península:", "options": ["Galia", "Britania", "Hispania", "Germania"], "answer": 2, "explanation": "Hispania."}, {"id": 165, "subject": "Ciencias Sociales", "topic": "Edad Media", "question": "Pueblo germánico tras Roma:", "options": ["Francos", "Vikingos", "Visigodos", "Sajones"], "answer": 2, "explanation": "Visigodos en la Península."}, {"id": 166, "subject": "Ciencias Sociales", "topic": "Edad Media", "question": "Año de llegada musulmana:", "options": ["711", "1000", "1212", "1492"], "answer": 0, "explanation": "711: cruzaron el estrecho."}, {"id": 167, "subject": "Ciencias Sociales", "topic": "Edad Media", "question": "Territorio musulmán peninsular:", "options": ["Hispania", "Al-Ándalus", "Castilla", "Aragón"], "answer": 1, "explanation": "Al-Ándalus."}, {"id": 168, "subject": "Ciencias Sociales", "topic": "Edad Media", "question": "¿Qué fue la Reconquista?", "options": ["Conquista América", "Recuperación cristiana", "Rev. industrial", "Expansión Roma"], "answer": 1, "explanation": "Recuperación de territorios (711-1492)."}, {"id": 169, "subject": "Ciencias Sociales", "topic": "Edad Moderna", "question": "¿Quiénes fueron los Reyes Católicos?", "options": ["Carlos I y Juana", "Felipe II e Isabel", "Fernando e Isabel", "Alfonso XIII"], "answer": 2, "explanation": "Fernando de Aragón e Isabel de Castilla."}, {"id": 170, "subject": "Ciencias Sociales", "topic": "Edad Moderna", "question": "Año llegada Colón a América:", "options": ["1412", "1482", "1492", "1592"], "answer": 2, "explanation": "12 octubre 1492."}, {"id": 171, "subject": "Ciencias Sociales", "topic": "Edad Moderna", "question": "Dinastía tras los Reyes Católicos:", "options": ["Borbones", "Habsburgo", "Trastámara", "Plantagenet"], "answer": 1, "explanation": "Habsburgo (Casa de Austria) desde Carlos I."}, {"id": 172, "subject": "Ciencias Sociales", "topic": "Constitución", "question": "Año de la Constitución Española:", "options": ["1931", "1975", "1978", "1982"], "answer": 2, "explanation": "6 diciembre 1978."}, {"id": 173, "subject": "Ciencias Sociales", "topic": "Constitución", "question": "Forma de gobierno de España:", "options": ["República", "Monarquía parlamentaria", "Dictadura", "República federal"], "answer": 1, "explanation": "Monarquía parlamentaria."}, {"id": 174, "subject": "Ciencias Sociales", "topic": "Constitución", "question": "Los tres poderes del Estado:", "options": ["Militar, civil, religioso", "Legislativo, ejecutivo, judicial", "Real, parlamentario, popular", "Municipal, provincial, nacional"], "answer": 1, "explanation": "Legislativo, ejecutivo y judicial."}, {"id": 175, "subject": "Ciencias Sociales", "topic": "UE", "question": "Órgano legislativo de la UE:", "options": ["Comisión", "Parlamento Europeo", "Consejo", "Tribunal"], "answer": 1, "explanation": "Parlamento Europeo."}, {"id": 176, "subject": "Ciencias Sociales", "topic": "UE", "question": "Sede del Parlamento Europeo:", "options": ["Bruselas", "Luxemburgo", "Estrasburgo", "La Haya"], "answer": 2, "explanation": "Estrasburgo (Francia)."}, {"id": 177, "subject": "Inglés", "topic": "Present Simple", "question": "She ___ to school every day.", "options": ["go", "goes", "going", "gone"], "answer": 1, "explanation": "3ª persona singular añade -s: goes."}, {"id": 178, "subject": "Inglés", "topic": "Present Simple", "question": "Correct sentence:", "options": ["He don't like fish", "He doesn't likes fish", "He doesn't like fish", "He not like fish"], "answer": 2, "explanation": "Doesn't + infinitivo sin -s."}, {"id": 179, "subject": "Inglés", "topic": "Present Simple", "question": "___ you play football on Saturdays?", "options": ["Does", "Do", "Are", "Is"], "answer": 1, "explanation": "Con 'you' se usa 'do'."}, {"id": 180, "subject": "Inglés", "topic": "Present Simple", "question": "My cat ___ milk every morning.", "options": ["drink", "drinks", "drinking", "drinked"], "answer": 1, "explanation": "3ª persona: drinks."}, {"id": 181, "subject": "Inglés", "topic": "Present Continuous", "question": "They ___ a film right now.", "options": ["watch", "watches", "are watching", "watched"], "answer": 2, "explanation": "Are + verbo-ing = present continuous."}, {"id": 182, "subject": "Inglés", "topic": "Present Continuous", "question": "I ___ my homework at the moment.", "options": ["do", "am doing", "does", "did"], "answer": 1, "explanation": "I am doing = present continuous."}, {"id": 183, "subject": "Inglés", "topic": "Present Continuous", "question": "Which is present continuous?", "options": ["She sings well", "She is singing now", "She sang yesterday", "She will sing"], "answer": 1, "explanation": "Is + singing = present continuous."}, {"id": 184, "subject": "Inglés", "topic": "Past Simple", "question": "Past simple of 'go':", "options": ["goed", "gone", "went", "going"], "answer": 2, "explanation": "Go es irregular: went."}, {"id": 185, "subject": "Inglés", "topic": "Past Simple", "question": "Yesterday I ___ a great movie.", "options": ["see", "saw", "seen", "seeing"], "answer": 1, "explanation": "See → saw (irregular)."}, {"id": 186, "subject": "Inglés", "topic": "Past Simple", "question": "Past simple of 'eat':", "options": ["eated", "eaten", "eating", "ate"], "answer": 3, "explanation": "Eat → ate (irregular)."}, {"id": 187, "subject": "Inglés", "topic": "Past Simple", "question": "Correct negative:", "options": ["She didn't went", "She didn't go", "She not go", "She don't go"], "answer": 1, "explanation": "Didn't + infinitivo: didn't go."}, {"id": 188, "subject": "Inglés", "topic": "Past Simple", "question": "We ___ happy at the party last night.", "options": ["was", "were", "are", "is"], "answer": 1, "explanation": "Con 'we' se usa 'were'."}, {"id": 189, "subject": "Inglés", "topic": "Past Simple", "question": "Past simple of 'have':", "options": ["haved", "having", "has", "had"], "answer": 3, "explanation": "Have → had (irregular)."}, {"id": 190, "subject": "Inglés", "topic": "Past Continuous", "question": "I ___ when the phone rang.", "options": ["was sleeping", "were sleeping", "am sleeping", "slept"], "answer": 0, "explanation": "Was + -ing con 'I' = past continuous."}, {"id": 191, "subject": "Inglés", "topic": "Past Continuous", "question": "They ___ football at 5pm yesterday.", "options": ["was playing", "were playing", "are playing", "played"], "answer": 1, "explanation": "Con 'they': were + -ing."}, {"id": 192, "subject": "Inglés", "topic": "Future", "question": "It ___ rain tomorrow. Look at the clouds!", "options": ["will", "is going to", "was", "does"], "answer": 1, "explanation": "Going to para evidencia presente."}, {"id": 193, "subject": "Inglés", "topic": "Future", "question": "I think robots ___ do all work in future.", "options": ["are going to", "going to", "will", "were"], "answer": 2, "explanation": "Will para opiniones/predicciones."}, {"id": 194, "subject": "Inglés", "topic": "Future", "question": "We ___ visit grandparents next weekend.", "options": ["are going to", "will to", "going", "were"], "answer": 0, "explanation": "Are going to para planes decididos."}, {"id": 195, "subject": "Inglés", "topic": "Comparatives", "question": "An elephant is ___ than a cat.", "options": ["big", "bigger", "biggest", "more big"], "answer": 1, "explanation": "Adjetivo corto + -er: bigger."}, {"id": 196, "subject": "Inglés", "topic": "Comparatives", "question": "This book is ___ than that one.", "options": ["more interesting", "interestinger", "most interesting", "interessant"], "answer": 0, "explanation": "Adjetivo largo: more + adjetivo."}, {"id": 197, "subject": "Inglés", "topic": "Superlatives", "question": "Everest is the ___ mountain in the world.", "options": ["higher", "highest", "most high", "more high"], "answer": 1, "explanation": "Adjetivo corto: the + -est."}, {"id": 198, "subject": "Inglés", "topic": "Superlatives", "question": "She is the ___ student in class.", "options": ["more intelligent", "most intelligent", "intelligentest", "intelligent"], "answer": 1, "explanation": "Adjetivo largo: the most + adjetivo."}, {"id": 199, "subject": "Inglés", "topic": "Vocabulary", "question": "Which is a vegetable?", "options": ["Strawberry", "Carrot", "Chicken", "Cheese"], "answer": 1, "explanation": "Carrot = zanahoria (verdura)."}, {"id": 200, "subject": "Inglés", "topic": "Vocabulary", "question": "Typical English breakfast:", "options": ["Paella", "Toast and cereal", "Sushi", "Tacos"], "answer": 1, "explanation": "Toast y cereal son típicos."}, {"id": 201, "subject": "Inglés", "topic": "Vocabulary", "question": "What do you wear on your feet?", "options": ["Hat", "Gloves", "Shoes", "Scarf"], "answer": 2, "explanation": "Shoes = zapatos (feet = pies)."}, {"id": 202, "subject": "Inglés", "topic": "Vocabulary", "question": "Which is NOT clothing?", "options": ["Trousers", "Dress", "Pencil", "T-shirt"], "answer": 2, "explanation": "Pencil = lápiz, no es ropa."}, {"id": 203, "subject": "Inglés", "topic": "Vocabulary", "question": "Which animal lives on a farm?", "options": ["Lion", "Shark", "Cow", "Penguin"], "answer": 2, "explanation": "Cow = vaca, animal de granja."}, {"id": 204, "subject": "Inglés", "topic": "Vocabulary", "question": "Weather when snowing:", "options": ["Sunny", "Rainy", "Cloudy", "Snowy"], "answer": 3, "explanation": "Snowy = nevado."}, {"id": 205, "subject": "Inglés", "topic": "Vocabulary", "question": "Take an umbrella! It's ___ outside.", "options": ["sunny", "rainy", "hot", "windy"], "answer": 1, "explanation": "Umbrella = lluvia: rainy."}, {"id": 206, "subject": "Inglés", "topic": "Vocabulary", "question": "Which is a school subject?", "options": ["Kitchen", "Mathematics", "Bedroom", "Garden"], "answer": 1, "explanation": "Mathematics = asignatura."}, {"id": 207, "subject": "Inglés", "topic": "Modals", "question": "You ___ wear a seatbelt in the car.", "options": ["can", "should", "must", "might"], "answer": 2, "explanation": "Must = obligación fuerte."}, {"id": 208, "subject": "Inglés", "topic": "Modals", "question": "'You should eat more fruit' means:", "options": ["Obligación", "Consejo", "Prohibición", "Pregunta"], "answer": 1, "explanation": "Should = consejo."}, {"id": 209, "subject": "Inglés", "topic": "Modals", "question": "___ I go to the toilet, please?", "options": ["Must", "Should", "Can", "Will"], "answer": 2, "explanation": "Can = pedir permiso."}, {"id": 210, "subject": "Inglés", "topic": "Prepositions", "question": "The cat is ___ the table. (debajo)", "options": ["on", "in", "under", "next to"], "answer": 2, "explanation": "Under = debajo de."}, {"id": 211, "subject": "Inglés", "topic": "Prepositions", "question": "The book is ___ the shelf.", "options": ["under", "on", "between", "behind"], "answer": 1, "explanation": "On = sobre la superficie."}, {"id": 212, "subject": "Inglés", "topic": "Prepositions", "question": "My birthday is ___ July.", "options": ["on", "in", "at", "to"], "answer": 1, "explanation": "Meses: in July."}, {"id": 213, "subject": "Inglés", "topic": "Prepositions", "question": "English class ___ Monday.", "options": ["in", "at", "on", "to"], "answer": 2, "explanation": "Días: on Monday."}, {"id": 214, "subject": "Inglés", "topic": "Pronouns", "question": "I saw Mary. I gave ___ a present.", "options": ["she", "her", "hers", "herself"], "answer": 1, "explanation": "Her = pronombre objeto."}, {"id": 215, "subject": "Inglés", "topic": "Pronouns", "question": "Object pronoun:", "options": ["He", "They", "Us", "We"], "answer": 2, "explanation": "Us = pronombre objeto (a nosotros)."}, {"id": 216, "subject": "Inglés", "topic": "There is/are", "question": "___ a park near my house.", "options": ["There is", "There are", "There was", "There have"], "answer": 0, "explanation": "Singular: There is a park."}, {"id": 217, "subject": "Inglés", "topic": "Countable", "question": "How ___ water do you drink?", "options": ["many", "much", "some", "few"], "answer": 1, "explanation": "Water incontable: much."}, {"id": 218, "subject": "Inglés", "topic": "Countable", "question": "There aren't ___ apples in the fridge.", "options": ["much", "some", "any", "a"], "answer": 2, "explanation": "Negativa + contable: any."}, {"id": 219, "subject": "Biosfera", "topic": "Biodiversidad", "question": "¿Qué es la biodiversidad?", "options": ["Solo plantas", "Variedad de seres vivos", "Cantidad de agua", "Nº de montañas"], "answer": 1, "explanation": "Variedad de seres vivos en un lugar."}, {"id": 220, "subject": "Biosfera", "topic": "Biodiversidad", "question": "¿Por qué conservar la biodiversidad?", "options": ["Estética", "Equilibrio ecosistemas", "No importa", "Solo turismo"], "answer": 1, "explanation": "Mantiene equilibrio ecológico."}, {"id": 221, "subject": "Biosfera", "topic": "Biodiversidad", "question": "Tres niveles de biodiversidad:", "options": ["Agua, tierra, aire", "Genética, especies, ecosistemas", "Local, nacional, mundial", "Fauna, flora, hongos"], "answer": 1, "explanation": "Genética, de especies y de ecosistemas."}, {"id": 222, "subject": "Biosfera", "topic": "Especies", "question": "Felino más amenazado de Iberia:", "options": ["Gato montés", "Lince ibérico", "Leopardo", "Pantera"], "answer": 1, "explanation": "Lince ibérico, en Andalucía."}, {"id": 223, "subject": "Biosfera", "topic": "Especies", "question": "¿Dónde vive el oso pardo?", "options": ["Andalucía", "Meseta", "Cantábrica y Pirineos", "Canarias"], "answer": 2, "explanation": "Cordillera Cantábrica y Pirineos."}, {"id": 224, "subject": "Biosfera", "topic": "Especies", "question": "Ave rapaz en peligro en España:", "options": ["Gorrión", "Paloma", "Águila imperial", "Gallina"], "answer": 2, "explanation": "Águila imperial ibérica, endémica."}, {"id": 225, "subject": "Biosfera", "topic": "Especies", "question": "Mamífero marino en peligro (Mediterráneo):", "options": ["Delfín", "Foca monje", "Ballena azul", "Tiburón"], "answer": 1, "explanation": "Foca monje del Mediterráneo."}, {"id": 226, "subject": "Biosfera", "topic": "Especies", "question": "Ave carroñera en peligro en montañas:", "options": ["Cuervo", "Quebrantahuesos", "Cigüeña", "Flamenco"], "answer": 1, "explanation": "Quebrantahuesos en Pirineos."}, {"id": 227, "subject": "Biosfera", "topic": "Parques", "question": "¿CCAA de Doñana?", "options": ["Extremadura", "Andalucía", "Castilla-La Mancha", "Murcia"], "answer": 1, "explanation": "Doñana está en Andalucía."}, {"id": 228, "subject": "Biosfera", "topic": "Parques", "question": "Isla del Parque del Teide:", "options": ["Gran Canaria", "Lanzarote", "Tenerife", "La Palma"], "answer": 2, "explanation": "Teide en Tenerife (3.718 m)."}, {"id": 229, "subject": "Biosfera", "topic": "Parques", "question": "Cordillera de Ordesa:", "options": ["Sierra Nevada", "Pirineos", "Cantábrica", "Sistema Central"], "answer": 1, "explanation": "Ordesa en Pirineo aragonés."}, {"id": 230, "subject": "Biosfera", "topic": "Parques", "question": "Parque humedal en C-La Mancha:", "options": ["Sierra Nevada", "Tablas de Daimiel", "Cabañeros", "Aigüestortes"], "answer": 1, "explanation": "Tablas de Daimiel (Ciudad Real)."}, {"id": 231, "subject": "Biosfera", "topic": "Parques", "question": "CCAA de Picos de Europa:", "options": ["Solo Asturias", "Solo Cantabria", "Asturias, Cantabria, CyL", "País Vasco"], "answer": 2, "explanation": "Se extiende por 3 comunidades."}, {"id": 232, "subject": "Biosfera", "topic": "Ciclo agua", "question": "Paso de agua líquida a vapor:", "options": ["Condensación", "Precipitación", "Evaporación", "Infiltración"], "answer": 2, "explanation": "Evaporación = líquido a gas."}, {"id": 233, "subject": "Biosfera", "topic": "Ciclo agua", "question": "¿Qué proceso forma las nubes?", "options": ["Evaporación", "Condensación", "Precipitación", "Escorrentía"], "answer": 1, "explanation": "Condensación: vapor → gotitas."}, {"id": 234, "subject": "Biosfera", "topic": "Ciclo agua", "question": "Caída de agua de nubes al suelo:", "options": ["Evaporación", "Condensación", "Precipitación", "Transpiración"], "answer": 2, "explanation": "Precipitación: lluvia, nieve, granizo."}, {"id": 235, "subject": "Biosfera", "topic": "Ciclo agua", "question": "¿Qué es la infiltración?", "options": ["Agua que se evapora", "Agua que penetra en el suelo", "Agua de nubes", "Agua del mar"], "answer": 1, "explanation": "Penetra en el suelo hacia acuíferos."}, {"id": 236, "subject": "Biosfera", "topic": "Atmósfera", "question": "Capa donde vivimos y hay clima:", "options": ["Estratosfera", "Mesosfera", "Troposfera", "Termosfera"], "answer": 2, "explanation": "Troposfera = fenómenos meteorológicos."}, {"id": 237, "subject": "Biosfera", "topic": "Atmósfera", "question": "Gas más abundante en la atmósfera:", "options": ["Oxígeno", "Nitrógeno", "CO₂", "Argón"], "answer": 1, "explanation": "Nitrógeno ≈ 78%."}, {"id": 238, "subject": "Biosfera", "topic": "Atmósfera", "question": "Capa de ozono está en:", "options": ["Troposfera", "Estratosfera", "Mesosfera", "Exosfera"], "answer": 1, "explanation": "Estratosfera protege de rayos UV."}, {"id": 239, "subject": "Biosfera", "topic": "Contaminación", "question": "Causa de contaminación del aire:", "options": ["Plantar árboles", "Bicicleta", "Quemar combustibles", "Reciclar"], "answer": 2, "explanation": "Combustibles fósiles contaminan."}, {"id": 240, "subject": "Biosfera", "topic": "Contaminación", "question": "Fábricas vertiendo al río = contaminación:", "options": ["Acústica", "Lumínica", "Atmosférica", "Del agua"], "answer": 3, "explanation": "Contaminación hídrica."}, {"id": 241, "subject": "Biosfera", "topic": "Contaminación", "question": "Exceso de ruido = contaminación:", "options": ["Atmosférica", "Acústica", "Lumínica", "Del suelo"], "answer": 1, "explanation": "Contaminación acústica."}, {"id": 242, "subject": "Biosfera", "topic": "Reciclaje", "question": "Contenedor para plásticos y latas:", "options": ["Azul", "Verde", "Amarillo", "Gris"], "answer": 2, "explanation": "Amarillo = plástico, latas, briks."}, {"id": 243, "subject": "Biosfera", "topic": "Reciclaje", "question": "Contenedor para papel y cartón:", "options": ["Amarillo", "Verde", "Azul", "Gris"], "answer": 2, "explanation": "Azul = papel y cartón."}, {"id": 244, "subject": "Biosfera", "topic": "Reciclaje", "question": "Color del contenedor de vidrio:", "options": ["Azul", "Amarillo", "Gris", "Verde"], "answer": 3, "explanation": "Verde (iglú) = vidrio."}, {"id": 245, "subject": "Biosfera", "topic": "Reciclaje", "question": "Las 3 R de la ecología:", "options": ["Reducir, Reutilizar, Reciclar", "Reciclar, Reparar, Recoger", "Reducir, Regar, Reforestar", "Reciclar, Romper, Rellenar"], "answer": 0, "explanation": "Reducir, Reutilizar, Reciclar."}, {"id": 246, "subject": "Biosfera", "topic": "Cambio climático", "question": "¿Qué es el efecto invernadero?", "options": ["Subida del mar", "Gases retienen calor", "Contaminación acústica", "Destrucción ozono"], "answer": 1, "explanation": "Gases retienen calor en la atmósfera."}, {"id": 247, "subject": "Biosfera", "topic": "Cambio climático", "question": "Principal gas de efecto invernadero:", "options": ["Oxígeno", "Nitrógeno", "CO₂", "Helio"], "answer": 2, "explanation": "CO₂ por actividad humana."}, {"id": 248, "subject": "Biosfera", "topic": "Cambio climático", "question": "Consecuencia del cambio climático:", "options": ["Más biodiversidad", "Deshielo de polos", "Más lluvia en desiertos", "Baja del mar"], "answer": 1, "explanation": "Deshielo → sube nivel del mar."}, {"id": 249, "subject": "Biosfera", "topic": "Cambio climático", "question": "Acuerdo para limitar calentamiento:", "options": ["Tratado Roma", "Acuerdo de París", "Protocolo Ginebra", "Declaración Río"], "answer": 1, "explanation": "Acuerdo de París (2015)."}, {"id": 250, "subject": "Biosfera", "topic": "Sostenibilidad", "question": "¿Qué es desarrollo sostenible?", "options": ["Usar todo sin límite", "Cubrir necesidades sin dañar futuro", "Solo economía", "Solo medio ambiente"], "answer": 1, "explanation": "Equilibrio económico-social-ambiental."}, {"id": 251, "subject": "Biosfera", "topic": "Sostenibilidad", "question": "¿Cuántos ODS (Objetivos) hay?", "options": ["10", "15", "17", "20"], "answer": 2, "explanation": "17 ODS de la ONU para 2030."}, {"id": 252, "subject": "Biosfera", "topic": "Flora", "question": "Árbol del bosque mediterráneo:", "options": ["Abeto", "Encina", "Abedul", "Pino canario"], "answer": 1, "explanation": "Encina = árbol típico mediterráneo."}, {"id": 253, "subject": "Biosfera", "topic": "Flora", "question": "¿De qué árbol se obtiene el corcho?", "options": ["Roble", "Pino", "Alcornoque", "Encina"], "answer": 2, "explanation": "Alcornoque produce corcho."}, {"id": 254, "subject": "Biosfera", "topic": "Fauna", "question": "Animal símbolo de los Pirineos:", "options": ["Lobo", "Cabra montés", "Sarrio/rebeco", "Jabalí"], "answer": 2, "explanation": "Sarrio = rebeco pirenaico."}, {"id": 255, "subject": "Biosfera", "topic": "Fauna", "question": "¿Dónde ver flamencos en España?", "options": ["Pirineos", "Meseta Norte", "Doñana y Delta del Ebro", "Cantábrica"], "answer": 2, "explanation": "Humedales del sur y Delta del Ebro."}, {"id": 256, "subject": "Biosfera", "topic": "Espacios", "question": "¿Qué es Reserva de la Biosfera?", "options": ["Un zoo", "Espacio UNESCO biodiversidad", "Parque atracciones", "Granja ecológica"], "answer": 1, "explanation": "UNESCO para conservación sostenible."}, {"id": 257, "subject": "Biosfera", "topic": "Energías", "question": "Energía de la fuerza del viento:", "options": ["Solar", "Hidráulica", "Eólica", "Geotérmica"], "answer": 2, "explanation": "Eólica = viento."}, {"id": 258, "subject": "Biosfera", "topic": "Energías", "question": "Paneles solares producen energía:", "options": ["Eólica", "Solar fotovoltaica", "Hidráulica", "Biomasa"], "answer": 1, "explanation": "Paneles convertir luz en electricidad."}, {"id": 259, "subject": "Biosfera", "topic": "Deforestación", "question": "¿Qué es la deforestación?", "options": ["Plantar árboles", "Pérdida de bosques", "Regar campos", "Proteger parques"], "answer": 1, "explanation": "Eliminación masiva de bosques."}, {"id": 260, "subject": "Biosfera", "topic": "Océanos", "question": "Mayor contaminante de los océanos:", "options": ["Arena", "Plásticos", "Algas", "Piedras"], "answer": 1, "explanation": "Plástico forma islas de basura."}];


// ===== UTILIDADES =====
function shuffleArray(a){const b=[...a];for(let i=b.length-1;i>0;i--){const j=Math.floor(Math.random()*(i+1));[b[i],b[j]]=[b[j],b[i]];}return b;}
function sanitizeHTML(s){if(!s)return'';return s.replace(/<script[^>]*>[\s\S]*?<\/script>/gi,'').replace(/on\w+="[^"]*"/gi,'').replace(/<\/?(?:script|iframe|object|embed|form)[^>]*>/gi,'');}
function renderMarkdown(s){if(!s)return'';let r=sanitizeHTML(s);r=r.replace(/\*\*(.+?)\*\*/g,'<strong>$1</strong>');r=r.replace(/\*(.+?)\*/g,'<em>$1</em>');r=r.replace(/`(.+?)`/g,'<code>$1</code>');r=r.replace(/\n/g,'<br>');return r;}
function formatTime(sec){const m=Math.floor(sec/60),s=sec%60;return String(m).padStart(2,'0')+':'+String(s).padStart(2,'0');}
function getSubjectColor(s){return{'Matemáticas':'#007AFF','Lengua':'#FF9500','Ciencias Naturales':'#34C759','Ciencias Sociales':'#AF52DE','Inglés':'#FF2D55','Biosfera':'#00C7BE'}[s]||'#007AFF';}
function getSubjectEmoji(s){return{'Matemáticas':'📐','Lengua':'🔤','Ciencias Naturales':'🔬','Ciencias Sociales':'🌍','Inglés':'🇬🇧','Biosfera':'🌿'}[s]||'📚';}
function saveData(k,v){try{localStorage.setItem(k,JSON.stringify(v));}catch(e){}}
function loadData(k,d){try{return JSON.parse(localStorage.getItem(k))||d;}catch(e){return d;}}

// ===== ESTADO =====
let quizState={questions:[],current:0,score:0,answered:false,subject:''};
let examState={questions:[],current:0,score:0,answered:false,timer:null,timeLeft:900,results:{}};
let progress=loadData('schoolProgress',{subjects:{},exams:[]});
let aiProvider='auto';

// ===== INIT =====
document.addEventListener('DOMContentLoaded',function(){
  setTimeout(function(){
    var sp=document.getElementById('splash');
    var ma=document.getElementById('main-app');
    if(sp)sp.style.display='none';
    if(ma)ma.style.display='block';
  },2000);
  initSettings();
  initNavigation();
  initChat();
  detectAIProvider();
  renderProgress();
});

// ===== NAVEGACIÓN =====
function initNavigation(){
  var links=document.querySelectorAll('.nav-links a[data-section]');
  var sections=document.querySelectorAll('.section');
  var sidebar=document.getElementById('sidebar');
  var overlay=document.getElementById('sidebar-overlay');
  var hamburger=document.getElementById('hamburger');
  links.forEach(function(link){
    link.addEventListener('click',function(e){
      e.preventDefault();
      var target=this.getAttribute('data-section');
      links.forEach(function(l){l.classList.remove('active');});
      sections.forEach(function(s){s.classList.remove('active');});
      this.classList.add('active');
      var sec=document.getElementById(target);
      if(sec)sec.classList.add('active');
      if(target==='progreso')renderProgress();
      if(target==='examen')renderExamHistory();
      if(target==='tutor')detectAIProvider();
      sidebar.classList.remove('open');
      overlay.classList.remove('open');
    });
  });
  if(hamburger)hamburger.addEventListener('click',function(){
    sidebar.classList.toggle('open');
    overlay.classList.toggle('open');
  });
  if(overlay)overlay.addEventListener('click',function(){
    sidebar.classList.remove('open');
    overlay.classList.remove('open');
  });
}

// ===== TARJETAS =====
function toggleCard(header){
  header.classList.toggle('open');
  var body=header.nextElementSibling;
  if(body)body.classList.toggle('open');
}

// ===== QUIZ =====
function startQuiz(subject){
  var filtered=QUESTIONS.filter(function(q){return q.subject===subject;});
  if(!filtered.length){alert('No hay preguntas.');return;}
  var shuffled=shuffleArray(filtered).slice(0,10);
  quizState={questions:shuffled,current:0,score:0,answered:false,subject:subject};
  document.getElementById('quiz-modal').classList.add('active');
  document.getElementById('quiz-results').style.display='none';
  document.getElementById('quiz-question').style.display='';
  document.getElementById('quiz-options').style.display='';
  renderQuizQuestion();
}

function renderQuizQuestion(){
  var q=quizState.questions[quizState.current];
  var total=quizState.questions.length;
  quizState.answered=false;
  document.getElementById('quiz-title').textContent=getSubjectEmoji(quizState.subject)+' '+quizState.subject;
  document.getElementById('quiz-progress').textContent=(quizState.current+1)+'/'+total;
  document.getElementById('quiz-progress-fill').style.width=((quizState.current+1)/total*100)+'%';
  document.getElementById('quiz-question').textContent=q.question;
  document.getElementById('quiz-explanation').style.display='none';
  document.getElementById('quiz-next').style.display='none';
  var optDiv=document.getElementById('quiz-options');
  optDiv.innerHTML='';
  q.options.forEach(function(opt,i){
    var btn=document.createElement('button');
    btn.textContent=opt;
    btn.addEventListener('click',function(){selectQuizAnswer(i,q.answer,q.explanation);});
    optDiv.appendChild(btn);
  });
}

function selectQuizAnswer(sel,correct,expl){
  if(quizState.answered)return;
  quizState.answered=true;
  var btns=document.querySelectorAll('#quiz-options button');
  btns.forEach(function(btn,i){
    btn.classList.add('disabled');
    if(i===correct)btn.classList.add('correct');
    if(i===sel&&sel!==correct)btn.classList.add('wrong');
  });
  if(sel===correct)quizState.score++;
  var el=document.getElementById('quiz-explanation');
  el.textContent=expl;el.style.display='block';
  document.getElementById('quiz-next').style.display='block';
}

function nextQuestion(){
  quizState.current++;
  if(quizState.current<quizState.questions.length)renderQuizQuestion();
  else showQuizResults();
}

function showQuizResults(){
  document.getElementById('quiz-question').style.display='none';
  document.getElementById('quiz-options').style.display='none';
  document.getElementById('quiz-explanation').style.display='none';
  document.getElementById('quiz-next').style.display='none';
  var t=quizState.questions.length,s=quizState.score,p=Math.round(s/t*100);
  var emoji=p>=80?'🏆':p>=50?'👍':'💪';
  var rd=document.getElementById('quiz-results');
  rd.style.display='block';
  rd.innerHTML='<div style="font-size:3rem;margin-bottom:1rem;">'+emoji+'</div><h2>Quiz completado</h2><p style="font-size:1.3rem;margin:1rem 0;"><strong>'+s+'/'+t+'</strong> correctas ('+p+'%)</p><p style="color:var(--text-secondary);">'+getSubjectEmoji(quizState.subject)+' '+quizState.subject+'</p><button class="btn-primary" style="margin-top:1.5rem;" onclick="closeQuiz()">Cerrar</button>';
  if(!progress.subjects[quizState.subject])progress.subjects[quizState.subject]={attempts:0,correct:0,total:0};
  progress.subjects[quizState.subject].attempts++;
  progress.subjects[quizState.subject].correct+=s;
  progress.subjects[quizState.subject].total+=t;
  saveData('schoolProgress',progress);
}

function closeQuiz(){
  document.getElementById('quiz-modal').classList.remove('active');
  document.getElementById('quiz-question').style.display='';
  document.getElementById('quiz-options').style.display='';
  document.getElementById('quiz-results').style.display='none';
}

// ===== EXAMEN =====
function startExam(){
  var shuffled=shuffleArray(QUESTIONS.slice()).slice(0,20);
  examState={questions:shuffled,current:0,score:0,answered:false,timer:null,timeLeft:900,results:{}};
  document.getElementById('exam-modal').classList.add('active');
  document.getElementById('exam-results').style.display='none';
  document.getElementById('exam-question').style.display='';
  document.getElementById('exam-options').style.display='';
  updateExamTimerDisplay();
  examState.timer=setInterval(updateExamTimer,1000);
  renderExamQuestion();
}

function renderExamQuestion(){
  var q=examState.questions[examState.current],t=examState.questions.length;
  examState.answered=false;
  document.getElementById('exam-title').textContent='📝 Examen Semanal';
  document.getElementById('exam-progress').textContent=(examState.current+1)+'/'+t;
  document.getElementById('exam-progress-fill').style.width=((examState.current+1)/t*100)+'%';
  document.getElementById('exam-question').textContent=q.question;
  document.getElementById('exam-explanation').style.display='none';
  document.getElementById('exam-next').style.display='none';
  var od=document.getElementById('exam-options');od.innerHTML='';
  q.options.forEach(function(opt,i){
    var btn=document.createElement('button');btn.textContent=opt;
    btn.addEventListener('click',function(){selectExamAnswer(i,q.answer,q.explanation,q.subject);});
    od.appendChild(btn);
  });
}

function selectExamAnswer(sel,correct,expl,subj){
  if(examState.answered)return;
  examState.answered=true;
  var btns=document.querySelectorAll('#exam-options button');
  btns.forEach(function(b,i){b.classList.add('disabled');if(i===correct)b.classList.add('correct');if(i===sel&&sel!==correct)b.classList.add('wrong');});
  if(!examState.results[subj])examState.results[subj]={correct:0,total:0};
  examState.results[subj].total++;
  if(sel===correct){examState.score++;examState.results[subj].correct++;}
  var el=document.getElementById('exam-explanation');el.textContent=expl;el.style.display='block';
  document.getElementById('exam-next').style.display='block';
}

function nextExamQuestion(){
  examState.current++;
  if(examState.current<examState.questions.length)renderExamQuestion();
  else showExamResults();
}

function updateExamTimer(){
  examState.timeLeft--;
  updateExamTimerDisplay();
  if(examState.timeLeft<=0){clearInterval(examState.timer);showExamResults();}
}

function updateExamTimerDisplay(){
  var el=document.getElementById('exam-timer');
  if(el)el.textContent=formatTime(examState.timeLeft);
}

function showExamResults(){
  clearInterval(examState.timer);
  document.getElementById('exam-question').style.display='none';
  document.getElementById('exam-options').style.display='none';
  document.getElementById('exam-explanation').style.display='none';
  document.getElementById('exam-next').style.display='none';
  var t=examState.questions.length,s=examState.score,p=Math.round(s/t*100);
  var emoji=p>=80?'🏆':p>=50?'👍':'💪';
  var bk='';
  for(var subj in examState.results){
    var d=examState.results[subj],sp=d.total>0?Math.round(d.correct/d.total*100):0;
    bk+='<div style="display:flex;justify-content:space-between;padding:6px 0;border-bottom:1px solid var(--border);"><span>'+getSubjectEmoji(subj)+' '+subj+'</span><span style="color:'+getSubjectColor(subj)+';font-weight:600;">'+d.correct+'/'+d.total+' ('+sp+'%)</span></div>';
  }
  var rd=document.getElementById('exam-results');rd.style.display='block';
  rd.innerHTML='<div style="font-size:3rem;margin-bottom:1rem;">'+emoji+'</div><h2>Examen completado</h2><p style="font-size:1.3rem;margin:1rem 0;"><strong>'+s+'/'+t+'</strong> correctas ('+p+'%)</p><div style="text-align:left;margin:1.5rem 0;">'+bk+'</div><button class="btn-primary" onclick="closeExam()">Cerrar</button>';
  progress.exams.push({date:new Date().toLocaleDateString('es-ES'),score:s,total:t,percentage:p,details:examState.results});
  if(progress.exams.length>20)progress.exams=progress.exams.slice(-20);
  saveData('schoolProgress',progress);
}

function closeExam(){
  clearInterval(examState.timer);
  document.getElementById('exam-modal').classList.remove('active');
  document.getElementById('exam-question').style.display='';
  document.getElementById('exam-options').style.display='';
  document.getElementById('exam-results').style.display='none';
}

// ===== CHAT IA DUAL (Ollama local + Groq cloud) =====
function detectAIProvider(){
  var manual=loadData('aiProviderCloud',false);
  var host=window.location.hostname;
  var provider,statusText;
  if(manual){
    provider='cloud';statusText='☁️ Proveedor: Cloud (Groq) — Modo manual';
  }else if(host==='localhost'||host==='127.0.0.1'){
    provider='local';statusText='🖥️ Proveedor: Local (Ollama gemma2:2b) — Auto';
  }else{
    provider='cloud';statusText='☁️ Proveedor: Cloud (Groq) — GitHub Pages';
  }
  aiProvider=provider;
  var el=document.getElementById('ai-status');
  if(el)el.textContent=statusText;
  return provider;
}

function initChat(){
  var btn=document.getElementById('chat-send');
  var input=document.getElementById('chat-input');
  if(btn)btn.addEventListener('click',sendMessage);
  if(input)input.addEventListener('keydown',function(e){if(e.key==='Enter')sendMessage();});
}

function addChatBubble(text,type){
  var md=document.getElementById('chat-messages');
  var b=document.createElement('div');
  b.className='chat-bubble '+type;
  if(type.indexOf('ai')>=0)b.innerHTML=renderMarkdown(text);
  else b.textContent=text;
  md.appendChild(b);
  md.scrollTop=md.scrollHeight;
  return b;
}

async function sendMessage(){
  var input=document.getElementById('chat-input');
  var msg=input.value.trim();
  if(!msg)return;
  input.value='';
  addChatBubble(msg,'user');
  var thinking=addChatBubble('Pensando... 🤔','ai thinking');
  try{
    var response;
    if(aiProvider==='local')response=await callLocalAI(msg);
    else response=await callCloudAI(msg);
    thinking.remove();
    addChatBubble(response,'ai');
  }catch(err){
    thinking.remove();
    var errMsg=aiProvider==='local'?
      'Error al conectar con Ollama. ¿Está ejecutándose en localhost:11434? 😔':
      'El servicio cloud no está disponible ahora. Inténtalo más tarde. 😔';
    addChatBubble(errMsg,'ai');
  }
}

async function callLocalAI(message){
  var systemPrompt='Eres un tutor amable para alumnos de 6º de Primaria en España. Responde de forma clara, breve y educativa. Usa ejemplos sencillos.';
  var res=await fetch('http://localhost:11434/api/generate',{
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body:JSON.stringify({model:'gemma2:2b',prompt:systemPrompt+'\n\nPregunta del alumno: '+message,stream:false})
  });
  var data=await res.json();
  return data.response||'No he podido generar una respuesta.';
}

async function callCloudAI(message){
  var res=await fetch('https://school-gemini-proxy.pechicolo.workers.dev',{
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body:JSON.stringify({message:message})
  });
  var data=await res.json();
  return data.reply||data.response||data.text||data.message||'No he podido generar una respuesta.';
}

// ===== PROGRESO =====
function renderProgress(){
  progress=loadData('schoolProgress',{subjects:{},exams:[]});
  var statsDiv=document.getElementById('progress-stats');
  var totalQ=0,totalC=0;
  for(var k in progress.subjects){totalQ+=progress.subjects[k].total;totalC+=progress.subjects[k].correct;}
  var avgPct=totalQ>0?Math.round(totalC/totalQ*100):0;
  if(statsDiv)statsDiv.innerHTML='<div class="stat-grid"><div class="stat-item"><div class="stat-value">'+totalQ+'</div><div class="stat-label">Preguntas respondidas</div></div><div class="stat-item"><div class="stat-value">'+totalC+'</div><div class="stat-label">Correctas</div></div><div class="stat-item"><div class="stat-value">'+avgPct+'%</div><div class="stat-label">Media general</div></div><div class="stat-item"><div class="stat-value">'+progress.exams.length+'</div><div class="stat-label">Exámenes</div></div></div>';
  var subjDiv=document.getElementById('progress-subjects');
  if(subjDiv){
    var subjects=['Matemáticas','Lengua','Ciencias Naturales','Ciencias Sociales','Inglés','Biosfera'];
    var html='';
    subjects.forEach(function(subj){
      var d=progress.subjects[subj]||{attempts:0,correct:0,total:0};
      var pct=d.total>0?Math.round(d.correct/d.total*100):0;
      var medal=pct>=80?' 🏆':(pct>=50?' ⭐':'');
      var color=getSubjectColor(subj);
      html+='<div class="progress-subject-item"><div class="progress-subject-header"><span>'+getSubjectEmoji(subj)+' '+subj+medal+'</span><span style="color:'+color+';font-weight:600;">'+pct+'% ('+d.correct+'/'+d.total+')</span></div><div class="progress-bar-container"><div class="progress-bar-fill" style="width:'+pct+'%;background:'+color+';"></div></div><div style="font-size:0.8rem;color:var(--text-secondary);margin-top:4px;">'+d.attempts+' intentos</div></div>';
    });
    subjDiv.innerHTML=html;
  }
  renderExamHistory();
}

function renderExamHistory(){
  var divs=[document.getElementById('progress-exams'),document.getElementById('exam-history')];
  divs.forEach(function(examsDiv){
    if(!examsDiv)return;
    var exams=(progress.exams||[]).slice(-5).reverse();
    if(!exams.length){examsDiv.innerHTML='<div class="empty-state">📭 Aún no has realizado ningún examen</div>';return;}
    var html='';
    exams.forEach(function(ex){
      var emoji=ex.percentage>=80?'🏆':(ex.percentage>=50?'👍':'💪');
      html+='<div class="exam-history-item"><div><strong>'+emoji+' '+ex.date+'</strong></div><div style="font-weight:600;color:var(--primary);">'+ex.score+'/'+ex.total+' ('+ex.percentage+'%)</div></div>';
    });
    examsDiv.innerHTML=html;
  });
}

// ===== AJUSTES =====
function initSettings(){
  var darkToggle=document.getElementById('dark-toggle');
  var isDark=loadData('darkMode',false);
  if(isDark){document.body.classList.add('dark-mode');if(darkToggle)darkToggle.checked=true;}
  if(darkToggle)darkToggle.addEventListener('change',function(){
    document.body.classList.toggle('dark-mode',this.checked);
    saveData('darkMode',this.checked);
  });
  var aiToggle=document.getElementById('ai-toggle');
  var isCloud=loadData('aiProviderCloud',false);
  if(aiToggle){
    aiToggle.checked=isCloud;
    aiToggle.addEventListener('change',function(){
      saveData('aiProviderCloud',this.checked);
      detectAIProvider();
    });
  }
}

function resetProgress(){
  if(confirm('¿Seguro que quieres borrar todo tu progreso?')){
    progress={subjects:{},exams:[]};
    saveData('schoolProgress',progress);
    renderProgress();
    alert('✅ Progreso eliminado.');
  }
}

console.log('🎓 School v4 – Exploradores de Sexto (' + QUESTIONS.length + ' preguntas LOMLOE)');
