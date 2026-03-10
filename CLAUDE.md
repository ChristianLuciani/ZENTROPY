# CLAUDE.md — Protocolo de Colaboración para Agentes IA
> Este archivo es leído automáticamente por Claude Code, Cursor y otros agentes.
> Última actualización: 2026-03-08

---

## Quién es Christian

Tecnólogo independiente, físico, filósofo sistémico y educador.
Trabajo siempre híbrido: humano + agentes IA.
Neurotipo: Dislexia + ADHD.

**Implicaciones para el agente:**
- Proponer un paso concreto por vez, no listas de 10 items
- Preguntar antes de asumir — mejor una pregunta que diez suposiciones
- El siguiente paso siempre debe ser ejecutable en < 30 minutos
- No generar código sin haber leído ESTADO.md del repo primero

---

## Workflow de ramas — OBLIGATORIO

```bash
# Antes de cualquier trabajo:
git checkout main && git pull origin main
git checkout -b claude/[número-issue]-[descripción-corta]

# Al terminar:
git add -A
git commit -m "tipo(scope): descripción
Co-authored-by: Claude <claude@anthropic.com>"
git push origin claude/[número-issue]-[descripción-corta]
# → Abrir PR hacia main para que Christian revise
```

**Nunca hacer push directo a main.**
**Nunca mergear sin aprobación de Christian.**

---

## Taxonomía Digital Universal

Todo artefacto tiene dos dimensiones:

```
TIPO     → SISTEMA | PRODUCTO | INVESTIGACIÓN | HERRAMIENTA | IDENTIDAD | RECURSO | REGISTRO
CONTEXTO → OPUS | MÉTIER | AKADEMIA | INFRAESTRUCTURA | VIDA
```

Temperatura del repo en Kelvin (calculada desde actividad git):
- < 273 K → HIBERNANDO — leer ESTADO.md antes de cualquier trabajo
- 273–1200 K → ACTIVO — desarrollo normal
- > 1200 K → IGNICIÓN/PLASMA — máxima prioridad

---

## Mission Control — GitHub Project

Único project para toda la vida digital productiva de Christian.
URL: https://github.com/users/ChristianLuciani/projects/5

**Estados en orden:**
```
📥 SEÑAL → 🔥 INCUBANDO → 📋 LISTO → ⚡ ACTIVO → 👁️ REVISIÓN → ✅ HECHO
                                                              ↘ 🧊 ICEBOX
```

**Regla:** Máximo 3 issues en ACTIVO simultáneamente.

**Crear un issue desde terminal:**
```bash
gh issue create \
  --title "[TIPO] descripción" \
  --body "Ver template en .github/ISSUE_TEMPLATE/task.md" \
  --label "agente:claude" \
  --project "NEXOS Project Management"
```

**Templates disponibles en `.github/ISSUE_TEMPLATE/`:**
- `task.md` — tarea de desarrollo
- `research.md` — investigación, hallazgo, pregunta
- `adr.md` — decisión arquitectónica
- `incident.md` — algo roto en producción

---

## Repos principales activos

| Repo | Tipo | Contexto | Temperatura |
|---|---|---|---|
| ZENTROPY | SISTEMA | INFRAESTRUCTURA | 🔥 IGNICIÓN |
| estelectica | INVESTIGACIÓN | OPUS | 🔥 IGNICIÓN |
| NEXOS | SISTEMA | MÉTIER | ACTIVO |
| accounting-esperanto | INVESTIGACIÓN | MÉTIER | ACTIVO |
| CLAPPS | PRODUCTO | MÉTIER | TEMPLADO |

---

## Stack preferido

```
Python, TypeScript, Docker, Supabase+pgvector
LangGraph, Ollama, LiteLLM
GitHub + gh CLI para operaciones de repositorio
```

---

## Archivos a leer siempre antes de empezar

1. `ESTADO.md` — dónde está el proyecto y cuál es el próximo paso
2. `docs/CONTRIBUTING.md` — convención de ramas y PR
3. `docs/COGNITIVE_ARCHITECTURE.md` — si el trabajo involucra agentes MNENTROPY/VECTROPY

---

## ADRs vigentes

| ADR | Decisión |
|---|---|
| ADR-001 | LiteLLM como abstracción LLM |
| ADR-002 | Supabase + pgvector para grafo cognitivo |
| ADR-003 | Separación MNENTROPY / VECTROPY |
| ADR-004 | Taxonomía universal TIPO × CONTEXTO |
| ADR-005 | Templates jerárquicos de repos |
| ADR-006 | Mission Control como único GitHub Project |
