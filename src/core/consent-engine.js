import { sanitizeText } from "./secure-vault.js";

const CONSENT_KEY = "tgd_phase9_consent_records";

export function needsParentalConsent(age) {
  const n = Number(age);
  return Number.isFinite(n) && n < 14;
}

export function buildConsentRecord({ studentAlias, age, guardianName, purpose }) {
  return {
    id: crypto.randomUUID(),
    studentAlias: sanitizeText(studentAlias, 80),
    age: Number(age) || null,
    guardianName: sanitizeText(guardianName, 80),
    purpose: sanitizeText(purpose || "Uso educativo local de la app TGD", 300),
    accepted: true,
    acceptedAt: new Date().toISOString(),
    legalBasis: needsParentalConsent(age) ? "consentimiento_tutor_legal" : "consentimiento_usuario_mayor_14",
    dataPolicy: {
      minimization: true,
      localFirst: true,
      encryption: true,
      noTelemetry: true,
      noAds: true
    }
  };
}

export function saveConsent(record) {
  const list = getConsents();
  list.push(record);
  localStorage.setItem(CONSENT_KEY, JSON.stringify(list));
}

export function getConsents() {
  try { return JSON.parse(localStorage.getItem(CONSENT_KEY) || "[]"); }
  catch { return []; }
}

export function revokeConsent(id) {
  const list = getConsents().map(c => c.id === id ? { ...c, revoked: true, revokedAt: new Date().toISOString() } : c);
  localStorage.setItem(CONSENT_KEY, JSON.stringify(list));
}
