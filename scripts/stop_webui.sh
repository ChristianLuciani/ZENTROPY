#!/bin/bash
echo "🛑 Deteniendo Open WebUI..."
docker compose -f docker/docker-compose.yml down
echo "✅ Detenido"
