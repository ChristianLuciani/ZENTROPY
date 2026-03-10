# Condensación Epistémica — Sesión Fundacional ZENTROPY
> Documento vivo. Generado: 2026-03-09
> Propósito: destilación ontológica, epistemológica y de decisiones de la sesión fundacional.
> Este documento es la memoria semántica de por qué ZENTROPY existe y cómo piensa.

---

## I. La Pregunta Central

> **¿Cómo puede una identidad cognitiva plural — física, filosófica, pedagógica, constructora, emprendedora — crear una infraestructura digital coherente sin reducir ni perder esa pluralidad?**

La respuesta no es consolidar las identidades en una sola, sino diseñar un **sistema de integración** que preserve la pluralidad y le dé continuidad. ZENTROPY es ese sistema.

---

## II. El Diagnóstico — Fragmentación vs. Pluralidad

El diagnóstico fue preciso: lo que aparecía como "fragmentación" no era pérdida sino **pluralidad no estructurada**. La diferencia es fundamental:

- **Fragmentación**: piezas que no pueden reconectarse — hay pérdida real
- **Pluralidad no estructurada**: riqueza sin sistema de integración — no hay pérdida, hay potencial invisible

Patrón observable en los 56 repositorios auditados:
- Proyectos nacen por inspiración, no por disciplina
- Sin sistema de re-entrada, el costo cognitivo de retomar escala exponencialmente
- Sin clasificación, la energía se disipa en decisiones meta
- Sin temperatura visible, no hay señal de qué está vivo y qué está muerto

---

## III. La Ontología — Taxonomía Universal

### Dimensión 1: TIPO

| TIPO | Relación con el mundo | Criterio de éxito |
|------|----------------------|-------------------|
| SISTEMA | Habilita — otros dependen de él | Evoluciona, no termina |
| PRODUCTO | Sirve — tiene usuarios | DoD por fase |
| INVESTIGACIÓN | Interroga — publica hallazgos | Pregunta central en una oración |
| HERRAMIENTA | Asiste — problema específico acotado | Funciona sin leer el código |
| IDENTIDAD | Representa — proyecta quién eres | Refleja quién eres hoy |
| RECURSO | Referencia — insumo externo | Organizado y encontrable |
| REGISTRO | Captura — momento, evento | Tiene fecha y contexto |

### Dimensión 2: CONTEXTO

| CONTEXTO | Descripción |
|----------|-------------|
| OPUS | Obra mayor, legado intelectual |
| MÉTIER | Trabajo profesional, ingresos |
| AKADEMIA | Formación y conocimiento |
| INFRAESTRUCTURA | Ecosistema que te permite trabajar |
| VIDA | Personal no profesional |

**Clasificación completa**: `ARTEFACTO = TIPO × CONTEXTO`

Aplica universalmente: repos, carpetas, imágenes, emails, redes sociales, bookmarks.

**Nota sobre VIDA**: Las tareas operativas (pagar luz, dentista) pertenecen al calendario, no a GitHub. La intersección ocurre cuando un evento de vida *genera* un proyecto digital.

---

## IV. La Epistemología — Cómo conocemos la salud de un artefacto

### Temperatura en Kelvin

| Rango (K) | Estado | Señal automática |
|-----------|--------|-----------------|
| 0 – 77 | ⚫ FÓSIL | Sin actividad > 1 año |
| 77 – 273 | 🧊 HIBERNANDO | Sin commit semántico 3–12 meses |
| 273 – 373 | 🌊 TEMPLADO | Commit esporádico < 2 meses |
| 373 – 1.200 | 🔥 ACTIVO | Commit semántico < 2 semanas |
| 1.200 – 5.778 | ☀️ IGNICIÓN | Commit < 3 días, issues activos |
| > 5.778 | ⚡ PLASMA | Múltiples agentes activos |

**Umbral crítico: 273 K** — debajo de ahí, ESTADO.md antes de cualquier trabajo.
MNENTROPY calcula la temperatura automáticamente. El usuario solo la lee.

### Madurez Estructural

| Nivel | Nombre | Requisito |
|-------|--------|-----------|
| 0 | EXISTENCIA | README.md: qué es y para qué |
| 1 | HIGIENE | .gitignore, .env.example, sin binarios |
| **2** | **ORIENTACIÓN** ⚠️ | **ESTADO.md con próximo paso concreto** |
| 3 | INTENCIÓN | CLASIFICACION.yml, specs, ADRs |
| 4 | PRODUCCIÓN | Tests, CI/CD, deployment docs |

