#!/bin/bash
# ZENTROPY — Test de automatización completo
# Crea una conversación de prueba y la ingesta

ZENTROPY_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "🧪 ZENTROPY — Test de automatización"
echo ""

# Crear conversación de prueba
cat > /tmp/zentropy_test.json << JSON
{
  "uuid": "test-$(date +%s)",
  "name": "TEST — Automatización Zentropy $(date '+%Y-%m-%d %H:%M')",
  "model": "claude-sonnet-4-6",
  "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "updated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "chat_messages": [
    {
      "uuid": "msg-001",
      "sender": "human",
      "text": "Test de automatización de ingesta en Zentropy.",
      "content": [],
      "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    },
    {
      "uuid": "msg-002",
      "sender": "assistant",
      "text": "Test recibido. El sistema de ingesta automática funciona correctamente. Este mensaje confirma que el pipeline Claude JSON → Supabase zentropia.messages está operacional.",
      "content": [],
      "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    }
  ]
}
JSON

echo "📄 Conversación de prueba creada"
echo ""

# Ingestar (modo no-interactivo con defaults)
cd "$ZENTROPY_DIR"
echo -e "zentropy,test\nzentropy\ny" | python scripts/ingest.py /tmp/zentropy_test.json

echo ""
echo "✅ Test completado — verifica en Supabase Dashboard:"
echo "   zentropia.sessions → busca 'TEST — Automatización'"
