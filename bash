
#!/bin/bash
set -euo pipefail

# ======================
# CONFIGURATION MONETAIRE
# ======================
echo "💰 Configuration Mobile Money..."

# Sécurité: Ne jamais hardcoder les infos de paiement
if [[ -z "${MM_API_KEY:-}" ]]; then
  echo "❌ ERREUR: API Key Mobile Money manquante"
  exit 1
fi

# =================
# BUILD FLUTTER WEB
# =================
echo "🛠  Installation Flutter..."
export FLUTTER_CHANNEL="stable"
export FLUTTER_VERSION="3.22.1"

git clone https://github.com/flutter/flutter.git --depth 1 -b $FLUTTER_CHANNEL
export PATH="$PATH:$(pwd)/flutter/bin"

flutter precache
flutter pub get

echo "🚀 Compilation PWA..."
flutter build web \
  --release \
  --web-renderer canvaskit \
  --dart-define=MM_API_KEY=$MM_API_KEY

# ==============
# DÉPLOIEMENT FINAL
# ==============
echo "📦 Préparation des assets..."
rm -rf public
mkdir -p public
cp -r build/web/* public/

# Sécurité: Suppression des traces sensibles
find public -name "*.map" -type f -delete

echo "✅ Build réussi! PWA prête pour Mobile Money"
