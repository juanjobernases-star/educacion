import { TRIMESTRE2_QUESTIONS } from "./questions-trimestre2.js";
import { QUESTIONS_BANK } from "./questions-ccaa.js";
import { EXTRA_QUESTIONS_BANK } from "./questions-lomloe-extra.js";

export const ALL_QUESTIONS_BANK = [...QUESTIONS_BANK, ...EXTRA_QUESTIONS_BANK, ...TRIMESTRE2_QUESTIONS];

export function getQuestionsByPerfil(perfil) {
  return ALL_QUESTIONS_BANK.filter((q) => q.perfil === perfil);
}
export function getQuestionsByMateria(materia) {
  return ALL_QUESTIONS_BANK.filter((q) => q.materia === materia);
}
export function getQuestionsByNivel(nivel) {
  return ALL_QUESTIONS_BANK.filter((q) => q.nivel === nivel);
}
export function getRandomQuestions(perfil, materia, nivel, count = 5) {
  let pool = ALL_QUESTIONS_BANK.filter((q) =>
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
