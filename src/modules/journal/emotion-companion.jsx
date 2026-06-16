import React, { useEffect, useState } from "react";
import { getResponseForMood } from "../../core/emotional-support.js";

export default function EmotionCompanion({ mood, engineStats, teaMode, lowStim }) {
  const [response, setResponse] = useState(null);
  const [breathingStep, setBreathingStep] = useState(-1);
  const [breathingActive, setBreathingActive] = useState(false);
  const [timer, setTimer] = useState(0);

  useEffect(() => {
    if (mood) {
      setResponse(getResponseForMood(mood, engineStats));
      setBreathingStep(-1);
      setBreathingActive(false);
    }
  }, [mood, engineStats]);

  useEffect(() => {
    if (!breathingActive || !response?.breathingExercise) return;
    const steps = response.breathingExercise.steps;
    if (breathingStep >= steps.length) {
      setBreathingActive(false);
      return;
    }
    const current = steps[breathingStep];
    if (!current || current.duration === 0) return;

    setTimer(current.duration);
    const interval = setInterval(() => {
      setTimer((prev) => {
        if (prev <= 1) {
          clearInterval(interval);
          setBreathingStep((s) => s + 1);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [breathingStep, breathingActive, response]);

  function startBreathing() {
    setBreathingStep(0);
    setBreathingActive(true);
  }

  if (!response || !mood) return null;

  const bg = lowStim ? "bg-slate-50" : "bg-gradient-to-br from-blue-50 to-violet-50";
  const exercise = response.breathingExercise;
  const currentStep = exercise && breathingStep >= 0 && breathingStep < exercise.steps.length
    ? exercise.steps[breathingStep]
    : null;
  const breathingDone = exercise && breathingStep >= exercise.steps.length;

  return (
    <div className={["rounded-2xl border p-4 md:p-5 space-y-4", bg].join(" ")}>
      <div className="rounded-2xl bg-white border p-4">
        <p className="text-base leading-relaxed">{response.validation}</p>
      </div>

      {response.selfEsteem && (
        <div className="rounded-2xl bg-white border p-4">
          <p className="text-sm font-medium text-slate-800 mb-1">💪 Recuerda</p>
          <p className="text-sm text-slate-700">{response.selfEsteem}</p>
        </div>
      )}

      {response.subjectStrength && (
        <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-4">
          <p className="text-sm text-emerald-800">🌟 {response.subjectStrength}</p>
        </div>
      )}

      {response.tips && response.tips.length > 0 && (
        <div className="rounded-2xl bg-white border p-4 space-y-2">
          <p className="text-sm font-medium text-slate-800">💡 Tips que pueden ayudarte</p>
          {response.tips.map((tip, i) => (
            <p key={i} className="text-sm text-slate-600 pl-4 border-l-2 border-slate-200">{tip}</p>
          ))}
        </div>
      )}

      {exercise && !breathingActive && !breathingDone && (
        <div className="rounded-2xl bg-white border p-4 space-y-3">
          <p className="text-sm font-medium text-slate-800">
            {exercise.icon} {exercise.name}
          </p>
          <p className="text-sm text-slate-600">{exercise.description}</p>
          <button
            onClick={startBreathing}
            className="rounded-2xl border px-4 py-3 bg-slate-900 text-white text-sm w-full"
          >
            Empezar ejercicio de respiración
          </button>
        </div>
      )}

      {breathingActive && currentStep && (
        <div className="rounded-2xl bg-white border p-6 text-center space-y-4">
          <p className="text-5xl">{currentStep.icon}</p>
          <p className="text-lg font-medium leading-relaxed">{currentStep.text}</p>
          {currentStep.duration > 0 && (
            <div className="space-y-2">
              <div className="w-full bg-slate-200 rounded-full h-3 max-w-xs mx-auto">
                <div
                  className="bg-slate-900 h-3 rounded-full transition-all duration-1000"
                  style={{ width: Math.round((timer / currentStep.duration) * 100) + "%" }}
                ></div>
              </div>
              <p className="text-sm text-slate-500">{timer}s</p>
            </div>
          )}
        </div>
      )}

      {breathingActive && breathingStep >= 0 && exercise && breathingStep < exercise.steps.length && exercise.steps[breathingStep]?.duration === 0 && (
        <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-6 text-center space-y-3">
          <p className="text-5xl">{exercise.steps[breathingStep].icon}</p>
          <p className="text-lg font-medium text-emerald-900">{exercise.steps[breathingStep].text}</p>
          <button
            onClick={() => setBreathingActive(false)}
            className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white text-sm"
          >
            Listo
          </button>
        </div>
      )}

      {breathingDone && (
        <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-4 text-center">
          <p className="text-emerald-800 font-medium">🌟 ¡Ejercicio completado! Lo has hecho muy bien.</p>
        </div>
      )}

      {response.achievements && response.achievements.totalAnswered > 0 && (
        <div className="rounded-2xl bg-white border p-4 space-y-2">
          <p className="text-sm font-medium text-slate-800">🏆 Tus logros</p>
          <div className="grid grid-cols-3 gap-2 text-center text-sm">
            <div className="rounded-xl bg-slate-50 p-2">
              <p className="font-bold">{response.achievements.totalAnswered}</p>
              <p className="text-xs text-slate-500">Respondidas</p>
            </div>
            <div className="rounded-xl bg-slate-50 p-2">
              <p className="font-bold text-emerald-600">{response.achievements.totalCorrect}</p>
              <p className="text-xs text-slate-500">Correctas</p>
            </div>
            <div className="rounded-xl bg-slate-50 p-2">
              <p className="font-bold">{response.achievements.totalPoints} pts</p>
              <p className="text-xs text-slate-500">Puntos</p>
            </div>
          </div>
          {response.achievements.levelInfo && (
            <p className="text-sm text-center text-slate-600">
              {response.achievements.levelInfo.icon} Nivel: {response.achievements.levelInfo.name}
            </p>
          )}
        </div>
      )}
    </div>
  );
}
