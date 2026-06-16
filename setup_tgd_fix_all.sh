#!/bin/bash
set -e
echo "FIX ALL: modulos + fases 10 + 11"
mkdir -p src/core src/modules/{journal,learning,emotion,exams,games,social,challenges,tea,habits,emotional-tutor,teacher,security,routines,family,reports,stage-selector,consent}

cat << 'EOF' > src/core/routines-data.js
export const ROUTINE_TEMPLATES=[{id:"manana_cole",title:"Antes del cole",icon:"🌅",steps:[{id:"s1",text:"Me despierto",icon:"⏰"},{id:"s2",text:"Voy al baño",icon:"🚿"},{id:"s3",text:"Me visto",icon:"👕"},{id:"s4",text:"Desayuno",icon:"🥣"},{id:"s5",text:"Me lavo los dientes",icon:"🪥"},{id:"s6",text:"Preparo mochila",icon:"🎒"},{id:"s7",text:"Salgo de casa",icon:"🚶"}]},{id:"llegada_cole",title:"Al llegar al cole",icon:"🏫",steps:[{id:"s1",text:"Saludo",icon:"👋"},{id:"s2",text:"Dejo mochila",icon:"🎒"},{id:"s3",text:"Me siento",icon:"🪑"},{id:"s4",text:"Saco material",icon:"📚"},{id:"s5",text:"Miro agenda",icon:"📋"}]},{id:"tarea",title:"Hacer tarea",icon:"📝",steps:[{id:"s1",text:"Leo instruccion",icon:"👀"},{id:"s2",text:"Pienso",icon:"🧠"},{id:"s3",text:"Primer paso",icon:"✏️"},{id:"s4",text:"Reviso",icon:"🔍"},{id:"s5",text:"Pido ayuda si necesito",icon:"🙋"},{id:"s6",text:"Guardo",icon:"✅"}]},{id:"recreo",title:"Recreo",icon:"⚽",steps:[{id:"s1",text:"Salgo con calma",icon:"🚶"},{id:"s2",text:"Busco companero",icon:"👫"},{id:"s3",text:"Elijo actividad",icon:"🎮"},{id:"s4",text:"Si algo molesta busco profe",icon:"🧑‍🏫"},{id:"s5",text:"Timbre vuelvo",icon:"🔔"}]},{id:"vuelta",title:"Volver a casa",icon:"🏠",steps:[{id:"s1",text:"Llego saludo",icon:"👋"},{id:"s2",text:"Me cambio",icon:"👕"},{id:"s3",text:"Meriendo",icon:"🍎"},{id:"s4",text:"Descanso",icon:"🛋️"},{id:"s5",text:"Deberes",icon:"📖"},{id:"s6",text:"Tiempo libre",icon:"🎨"}]},{id:"dormir",title:"Antes dormir",icon:"🌙",steps:[{id:"s1",text:"Ceno",icon:"🍽️"},{id:"s2",text:"Dientes",icon:"🪥"},{id:"s3",text:"Pijama",icon:"🩳"},{id:"s4",text:"Preparo ropa",icon:"👕"},{id:"s5",text:"Leo",icon:"📖"},{id:"s6",text:"Luz apagada",icon:"💤"}]},{id:"examen",title:"Dia examen",icon:"📝",steps:[{id:"s1",text:"Respiro",icon:"🫁"},{id:"s2",text:"Leo todo",icon:"👀"},{id:"s3",text:"Empiezo por la que se",icon:"✅"},{id:"s4",text:"Si bloqueo paso a otra",icon:"➡️"},{id:"s5",text:"Reviso",icon:"🔍"},{id:"s6",text:"Entrego",icon:"😌"}]},{id:"nervios",title:"Si nervioso",icon:"😟",steps:[{id:"s1",text:"Paro",icon:"✋"},{id:"s2",text:"Respiro 4-4",icon:"🫁"},{id:"s3",text:"Manos aprieto suelto",icon:"✊"},{id:"s4",text:"Pienso",icon:"🧠"},{id:"s5",text:"Pido ayuda",icon:"🙋"},{id:"s6",text:"Paso pequeno",icon:"👣"}]}];
export function getRoutineById(id){return ROUTINE_TEMPLATES.find(r=>r.id===id)||null;}
EOF
echo "OK routines-data.js"

cat << 'EOF' > src/modules/routines/routines-view.jsx
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
EOF
echo "OK routines-view.jsx"

