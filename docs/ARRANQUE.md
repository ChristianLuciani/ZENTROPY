# 🌀 ZENTROPY SIS — Guía de Arranque
**Protocolo: Validación por Capas (MVC)**
> No avanzamos al siguiente paso si el anterior no tiene ✅

---

## PRE-REQUISITOS (5 min)

Abre Terminal y verifica que tienes todo:

```bash
docker --version        # debe mostrar Docker version 24+
python3 --version       # debe mostrar Python 3.9+
pip3 install psycopg2-binary python-dotenv
```

---

## PASO 1 — Configurar Secretos (2 min)

```bash
# Clona o crea la carpeta ZENTROPY
cd ~/PROJECTOS/GitHub/ChristianLuciani
mkdir -p ZENTROPY/scripts && cd ZENTROPY

# Copia el template de variables
cp .env.example .env

# Edita con tu editor favorito
nano .env   # o: open -e .env
```

En `.env` completa:
- `SUPABASE_DB_PASSWORD` → tu password de Supabase (Settings > Database)
- `OPENROUTER_API_KEY` → tu key de openrouter.ai/keys
- `WEBUI_SECRET_KEY` → ejecuta `openssl rand -hex 32` y pega el resultado

---

## PASO 2 — Handshake con Supabase ✋ (3 min)

```bash
python3 scripts/test_db_conn.py
```

**Resultado esperado:**
```
✅ Conexión establecida
✅ PostgreSQL version: PostgreSQL 15.x
✅ pgvector instalado — versión 0.5.x
✅ Todas las tablas de NEXOS base están presentes
🎯 RESULTADO: Supabase listo para ZENTROPY
```

⛔ **Si falla aquí: NO continuar al Paso 3**
- Password incorrecto → revisar Supabase Dashboard > Settings > Database
- pgvector ausente → Supabase Dashboard > Database > Extensions > activar "vector"

---

## PASO 3 — Arrancar Zentropy (2 min)

```bash
# Abre Docker Desktop primero (desde Applications)
# Espera hasta que el ícono de Docker deje de girar

# Luego:
docker compose up -d

# Verifica que está corriendo:
docker compose logs -f zentropy
```

Cuando veas `Application startup complete` → Zentropy está vivo.

---

## PASO 4 — Primer Acceso

Abre en tu navegador: **http://localhost:3010**

1. Crea tu cuenta admin (primer usuario = admin automáticamente)
2. Ve a **Settings > Connections** y verifica que OpenRouter aparece
3. Prueba una conversación con cualquier modelo

---

## PASO 5 — Configurar los 5 Proveedores en OpenRouter

En OpenRouter ya tienes acceso a todos. Solo necesitas activar los modelos en Zentropy:

| Proveedor | Modelo en OpenRouter |
|-----------|---------------------|
| Gemini    | `google/gemini-2.0-flash-exp` |
| Claude    | `anthropic/claude-sonnet-4-5` |
| Z.ai      | `x-ai/grok-3` |
| DeepSeek  | `deepseek/deepseek-r1` |
| GPT-4o    | `openai/gpt-4o` |

En Zentropy: **Settings > Models** — busca y activa cada uno.

---

## ESTADO DEL SISTEMA

Actualiza esta tabla después de cada sesión:

| Componente | Estado | Fecha |
|------------|--------|-------|
| Supabase handshake | ⏳ Pendiente | — |
| Docker arriba | ⏳ Pendiente | — |
| OpenRouter conectado | ⏳ Pendiente | — |
| 5 modelos activos | ⏳ Pendiente | — |
| Acceso desde iPhone (Tailscale) | 🔮 Fase 2 | — |

---

## SI ALGO FALLA

```bash
# Ver logs completos
docker compose logs zentropy

# Reiniciar limpio
docker compose down && docker compose up -d

# Verificar que el puerto no está ocupado
lsof -i :3010
```

---

*Última actualización: inicio del proyecto*
*Próxima sesión: Fase 2 — Tailscale para acceso móvil*
