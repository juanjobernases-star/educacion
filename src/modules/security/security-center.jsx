import React, { useState } from "react";
import { AppCard, UI } from "../../ui/ui-kit.jsx";
import { secureWipe, vaultList } from "../../core/secure-vault.js";
import { buildConsentRecord, saveConsent, getConsents, revokeConsent, needsParentalConsent } from "../../core/consent-engine.js";

export default function SecurityCenter() {
  const [age, setAge] = useState(12);
  const [studentAlias, setStudentAlias] = useState("Alumno");
  const [guardianName, setGuardianName] = useState("");
  const [consents, setConsents] = useState(getConsents());

  function accept() {
    const record = buildConsentRecord({ studentAlias, age, guardianName, purpose: "Uso educativo, local-first, cifrado, sin publicidad ni telemetría" });
    saveConsent(record); setConsents(getConsents());
  }
  function wipe() {
    if (confirm("Esto borrará datos cifrados locales de la app. ¿Continuar?")) secureWipe();
  }

  return (
    <div className="tgd-grid tgd-grid-2">
      <AppCard title="Privacidad y consentimiento" subtitle="RGPD/LOPDGDD: minimización, consentimiento y protección de menores.">
        <div className="tgd-grid">
          <input className="tgd-input" value={studentAlias} onChange={e => setStudentAlias(e.target.value)} placeholder="Alias alumno" />
          <input className="tgd-input" type="number" value={age} onChange={e => setAge(e.target.value)} placeholder="Edad" />
          {needsParentalConsent(age) && <input className="tgd-input" value={guardianName} onChange={e => setGuardianName(e.target.value)} placeholder="Nombre tutor legal" />}
          <div className="tgd-alert">Menores de 14 años: consentimiento del padre/madre/tutor legal. Desde 14 años: puede consentir salvo norma específica.</div>
          <button className={UI.buttonPrimary} onClick={accept}>Registrar consentimiento</button>
        </div>
      </AppCard>
      <AppCard title="Centro de seguridad" subtitle="Auditoría local y control de datos">
        <p>Registros cifrados locales: {vaultList().length}</p>
        <button className={UI.button} onClick={() => setConsents(getConsents())}>Actualizar</button>{" "}
        <button className={UI.button} onClick={wipe}>Borrado seguro local</button>
        <div className="tgd-panel" style={{ marginTop: 12 }}>
          <strong>Consentimientos</strong>
          {consents.length === 0 && <p>Sin consentimientos registrados.</p>}
          {consents.map(c => <p key={c.id}>{c.studentAlias} - {c.legalBasis} {c.revoked ? "(revocado)" : <button className={UI.buttonSoft} onClick={() => { revokeConsent(c.id); setConsents(getConsents()); }}>Revocar</button>}</p>)}
        </div>
      </AppCard>
    </div>
  );
}
