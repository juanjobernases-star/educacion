import { sanitizeText, redactPII } from "./secure-vault.js";

const RISK_WORDS = ["me quiero hacer daño", "no quiero vivir", "hacerme daño", "suicidio"];

export function detectEmotion(text, history = []) {
  const t = sanitizeText(text, 1200).toLowerCase();
  const scores = { tranquilo: 1, feliz: 0, triste: 0, nervioso: 0, enfadado: 0, frustrado: 0 };
  const add = (k, n = 1) => { scores[k] = (scores[k] || 0) + n; };
  if (/feliz|contento|bien|alegre|genial|guay/.test(t)) add("feliz", 3);
  if (/triste|solo|mal|llorar|pena/.test(t)) add("triste", 3);
  if (/nervioso|miedo|ansiedad|agobio|ruido|examen/.test(t)) add("nervioso", 3);
  if (/enfadado|rabia|odio|molesto/.test(t)) add("enfadado", 3);
  if (/no puedo|difícil|frustrado|bloqueado|me cuesta/.test(t)) add("frustrado", 3);
  history.slice(-5).forEach(e => { if (scores[e]) scores[e] += 0.5; });
  return Object.entries(scores).sort((a,b) => b[1]-a[1])[0][0];
}

export function hasSafetyRisk(text) {
  const t = sanitizeText(text, 1200).toLowerCase();
  return RISK_WORDS.some(w => t.includes(w));
}

export function getTutorResponse({ text, history = [], teaMode = true }) {
  const clean = redactPII(text);
  if (hasSafetyRisk(clean)) {
    return {
      emotion: "riesgo",
      level: "urgent",
      response: "Esto es importante. Para estar seguro, habla ahora con un adulto de confianza. Si hay peligro inmediato, llama a emergencias. Yo puedo acompañarte con respiración mientras pides ayuda.",
      steps: ["Paro", "Busco un adulto", "Digo: necesito ayuda", "No me quedo solo"],
      disclaimer: "La app no sustituye a profesionales sanitarios ni servicios de emergencia."
    };
  }
  const emotion = detectEmotion(clean, history);
  const base = {
    feliz: "Me alegra saberlo. Podemos aprovechar esta energía para dar un paso pequeño.",
    tranquilo: "Perfecto. Vamos paso a paso y sin prisa.",
    triste: "Siento que estés pasando por eso. Estoy contigo. Podemos hacer algo pequeño y seguro.",
    nervioso: "Entiendo que estés nervioso. Vamos a respirar despacio y ordenar el siguiente paso.",
    enfadado: "Veo que hay enfado. Primero calmamos el cuerpo y después pensamos qué hacer.",
    frustrado: "Cuando algo cuesta, lo dividimos en pasos pequeños. No tienes que hacerlo todo a la vez."
  };
  const stepsByEmotion = {
    feliz: ["Elijo una tarea", "La hago 5 minutos", "Celebro el avance"],
    tranquilo: ["Leo la tarea", "Hago un paso", "Reviso"],
    triste: ["Respiro", "Hablo con un adulto", "Hago una tarea sencilla"],
    nervioso: ["Inspiro 4", "Suelto 4", "Miro solo el primer paso"],
    enfadado: ["Paro", "Aprieto y suelto manos", "Uso voz tranquila"],
    frustrado: ["Divido la tarea", "Pido pista", "Hago un intento"],
  };
  return { emotion, level: "support", response: base[emotion], steps: stepsByEmotion[emotion] || [], sanitizedInput: clean, teaMode };
}

// Preparado para futuro LLM local. Desactivado por seguridad y privacidad.
export async function optionalLocalLLM(prompt, { enabled = false, endpoint = "http://localhost:11434/api/generate" } = {}) {
  if (!enabled) return null;
  const safePrompt = redactPII(prompt).slice(0, 1200);
  const res = await fetch(endpoint, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ model: "gemma2:2b", prompt: safePrompt, stream: false }) });
  const data = await res.json();
  return sanitizeText(data.response || "", 1200);
}
