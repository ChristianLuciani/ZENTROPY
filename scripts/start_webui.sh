#!/bin/bash
# ZENTROPY — Arrancar Open WebUI
# Uso: bash scripts/start_webui.sh

set -e

echo "🌀 ZENTROPY — Open WebUI"
echo ""

# Verificar Docker
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está corriendo. Ábrelo primero."
    exit 1
fi

# Verificar .env
if [ ! -f .env ]; then
    echo "❌ Falta .env — copia .env.example y completa las variables"
    exit 1
fi

if ! grep -q "OPENROUTER_API_KEY=sk-" .env; then
    echo "⚠️  OPENROUTER_API_KEY no configurada en .env"
    echo "   Obtén una en: https://openrouter.ai/keys"
    exit 1
fi

echo "🚀 Arrancando Open WebUI en puerto 3010..."
docker compose -f docker/docker-compose.yml --env-file .env up -d

echo ""
echo "✅ Open WebUI corriendo"
echo "   Local  : http://localhost:3010"

# Mostrar IP de Tailscale si está disponible
TAILSCALE_IP=$(tailscale ip -4 2>/dev/null || echo "")
if [ -n "$TAILSCALE_IP" ]; then
    echo "   Móvil  : http://$TAILSCALE_IP:3010"
else
    echo "   Móvil  : Instala Tailscale y corre: tailscale up"
fi

echo ""
echo "📋 Logs: docker logs -f zentropy_webui"