cat << 'EOF' > src/core/family-data.js
export const FAMILY_SECTIONS=[{id:"tea",title:"Que es el TEA",icon:"🧩",content:["El TEA es una condicion del neurodesarrollo.","No es una enfermedad.","Cada persona es unica.","Los apoyos mejoran la calidad de vida."]},{id:"visual",title:"Apoyos visuales",icon:"🖼️",content:["Comprenden mejor lo visual.","Reducen ansiedad.","Ejemplos: agendas, pictogramas."]},{id:"rutinas",title:"Rutinas",icon:"📋",content:["Dan estructura.","Cambios inesperados generan ansiedad.","Anticipar con apoyos visuales."]},{id:"comunicacion",title:"Comunicacion",icon:"💬",content:["Frases cortas claras.","Evitar dobles sentidos.","Dar tiempo.","Apoyar con imagenes."]},{id:"emociones",title:"Emociones",icon:"💛",content:["Ensenar a nombrar emociones.","Estrategias de calma.","Validar sentimientos."]},{id:"sensorial",title:"Sensorial",icon:"👂",content:["Hiper o hiposensibles.","Adaptar entorno."]},{id:"escuela",title:"Escuela",icon:"🏫",content:["Coordinacion familia-escuela.","Adaptar examenes.","Sensibilizar companeros."]},{id:"recursos",title:"Recursos",icon:"📚",content:["Autismo Espana: autismo.org.es","Autismo Madrid: autismomadrid.es","Asperger: asperger.es","Tel Esperanza: 717003717"]}];
EOF
echo "OK family-data.js"

cat << 'EOF' > src/modules/family/family-view.jsx
import React,{useState} from "react";
import {FAMILY_SECTIONS} from "../../core/family-data.js";
export default function FamilyView({teaMode=true,lowStim=true}){
  const[sid,setSid]=useState(FAMILY_SECTIONS[0]?.id);
  const s=FAMILY_SECTIONS.find(x=>x.id===sid);
  const bg=lowStim?"bg-slate-50":"bg-gradient-to-br from-violet-50 via-white to-cyan-50";
  return(<div className={["rounded-3xl border p-4 md:p-6 space-y-4",bg].join(" ")}><div><h2 className="text-xl font-bold">Guia familias</h2></div><div className="grid grid-cols-2 sm:grid-cols-4 gap-3">{FAMILY_SECTIONS.map(x=><button key={x.id} onClick={()=>setSid(x.id)} className={["rounded-2xl border p-4 text-left",sid===x.id?"bg-slate-900 text-white":"bg-white"].join(" ")}><div className="text-2xl mb-1">{x.icon}</div><div className="font-medium text-sm">{x.title}</div></button>)}</div>{s&&<div className="rounded-2xl border bg-white p-5 space-y-3"><h3 className="font-semibold text-lg">{s.icon} {s.title}</h3>{s.content.map((t,i)=><div key={i} className="rounded-xl border bg-slate-50 p-4"><p>{t}</p></div>)}</div>}<div className="rounded-2xl border bg-white p-4 text-sm text-slate-500">No sustituye valoracion profesional.</div></div>);
}
EOF
echo "OK family-view.jsx"

cat << 'EOF' > src/modules/reports/reports-view.jsx
import React,{useState} from "react";
export default function ReportsView({engineStats,studentName="Alumno",perfilNombre="General"}){
  const[msg,setMsg]=useState("");
  const li=engineStats?.levelInfo;
  const st=engineStats?.statsByMateria||{};
  async function pdf(){try{const{jsPDF}=await import("jspdf");const d=new jsPDF();d.setFont("helvetica","bold");d.setFontSize(18);d.text("Informe progreso",105,20,{align:"center"});d.setFont("helvetica","normal");d.setFontSize(12);d.text("Alumno: "+studentName,20,50);d.text("Nivel: "+(li?.name||"Explorador"),20,58);d.text("Puntos: "+(li?.totalPoints||0),20,66);d.text("Precision: "+(engineStats?.accuracy||0)+"%",20,74);let y=90;Object.entries(st).forEach(([m,s])=>{d.text(m+": "+s.correct+"/"+s.total,25,y);y+=8;});d.save("informe_"+new Date().toISOString().slice(0,10)+".pdf");setMsg("PDF generado.");}catch(e){setMsg("npm install jspdf");}}
  return(<div className="rounded-3xl border p-4 md:p-6 bg-slate-50 space-y-4"><h2 className="text-xl font-bold">Informes</h2><div className="grid sm:grid-cols-4 gap-4"><div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{li?.totalPoints||0}</p><p className="text-sm text-slate-600">Puntos</p></div><div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{li?.icon||"🔍"}</p><p className="text-sm text-slate-600">{li?.name||"Explorador"}</p></div><div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{engineStats?.accuracy||0}%</p><p className="text-sm text-slate-600">Precision</p></div><div className="rounded-2xl border bg-white p-4 text-center"><p className="text-3xl font-bold">{engineStats?.totalAnswered||0}</p><p className="text-sm text-slate-600">Respondidas</p></div></div><button onClick={pdf} className="rounded-2xl border px-4 py-3 bg-slate-900 text-white">Descargar PDF</button>{msg&&<div className="rounded-2xl border bg-sky-50 text-sky-900 p-4 text-sm">{msg}</div>}</div>);
}
EOF
echo "OK reports-view.jsx"

