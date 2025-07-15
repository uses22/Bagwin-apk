# 1. Nettoyage
git rm Flutter Html Markdown Mermaid dart

# 2. Réorganisation
mkdir -p lib/services
git mv mobile-money-service.dart lib/services/bagwin_money_service.dart

# 3. Validation
git add .
git commit -m "STRUCTURE PRO: Migration vers l'architecture officielle BagWin"
