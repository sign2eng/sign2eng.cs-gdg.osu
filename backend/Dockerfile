# =========================================================
# Stage: base image
# =========================================================
FROM python:3.14-slim AS base

# =========================================================
# Stage: dependencies exporter
# =========================================================
FROM base AS dependencies-exporter

ARG POETRY_VERSION
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /tmp
RUN apt update && \
    apt install -y --no-install-recommends \
        pipx \
    && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    pipx ensurepath && \
    if [ -z "$POETRY_VERSION" ]; then \
        pipx install poetry; \
    else \
        pipx install poetry==$POETRY_VERSION; \
    fi && \
    pipx inject poetry poetry-plugin-export

COPY pyproject.toml poetry.lock ./
RUN poetry export -f requirements.txt --without dev --output requirements.txt --without-hashes

# =========================================================
# Stage: builder
# =========================================================
FROM base AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
RUN apt update && \
    apt install -y --no-install-recommends \
        curl \
    && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=dependencies-exporter /tmp/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# =========================================================
# Stage: runner
# =========================================================
FROM builder AS runner

COPY src/ .
EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:8000/health-check || exit 1

CMD ["fastapi", "run", "main.py", "--host", "0.0.0.0", "--port", "8000"]
