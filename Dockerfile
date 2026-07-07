# syntax=docker/dockerfile:1
# ============================================================
# casino-backend  -  imagen de producción (multi-stage, usuario no root)
# ============================================================

# ---- Stage 1: deps (instala solo dependencias de producción) ----
FROM node:20-slim AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# ---- Stage 2: runtime ----
FROM node:20-slim AS runtime
ENV NODE_ENV=production
WORKDIR /app

# node:20-slim ya trae el usuario 'node' sin privilegios
COPY --from=deps /app/node_modules ./node_modules
COPY . .

USER node
EXPOSE 3000

CMD ["node", "src/server.js"]
