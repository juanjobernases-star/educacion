import React, { useMemo, useState } from "react";
import { AppCard, BigAction, ProgressBar, UI } from "../../ui/ui-kit.jsx";
import { minimizeStudentRecord, sanitizeText } from "../../core/secure-vault.js";

const STORE = "tgd_teacher_students_v9";

function loadStudents() {
  try { return JSON.parse(localStorage.getItem(STORE) || "[]"); } catch { return []; }
}
function saveStudents(students) { localStorage.setItem(STORE, JSON.stringify(students)); }

export default function TeacherDashboard() {
  const [students, setStudents] = useState(loadStudents());
  const [alias, setAlias] = useState("");
  const [group, setGroup] = useState("");
  const [selectedId, setSelectedId] = useState(students[0]?.id || null);

  const selected = useMemo(() => students.find(s => s.id === selectedId) || null, [students, selectedId]);

  function addStudent() {
    const student = minimizeStudentRecord({ alias, group });
    const next = [...students, { ...student, progress: 0, emotionalState: "sin_datos", notes: [] }];
    setStudents(next); saveStudents(next); setSelectedId(student.id); setAlias(""); setGroup("");
  }
  function addNote() {
    if (!selected) return;
    const note = prompt("Nota breve del profesor (sin datos sensibles):");
    if (!note) return;
    const next = students.map(s => s.id === selected.id ? { ...s, notes: [...(s.notes || []), { text: sanitizeText(note, 300), at: new Date().toISOString() }] } : s);
    setStudents(next); saveStudents(next);
  }

  return (
    <div className="tgd-grid tgd-grid-2">
      <AppCard title="Panel profesor" subtitle="Gestión local multi-alumno. Evita nombres completos: usa alias o iniciales.">
        <div className="tgd-grid">
          <input className="tgd-input" value={alias} onChange={e => setAlias(e.target.value)} placeholder="Alias del alumno" />
          <input className="tgd-input" value={group} onChange={e => setGroup(e.target.value)} placeholder="Grupo / clase" />
          <button className={UI.buttonPrimary} onClick={addStudent}>Añadir alumno</button>
        </div>
        <div className="tgd-grid" style={{ marginTop: 16 }}>
          {students.map(s => (
            <BigAction key={s.id} icon="A" title={s.alias} text={s.group || "Sin grupo"} active={s.id === selectedId} onClick={() => setSelectedId(s.id)} />
          ))}
        </div>
      </AppCard>

      <AppCard title="Informe rápido" subtitle={selected ? selected.alias : "Selecciona un alumno"} actions={selected && <button className={UI.buttonSoft} onClick={addNote}>Añadir nota</button>}>
        {!selected && <p>No hay alumno seleccionado.</p>}
        {selected && (
          <div className="tgd-grid">
            <p><span className="tgd-badge">Estado emocional: {selected.emotionalState}</span></p>
            <div><strong>Progreso</strong><ProgressBar value={selected.progress || 0} /></div>
            <div className="tgd-panel">
              <strong>Notas</strong>
              {(selected.notes || []).length === 0 && <p className="tgd-subtitle">Sin notas.</p>}
              {(selected.notes || []).map((n, i) => <p key={i}>- {n.text}</p>)}
            </div>
          </div>
        )}
      </AppCard>
    </div>
  );
}
