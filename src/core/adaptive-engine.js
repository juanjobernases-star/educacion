import { getRandomQuestions } from "./questions-bank.js";

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
      if (this.currentStreak > 0 && this.currentStreak % 3 === 0) pointsEarned += 5;
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

  getLevel(materia) {
    this._ensureMateria(materia);
    return this.levels[materia];
  }

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

  getNextQuestions(materia, count = 5) {
    const nivel = this.getLevel(materia);
    let pool = getRandomQuestions(this.perfil, materia, nivel, count + 12).filter((q) => !this.answeredIds.has(q.id));
    if (pool.length < count) {
      const extra = getRandomQuestions(this.perfil, materia, null, count + 12).filter((q) => !this.answeredIds.has(q.id));
      pool = [...pool, ...extra];
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
      totalAnswered: total,
      totalCorrect: correct,
      accuracy: total > 0 ? Math.round((correct / total) * 100) : 0,
      totalPoints: this.totalPoints,
      currentStreak: this.currentStreak,
      levelByMateria: { ...this.levels },
      statsByMateria: byMateria,
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

  reset() {
    this.history = [];
    this.streaks = {};
    this.levels = {};
    this.answeredIds = new Set();
    this.totalPoints = 0;
    this.currentStreak = 0;
  }

  toJSON() {
    return {
      perfil: this.perfil,
      history: this.history,
      streaks: this.streaks,
      levels: this.levels,
      answeredIds: Array.from(this.answeredIds),
      totalPoints: this.totalPoints,
      currentStreak: this.currentStreak
    };
  }

  static fromJSON(data) {
    const e = new AdaptiveEngine(data.perfil);
    e.history = data.history || [];
    e.streaks = data.streaks || {};
    e.levels = data.levels || {};
    e.answeredIds = new Set(data.answeredIds || []);
    e.totalPoints = data.totalPoints || 0;
    e.currentStreak = data.currentStreak || 0;
    return e;
  }
}
