# Investigación: Ecosistema Open Source para Memoria de Agentes
**Fecha:** 2026-03-09
**Herramientas:** Perplexity [Agente Cognitivo](https://www.perplexity.ai/search/estoy-disenando-un-agente-cogn-4EUiERAgTFCMNLKHAihAUg?sm=d)  +  Google DeepSearch [Agente Cognitivo Personal: Investigación Open Source](https://gemini.google.com/app/0d116735ca0cb02a)
**Objetivo:** Decidir si construir MNENTROPY desde cero o apalancarse en proyectos existentes
**ADR resultante:** ADR-I-007 (pendiente de escribir)
**Decisión tomada:** Inspiración sin dependencia directa — patrón Opción C

---

## Insight Central — La Inversión del Sujeto

Los frameworks existentes construyen memoria **para** el agente.
ZENTROPY construye memoria **del** humano.

Esta distinción cambia todo:
- En frameworks existentes: el agente decide qué guardar y qué descartar
- En ZENTROPY: el humano es la fuente de verdad, los agentes son custodios

Ningún proyecto existente resuelve exactamente este problema.

---

## Proyectos Evaluados

### Mem0 (mem0ai/mem0)
- **Licencia:** Apache 2.0 ✅
- **Madurez:** ~10k+ stars, activo 2025
- **Compatibilidad:** Python + LangGraph + Supabase/pgvector ✅
- **Lo que hace bien:** destilación de conversaciones, persistencia vectorial
- **Lo que no hace:** ingesta de git, no es centrado en humano
- **Red flag:** tier de pago emergente — incentivos comerciales divergentes
- **Decisión:** tomar el patrón de scoring (similitud + importancia + recencia), no la dependencia

### LangMem (langchain-ai/langmem)
- **Licencia:** MIT ✅
- **Madurez:** 2025, de LangChain, activo
- **Compatibilidad:** LangGraph-native, Python ✅
- **Lo que hace bien:** consolidación temporal (background manager = "hipocampo")
  distinción episodic/semantic/procedural memory
- **Lo que no hace:** ingesta de git, no es centrado en humano
- **Red flag:** de LangChain → incentivo de adoptar LangChain Platform
- **Decisión:** tomar el patrón de consolidación nocturna, no la dependencia
- **Uso complementario:** adecuado para Open WebUI (memoria de conversación de interfaz)

### Letta (letta-ai/letta, ex-MemGPT)
- **Licencia:** Apache 2.0 ✅
- **Madurez:** ~15k+ stars, activo 2025
- **Compatibilidad:** Python, Ollama — pero NO LangGraph/Supabase nativo
- **Lo que hace bien:** sleep-time compute (computa offline mientras el humano duerme)
  memory blocks editables, subagentes especializados
- **Red flag:** infra propia, migración MemGPT→Letta introdujo breaking changes
- **Decisión:** tomar el patrón de sleep-time compute y memory blocks, no la dependencia

### LightRAG (HKUDS/LightRAG)
- **Licencia:** MIT ✅
- **Lo que hace bien:** GraphRAG con actualizaciones incrementales — añade sin reconstruir
- **Compatibilidad:** requiere adaptación para Supabase puro
- **Decisión:** tomar el patrón de indexación incremental para el ingestor de git

### Cognee (topical-ai/cognee)
- **Lo que hace bien:** pipeline "Cognify" — texto no estructurado → grafo semántico
- **Red flag:** requiere Memgraph para funciones avanzadas de grafo
- **Decisión:** referencia conceptual, no dependencia

---

## Fórmula de Scoring (de Mem0 — usaremos este patrón)

```
S = w_sim · cos(θ) + w_imp · I + w_rec · e^(−λΔt)

donde:
  cos(θ) = similitud de coseno (pgvector)
  I      = importancia asignada por SENTROPY (0-1)
  Δt     = tiempo desde última actualización
  λ      = constante de decaimiento (curva Ebbinghaus)
  pesos típicos: w_sim=0.5, w_imp=0.3, w_rec=0.2
```

---

## Patrones que Implementaremos (sin dependencia directa)

| Patrón | Origen | Cómo lo usamos |
|--------|--------|----------------|
| Background consolidation | LangMem | Proceso nocturno de MNENTROPY |
| Sleep-time compute | Letta | MNENTROPY corre cuando humano no opera |
| Memory blocks editables | Letta | Estados estructurados en LangGraph |
| Scoring ponderado | Mem0 | Fórmula S para recuperación en VECTROPY |
| Indexación incremental | LightRAG | Ingestor de git commits |
| pg_cron para decaimiento | Mem0 docs | Supabase cron job para temperatura |

---

## Lo que construimos desde cero (no existe en ningún framework)

- Ingestores: conversaciones IA (Claude/Gemini export), git commits, ESTADO.md
- Schema cognitivo centrado en humano (cognitive_nodes ya diseñado)
- Temperatura en Kelvin como métrica de vitalidad de artefactos
- Clasificación TIPO × CONTEXTO en cada nodo del grafo
- Multi-tenancy desde el día 1 (user_data/[tenant_id]/)
- El puente MNENTROPY → VECTROPY vía grafo (no vía API)
- La arquitectura completa de 9 agentes del exocerebro

---

## Decisión Final

**Estrategia: Inspiración sin dependencia (Opción C)**

Razón: los frameworks existentes tienen incentivos comerciales que divergen
de la filosofía de soberanía cognitiva de ZENTROPY. Apache 2.0 y MIT
permiten uso libre, pero la dependencia en proyectos con roadmaps propios
introduce entropía futura. Los patrones son estables — las dependencias, no.

Ahorro estimado vs. construcción total desde cero: ~60% de esfuerzo
en la capa de destilación y consolidación, tomando los patrones sin el código.
