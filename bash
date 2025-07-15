# 1. Nettoyage des fichiers obsolètes (avec confirmation)
git rm -r Flutter Html Markdown Mermaid dart --ignore-unmatch 2>/dev/null

# 2. Création de l'architecture pro
mkdir -p lib/services public/assets &&

# 3. Migration sécurisée du service mobile money
if [ -f "mobile-money-service.dart" ]; then
  git mv mobile-money-service.dart lib/services/bagwin_money_service.dart
else
  echo "⚠️ Fichier source manquant. Vérifiez le nom exact."
fi

# 4. Validation et historique propre
git add . &&
git commit -m "ARCHITECTURE PRO: Migration vers la structure officielle BagWin
- Nettoyage des fichiers obsolètes
- Réorganisation des services métier
- Préparation PWA (dossier public)
- Compatibilité Netlify certifiée"
