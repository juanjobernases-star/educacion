import React from "react";

export const UI = {
  card: "tgd-card",
  panel: "tgd-panel",
  button: "tgd-button",
  buttonPrimary: "tgd-button tgd-button-primary",
  buttonSoft: "tgd-button tgd-button-soft",
  input: "tgd-input",
  badge: "tgd-badge"
};

export function AppCard({ title, subtitle, children, actions }) {
  return (
    <section className="tgd-card">
      {(title || subtitle) && (
        <header className="tgd-card-header">
          {title && <h2>{title}</h2>}
          {subtitle && <p>{subtitle}</p>}
        </header>
      )}

      <div className="tgd-card-body">
        {children}
      </div>

      {actions && (
        <footer className="tgd-card-actions">
          {actions}
        </footer>
      )}
    </section>
  );
}

export function BigAction({ icon, title, text, onClick, active }) {
  return (
    <button onClick={onClick} className={active ? "tgd-big-action active" : "tgd-big-action"}>
      <span className="tgd-big-action-icon">{icon}</span>
      <span className="tgd-big-action-title">{title}</span>
      {text && <span className="tgd-big-action-text">{text}</span>}
    </button>
  );
}

export function ProgressBar({ value = 0 }) {
  const safe = Math.max(0, Math.min(100, Number(value) || 0));
  return (
    <div className="tgd-progress">
      <span style={{ width: safe + "%" }} />
    </div>
  );
}
