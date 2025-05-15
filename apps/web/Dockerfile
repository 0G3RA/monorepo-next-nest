# Build stage
FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

# Development stage
FROM base AS development
WORKDIR /app

# Copy root package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages/domain/package.json ./packages/domain/
COPY apps/web/package.json ./apps/web/

# Install dependencies
RUN pnpm install --no-frozen-lockfile --ignore-scripts
COPY . .

# Build domain package
RUN pnpm --filter "@plinks-pw/domain" build

# Build web app
RUN pnpm --filter "@plinks-pw/web" build

# Production stage
FROM base AS production
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages/domain/package.json ./packages/domain/
COPY apps/web/package.json ./apps/web/

# Install production dependencies
RUN pnpm install --prod --no-frozen-lockfile --ignore-scripts

# Copy built files
COPY --from=development /app/packages/domain/dist ./packages/domain/dist
COPY --from=development /app/apps/web/.next ./apps/web/.next
COPY --from=development /app/apps/web/public ./apps/web/public
COPY --from=development /app/apps/web/next.config.ts ./apps/web/

WORKDIR /app/apps/web
EXPOSE 3000

CMD ["pnpm", "start"] 