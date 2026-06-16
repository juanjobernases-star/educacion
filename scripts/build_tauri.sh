#!/bin/bash
set -e
echo "Tauri: necesitas Rust (rustup.rs)"
if ! npm list @tauri-apps/cli &>/dev/null; then npm install @tauri-apps/cli @tauri-apps/api -D; npx tauri init; fi
npx tauri build
