import { jsPDF } from "jspdf";

export function createCertificatePdf({ studentName, weekKey, percent, perfilNombre }) {
  const doc = new jsPDF({ orientation: "landscape", unit: "mm", format: "a4" });
  doc.setDrawColor(40, 40, 40);
  doc.rect(10, 10, 277, 190);
  doc.setFont("helvetica", "bold");
  doc.setFontSize(24);
  doc.text("Certificado de superación", 148, 35, { align: "center" });
  doc.setFontSize(14);
  doc.setFont("helvetica", "normal");
  doc.text("App educativa segura TGD", 148, 48, { align: "center" });
  doc.setFontSize(18);
  doc.text(`Se certifica que ${studentName || "el alumno"}`, 148, 80, { align: "center" });
  doc.text(`ha superado el examen semanal ${weekKey}`, 148, 95, { align: "center" });
  doc.text(`con una puntuación de ${percent}%`, 148, 110, { align: "center" });
  doc.setFontSize(12);
  doc.text(`Perfil curricular: ${perfilNombre || "General"}`, 148, 130, { align: "center" });
  doc.text(`Fecha: ${new Date().toLocaleDateString("es-ES")}`, 148, 145, { align: "center" });
  doc.save(`certificado_${weekKey}.pdf`);
}
