# ZENTROPY — Cognitive Architecture
> Especificación de los agentes MNENTROPY y VECTROPY
> Versión: 0.1 | Fecha: 2026-03-08 | Estado: Draft

---

## Filosofía de diseño

ZENTROPY no es una herramienta. Es un **sistema de cognición externo** — una extensión del
pensamiento que opera de forma autónoma cuando el operador humano no está mirando.

La distinción fundamental:
- Un **protocolo** requiere energía humana para mantenerse vivo.
- Un **agente** requiere energía computacional. Esa es infinitamente más barata.

---

## MNENTROPY — El Hipocampo Digital

```
 Función biológica análoga: HIPOCAMPO + CORTEZA ENTORRINAL + RED POR DEFECTO

 HIPOCAMPO
 Consolida memorias episódicas (eventos del día) en memoria semántica (conocimiento duradero).
 Trabaja durante el descanso, no en tiempo real.

 CORTEZA ENTORRINAL
 Gateway de entrada al hipocampo. Filtra, comprime y etiqueta inputs antes de almacenarlos.

 RED POR DEFECTO (Default Mode Network)
 Activa durante reposo. Integra experiencias, identifica patrones, conecta conceptos distantes.
```

### Misión
MNENTROPY **registra y destila la actividad cognitiva del día**.
No actúa, no decide, no planifica. Su única función es convertir eventos cognitivos
dispersos en nodos persistentes en el grafo de conocimiento.

### Inputs (por fase)
| Fuente | Fase |
|---|---|
| Conversaciones IA exportadas (Claude, WebUI) | Fase 1 |
| Git commits + diffs | Fase 1 |
| Archivos creados/modificados en /CORTEX/ | Fase 1 |
| Calendario (eventos completados) | Fase 2 |
| Descargas + documentos abiertos | Fase 2 |
| Browser history | Fase 3 |

### Pipeline
```
RAW EVENTS → PARSE → CHUNK → EMBED → CLASSIFY → RELATE → MERGE/NEW → PERSIST → DIGEST
```

### Horario
- 12:00 PM — procesa la mañana
- 11:00 PM — consolida el día completo
- Bajo demanda: `zentropy mnentropy run --now`

---

## VECTROPY — La Corteza Prefrontal Digital

```
 Función biológica análoga: CORTEZA PREFRONTAL + CÍNGULO ANTERIOR + SISTEMA DOPAMINÉRGICO

 CORTEZA PREFRONTAL (PFC)
 Función ejecutiva: planificación, toma de decisiones, jerarquización de objetivos.
 Ve el futuro, no el presente.

 CÍNGULO ANTERIOR (ACC)
 Detecta conflictos entre metas competidoras. Resuelve "¿qué merece energía ahora?".

 SISTEMA DOPAMINÉRGICO
 Sistema de ANTICIPACIÓN, no del placer. Motiva hacia recompensas futuras.
 Sin él, todo parece igualmente urgente y nada se mueve.
```

### Misión
VECTROPY **construye el plan del día seleccionando las acciones de mayor valor**.
Ve el pasado solo como condición inicial. Su orientación es siempre hacia el futuro.
Es el agente que te espera cuando despiertas.

### Horario
- 7:30 AM — brief listo para las 8:00 AM
- 2:00 PM — re-evaluación si el día cambió
- Bajo demanda: `zentropy vectropy brief --now`

### Output (daily brief)
```json
{
  "date": "2026-03-09",
  "top_3": [
    {
      "rank": 1,
      "project": "ZENTROPY",
      "action": "Implementar schema cognitive_nodes en Supabase",
      "why": "Bloquea todo el pipeline de MNENTROPY",
      "estimated_minutes": 45
    }
  ]
}
```

---

## Relación entre agentes

```
                    HUMANO
                  ↗        ↘
             actúa        consume brief (8am)
               ↓               ↑
         [mundo real]      VECTROPY
               ↓           (Corteza Prefrontal)
         genera eventos         ↑
               ↓         daily_digest
           MNENTROPY ────────────┘
        (Hipocampo)
               ↓
      cognitive_nodes
   (Supabase + pgvector)
```

**No hay comunicación directa entre agentes.** El grafo es el medio.
Esto permite reemplazar cualquiera de los dos sin afectar al otro.

---

## Framework: LangGraph + Ollama

### Stack
| Capa | Tecnología | Razón |
|---|---|---|
| Agentes | LangGraph 0.2+ | Grafos de estado, Python nativo |
| LLM local | Ollama + llama3.2 | Offline-first |
| Embeddings | nomic-embed-text | Ligero, buena calidad semántica |
| Persistencia | Supabase + pgvector | Ya acordado, comparte stack con CLAPPS |
| Scheduling | APScheduler | Simple, cron-compatible, embebible |
| Orquestación | Docker Compose | Infraestructura ya existente |
| CLI | Typer | `zentropy mnentropy run` |
| Abstracción LLM | LiteLLM | Anti-vendor-lock (ver ADR-001) |

---

## Próximos pasos

1. Crear schema SQL en Supabase (ver ADR-002)
2. Implementar `agents/shared/models.py` con Pydantic
3. Implementar `agents/mnentropy/sources/conversations.py`
4. Implementar `agents/mnentropy/graph.py`
5. Primer run: `zentropy mnentropy run --dry-run`
6. VECTROPY solo cuando MNENTROPY tenga ≥7 días de datos reales
