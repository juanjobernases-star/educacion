import React,{useState} from "react";
import {ROUTINE_TEMPLATES} from "../../core/routines-data.js";
export default function RoutinesView({teaMode=true,lowStim=true}){
  const[sid,setSid]=useState(ROUTINE_TEMPLATES[0]?.id);
  const[done,setDone]=useState({});
  const r=ROUTINE_TEMPLATES.find(x=>x.id===sid);
  const d=done[sid]||[];
  const prog=r?Math.round((d.length/r.steps.length)*100):0;
  const bg=lowStim?"bg-slate-50":"bg-gradient-to-br from-violet-50 via-white to-cyan-50";
  return(<div className={["rounded-3xl border p-4 md:p-6 space-y-4",bg].join(" ")}><div><h2 className="text-xl font-bold">Rutinas visuales</h2></div><div className="grid grid-cols-2 sm:grid-cols-4 gap-3">{ROUTINE_TEMPLATES.map(x=><button key={x.id} onClick={()=>setSid(x.id)} className={["rounded-2xl border p-4 text-left",sid===x.id?"bg-slate-900 text-white":"bg-white"].join(" ")}><div className="text-2xl mb-1">{x.icon}</div><div className="font-medium text-sm">{x.title}</div></button>)}</div>{r&&<div className="rounded-2xl border bg-white p-5 space-y-4"><div className="flex items-center justify-between"><h3 className="font-semibold">{r.icon} {r.title}</h3><span className="text-sm">{prog}%</span></div><div className="w-full bg-slate-200 rounded-full h-3"><div className="bg-emerald-500 h-3 rounded-full" style={{width:prog+"%"}}></div></div><div className="space-y-3">{r.steps.map((s,i)=>{const ok=d.includes(s.id);return<button key={s.id} onClick={()=>{const c=done[sid]||[];setDone({...done,[sid]:ok?c.filter(x=>x!==s.id):[...c,s.id]});}} className={["w-full rounded-2xl border p-4 text-left flex items-center gap-4",ok?"bg-emerald-50 border-emerald-300":"bg-white"].join(" ")}><span className="text-2xl">{ok?"✅":s.icon}</span><span className="font-medium">{i+1}. {s.text}</span></button>;})}</div>{prog===100&&<div className="rounded-2xl bg-emerald-50 text-emerald-900 p-4 text-center font-bold">Rutina completada!</div>}<button onClick={()=>setDone({...done,[sid]:[]})} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Reiniciar</button></div>}</div>);
}
