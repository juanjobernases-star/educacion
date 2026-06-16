import React, { useState } from "react";
import { COMMUNITY_PROFILES, SAMPLE_QUESTIONS } from "../../core/questions-ccaa";

export default function LearningView() {
  const [community, setCommunity] = useState("madrid");
  const [index, setIndex] = useState(0);
  const [answer, setAnswer] = useState("");
  const [result, setResult] = useState("");

  const questions = SAMPLE_QUESTIONS[community] || [];
  const current = questions[index];

  function checkAnswer() {
    if (!current) return;

    if (answer.toLowerCase().includes(current.respuesta.toLowerCase())) {
      setResult("✅ Correcto");
    } else {
      setResult("❌ Incorrecto");
    }
  }

  function nextQuestion() {
    setIndex((prev) => (prev + 1) % questions.length);
    setAnswer("");
    setResult("");
  }

  return (
    <div className="rounded-2xl border bg-white p-6 space-y-4">
      <h2 className="text-xl font-bold">Aprendizaje adaptado</h2>

      <select
        value={community}
        onChange={(e) => {
          setCommunity(e.target.value);
          setIndex(0);
        }}
        className="border rounded-xl px-3 py-2"
      >
        {Object.keys(COMMUNITY_PROFILES).map((c) => (
          <option key={c} value={c}>
            {COMMUNITY_PROFILES[c].nombre}
          </option>
        ))}
      </select>

      {current && (
        <div className="space-y-3">
          <p className="font-medium">{current.texto}</p>

          <input
            value={answer}
            onChange={(e) => setAnswer(e.target.value)}
            className="border rounded-xl px-3 py-2 w-full"
            placeholder="Tu respuesta"
          />

          <div className="flex gap-2">
            <button
              onClick={checkAnswer}
              className="bg-blue-600 text-white px-4 py-2 rounded-xl"
            >
              Comprobar
            </button>

            <button
              onClick={nextQuestion}
              className="bg-slate-200 px-4 py-2 rounded-xl"
            >
              Siguiente
            </button>
          </div>

          {result && <p>{result}</p>}
        </div>
      )}
    </div>
  );
}
