#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Pull images..."
docker compose -f docker-compose.image.yml pull

echo "[INFO] Start api + worker..."
docker compose -f docker-compose.image.yml up -d api worker

echo "[INFO] Done."
