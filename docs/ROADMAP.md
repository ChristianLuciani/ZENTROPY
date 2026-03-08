# ZENTROPY — Roadmap & Status
> Living document. Actualizar al cerrar cada sesión significativa.
> Última actualización: 2026-03-08

---

## STATUS ACTUAL

| Componente | Estado | Notas |
|---|---|---|
| Repositorio GitHub | ✅ | `ChristianLuciani/ZENTROPY` |
| Open WebUI | ✅ | Puerto 3010, Docker Compose |
| Autostart (LaunchAgent) | ✅ | PATH explícito, macOS |
| OpenRouter | ✅ | Conectado, saldo activo |
| Arquitectura cognitiva | ✅ | MNENTROPY/VECTROPY especificados |
| ADR-001,002,003 | ✅ | LiteLLM, Supabase, separación agentes |
| cognitive_node schema | ✅ | docs/schema/cognitive_node.json |
| system_prompt.md | 🔶 | Borrador, pendiente refinar |
| Supabase schema SQL | 🟡 | Definido en ADR-002, pendiente ejecutar |
| MNENTROPY | 🟡 | Especificado, pendiente implementar |
| VECTROPY | 🟡 | Bloqueado hasta MNENTROPY ≥7 días |

---

## ARQUITECTURA DE AGENTES

```
                    HUMANO
                  ↗        ↘
             actúa        consume brief (8am)
               ↓               ↑
         [mundo real]      VECTROPY (Corteza Prefrontal)
               ↓               ↑
         genera eventos    daily_digest
               ↓               ↑
           MNENTROPY (Hipocampo) ─────────────┘
               ↓
      cognitive_nodes (Supabase + pgvector)
```

**MNENTROPY** — Consolida memoria episódica → semántica. Corre 12pm + 11pm.
**VECTROPY** — Función ejecutiva. Orienta hacia futuro. Corre 7:30am + 2pm.
**Stack:** LangGraph + Ollama + LiteLLM + Supabase + APScheduler

---

## ROADMAP POR FASES

### Fase 0 — Fundación [CERRADA ✅]
- [x] Open WebUI corriendo
- [x] OpenRouter conectado
- [x] Autostart macOS
- [x] Arquitectura cognitiva especificada
- [x] Schema cognitive_node.json
- [x] ADR-001, ADR-002, ADR-003
- [x] Estructura de directorios en repo
- [ ] Ejecutar SQL de ADR-002 en Supabase ← SIGUIENTE ACCIÓN
- [ ] Refinar system_prompt.md

### Fase 1 — MNENTROPY MVP [~2 semanas]
- [ ] `agents/shared/models.py` — Pydantic CognitiveNode
- [ ] `agents/shared/supabase_client.py`
- [ ] `agents/shared/llm_client.py` con LiteLLM
- [ ] `agents/mnentropy/sources/conversations.py`
- [ ] `agents/mnentropy/sources/git_log.py`
- [ ] `agents/mnentropy/graph.py` — pipeline LangGraph completo
- [ ] Scheduling con APScheduler
- [ ] `zentropy mnentropy run --dry-run` funcional
- [ ] 7 días de datos reales en Supabase

### Fase 2 — VECTROPY MVP
- [ ] `agents/vectropy/graph.py`
- [ ] Scoring de acciones por valor estratégico
- [ ] `daily_briefs` a las 7:30am

### Fase 3 — Expansión de inputs
- [ ] Ingest de calendario, archivos, descargas
- [ ] RAG sobre grafo desde Open WebUI

### Fase 4 — Soberanía completa
- [ ] ZENTROPY orquestando CLAPPS, NOOS, KONTABLO
- [ ] Dashboard de estado del grafo cognitivo

---

## ADR REGISTER
| # | Decisión | Estado |
|---|---|---|
| ADR-001 | LiteLLM abstracción LLM | ✅ ACEPTADO |
| ADR-002 | Supabase + pgvector | ✅ ACEPTADO |
| ADR-003 | Separación MNENTROPY/VECTROPY | ✅ ACEPTADO |

---

## LOG DE SESIONES
```
2026-03-08 — Sesión fundacional: Arquitectura Cognitiva
  Definido: MNENTROPY (hipocampo), VECTROPY (corteza prefrontal)
  Definido: cognitive_node schema con 13 parámetros
  Definido: Stack LangGraph + Ollama + LiteLLM + Supabase
  ADRs: 001, 002, 003
  Ejecutado: tree de directorios creado en repo
  Victoria: Fase 0 cerrada
```
