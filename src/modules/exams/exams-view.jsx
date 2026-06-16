import React, { useMemo, useState } from "react";
import { buildWeeklyExam, getWeekKey, isWeeklyExamDay, scoreExam } from "../../core/exams-engine.js";
import { createCertificatePdf } from "../../core/certificates-pdf.js";

function OptionButton({ onClick, active, disabled, children }) {
  return <button onClick={onClick} disabled={disabled} className={["rounded-2xl border px-4 py-4 text-left w-full", active ? "bg-slate-900 text-white" : "bg-white hover:bg-slate-50"].join(" ")}>{children}</button>;
}

export default function ExamsView({ perfil, perfilNombre, studentName = "Alumno" }) {
  const [exam, setExam] = useState(() => buildWeeklyExam(perfil));
  const [idx, setIdx] = useState(0);
  const [answers, setAnswers] = useState([]);
  const [finished, setFinished] = useState(false);

  const current = exam.questions[idx];
  const weekKey = useMemo(() => getWeekKey(), []);
  const result = finished ? scoreExam(exam.questions, answers) : null;

  function select(optionIdx) {
    const copy = [...answers];
    copy[idx] = optionIdx;
    setAnswers(copy);
  }
  function next() {
    if (idx < exam.questions.length - 1) setIdx((i) => i + 1);
    else setFinished(true);
  }
  function restart() {
    setExam(buildWeeklyExam(perfil));
    setIdx(0);
    setAnswers([]);
    setFinished(false);
  }

  if (finished && result) {
    return (
      <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
        <h2 className="text-xl font-bold">📝 Examen semanal</h2>
        <div className="grid sm:grid-cols-3 gap-4">
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{result.percent}%</p><p className="text-sm text-slate-600">Puntuación</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{result.correct}/{result.total}</p><p className="text-sm text-slate-600">Correctas</p></div>
          <div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{result.passed ? "✅" : "📘"}</p><p className="text-sm text-slate-600">{result.passed ? "Superado" : "Sigue practicando"}</p></div>
        </div>
        <div className="rounded-2xl border bg-white p-4 space-y-2">
          <h3 className="font-semibold">Por asignatura</h3>
          {Object.entries(result.byMateria).map(([materia, stats]) => (
            <div key={materia} className="flex items-center justify-between rounded-xl border p-3">
              <span className="capitalize">{materia}</span>
              <span>{stats.correct}/{stats.total}</span>
            </div>
          ))}
        </div>
        <div className="flex flex-wrap gap-3">
          <button onClick={restart} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Nuevo examen</button>
          {result.passed && <button onClick={() => createCertificatePdf({ studentName, weekKey, percent: result.percent, perfilNombre })} className="rounded-2xl border px-4 py-3 bg-emerald-600 text-white">Certificado PDF</button>}
        </div>
      </div>
    );
  }

  return (
    <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold">📝 Examen semanal</h2>
          <p className="text-sm text-slate-600">Semana {weekKey} · {isWeeklyExamDay() ? "Hoy es viernes" : "Examen disponible"}</p>
        </div>
        <div className="text-sm rounded-2xl border bg-white px-3 py-2">Pregunta {idx + 1}/{exam.questions.length}</div>
      </div>
      <div className="rounded-2xl border bg-white p-5"><p className="text-lg font-medium leading-relaxed">{current.pregunta}</p></div>
      <div className="grid gap-3">
        {current.opciones.map((opt, i) => <OptionButton key={i} active={answers[idx] === i} onClick={() => select(i)}>{opt}</OptionButton>)}
      </div>
      <div className="flex flex-wrap gap-3">
        <button onClick={next} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">{idx < exam.questions.length - 1 ? "Siguiente" : "Finalizar examen"}</button>
        <button onClick={restart} className="rounded-2xl border px-4 py-3 bg-white">Reiniciar</button>
      </div>
    </div>
  );
}
