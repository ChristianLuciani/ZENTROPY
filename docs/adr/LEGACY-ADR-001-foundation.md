# ADR-001: Fundación de Zentropy

**Fecha:** 2026-03-07  
**Estado:** Accepted

## Contexto
Las conversaciones con IA son la fuente primaria de generación de ideas
en NEXOS. Actualmente se pierden en múltiples proveedores sin persistencia.
El schema existente en Supabase (content_atoms, entities, missions) fue
creado para universal_cv_engine pero es compatible con la visión de Zentropy.

## Decisión
Reutilizar y extender el schema existente de Supabase en lugar de crear
uno nuevo. Primera extensión: añadir `tenant_id` cuando se active
multi-tenancy.

## Consecuencias
- No hay deuda técnica de migración inmediata.
- El schema de `content_atoms` (type, tags, weight_metrics JSONB) es 
  suficientemente flexible para modelar conversaciones IA.
- `entities` modelará sesiones de chat como entidades de tipo 
  `ai_conversation`.

___

# 📜 ADR Registry — ZENTROPY / NEXOS
> Registro de Decisiones de Arquitectura.
> Inmutable una vez aceptado. Se supersede con nuevo ADR numerado.
> Última actualización: 2026-03-07

---

## ADR-001 — Reutilizar schema Supabase existente temporalmente
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Contexto:** NEXOS_DB ya tenía tablas de UCVE en `public`. Recrear desde cero genera deuda inmediata.

**Decisión:** Usar `public.profiles` como tabla de tenants compartida temporalmente. Zentropy opera en schema `zentropia` separado desde el inicio.

**Consecuencias:** Separación semántica de Zentropy correcta desde el día 1. UCVE queda con deuda de migración (ver ADR-009).

---

## ADR-002 — Regla: Un módulo = Un schema en Supabase
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Contexto:** El intento de usar `content_atoms` (UCVE) para conversaciones de Zentropy reveló el riesgo de mezclar módulos en el mismo schema.

**Decisión:** Cada módulo o aplicación de NEXOS tiene su propio schema dedicado en Supabase. El schema `public` es exclusivo para tablas verdaderamente compartidas (profiles, tenants futuros). Sin excepciones.

**Schemas definidos:**
- `zentropia` → ZENTROPY ✅ activo
- `ucve` → UCVE ⚠️ pendiente migración desde public
- `clapps` → CLAPPS ⬜ pendiente
- `finexos` → FINEXOS ⬜ pendiente

**Consecuencias:** Elimina la posibilidad de mezclas semánticas. Crea deuda de migración para UCVE.

---

## ADR-003 — Scripts dev usan Service Role Key; app usará Publishable Key
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Contexto:** RLS bloquea operaciones admin con publishable key. Dos contextos distintos: scripts locales vs. app de usuario final.

**Decisión:** `SUPABASE_SERVICE_KEY` exclusivo para scripts CLI locales (nunca en git, nunca en producción). La futura app usará publishable key con Supabase Auth real.

**Consecuencias:** `profiles.id` debe eventualmente vincularse a `auth.uid()` para que RLS funcione en producción (DT-001).

---

## ADR-004 — Python para CLI, TypeScript para servicios web
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Contexto:** Stack principal de NEXOS es TypeScript/Node. Scripts de captura son herramientas locales personales.

**Decisión:** Python para scripts CLI locales de Zentropy. TypeScript + Supabase Edge Functions (Deno) para lógica de negocio futura.

**Consecuencias:** Sin fricción hoy. Migración gradual a TS al escalar a web.

---

## ADR-005 — Supabase como SSOT: Opción B ahora → Opción C después
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Opciones evaluadas:**
- A: Supabase como backend primario de Open WebUI (schema conflict)
- B: Supabase como almacén semántico secundario ← **elegida para Stage 1-2**
- C: Postgres local + Supabase como espejo en la nube ← **objetivo Stage 3+**

**Decisión:** Implementar B ahora. Planificar migración a C cuando el sistema sea estable. Open WebUI usa su storage interno; Zentropy exporta conversaciones curadas a Supabase.

---

## ADR-006 — Abandonar ERPNext; FINEXOS sobre Postgres+Kontablo
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Contexto:** ERPNext usa MariaDB, creando segundo SSOT incompatible con Supabase. Su modelo multi-tenancy choca con RLS de Postgres.

**Decisión:** FINEXOS se construye nativamente sobre Supabase con Kontablo como ontología base. ERPNext descartado permanentemente.

**Consecuencias:** Mayor trabajo inicial de UI. Coherencia total del ecosistema. Elimina entropía MariaDB/Postgres.

---

## ADR-007 — NOOS y FINEXOS son capas distintas; Kontablo alimenta ambas
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Contexto:** Confusión inicial entre FINEXOS y NOOS como el mismo sistema.

**Decisión:** Son capas conceptualmente distintas con una base común:

| | FINEXOS | NOOS |
|--|---------|------|
| Naturaleza | ERP modernizado | Transformación paradigmática |
| Paradigma | Evolución incremental | Ruptura/revolución |
| Estado | Implementación práctica | I+D doctoral → software |
| Base | Kontablo | Kontablo |
| Agentes | Humanos + software | Human+IA como entidades cognitivas complejas |
| Métrica | Control de recursos | Expansión de potencial organizacional |

**Kontablo:** Ontología contable universal compartida. Alimenta tanto FINEXOS (contabilidad práctica) como NOOS (modelo financiero del nuevo paradigma organizacional).

---

## ADR-008 — GitHub Projects como task manager único de NEXOS
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Decisión:** GitHub Projects es el único task manager activo. Todos los demás (Notion, Linear, etc.) se migran y cierran. Una herramienta por función.

---

## ADR-009 — Política "Una herramienta por función" + proceso de cierre
**Fecha:** 2026-03-07 | **Estado:** `accepted`

**Decisión:** Por cada función cognitiva/operativa, una sola herramienta. Proceso de cierre: exportar → ingestar en Zentropy → cerrar cuenta.

**Estado actual:**
| Función | Herramienta | Estado |
|---------|------------|--------|
| IA dialéctica | Claude + Zentropy | ✅ |
| Task manager | GitHub Projects | 🟡 Migrar |
| PKM | Logseq + synapse-arc | ✅ |
| DB | Supabase | ✅ |
| IDE agéntico | Por definir (ADR-010) | 🟡 |

---

## ADRs Pendientes

- [ ] **ADR-010** — Elección IDE agéntico: Cursor vs. Windsurf
- [ ] **ADR-011** — Organización de GitHub Organizations por dominio
- [ ] **ADR-012** — Estrategia de destilación: raw vs. curado (chat + repos)
- [ ] **ADR-013** — Stack de destilación: Edge Functions vs. local
- [ ] **ADR-014** — Migración UCVE: public → schema ucve (plan y timing)
- [ ] **ADR-015** — Modelo de multi-tenancy público (cuando aplique)
- [ ] **ADR-016** — Arquitectura CLAPPS: repo/org propio (separar de perfil personal)


