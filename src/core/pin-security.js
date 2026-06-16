const SECURITY_KEY = "tgd_security_config";

function enc() {
  return new TextEncoder();
}

function toBase64(buffer) {
  const bytes = new Uint8Array(buffer);
  let binary = "";
  for (let i = 0; i < bytes.byteLength; i++) binary += String.fromCharCode(bytes[i]);
  return btoa(binary);
}

async function sha256(text) {
  const data = enc().encode(text);
  const digest = await crypto.subtle.digest("SHA-256", data);
  return toBase64(digest);
}

function randomString(length = 8) {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  const bytes = crypto.getRandomValues(new Uint8Array(length));
  return Array.from(bytes).map((b) => alphabet[b % alphabet.length]).join("");
}

export function generateTeacherPuk() {
  return randomString(8);
}

export function hasPinConfig() {
  return localStorage.getItem(SECURITY_KEY) !== null;
}

export function getPinConfigMeta() {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) return null;
  const cfg = JSON.parse(raw);
  return {
    childLabel: cfg.childLabel || "Alumno",
    createdAt: cfg.createdAt || null,
    hasTeacherPuk: !!cfg.teacherPukHash
  };
}

export async function setupPinSecurity({ childPin, teacherPuk, childLabel = "Alumno" }) {
  if (!childPin || String(childPin).length < 4) {
    throw new Error("El PIN del alumno debe tener al menos 4 caracteres.");
  }
  if (!teacherPuk || String(teacherPuk).length < 6) {
    throw new Error("El PUK del maestro debe tener al menos 6 caracteres.");
  }
  const salt = randomString(12);
  const childPinHash = await sha256(`${salt}:${childPin}`);
  const teacherPukHash = await sha256(`${salt}:${teacherPuk}`);
  const config = {
    version: 1,
    salt,
    childLabel,
    childPinHash,
    teacherPukHash,
    createdAt: new Date().toISOString()
  };
  localStorage.setItem(SECURITY_KEY, JSON.stringify(config));
  return true;
}

export async function verifyChildPin(pin) {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) return false;
  const cfg = JSON.parse(raw);
  const hash = await sha256(`${cfg.salt}:${pin}`);
  return hash === cfg.childPinHash;
}

export async function verifyTeacherPuk(puk) {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) return false;
  const cfg = JSON.parse(raw);
  const hash = await sha256(`${cfg.salt}:${puk}`);
  return hash === cfg.teacherPukHash;
}

export async function resetChildPinWithPuk(teacherPuk, newChildPin) {
  const raw = localStorage.getItem(SECURITY_KEY);
  if (!raw) throw new Error("No hay seguridad configurada todavía.");
  if (!newChildPin || String(newChildPin).length < 4) {
    throw new Error("El nuevo PIN debe tener al menos 4 caracteres.");
  }
  const cfg = JSON.parse(raw);
  const teacherHash = await sha256(`${cfg.salt}:${teacherPuk}`);
  if (teacherHash !== cfg.teacherPukHash) {
    throw new Error("PUK del maestro incorrecto.");
  }
  cfg.childPinHash = await sha256(`${cfg.salt}:${newChildPin}`);
  cfg.updatedAt = new Date().toISOString();
  localStorage.setItem(SECURITY_KEY, JSON.stringify(cfg));
  return true;
}

export function clearPinSecurity() {
  localStorage.removeItem(SECURITY_KEY);
}
