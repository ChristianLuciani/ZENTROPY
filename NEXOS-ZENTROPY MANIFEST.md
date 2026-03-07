# 🗺️ NEXOS MANIFEST
> El mapa vivo del ecosistema. Fuente de verdad para IDEs agénticos y sesiones nuevas.
> Leer este archivo antes de trabajar en cualquier módulo de NEXOS.
> Última actualización: 2026-03-07

## ¿Qué es NEXOS?
Sistema Operativo Personal multi-tenant. Gestiona vida, proyectos e inteligencia de Christian Luciani (cluciani). Diseñado para escalar a uso público.

**Principio rector:** Una herramienta por función. Un SSOT. Cero entropía.

---

## 🏛️ Arquitectura Global

```
NEXOS (OS Personal)
├── ZENTROPY    — CIA: Centro de Inteligencia Artificial (corazón cognitivo)
├── CLAPPS      — Comprehensive Learning Applications (SaaS salud)
├── UCVE        — Universal CV Engine (identidad profesional)
│
└── NEXOS ENTERPRISE LAYER (I+D)
    ├── FINEXOS     — ERP modernizado sobre Kontablo
    ├── NOOS        — Transformación organizacional (tesis doctoral → software)
    └── KONTABLO    — Ontología contable universal (alimenta FINEXOS y NOOS)

NEXOS_DB (Supabase: cgwtnswpyyiitwpqkndi)
├── schema: public       → SOLO tablas verdaderamente compartidas (profiles, tenants)
├── schema: zentropia    → ZENTROPY ✅ operacional
├── schema: ucve         → UCVE ⚠️ pendiente migración desde public
├── schema: clapps       → CLAPPS ⬜ pendiente creación
├── schema: finexos      → FINEXOS ⬜ pendiente
└── schema: vault        → Supabase Vault (secretos)

REGLA ARQUITECTÓNICA CRÍTICA:
  Cada módulo = su propio schema. Sin excepciones.
  public = solo profiles/tenants compartidos.
  Nunca mezclar tablas de módulos distintos.
```

---

## 📦 Módulos

### 🌀 ZENTROPY (CIA — Centro de Inteligencia Artificial)
| Campo | Valor |
|-------|-------|
| Repo | `ChristianLuciani/ZENTROPY` |
| Estado | 🟢 **Stage 1 completo** |
| Schema DB | `zentropia` ✅ |
| Descripción | Corazón cognitivo de NEXOS. Captura y destila conversaciones con IA. Resuelve la entropía dialéctica. Primer módulo operacional. |
| Próximo | Stage 2: Open WebUI local (puerto 3010) |
| Prioridad | 🔴 CRÍTICA |

### 🏥 CLAPPS (Comprehensive Learning Applications)
| Campo | Valor |
|-------|-------|
| Repo | `ChristianLuciani/CLApps` (temporal — necesita repo/org propio) |
| Estado | 🟡 **MVP activo** |
| Schema DB | `clapps` ⬜ pendiente |
| Descripción | SaaS para profesionales de la salud. Gestión de clínicas con aislamiento federado por cliente. Integra Yappy, Wompi, Alegra, Chatwoot. |
| Prioridad | 🔴 Alta (producto comercial) |

### 📄 UCVE (Universal CV Engine)
| Campo | Valor |
|-------|-------|
| Repo | `ChristianLuciani/universal_cv_engine` |
| Estado | 🟡 **Operacional — deuda técnica de schema** |
| Schema DB | `public` ⚠️ → debe migrar a `ucve` |
| Descripción | Motor de identidad profesional. Átomos de contenido CV reutilizables desacoplados de la presentación. |
| Deuda | `content_atoms`, `entities`, `cv_configs` en `public` → migrar a `ucve` |
| Prioridad | 🟠 Media |

### 🧬 KONTABLO (accounting-esperanto)
| Campo | Valor |
|-------|-------|
| Repo | `ChristianLuciani/accounting-esperanto` |
| Estado | 🟡 **I+D activo — paper en progreso** |
| Descripción | Ontología contable universal inspirada en Esperanto. Puente entre estándares locales LATAM e IFRS/XBRL. Graph-based, AI-native. **Base fundacional de FINEXOS y NOOS.** |
| Prioridad | 🔴 Alta (bloquea capa enterprise) |

