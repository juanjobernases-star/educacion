const DEFAULT_NAMESPACE = "tgd_secure";
const PBKDF2_ITERATIONS = 150000;
const AES_LENGTH = 256;
const SALT_LENGTH = 16;
const IV_LENGTH = 12;

function ensureBrowserCrypto() {
  if (typeof window === "undefined" || !window.crypto?.subtle) {
    throw new Error("Web Crypto API no disponible en este entorno.");
  }
}

function textEncoder() {
  return new TextEncoder();
}

function textDecoder() {
  return new TextDecoder();
}

function toBase64(buffer) {
  const bytes = new Uint8Array(buffer);
  let binary = "";
  for (let i = 0; i < bytes.byteLength; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}

function fromBase64(base64) {
  const binary = atob(base64);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i);
  }
  return bytes.buffer;
}

function scopedKey(namespace, key) {
  return `${namespace}:${key}`;
}

async function deriveKeyFromPin(pin, salt) {
  ensureBrowserCrypto();

  if (!pin || String(pin).length < 4) {
    throw new Error("Se necesita un PIN local de al menos 4 caracteres.");
  }

  const rawKey = await crypto.subtle.importKey(
    "raw",
    textEncoder().encode(String(pin)),
    { name: "PBKDF2" },
    false,
    ["deriveKey"]
  );

  return crypto.subtle.deriveKey(
    {
      name: "PBKDF2",
      salt,
      iterations: PBKDF2_ITERATIONS,
      hash: "SHA-256"
    },
    rawKey,
    { name: "AES-GCM", length: AES_LENGTH },
    false,
    ["encrypt", "decrypt"]
  );
}

export async function encryptJson(pin, data) {
  ensureBrowserCrypto();

  const salt = crypto.getRandomValues(new Uint8Array(SALT_LENGTH));
  const iv = crypto.getRandomValues(new Uint8Array(IV_LENGTH));
  const key = await deriveKeyFromPin(pin, salt);
  const payload = textEncoder().encode(JSON.stringify(data));

  const cipher = await crypto.subtle.encrypt(
    { name: "AES-GCM", iv },
    key,
    payload
  );

  return {
    version: 1,
    salt: toBase64(salt.buffer),
    iv: toBase64(iv.buffer),
    cipher: toBase64(cipher),
    createdAt: new Date().toISOString()
  };
}

export async function decryptJson(pin, packet) {
  ensureBrowserCrypto();

  if (!packet?.salt || !packet?.iv || !packet?.cipher) {
    throw new Error("Paquete cifrado no válido.");
  }

  const salt = new Uint8Array(fromBase64(packet.salt));
  const iv = new Uint8Array(fromBase64(packet.iv));
  const cipher = fromBase64(packet.cipher);

  const key = await deriveKeyFromPin(pin, salt);

  const plain = await crypto.subtle.decrypt(
    { name: "AES-GCM", iv },
    key,
    cipher
  );

  return JSON.parse(textDecoder().decode(plain));
}

export async function saveEncryptedJSON(key, data, pin, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const packet = await encryptJson(pin, data);
  localStorage.setItem(scopedKey(namespace, key), JSON.stringify(packet));
  return true;
}

export async function loadEncryptedJSON(key, pin, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const raw = localStorage.getItem(scopedKey(namespace, key));
  if (!raw) return null;

  const packet = JSON.parse(raw);
  return decryptJson(pin, packet);
}

export function removeEncryptedJSON(key, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  localStorage.removeItem(scopedKey(namespace, key));
}

export function hasEncryptedJSON(key, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  return localStorage.getItem(scopedKey(namespace, key)) !== null;
}

export function listNamespaceKeys(options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const prefix = `${namespace}:`;

  return Object.keys(localStorage)
    .filter((k) => k.startsWith(prefix))
    .map((k) => k.slice(prefix.length))
    .sort();
}

export async function exportNamespace(pin, options = {}) {
  const namespace = options.namespace || DEFAULT_NAMESPACE;
  const keys = listNamespaceKeys({ namespace });
  const values = {};

  for (const k of keys) {
    values[k] = await loadEncryptedJSON(k, pin, { namespace });
  }

  return {
    namespace,
    exportedAt: new Date().toISOString(),
    values
  };
}

export async function importNamespace(bundle, pin, options = {}) {
  const namespace = options.namespace || bundle?.namespace || DEFAULT_NAMESPACE;
  const values = bundle?.values || {};

  for (const [k, v] of Object.entries(values)) {
    await saveEncryptedJSON(k, v, pin, { namespace });
  }

  return true;
}

/* ==========================
   Helpers específicos diario
   ========================== */

export async function saveJournalEntry(pin, entry, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  const fecha = entry?.fecha || new Date().toISOString().slice(0, 10);
  const key = `entry:${fecha}`;

  const normalized = {
    fecha,
    estado: entry?.estado || "tranquilo",
    dia: entry?.dia || "",
    gusto: entry?.gusto || "",
    costo: entry?.costo || "",
    manana: entry?.manana || "",
    ruido: entry?.ruido || "bajo",
    ayuda: entry?.ayuda || "no",
    energia: entry?.energia || "media",
    rutina: Array.isArray(entry?.rutina) ? entry.rutina : [],
    apoyos: Array.isArray(entry?.apoyos) ? entry.apoyos : [],
    updatedAt: new Date().toISOString()
  };

  await saveEncryptedJSON(key, normalized, pin, { namespace });
  return normalized;
}

export async function loadJournalEntry(pin, fecha, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  return loadEncryptedJSON(`entry:${fecha}`, pin, { namespace });
}

export function listJournalDates(options = {}) {
  const namespace = options.namespace || "tgd_journal";

  return listNamespaceKeys({ namespace })
    .filter((k) => k.startsWith("entry:"))
    .map((k) => k.replace("entry:", ""))
    .sort((a, b) => b.localeCompare(a));
}

export async function loadAllJournalEntries(pin, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  const fechas = listJournalDates({ namespace });
  const entries = [];

  for (const fecha of fechas) {
    const entry = await loadJournalEntry(pin, fecha, { namespace });
    if (entry) {
      entries.push(entry);
    }
  }

  return entries;
}

export function deleteJournalEntry(fecha, options = {}) {
  const namespace = options.namespace || "tgd_journal";
  removeEncryptedJSON(`entry:${fecha}`, { namespace });
}
