# 🌀 ZENTROPY — Zero Entropy Intelligence Station

> "Capturar el rayo en la botella."

Zentropy es el corazón cognitivo de NEXOS. Su primera función es
resolver el problema más urgente: **las ideas que nacen en conversaciones
con IA se pierden**. Zentropy las captura, las indexa y las hace
recuperables como cognición externa persistente.

## Módulos

| Módulo | Estado | Descripción |
|--------|--------|-------------|
| `capture` | 🟡 En construcción | Ingestar conversaciones IA → Supabase |
| `search` | ⬜ Pendiente | Búsqueda semántica sobre conversaciones |
| `bridge` | ⬜ Pendiente | Sync con Logseq / IDEs agénticos |

## Stack
- **DB**: Supabase (Postgres + pgvector)
- **Captura**: Python scripts
- **Schema base**: content_atoms, entities, missions (ya existentes)

## Quick Start
```bash
cp .env.example .env
# Edita .env con tus credenciales
pip install -r requirements.txt
python scripts/test_db_conn.py
```

## Protocolo de Trabajo
1. Toda sesión de trabajo produce al menos UN commit.
2. Cada insight importante de una conversación IA → `capture_chat.py`
3. No avanzar a la siguiente etapa si la actual no tiene ✅