### 🏢 FINEXOS (ERP Modernizado)
| Campo | Valor |
|-------|-------|
| Repo | `ChristianLuciani/FINEXOS` |
| Estado | 🔴 **Reconstruir** — abandona ERPNext/MariaDB |
| Schema DB | `finexos` ⬜ pendiente |
| Descripción | ERP de nueva generación para empresas latinoamericanas. Implementación práctica actual de la capa enterprise. Se construye nativamente sobre Postgres+Kontablo. Evolución incremental del ERP tradicional. |
| Alimentado por | KONTABLO |
| Relación con NOOS | FINEXOS = evolución incremental. NOOS = ruptura paradigmática futura. |
| Prioridad | 🟡 Alta (necesita Kontablo primero) |

### 🔬 NOOS (Natural Organization Operating System)
| Campo | Valor |
|-------|-------|
| Repo | Pendiente — actualmente en NEXOS/docs |
| Estado | 🟡 **I+D conceptual — fase doctoral** |
| Descripción | Propuesta de transformación radical del ERP. Aplica principios de sistemas complejos (fractalidad, emergencia, no-linealidad). Integra agentes Human+IA como entidades cognitivas cuyo valor es mayor que la suma de las partes. No controla recursos: expande potencial organizacional. **Objetivo: tesis doctoral → software.** |
| Diferencia con FINEXOS | FINEXOS moderniza el paradigma actual. NOOS lo reemplaza. |
| Alimentado por | KONTABLO (ontología compartida con FINEXOS) |
| Prioridad | 🟠 Media-Alta (investigación activa) |

---

## 🗂️ Repositorios Legado

### Grupo Angel (ex-cliente — semillero de ideas)
No activo comercialmente. Valor como archivo de patrones y semillas conceptuales.

| Repo | Valor rescatable | Acción |
|------|-----------------|--------|
| `angel-aidi` | Arquitectura, guardian proxy | Extraer patterns → archivar |
| `angel-cashbox-system` | Sistema de caja | Revisar → archivar |
| `angel-cashbox-sys` | Duplicado probable | Eliminar |
| `grupo-angel-apps` | Apps varias | Revisar → archivar |
| `matrix_access_control` | Patrón de control acceso | Extraer → archivar |

**Proceso antes de archivar:** documentar en Zentropy los insights/patterns relevantes.

---

## 🛠️ Stack Global

| Capa | Herramienta | Estado |
|------|-------------|--------|
| SSOT / DB | Supabase (NEXOS_DB) | ✅ |
| IA principal | Claude + Zentropy | ✅ |
| IDE agéntico | Cursor / Windsurf | 🟡 Elegir uno |
| Task manager | GitHub Projects | 🟡 Migrar |
| PKM | Logseq + synapse-arc | ✅ |
| Secretos | Infisical | ⬜ Stage 3 |
| Edge Functions | Supabase (TypeScript/Deno) | ⬜ Stage 4 |
| Frontend | Next.js | ⬜ Stage 5 |
| Conectividad móvil | Tailscale → Cloudflare | ⬜ Stage 2 |

---

## 🚨 Deuda Técnica de Schema (Pendientes Críticos)

| Schema | Tablas afectadas | De | A | Prioridad |
|--------|-----------------|-----|---|-----------|
| ucve | content_atoms, entities, cv_configs, cv_atoms_pivot | public | ucve | 🟡 Media |
| clapps | (por definir) | — | clapps | 🟠 Cuando MVP estabilice |
| finexos | (Kontablo schema) | — | finexos | 🟡 Post-Kontablo |

---

## 🗺️ Roadmap

```
AHORA (Stage 2):
  └─ Open WebUI local → Zentropy
  └─ Ingestar ChatGPT → cerrar ChatGPT
  └─ Auditoría repos legado (distill_repos)

PRÓXIMO MES:
  └─ Kontablo: ontología core estable
  └─ CLAPPS: repo/org propio
  └─ Migración UCVE → schema propio

PRÓXIMO TRIMESTRE:
  └─ FINEXOS sobre Kontablo
  └─ NOOS: primer paper/draft tesis
  └─ GitHub Projects como task manager único

FUTURO:
  └─ Multi-tenancy público NEXOS
  └─ Unified Inbox (comunicaciones)
  └─ Frontend web Zentropy
```

---

## 📋 Protocolo para IDEs Agénticos

```
ANTES: Leer NEXOS_MANIFEST.md + ZENTROPY_STATE.md
DURANTE: Cada módulo = su schema. Sin mezclas.
AL TERMINAR: Commit semántico + actualizar ZENTROPY_STATE.md
```