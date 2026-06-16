import React,{useState} from "react";
import {FAMILY_SECTIONS} from "../../core/family-data.js";
export default function FamilyView({teaMode=true,lowStim=true}){
  const[sid,setSid]=useState(FAMILY_SECTIONS[0]?.id);
  const s=FAMILY_SECTIONS.find(x=>x.id===sid);
  const bg=lowStim?"bg-slate-50":"bg-gradient-to-br from-violet-50 via-white to-cyan-50";
  return(<div className={["rounded-3xl border p-4 md:p-6 space-y-4",bg].join(" ")}><div><h2 className="text-xl font-bold">Guia familias</h2></div><div className="grid grid-cols-2 sm:grid-cols-4 gap-3">{FAMILY_SECTIONS.map(x=><button key={x.id} onClick={()=>setSid(x.id)} className={["rounded-2xl border p-4 text-left",sid===x.id?"bg-slate-900 text-white":"bg-white"].join(" ")}><div className="text-2xl mb-1">{x.icon}</div><div className="font-medium text-sm">{x.title}</div></button>)}</div>{s&&<div className="rounded-2xl border bg-white p-5 space-y-3"><h3 className="font-semibold text-lg">{s.icon} {s.title}</h3>{s.content.map((t,i)=><div key={i} className="rounded-xl border bg-slate-50 p-4"><p>{t}</p></div>)}</div>}<div className="rounded-2xl border bg-white p-4 text-sm text-slate-500">No sustituye valoracion profesional.</div></div>);
}
