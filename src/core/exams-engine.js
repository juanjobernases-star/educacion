import { getRandomQuestions } from "./questions-bank.js";

const SUBJECTS = ["matematicas", "lengua", "medio", "digital", "ingles"];

export function getWeekKey(date = new Date()) {
  const d = new Date(date);
  const firstJan = new Date(d.getFullYear(), 0, 1);
  const days = Math.floor((d - firstJan) / 86400000);
  const week = Math.ceil((days + firstJan.getDay() + 1) / 7);
  return `${d.getFullYear()}-W${String(week).padStart(2, "0")}`;
}

export function isWeeklyExamDay(date = new Date()) {
  return new Date(date).getDay() === 5; // viernes
}

export function buildWeeklyExam(perfil, countPerSubject = 2) {
  const questions = SUBJECTS.flatMap((materia) => getRandomQuestions(perfil, materia, null, countPerSubject));
  return {
    examId: `exam-${getWeekKey()}`,
    createdAt: new Date().toISOString(),
    questions
  };
}

export function scoreExam(questions, answers) {
  const details = questions.map((q, idx) => ({
    id: q.id,
    materia: q.materia,
    correct: answers[idx] === q.correcta
  }));
  const correct = details.filter((d) => d.correct).length;
  const total = questions.length;
  const percent = total > 0 ? Math.round((correct / total) * 100) : 0;
  const byMateria = {};
  for (const d of details) {
    if (!byMateria[d.materia]) byMateria[d.materia] = { total: 0, correct: 0 };
    byMateria[d.materia].total += 1;
    if (d.correct) byMateria[d.materia].correct += 1;
  }
  return { total, correct, percent, byMateria, passed: percent >= 70 };
}
