FROM python:3.12.12-slim

LABEL maintainer="Tal & Nir"
LABEL description="Base runtime image for Stock Alerts System"

# System packages required by the application runtime
# procps: provides pgrep for container healthchecks
RUN apt-get update \
    && apt-get install -y --no-install-recommends procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV PATH=/root/.local/bin:$PATH
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1
