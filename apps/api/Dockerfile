# base stage to have pnpm installed
FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

# development stage
FROM base AS development
ARG APP
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
WORKDIR /app

# Копіюємо файли конфігурації монорепозиторію
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages/domain/package.json ./packages/domain/
COPY apps/${APP}/package.json ./apps/${APP}/

# Встановлюємо залежності
RUN pnpm install --no-frozen-lockfile --ignore-scripts
COPY . .

# Збираємо domain пакет та додаток
RUN pnpm --filter "@plinks-pw/domain" build
RUN pnpm --filter "@plinks-pw/${APP}" build

# production stage
FROM base AS production
ARG APP
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /app

# Копіюємо тільки необхідні файли
COPY --from=development /app/node_modules ./node_modules
COPY --from=development /app/packages/domain/dist ./packages/domain/dist
COPY --from=development /app/apps/${APP}/dist ./apps/${APP}/dist
COPY --from=development /app/packages/domain/package.json ./packages/domain/
COPY --from=development /app/apps/${APP}/package.json ./apps/${APP}/

WORKDIR /app/apps/${APP}
EXPOSE 3000
CMD ["node", "dist/main.js"]