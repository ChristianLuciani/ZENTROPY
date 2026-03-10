# AGENTS.md — Protocolo Universal para Agentes IA
> Fuente de verdad agnóstica. Aplica a Claude, Gemini, Cursor, y cualquier agente futuro.
> Los archivos CLAUDE.md, GEMINI.md etc. son adaptadores que extienden este documento.
> Última actualización: 2026-03-09

---

## Sobre ZENTROPY

ZENTROPY es un sistema de cognición externalizada multi-tenant.
Diseñado para amplificar la continuidad cognitiva de sus usuarios,
no para reemplazar su pensamiento.

**Arquitectura de agentes internos:**
- **MNENTROPY** — Hipocampo digital. Ingiere, destila y relaciona eventos cognitivos. Corre 12pm + 11pm.
- **VECTROPY** — Corteza prefrontal digital. Construye el plan del día con 3 victorias concretas. Corre 7:30am + 2pm.
- Los agentes no se comunican directamente. El grafo cognitivo en Supabase (schema: `zentropia`) es el único canal.

---

## Principios de colaboración — Para cualquier agente externo

### 1. Leer antes de actuar
Antes de cualquier tarea en un repo:
1. `ESTADO.md` — dónde está el proyecto, cuál es el próximo paso
2. `CLASIFICACION.yml` — tipo, contexto, temperatura del repo
3. `docs/CONTRIBUTING.md` — convención de ramas y PR

### 2. Workflow de ramas — OBLIGATORIO
```bash
git checkout main && git pull origin main
git checkout -b [agente]/[número-issue]-[descripción-corta]
# Al terminar: PR hacia main — nunca merge directo
```
- Claude Code / claude.ai → prefijo `claude/`
- Gemini / Antigravity  → prefijo `gemini/`
- Cursor / IDE agents   → prefijo `cursor/`
- Humano               → prefijo `feature/`

### 3. Un paso concreto por vez
El usuario tiene neurotipo Dislexia + ADHD. Proponer un paso ejecutable en < 30 minutos.
No generar listas de 10 items. Preguntar antes de asumir.

### 4. Issues antes de código
Todo trabajo tiene un issue asociado en Mission Control antes de empezar.
Templates en `.github/ISSUE_TEMPLATE/` del repo activo.

---

## Taxonomía Digital Universal

Todo artefacto digital tiene dos dimensiones:
```
TIPO:     SISTEMA | PRODUCTO | INVESTIGACIÓN | HERRAMIENTA | IDENTIDAD | RECURSO | REGISTRO
CONTEXTO: OPUS | MÉTIER | AKADEMIA | INFRAESTRUCTURA | VIDA
```

Temperatura en Kelvin (calculada desde actividad git por MNENTROPY):
```
< 273 K    → HIBERNANDO  — leer ESTADO.md antes de cualquier trabajo
273–1200 K → ACTIVO      — desarrollo normal
> 1200 K   → IGNICIÓN    — máxima prioridad
```

---

## Mission Control — GitHub Project

Estados: `📥 SEÑAL → 🔥 INCUBANDO → 📋 EN COLA → ⚡ ACTIVO → 👁️ REVISIÓN → ✅ HECHO | 🧊 ICEBOX`
Regla: máximo 3 issues en ACTIVO simultáneamente.

Crear issue desde terminal:
```bash
gh issue create \
  --title "[TIPO] descripción concisa" \
  --body-file .github/ISSUE_TEMPLATE/task.md \
  --project "Mission Control"
```

---

## Datos de usuario

Los datos específicos del tenant activo están en:
- `user_data/[tenant_id]/repos.yml` — inventario de repos con clasificación
- `user_data/[tenant_id]/context.md` — contexto profesional y personal
- Supabase `zentropia.user_profiles` — perfil del tenant

**Nunca hardcodear datos de usuario en archivos de sistema.**

---

## Stack del proyecto

```
Python         → agentes CLI (MNENTROPY, VECTROPY)
TypeScript     → servicios web y Edge Functions
Docker Compose → orquestación local
Supabase       → grafo cognitivo (schema: zentropia)
pgvector       → embeddings semánticos
LiteLLM        → abstracción LLM (nunca proveedor directo)
Ollama         → modelos locales
LangGraph      → orquestación de agentes
gh CLI         → operaciones GitHub desde terminal
```

---

## ADRs vigentes — índice rápido

Ver `docs/CONDENSACION_EPISTEMICA.md` para el registro completo con contexto.
Ver `docs/adr/` para los documentos individuales con razonamiento.

| Familia | Descripción |
|---------|-------------|
| ADR-I-* | Infraestructura cognitiva (LiteLLM, Supabase, agentes) |
| ADR-E-* | Ecosistema (FINEXOS, NOOS, herramientas) |
| ADR-O-* | Organización digital (taxonomía, templates, Mission Control) |
| ADR-P-* | Pendientes de decisión |