El nivel 2 es el más crítico para el neurotipo de Christian (Dislexia + ADHD).

---

## V. Principios de Diseño — Lo que no cambia

### P1: Multi-tenancy por defecto
ZENTROPY es personal hoy, diseñado para ser multi-usuario mañana. Todo dato de usuario vive en `user_data/[tenant_id]/` o en `zentropia.user_profiles`. Ningún archivo de sistema hardcodea información personal.

### P2: Agnosticismo de agente
El sistema no asume ningún agente IA específico. El ecosistema actual incluye: Claude (claude.ai, Claude Code), Gemini (Antigravity, Google AI Studio), Cursor, y otros futuros. Los protocolos funcionan para todos.
- `AGENTS.md` → fuente de verdad agnóstica
- `CLAUDE.md` → adaptador para Claude Code
- `GEMINI.md` → adaptador para Antigravity (pendiente)

### P3: El grafo como único medio entre agentes
MNENTROPY y VECTROPY no se comunican directamente. El grafo cognitivo en Supabase es el canal. Sin acoplamiento directo entre agentes.

### P4: Superficie mínima
Una herramienta por función. Un project manager. Un schema por módulo.

### P5: El template nace maduro
Un repo desde template responde todas las preguntas de madurez nivel 2 desde el primer commit, mediante prompts activadores.

---

## VI. ADR Registry Unificado

> Los ADRs se organizan en tres familias con prefijo propio.
> Documentos completos en `docs/adr/`

### Familia I: Infraestructura Cognitiva

| ID | Decisión | Estado |
|----|----------|--------|
| ADR-I-001 | LiteLLM como abstracción LLM — nunca proveedor directo | ✅ |
| ADR-I-002 | Supabase + pgvector — schema `zentropia` | ✅ |
| ADR-I-003 | Separación MNENTROPY / VECTROPY — grafo como medio | ✅ |
| ADR-I-004 | Python para agentes CLI; TypeScript para servicios web | ✅ |
| ADR-I-005 | Un módulo = un schema. `public` solo para tablas compartidas | ✅ |

### Familia E: Ecosistema

| ID | Decisión | Estado |
|----|----------|--------|
| ADR-E-001 | Supabase SSOT: Opción B ahora → Opción C al escalar | ✅ |
| ADR-E-002 | Abandonar ERPNext. FINEXOS sobre Postgres + Kontablo | ✅ |
| ADR-E-003 | NOOS y FINEXOS son capas distintas. Kontablo alimenta ambas | ✅ |
| ADR-E-004 | Mission Control como único task manager | ✅ |

### Familia O: Organización Digital

| ID | Decisión | Estado |
|----|----------|--------|
| ADR-O-001 | Taxonomía universal TIPO × CONTEXTO | ✅ |
| ADR-O-002 | Temperatura en Kelvin como métrica de vitalidad | ✅ |
| ADR-O-003 | Templates jerárquicos: BASE → INVESTIGACIÓN → HERRAMIENTA → PRODUCTO → SISTEMA | ✅ |
| ADR-O-004 | CLASIFICACION.yml como contrato legible por máquina | ✅ |
| ADR-O-005 | Mission Control: 7 estados, 5 campos universales | ✅ |
| ADR-O-006 | Multi-tenancy por defecto: user_data/[tenant_id]/ | ✅ |
| ADR-O-007 | Agnosticismo de agente: AGENTS.md + adaptadores por agente | ✅ |

### Pendientes

| ID | Título | Bloqueado por |
|----|--------|---------------|
| ADR-P-001 | Elección IDE agéntico: Cursor vs. Windsurf | Evaluación práctica |
| ADR-P-002 | Organización GitHub Organizations por dominio | Auditoría repos |
| ADR-P-003 | Estrategia destilación: raw vs. curado | Stage 2 operativo |
| ADR-P-004 | Migración UCVE: public → schema ucve | Priorización |
| ADR-P-005 | Modelo multi-tenancy público | Madurez Stage 3 |
| ADR-P-006 | Arquitectura CLAPPS: org propia separada | Estrategia comercial |

---

## VII. La Pregunta que Unifica Todo

> **"Si desaparezco 6 meses y regreso — ¿podría retomar esto en menos de 15 minutos?"**

Si la respuesta es no: `ESTADO.md` antes que cualquier otra cosa.
