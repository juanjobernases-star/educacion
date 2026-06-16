import { SOCIAL_SCENARIOS, getRandomScenarios } from "./social-scenarios.js";
import { getRandomSocialQuestions } from "./questions-social.js";

export function buildSecurityChallengePack() {
  const scenarios = getRandomScenarios(3);
  const quiz = getRandomSocialQuestions("seguridad", 3);
  return {
    id: `challenge-pack-${Date.now()}`,
    createdAt: new Date().toISOString(),
    scenarios,
    quiz
  };
}

export function scoreChallengePack(pack, scenarioAnswers = [], quizAnswers = []) {
  const scenarioDetails = pack.scenarios.map((s, idx) => ({
    id: s.id,
    correct: scenarioAnswers[idx] === s.correct,
    type: "scenario"
  }));
  const quizDetails = pack.quiz.map((q, idx) => ({
    id: q.id,
    correct: quizAnswers[idx] === q.correcta,
    type: "quiz"
  }));

  const details = [...scenarioDetails, ...quizDetails];
  const correct = details.filter((d) => d.correct).length;
  const total = details.length;
  const percent = total > 0 ? Math.round((correct / total) * 100) : 0;
  const points = correct * 15 + (percent >= 80 ? 20 : 0);

  return {
    total,
    correct,
    percent,
    points,
    passed: percent >= 70,
    details
  };
}

export function getChallengeTips() {
  return [
    "Usa contraseñas fuertes y no las compartas.",
    "Piensa antes de publicar una foto o comentario.",
    "Si algo te incomoda, para y busca ayuda.",
    "No aceptes a desconocidos sin pensar.",
    "Comprueba la información antes de reenviarla."
  ];
}
