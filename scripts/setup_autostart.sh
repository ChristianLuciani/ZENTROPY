#!/bin/bash
# ZENTROPY — Configurar auto-start en macOS
# Crea un LaunchAgent que arranca Docker + Zentropy al iniciar sesión

set -e

ZENTROPY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PLIST_NAME="com.nexos.zentropy"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_NAME.plist"

echo "🌀 ZENTROPY — Configurando auto-start"
echo "   Directorio: $ZENTROPY_DIR"
echo ""

cat > "$PLIST_PATH" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$PLIST_NAME</string>

    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$ZENTROPY_DIR/scripts/autostart.sh</string>
    </array>

    <!-- Arrancar al iniciar sesión -->
    <key>RunAtLoad</key>
    <true/>

    <!-- Reintentar si falla -->
    <key>KeepAlive</key>
    <false/>

    <!-- Esperar 30s para que Docker Desktop arranque -->
    <key>StartInterval</key>
    <integer>0</integer>

    <key>StandardOutPath</key>
    <string>$ZENTROPY_DIR/logs/autostart.log</string>

    <key>StandardErrorPath</key>
    <string>$ZENTROPY_DIR/logs/autostart.error.log</string>
</dict>
</plist>
PLIST

echo "✅ LaunchAgent creado: $PLIST_PATH"

# Cargar inmediatamente
launchctl unload "$PLIST_PATH" 2>/dev/null || true
launchctl load "$PLIST_PATH"

echo "✅ LaunchAgent cargado"
echo ""
echo "📋 Para verificar: launchctl list | grep zentropy"
echo "📋 Para desactivar: launchctl unload $PLIST_PATH"
