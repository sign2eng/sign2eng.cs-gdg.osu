# =========================================================
# Stage: base image
# =========================================================
FROM node:25.3.0-slim AS base

ENV NEXT_TELEMETRY_DISABLED=1

WORKDIR /app

# =========================================================
# Stage: dependencies
# =========================================================
FROM base AS dependencies

COPY package.json package-lock.json* ./
RUN npm ci

# =========================================================
# Stage: builder
# =========================================================
FROM base AS builder

ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN npm run build

# =========================================================
# Stage: runner
# =========================================================
FROM builder AS runner

ENV NODE_ENV=production \
    NEXT_TELEMETRY_DISABLED=1 \
    PATH=/app/node_modules/.bin:$PATH \
    PORT=3000 \
    HOSTNAME=0.0.0.0

WORKDIR /app
RUN apt update && \
    apt install -y --no-install-recommends \
        curl \
    && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1

CMD ["npm", "run", "start"]