cat << 'EOF' > src/core/stages-data.js
export const STAGES=[{id:"infantil",name:"Infantil",ageMin:3,ageMax:5,icon:"🧒",description:"Rutinas, emociones, juego.",courses:[{id:"inf_3",label:"3 anios"},{id:"inf_4",label:"4 anios"},{id:"inf_5",label:"5 anios"}]},{id:"primaria",name:"Primaria",ageMin:6,ageMax:12,icon:"📚",description:"LOMLOE completo.",courses:[{id:"pri_1",label:"1 Primaria"},{id:"pri_2",label:"2 Primaria"},{id:"pri_3",label:"3 Primaria"},{id:"pri_4",label:"4 Primaria"},{id:"pri_5",label:"5 Primaria"},{id:"pri_6",label:"6 Primaria"}]},{id:"eso",name:"ESO",ageMin:12,ageMax:16,icon:"🎓",description:"Academico y critico.",courses:[{id:"eso_1",label:"1 ESO"},{id:"eso_2",label:"2 ESO"},{id:"eso_3",label:"3 ESO"},{id:"eso_4",label:"4 ESO"}]},{id:"bachillerato",name:"Bachillerato",ageMin:16,ageMax:18,icon:"🏆",description:"Preparacion universitaria.",courses:[{id:"bach_1",label:"1 Bach"},{id:"bach_2",label:"2 Bach"}]}];
export const STAGE_TABS={infantil:[{key:"inicio",label:"Inicio"},{key:"rutinas",label:"Rutinas"},{key:"emociones",label:"Emociones"},{key:"juegos",label:"Juegos"},{key:"tea",label:"Apoyos TEA"},{key:"diario",label:"Diario"},{key:"familia",label:"Familia"},{key:"ajustes",label:"Ajustes"}],primaria:[{key:"inicio",label:"Inicio"},{key:"aprender",label:"Aprender"},{key:"tutor",label:"Tutor emocional"},{key:"profesor",label:"Profesor"},{key:"redes",label:"Redes"},{key:"retos",label:"Retos"},{key:"historias",label:"Historias"},{key:"habitos",label:"Habitos"},{key:"examenes",label:"Examenes"},{key:"juegos",label:"Juegos"},{key:"tea",label:"Apoyos TEA"},{key:"rutinas",label:"Rutinas"},{key:"emociones",label:"Emociones"},{key:"diario",label:"Diario"},{key:"familia",label:"Familia"},{key:"informes",label:"Informes"},{key:"seguridad",label:"Seguridad"},{key:"ajustes",label:"Ajustes"}],eso:[{key:"inicio",label:"Inicio"},{key:"aprender",label:"Aprender"},{key:"redes",label:"Redes"},{key:"retos",label:"Retos"},{key:"habitos",label:"Habitos"},{key:"examenes",label:"Examenes"},{key:"tea",label:"Apoyos TEA"},{key:"emociones",label:"Emociones"},{key:"diario",label:"Diario"},{key:"informes",label:"Informes"},{key:"familia",label:"Familia"},{key:"seguridad",label:"Seguridad"},{key:"ajustes",label:"Ajustes"}],bachillerato:[{key:"inicio",label:"Inicio"},{key:"aprender",label:"Aprender"},{key:"redes",label:"Redes"},{key:"retos",label:"Retos"},{key:"habitos",label:"Habitos"},{key:"examenes",label:"Examenes"},{key:"informes",label:"Informes"},{key:"ajustes",label:"Ajustes"}]};
const SK="tgd_stage_selection";
export function getStageByAge(age){const n=Number(age);return STAGES.find(s=>n>=s.ageMin&&n<=s.ageMax)||null;}
export function getCourseByAge(stage,age){if(!stage)return null;const idx=Math.min(Math.max(0,Number(age)-stage.ageMin),stage.courses.length-1);return stage.courses[idx];}
export function getStageById(id){return STAGES.find(s=>s.id===id)||null;}
export function getAvailableTabs(sid){return STAGE_TABS[sid]||STAGE_TABS.primaria;}
export function saveStageSelection(d){localStorage.setItem(SK,JSON.stringify({...d,savedAt:new Date().toISOString()}));}
export function loadStageSelection(){try{return JSON.parse(localStorage.getItem(SK));}catch{return null;}}
export function clearStageSelection(){localStorage.removeItem(SK);}
EOF
echo "OK stages-data.js"

