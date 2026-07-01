#!/bin/bash
# =========================================
# deploy.sh — Déploiement simulé SkillHub API
# =========================================
# Ce script simule les étapes d'un déploiement en production.
# En contexte réel, il se connecterait via SSH à un serveur distant.

set -e

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
IMAGE_TAG="${1:-latest}"
LOG_FILE="deploy.log"

echo "=========================================" | tee "$LOG_FILE"
echo "  SkillHub API — Déploiement simulé"       | tee -a "$LOG_FILE"
echo "  Date : $TIMESTAMP"                       | tee -a "$LOG_FILE"
echo "  Image : skillhub-api:$IMAGE_TAG"         | tee -a "$LOG_FILE"
echo "=========================================" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo "[1/5] Connexion au serveur distant..."        | tee -a "$LOG_FILE"
echo "  -> ssh deploy@production-server (simulé)"   | tee -a "$LOG_FILE"

echo "[2/5] Pull de la nouvelle image Docker..."    | tee -a "$LOG_FILE"
echo "  -> docker pull ghcr.io/yair06/skillhub-api:$IMAGE_TAG (simulé)" | tee -a "$LOG_FILE"

echo "[3/5] Arrêt du conteneur actuel..."           | tee -a "$LOG_FILE"
echo "  -> docker compose down (simulé)"            | tee -a "$LOG_FILE"

echo "[4/5] Démarrage du nouveau conteneur..."      | tee -a "$LOG_FILE"
echo "  -> docker compose up -d (simulé)"           | tee -a "$LOG_FILE"

echo "[5/5] Vérification du healthcheck..."         | tee -a "$LOG_FILE"
echo "  -> curl http://localhost:3000/health (simulé)" | tee -a "$LOG_FILE"
echo "  -> Réponse : { \"status\": \"ok\", \"service\": \"skillhub-api\" }" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo "✅ Déploiement simulé terminé avec succès !" | tee -a "$LOG_FILE"
echo "📄 Log enregistré dans : $LOG_FILE"          | tee -a "$LOG_FILE"
