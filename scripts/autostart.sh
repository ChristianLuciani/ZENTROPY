#!/bin/bash
# ZENTROPY — Autostart resiliente
# LaunchAgent no hereda PATH completo — definirlo explícitamente

ZENTROPY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$ZENTROPY_DIR/logs/autostart.log"
mkdir -p "$ZENTROPY_DIR/logs"

# PATH explícito para LaunchAgent (no hereda el PATH del usuario)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin"
# Docker Desktop en Mac M2
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG"; }

log "🌀 ZENTROPY autostart iniciado"
log "   PATH: $PATH"

# Abrir Docker Desktop si no está corriendo
if ! docker info > /dev/null 2>&1; then
    log "🐳 Abriendo Docker Desktop..."
    open -a Docker
    log "⏳ Esperando 30s a que Docker arranque..."
    sleep 30
fi

# Reintentar hasta 60s
ATTEMPTS=0
until docker info > /dev/null 2>&1; do
    ATTEMPTS=$((ATTEMPTS + 1))
    if [ $ATTEMPTS -gt 20 ]; then
        log "❌ Docker no respondió tras 60s"
        exit 1
    fi
    sleep 3
done

log "✅ Docker listo"

# Arrancar Zentropy
cd "$ZENTROPY_DIR"
log "🚀 Arrancando Open WebUI..."
/usr/local/bin/docker compose -f docker/docker-compose.yml --env-file .env up -d >> "$LOG" 2>&1 \
  || /opt/homebrew/bin/docker compose -f docker/docker-compose.yml --env-file .env up -d >> "$LOG" 2>&1

if docker ps | grep -q zentropy_webui; then
    log "✅ Open WebUI corriendo en :3010"
else
    log "❌ Contenedor no arrancó — revisa logs manualmente"
fi

log "── Autostart completado ──"
