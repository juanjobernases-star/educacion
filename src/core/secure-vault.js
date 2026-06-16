const DEFAULT_NAMESPACE = "tgd_secure_vault_v9";
const encoder = new TextEncoder();
const decoder = new TextDecoder();

export function sanitizeText(value, maxLen = 2000) {
  return String(value ?? "")
    .replace(/[<>]/g, "")
    .replace(/javascript:/gi, "")
    .replace(/on\w+=/gi, "")
    .slice(0, maxLen)
    .trim();
}

export function minimizeStudentRecord(record = {}) {
  return {
    id: sanitizeText(record.id || crypto.randomUUID(), 80),
    alias: sanitizeText(record.alias || "Alumno", 80),
    ageRange: sanitizeText(record.ageRange || "no_especificado", 30),
    group: sanitizeText(record.group || "", 60),
    createdAt: record.createdAt || new Date().toISOString(),
    updatedAt: new Date().toISOString()
  };
}

export function redactPII(text) {
  return sanitizeText(text, 5000)
    .replace(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/gi, "[email]")
    .replace(/\b\d{3}[-.\s]?\d{3}[-.\s]?\d{3}\b/g, "[telefono]")
    .replace(/\b\d{8}[A-Z]\b/gi, "[dni]");
}

function b64(bytes) {
  return btoa(String.fromCharCode(...new Uint8Array(bytes)));
}
function fromB64(str) {
  return Uint8Array.from(atob(str), c => c.charCodeAt(0));
}
async function deriveKey(secret, salt) {
  const base = await crypto.subtle.importKey("raw", encoder.encode(secret), "PBKDF2", false, ["deriveKey"]);
  return crypto.subtle.deriveKey(
    { name: "PBKDF2", salt, iterations: 250000, hash: "SHA-256" },
    base,
    { name: "AES-GCM", length: 256 },
    false,
    ["encrypt", "decrypt"]
  );
}

export async function encryptJSON(data, secret) {
  if (!secret || String(secret).length < 6) throw new Error("Clave insuficiente");
  const salt = crypto.getRandomValues(new Uint8Array(16));
  const iv = crypto.getRandomValues(new Uint8Array(12));
  const key = await deriveKey(String(secret), salt);
  const payload = encoder.encode(JSON.stringify(data));
  const cipher = await crypto.subtle.encrypt({ name: "AES-GCM", iv }, key, payload);
  return { v: 1, alg: "AES-GCM", kdf: "PBKDF2-SHA256-250k", salt: b64(salt), iv: b64(iv), data: b64(cipher) };
}

export async function decryptJSON(blob, secret) {
  if (!blob || blob.v !== 1) throw new Error("Formato no compatible");
  const salt = fromB64(blob.salt);
  const iv = fromB64(blob.iv);
  const key = await deriveKey(String(secret), salt);
  const plain = await crypto.subtle.decrypt({ name: "AES-GCM", iv }, key, fromB64(blob.data));
  return JSON.parse(decoder.decode(plain));
}

export async function vaultSave(key, data, secret, namespace = DEFAULT_NAMESPACE) {
  const safeKey = sanitizeText(key, 120);
  const encrypted = await encryptJSON({ data, savedAt: new Date().toISOString() }, secret);
  localStorage.setItem(`${namespace}:${safeKey}`, JSON.stringify(encrypted));
  return true;
}

export async function vaultLoad(key, secret, namespace = DEFAULT_NAMESPACE) {
  const raw = localStorage.getItem(`${namespace}:${sanitizeText(key, 120)}`);
  if (!raw) return null;
  const decrypted = await decryptJSON(JSON.parse(raw), secret);
  return decrypted.data;
}

export function vaultDelete(key, namespace = DEFAULT_NAMESPACE) {
  localStorage.removeItem(`${namespace}:${sanitizeText(key, 120)}`);
}

export function vaultList(namespace = DEFAULT_NAMESPACE) {
  return Object.keys(localStorage).filter(k => k.startsWith(namespace + ":"));
}

export function secureWipe(namespace = DEFAULT_NAMESPACE) {
  vaultList(namespace).forEach(k => localStorage.removeItem(k));
}