cat << 'EOF' > src/modules/stage-selector/stage-selector-view.jsx
import React,{useMemo,useState} from "react";
import {STAGES,getStageByAge,getCourseByAge,saveStageSelection} from "../../core/stages-data.js";
const AGES=[3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
export default function StageSelectorView({onSelect}){
  const[step,setStep]=useState("age");
  const[age,setAge]=useState(null);
  const[cid,setCid]=useState(null);
  const stage=useMemo(()=>age!==null?getStageByAge(age):null,[age]);
  const suggested=useMemo(()=>stage?getCourseByAge(stage,age):null,[stage,age]);
  if(step==="age")return(<div className="min-h-screen bg-slate-50 flex items-center justify-center p-6"><div className="max-w-3xl w-full space-y-6"><div className="text-center space-y-3"><h1 className="text-3xl font-bold">TGD App educativa segura</h1><p className="text-lg text-slate-600">Cuantos anios tiene el alumno?</p></div><div className="grid grid-cols-4 sm:grid-cols-8 gap-3">{AGES.map(a=><button key={a} onClick={()=>{setAge(a);setCid(null);setStep("confirm");}} className="rounded-2xl border-2 bg-white p-4 text-center hover:border-slate-900 hover:shadow-lg transition"><span className="text-2xl font-bold block">{a}</span><span className="text-xs text-slate-500">anios</span></button>)}</div><p className="text-center text-sm text-slate-500">La edad no se envia a servidores.</p></div></div>);
  return(<div className="min-h-screen bg-slate-50 flex items-center justify-center p-6"><div className="max-w-2xl w-full space-y-6"><div className="text-center space-y-3"><p className="text-5xl">{stage?.icon}</p><h1 className="text-2xl font-bold">{age} anios → {stage?.name}</h1><p className="text-slate-600">{stage?.description}</p></div><div className="rounded-2xl border bg-white p-5 space-y-4"><h3 className="font-semibold">Curso</h3><div className="grid grid-cols-1 sm:grid-cols-2 gap-3">{stage?.courses.map(c=><button key={c.id} onClick={()=>setCid(c.id)} className={["rounded-2xl border-2 p-4 text-left",(cid||suggested?.id)===c.id?"bg-slate-900 text-white border-slate-900":"bg-white"].join(" ")}><span className="font-bold">{c.label}</span></button>)}</div></div><div className="flex flex-wrap gap-3 justify-center"><button onClick={()=>{setStep("age");setAge(null);}} className="rounded-2xl border px-5 py-3 bg-white">Cambiar edad</button><button onClick={()=>{if(!stage)return;const sel={age,stageId:stage.id,courseId:cid||suggested?.id};saveStageSelection(sel);onSelect(sel);}} className="rounded-2xl border px-5 py-3 bg-slate-900 text-white">Comenzar</button></div></div></div>);
}
EOF
echo "OK stage-selector-view.jsx"

# Fix HTML escaped + .jsxx
find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec grep -l "&lt;\|&gt;\|&amp;" {} \; 2>/dev/null | while read file; do
  sed -i 's/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g' "$file"
done
find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec sed -i 's/\.jsxx/.jsx/g' {} \;
echo "OK fixes applied"
echo "DONE setup_tgd_fix_all.sh"
