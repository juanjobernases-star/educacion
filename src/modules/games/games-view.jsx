import React, { useMemo, useState } from "react";

const MEMORY_WORDS = ["célula", "volcán", "mapa", "play", "río", "robot"];
const HANGMAN_WORDS = ["ecosistema", "fracción", "gramática", "algoritmo", "mountain"];
const SORT_WORDS = ["celula", "volcan", "friend", "island", "reciclar"];

function shuffle(arr) {
  const copy = [...arr];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}

function MemoryGame() {
  const cards = useMemo(() => shuffle([...MEMORY_WORDS, ...MEMORY_WORDS]).map((word, idx) => ({ id: idx, word })), []);
  const [open, setOpen] = useState([]);
  const [solved, setSolved] = useState([]);
  function clickCard(card) {
    if (open.includes(card.id) || solved.includes(card.word) || open.length === 2) return;
    const nextOpen = [...open, card.id];
    setOpen(nextOpen);
    if (nextOpen.length === 2) {
      const selected = cards.filter((c) => nextOpen.includes(c.id));
      if (selected[0].word === selected[1].word) {
        setSolved((prev) => [...prev, selected[0].word]);
        setOpen([]);
      } else {
        setTimeout(() => setOpen([]), 700);
      }
    }
  }
  return (
    <div className="space-y-3">
      <h3 className="font-semibold">🧠 Memory LOMLOE</h3>
      <div className="grid grid-cols-3 sm:grid-cols-4 gap-3">
        {cards.map((card) => {
          const visible = open.includes(card.id) || solved.includes(card.word);
          return (
            <button key={card.id} onClick={() => clickCard(card)} className="rounded-2xl border bg-white p-4 min-h-[72px]">
              {visible ? card.word : "?"}
            </button>
          );
        })}
      </div>
      <p className="text-sm text-slate-600">Parejas encontradas: {solved.length}/{MEMORY_WORDS.length}</p>
    </div>
  );
}

function HangmanGame() {
  const [word] = useState(HANGMAN_WORDS[Math.floor(Math.random() * HANGMAN_WORDS.length)].toUpperCase());
  const [guessed, setGuessed] = useState([]);
  const [wrong, setWrong] = useState(0);
  const letters = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ".split("");
  const masked = word.split("").map((ch) => (guessed.includes(ch) ? ch : "_"));
  const won = masked.join("") === word;
  const lost = wrong >= 6;
  function guess(letter) {
    if (guessed.includes(letter) || won || lost) return;
    setGuessed((p) => [...p, letter]);
    if (!word.includes(letter)) setWrong((w) => w + 1);
  }
  return (
    <div className="space-y-3">
      <h3 className="font-semibold">🎯 Ahorcado educativo</h3>
      <p className="text-2xl tracking-[0.35em]">{masked.join(" ")}</p>
      <p className="text-sm text-slate-600">Errores: {wrong}/6</p>
      {won && <p className="text-emerald-600 font-medium">¡Lo has conseguido!</p>}
      {lost && <p className="text-rose-600 font-medium">La palabra era {word}.</p>}
      <div className="grid grid-cols-6 sm:grid-cols-9 gap-2">
        {letters.map((l) => (
          <button key={l} onClick={() => guess(l)} className="rounded-xl border bg-white px-2 py-2 text-sm" disabled={guessed.includes(l) || won || lost}>{l}</button>
        ))}
      </div>
    </div>
  );
}

function SortWordGame() {
  const [word] = useState(SORT_WORDS[Math.floor(Math.random() * SORT_WORDS.length)].toUpperCase());
  const [letters, setLetters] = useState(shuffle(word.split("")));
  const [answer, setAnswer] = useState([]);
  const done = answer.join("") === word;
  function take(letter, idx) {
    if (done) return;
    setAnswer((a) => [...a, letter]);
    setLetters((arr) => arr.filter((_, i) => i !== idx));
  }
  function reset() {
    setLetters(shuffle(word.split("")));
    setAnswer([]);
  }
  return (
    <div className="space-y-3">
      <h3 className="font-semibold">🔤 Ordena la palabra</h3>
      <p className="text-sm text-slate-600">Forma la palabra correcta:</p>
      <div className="rounded-2xl border bg-white p-4 min-h-[64px] text-xl tracking-[0.2em]">{answer.join(" ")}</div>
      {done && <p className="text-emerald-600 font-medium">¡Correcto! La palabra es {word}.</p>}
      <div className="flex flex-wrap gap-2">
        {letters.map((l, idx) => <button key={idx} onClick={() => take(l, idx)} className="rounded-xl border bg-white px-4 py-2">{l}</button>)}
      </div>
      <button onClick={reset} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Reiniciar</button>
    </div>
  );
}

export default function GamesView() {
  const [tab, setTab] = useState("memory");
  return (
    <div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4">
      <div>
        <h2 className="text-xl font-bold">🎮 Juegos interactivos</h2>
        <p className="text-sm text-slate-600">Juega y aprende sin salir de la app.</p>
      </div>
      <div className="flex flex-wrap gap-2">
        <button onClick={() => setTab("memory")} className="rounded-2xl border px-4 py-2 bg-white">Memory</button>
        <button onClick={() => setTab("hangman")} className="rounded-2xl border px-4 py-2 bg-white">Ahorcado</button>
        <button onClick={() => setTab("sort")} className="rounded-2xl border px-4 py-2 bg-white">Ordena palabra</button>
      </div>
      {tab === "memory" && <MemoryGame />}
      {tab === "hangman" && <HangmanGame />}
      {tab === "sort" && <SortWordGame />}
    </div>
  );
}
