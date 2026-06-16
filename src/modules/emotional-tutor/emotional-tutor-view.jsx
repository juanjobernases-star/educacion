import React, { useState } from "react";
import { getTutorResponse } from "../../core/emotional-tutor-engine.js";
import { AppCard, UI } from "../../ui/ui-kit.jsx";

export default function EmotionalTutorView({ teaMode = true }) {
  const [text, setText] = useState("");
  const [history, setHistory] = useState([]);
  const [result, setResult] = useState(null);

  function send() {
    const r = getTutorResponse({ text, history, teaMode });
    setResult(r);
    if (r.emotion && r.emotion !== "riesgo") setHistory(prev => [...prev.slice(-6), r.emotion]);
    setText("");
  }

  return (
    <AppCard title="Tutor emocional" subtitle="Acompañamiento reglado, local y predecible. No sustituye apoyo profesional.">
      <div className="tgd-grid">
        <textarea className="tgd-textarea" value={text} onChange={e => setText(e.target.value)} placeholder="Escribe cómo te sientes o qué ha pasado..." />
        <button className={UI.buttonPrimary} onClick={send}>Responder</button>
        {result && (
          <div className={result.level === "urgent" ? "tgd-danger" : "tgd-safe"}>
            <p><strong>Estado detectado:</strong> {result.emotion}</p>
            <p>{result.response}</p>
            {result.steps?.length > 0 && (
              <ol>
                {result.steps.map((s, i) => <li key={i}>{s}</li>)}
              </ol>
            )}
            {result.disclaimer && <p><small>{result.disclaimer}</small></p>}
          </div>
        )}
      </div>
    </AppCard>
  );
}
