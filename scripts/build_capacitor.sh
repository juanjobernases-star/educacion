#!/bin/bash
set -e
if ! npm list @capacitor/core &>/dev/null; then npm install @capacitor/core @capacitor/cli; npx cap init "TGD" "es.tgd.app" --web-dir=dist; fi
npm run build
if ! [ -d android ]; then npm install @capacitor/android; npx cap add android; fi
if ! [ -d ios ]; then npm install @capacitor/ios; npx cap add ios; fi
npx cap sync
echo "Android: npx cap open android"
echo "iOS: npx cap open ios"
