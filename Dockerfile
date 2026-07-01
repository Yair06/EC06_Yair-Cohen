# ============================================
# Dockerfile multistage — SkillHub API
# ============================================

# ── Étape 1 : Builder ──────────────────────
# Installe toutes les dépendances (dev incluses)
FROM node:20-alpine AS builder

WORKDIR /app

# Copier les fichiers de dépendances en premier (cache Docker)
COPY package.json package-lock.json ./

# Installer TOUTES les dépendances (dev + prod)
RUN npm ci

# Copier le code source
COPY . .

EXPOSE 3000

CMD ["node", "src/server.js"]

# ── Étape 2 : Production ───────────────────
# Image finale légère, sans les devDependencies
FROM node:20-alpine AS production

# Métadonnées
LABEL maintainer="Yair Cohen <yair.cohen@ortmontreuil.fr>"
LABEL description="SkillHub API — Mini API Express Node.js 20"

# Installer curl pour le healthcheck
RUN apk add --no-cache curl

WORKDIR /app

# Copier uniquement les fichiers de dépendances
COPY package.json package-lock.json ./

# Installer uniquement les dépendances de production
RUN npm ci --omit=dev && npm cache clean --force

# Copier le code source depuis le builder
COPY --from=builder /app/src ./src

# Créer un utilisateur non-root pour la sécurité
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Changer le propriétaire des fichiers
RUN chown -R appuser:appgroup /app

# Basculer vers l'utilisateur non-root
USER appuser

# Exposer le port de l'application
EXPOSE 3000

# Healthcheck — vérifie que l'API répond
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Démarrer l'application
CMD ["node", "src/server.js"]
