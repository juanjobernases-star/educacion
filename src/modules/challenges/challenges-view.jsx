import React, { useMemo, useState } from "react";
import { buildSecurityChallengePack, scoreChallengePack, getChallengeTips } from "../../core/challenges-engine.js";
import { EXTRA_SOCIAL_CHALLENGES } from "../../core/social-challenges-extra.js";

function ChallengeOption({ active, onClick, children }) {
  return <button onClick={onClick} className={["rounded-2xl border px-4 py-4 text-left w-full", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>{children}</button>;
}

function ChallengeScenarioBlock({ item, answer, onAnswer, teaMode }) {
  return (
    <div className="rounded-2xl border bg-white p-5 space-y-4">
      <div className="flex items-center justify-between gap-3">
        <h3 className="font-semibold">{item.title}</h3>
        {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Paso a paso</span>}
      </div>
      <p className="text-lg font-medium leading-relaxed">{item.situation}</p>
      <div className="grid gap-3">
        {item.options.map((opt, i) => <ChallengeOption key={i} active={answer === i} onClick={() => onAnswer(i)}>{opt}</ChallengeOption>)}
      </div>
      {item.teaHint && <div className="rounded-2xl border bg-sky-50 text-sky-900 p-3 text-sm">Pista TEA: {item.teaHint}</div>}
    </div>
  );
}

export default function ChallengesView({ teaMode = true, lowStim = true }) {
  const [mode, setMode] = useState("digital");
  const [pack, setPack] = useState(() => buildSecurityChallengePack());
  const [phase, setPhase] = useState("scenario");
  const [index, setIndex] = useState(0);
  const [scenarioAnswers, setScenarioAnswers] = useState([]);
  const [quizAnswers, setQuizAnswers] = useState([]);
  const [finished, setFinished] = useState(false);
  const [extraAnswers, setExtraAnswers] = useState([]);
  const tips = useMemo(() => getChallengeTips(), []);
  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-violet-50 via-white to-cyan-50";

  const currentScenario = pack.scenarios[index];
  const currentQuiz = pack.quiz[index];
  const totalPerSection = 3;
  const extraCurrent = EXTRA_SOCIAL_CHALLENGES[index];

  function startMode(next) {
    setMode(next);
    setPhase("scenario");
    setIndex(0);
    setScenarioAnswers([]);
    setQuizAnswers([]);
    setExtraAnswers([]);
    setFinished(false);
    setPack(buildSecurityChallengePack());
  }

  function chooseScenario(option) {
    const copy = [...scenarioAnswers];
    copy[index] = option;
    setScenarioAnswers(copy);
  }

  function chooseQuiz(option) {
    const copy = [...quizAnswers];
    copy[index] = option;
    setQuizAnswers(copy);
  }

  function chooseExtra(option) {
    const copy = [...extraAnswers];
    copy[index] = option;
    setExtraAnswers(copy);
  }

  function next() {
    if (mode === "digital") {
      if (phase === "scenario") {
        if (index < totalPerSection - 1) setIndex((i) => i + 1);
        else { setPhase("quiz"); setIndex(0); }
      } else {
        if (index < totalPerSection - 1) setIndex((i) => i + 1);
        else setFinished(true);
      }
    } else {
      if (index < EXTRA_SOCIAL_CHALLENGES.length - 1) setIndex((i) => i + 1);
      else setFinished(true);
    }
  }

  function resetAll() {
    startMode(mode);
  }

  let score = null;
  if (finished) {
    if (mode === "digital") {
      score = scoreChallengePack(pack, scenarioAnswers, quizAnswers);
    } else {
      const correct = EXTRA_SOCIAL_CHALLENGES.filter((item, idx) => extraAnswers[idx] === item.correct).length;
      const total = EXTRA_SOCIAL_CHALLENGES.length;
      const percent = total > 0 ? Math.round((correct / total) * 100) : 0;
      score = { total, correct, percent, points: correct * 15 + (percent >= 80 ? 20 : 0), passed: percent >= 70 };
    }
  }

  if (finished && score) {
    return (
      <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
        <div className="flex flex-wrap gap-2">
          <button onClick={() => startMode("digital")} className={["rounded-2xl border px-4 py-2", mode === "digital" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Seguridad digital</button>
          <button onClick={() => startMode("social")} className={["rounded-2xl border px-4 py-2", mode === "social" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Retos sociales y hábitos</button>
        </div>
        <h2 className="text-xl font-bold">🛡️ Resultados de retos</h2>
        <div className="grid sm:grid-cols-3 gap-4">
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{score.percent}%</p><p className="text-sm text-slate-600">Resultado</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{score.correct}/{score.total}</p><p className="text-sm text-slate-600">Correctas</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">+{score.points}</p><p className="text-sm text-slate-600">Puntos</p></div>
        </div>
        <div className="rounded-2xl border bg-white p-4 space-y-2">
          <h3 className="font-semibold">Consejos clave</h3>
          {tips.map((tip, idx) => <p key={idx} className="text-sm text-slate-700">• {tip}</p>)}
        </div>
        <div className="flex flex-wrap gap-3">
          <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Nuevo reto</button>
        </div>
      </div>
    );
  }

  return (
    <div className={["rounded-3xl border p-4 md:p-6 space-y-4", bg].join(" ")}>
      <div>
        <h2 className="text-xl font-bold">🛡️ Retos y desafíos</h2>
        <p className="text-sm text-slate-600">Entrena decisiones seguras, sociales y saludables con retos paso a paso.</p>
      </div>
      <div className="flex flex-wrap gap-2">
        <button onClick={() => startMode("digital")} className={["rounded-2xl border px-4 py-2", mode === "digital" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Seguridad digital</button>
        <button onClick={() => startMode("social")} className={["rounded-2xl border px-4 py-2", mode === "social" ? "bg-slate-900 text-white" : "bg-white"].join(" ")}>Retos sociales y hábitos</button>
      </div>

      {mode === "digital" ? (
        <div className="rounded-2xl border bg-white p-5 space-y-4">
          <div className="flex items-center justify-between gap-3">
            <h3 className="font-semibold">{phase === "scenario" ? `Escenario ${index + 1} de ${totalPerSection}` : `Mini quiz ${index + 1} de ${totalPerSection}`}</h3>
            {teaMode && <span className="text-xs rounded-2xl border px-3 py-1 bg-slate-50">Paso a paso</span>}
          </div>
          {phase === "scenario" ? (
            <ChallengeScenarioBlock item={currentScenario} answer={scenarioAnswers[index]} onAnswer={chooseScenario} teaMode={teaMode} />
          ) : (
            <div className="space-y-4">
              <p className="text-lg font-medium leading-relaxed">{currentQuiz.pregunta}</p>
              <div className="grid gap-3">
                {currentQuiz.opciones.map((opt, i) => <ChallengeOption key={i} active={quizAnswers[index] === i} onClick={() => chooseQuiz(i)}>{opt}</ChallengeOption>)}
              </div>
            </div>
          )}
          <div className="flex flex-wrap gap-3">
            <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{phase === "quiz" && index === totalPerSection - 1 ? "Finalizar reto" : "Siguiente"}</button>
            <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
          </div>
        </div>
      ) : (
        <div className="space-y-4">
          <p className="text-sm text-slate-600">Reto {index + 1} de {EXTRA_SOCIAL_CHALLENGES.length}</p>
          <ChallengeScenarioBlock item={extraCurrent} answer={extraAnswers[index]} onAnswer={chooseExtra} teaMode={teaMode} />
          <div className="flex flex-wrap gap-3">
            <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{index === EXTRA_SOCIAL_CHALLENGES.length - 1 ? "Finalizar reto" : "Siguiente"}</button>
            <button onClick={resetAll} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
          </div>
        </div>
      )}
    </div>
  );
}
